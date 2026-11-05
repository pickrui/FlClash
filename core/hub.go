package main

import (
	"cmp"
	"context"
	"encoding/json"
	"net"
	"os"
	"runtime"
	"runtime/debug"
	"strconv"
	"time"

	"github.com/metacubex/mihomo/adapter"
	"github.com/metacubex/mihomo/adapter/outboundgroup"
	"github.com/metacubex/mihomo/adapter/provider"
	"github.com/metacubex/mihomo/common/observable"
	"github.com/metacubex/mihomo/component/mmdb"
	"github.com/metacubex/mihomo/component/resolver"
	"github.com/metacubex/mihomo/component/updater"
	"github.com/metacubex/mihomo/config"
	"github.com/metacubex/mihomo/constant"
	"github.com/metacubex/mihomo/constant/features"
	cp "github.com/metacubex/mihomo/constant/provider"
	"github.com/metacubex/mihomo/hub/executor"
	"github.com/metacubex/mihomo/listener"
	"github.com/metacubex/mihomo/log"
	"github.com/metacubex/mihomo/tunnel"
	"github.com/metacubex/mihomo/tunnel/statistic"
	"golang.org/x/exp/slices"
)

var (
	isInit        = false
	logSubscriber observable.Subscription[log.Event]
)

func handleInitClash(paramsString string) bool {
	runLock.Lock()
	defer runLock.Unlock()
	var params = InitParams{}
	err := json.Unmarshal([]byte(paramsString), &params)
	if err != nil {
		return false
	}
	version = params.Version
	constant.SetHomeDir(params.HomeDir)
	if params.ProfileKey != "" {
		GlobalProfileKey = params.ProfileKey
	}
	if params.ConfigAgeSecretKey != "" {
		GlobalConfigAgeSecretKey = params.ConfigAgeSecretKey
	}
	isInit = true
	return isInit
}

func handleStartListener() bool {
	runLock.Lock()
	defer runLock.Unlock()
	isRunning = true
	updateListeners()
	resolver.ResetConnection()
	return true
}

func handleStopListener() bool {
	runLock.Lock()
	defer runLock.Unlock()
	isRunning = false
	listener.StopListener()
	resolver.ResetConnection()
	return true
}

func handleGetIsInit() bool {
	return isInit
}

func handleForceGC() {
	log.Infoln("[APP] request force GC")
	runtime.GC()
	if features.Android {
		debug.FreeOSMemory()
	}
}

func handleShutdown() bool {
	listener.StopListener()
	executor.Shutdown()
	handleForceGC()
	isInit = false
	return true
}

func handleValidateConfig(path string) string {
	buf, err := readFile(path)
	if err != nil {
		return "readFile Error: " + err.Error()
	}
	if len(buf) == 0 {
		return "empty config file or decryption failed"
	}
	_, err = config.UnmarshalRawConfig(buf)
	if err != nil {
		return "Parse Error: " + err.Error()
	}
	return ""
}

func handleGetProxies() ProxiesData {
	runLock.Lock()
	defer runLock.Unlock()

	nameList := config.GetProxyNameList()

	proxies := make(map[string]constant.Proxy)

	for name, proxy := range tunnel.Proxies() {
		proxies[name] = proxy
	}
	for _, p := range tunnel.Providers() {
		for _, proxy := range p.Proxies() {
			proxies[proxy.Name()] = proxy
		}
	}

	hasGlobal := false
	allNames := make([]string, 0, len(nameList)+1)

	for _, name := range nameList {
		if name == "GLOBAL" {
			hasGlobal = true
		}

		p, ok := proxies[name]
		if !ok || p == nil {
			continue
		}
		switch p.Type() {
		case constant.Selector, constant.URLTest, constant.Fallback, constant.Relay, constant.LoadBalance:
			allNames = append(allNames, name)
		default:
		}
	}

	if !hasGlobal {
		if p, ok := proxies["GLOBAL"]; ok && p != nil {
			allNames = append([]string{"GLOBAL"}, allNames...)
		}
	}

	return ProxiesData{
		All:     allNames,
		Proxies: proxies,
	}
}

func handleChangeProxy(data string, fn func(string string)) {
	go func() {
		runLock.Lock()
		defer runLock.Unlock()
		var params = &ChangeProxyParams{}
		err := json.Unmarshal([]byte(data), params)
		if err != nil {
			fn(err.Error())
			return
		}
		if params.GroupName == nil || params.ProxyName == nil {
			fn("Missing group-name or proxy-name")
			return
		}
		groupName := *params.GroupName
		proxyName := *params.ProxyName
		proxies := tunnel.AllProxies()
		group, ok := proxies[groupName]
		if !ok {
			fn("Not found group")
			return
		}
		adapterProxy, ok := group.(*adapter.Proxy)
		if !ok {
			fn("Group is not adapter proxy")
			return
		}
		selector, ok := adapterProxy.ProxyAdapter.(outboundgroup.SelectAble)
		if !ok {
			fn("Group is not selectable")
			return
		}
		if proxyName == "" {
			selector.ForceSet(proxyName)
		} else if err := selector.Set(proxyName); err != nil {
			fn(err.Error())
			return
		}

		fn("")
	}()
}

func marshalTraffic(up, down int64) string {
	data, err := json.Marshal(map[string]int64{
		"up":   up,
		"down": down,
	})
	if err != nil {
		log.Errorln("Error: %s", err)
		return ""
	}
	return string(data)
}

func handleGetTraffic(onlyStatisticsProxy bool) string {
	return marshalTraffic(statistic.DefaultManager.NowTraffic(onlyStatisticsProxy))
}

func handleGetTotalTraffic(onlyStatisticsProxy bool) string {
	return marshalTraffic(statistic.DefaultManager.TotalTraffic(onlyStatisticsProxy))
}

func handleResetTraffic() {
	statistic.DefaultManager.ResetStatistic()
}

func handleAsyncTestDelay(paramsString string, fn func(string)) {
	go func() {
		if err := delaySem.Acquire(context.Background(), 1); err != nil {
			fn("")
			return
		}
		defer delaySem.Release(1)
		var params = &TestDelayParams{}
		if err := json.Unmarshal([]byte(paramsString), params); err != nil {
			fn("")
			return
		}

		delayData := &Delay{
			Name:  params.ProxyName,
			Value: -1,
		}
		reply := func() {
			data, _ := json.Marshal(delayData)
			fn(string(data))
		}

		proxy := tunnel.AllProxies()[params.ProxyName]
		if proxy == nil {
			reply()
			return
		}

		testUrl := constant.DefaultTestURL
		if params.TestUrl != "" {
			testUrl = params.TestUrl
		}
		delayData.Url = testUrl

		ctx, cancel := context.WithTimeout(context.Background(), time.Millisecond*time.Duration(params.Timeout))
		defer cancel()

		delay, err := proxy.URLTest(ctx, testUrl, nil)
		if err == nil && delay > 0 {
			delayData.Value = int32(delay)
		}
		reply()
	}()
}

func handleGetConnections() string {
	runLock.Lock()
	defer runLock.Unlock()
	snapshot := statistic.DefaultManager.Snapshot()
	data, err := json.Marshal(snapshot)
	if err != nil {
		log.Errorln("Error: %s", err)
		return ""
	}
	return string(data)
}

func handleCloseConnections() bool {
	runLock.Lock()
	defer runLock.Unlock()
	statistic.DefaultManager.Range(func(c statistic.Tracker) bool {
		_ = c.Close()
		return true
	})
	return true
}

func handleResetConnections() bool {
	runLock.Lock()
	defer runLock.Unlock()
	resolver.ResetConnection()
	return true
}

func handleCloseConnection(connectionId string) bool {
	runLock.Lock()
	defer runLock.Unlock()
	c := statistic.DefaultManager.Get(connectionId)
	if c == nil {
		return false
	}
	_ = c.Close()
	return true
}

func handleGetExternalProviders() string {
	runLock.Lock()
	defer runLock.Unlock()
	eps := make([]ExternalProvider, 0)
	for _, p := range getExternalProvidersRaw() {
		externalProvider, err := toExternalProvider(p)
		if err != nil {
			continue
		}
		eps = append(eps, *externalProvider)
	}
	slices.SortFunc(eps, func(a, b ExternalProvider) int {
		return cmp.Compare(a.Name, b.Name)
	})
	data, err := json.Marshal(eps)
	if err != nil {
		return ""
	}
	return string(data)
}

func lookupExternalProvider(name string) (cp.Provider, bool) {
	runLock.Lock()
	defer runLock.Unlock()
	p, exist := getExternalProvidersRaw()[name]
	return p, exist
}

func handleGetExternalProvider(externalProviderName string) string {
	externalProvider, exist := lookupExternalProvider(externalProviderName)
	if !exist {
		return ""
	}
	e, err := toExternalProvider(externalProvider)
	if err != nil {
		return ""
	}
	data, err := json.Marshal(e)
	if err != nil {
		return ""
	}
	return string(data)
}

func handleUpdateGeoData(geoType string, geoName string, fn func(value string)) {
	go func() {
		path := constant.Path.Resolve(geoName)
		var err error
		switch geoType {
		case "MMDB":
			err = updater.UpdateMMDBWithPath(path)
		case "ASN":
			err = updater.UpdateASNWithPath(path)
		case "GEOIP":
			err = updater.UpdateGeoIpWithPath(path)
		case "GEOSITE":
			err = updater.UpdateGeoSiteWithPath(path)
		}
		if err != nil {
			fn(err.Error())
			return
		}
		fn("")
	}()
}

func handleUpdateExternalProvider(providerName string, fn func(value string)) {
	go func() {
		externalProvider, exist := lookupExternalProvider(providerName)
		if !exist {
			fn("external provider is not exist")
			return
		}
		if err := externalProvider.Update(); err != nil {
			fn(err.Error())
			return
		}
		fn("")
	}()
}

func handleSideLoadExternalProvider(providerName string, data []byte, fn func(value string)) {
	go func() {
		externalProvider, exist := lookupExternalProvider(providerName)
		if !exist {
			fn("external provider is not exist")
			return
		}
		runLock.Lock()
		defer runLock.Unlock()
		if err := sideUpdateExternalProvider(externalProvider, data); err != nil {
			fn(err.Error())
			return
		}
		fn("")
	}()
}

func handleSuspend(suspended bool) bool {
	if suspended {
		tunnel.OnSuspend()
	} else {
		tunnel.OnRunning()
	}
	provider.SetHealthCheckSuspended(suspended)
	return true
}

func handleStartLog() {
	handleStopLog()
	logSubscriber = log.Subscribe()
	go func() {
		for logData := range logSubscriber {
			if logData.LogLevel < log.Level() {
				continue
			}

			message := &Message{
				Type: LogMessage,
				Data: logData,
			}
			sendMessage(*message)
		}
	}()
}

func handleStopLog() {
	if logSubscriber != nil {
		log.UnSubscribe(logSubscriber)
		logSubscriber = nil
	}
}

func handleGetCountryCode(ip string, fn func(value string)) {
	go func() {
		parsedIP := net.ParseIP(ip)
		if parsedIP == nil {
			fn("")
			return
		}
		codes := mmdb.IPInstance().LookupCode(parsedIP)
		if len(codes) == 0 {
			fn("")
			return
		}
		fn(codes[0])
	}()
}

func handleGetMemory(fn func(value string)) {
	go func() {
		fn(strconv.FormatUint(statistic.DefaultManager.Memory(), 10))
	}()
}

func handleGetConfig(path string) (*config.RawConfig, error) {
	data, err := readFile(path)
	if err != nil {
		return nil, err
	}
	return config.UnmarshalRawConfig(data)
}

func handleCrash() {
	panic("handle invoke crash")
}

func handleUpdateConfig(data []byte) string {
	var params = &UpdateParams{}
	if err := json.Unmarshal(data, params); err != nil {
		return err.Error()
	}
	updateConfig(params)
	return ""
}

func handleDelFile(path string, result ActionResult) {
	go func() {
		if err := os.RemoveAll(path); err != nil {
			result.success(err.Error())
			return
		}
		result.success("")
	}()
}

func handleSetupConfig(data []byte) string {
	if !isInit {
		return "not initialized"
	}
	var params = defaultSetupParams()
	err := UnmarshalJson(data, params)
	if err != nil {
		log.Errorln("unmarshalRawConfig error %v", err)
		_ = applyConfig(defaultSetupParams())
		return err.Error()
	}
	err = applyConfig(params)
	if err != nil {
		return err.Error()
	}
	return ""
}

func init() {
	adapter.UrlTestHook = func(url string, name string, delay uint16) {
		delayData := &Delay{
			Url:  url,
			Name: name,
		}
		if delay == 0 {
			delayData.Value = -1
		} else {
			delayData.Value = int32(delay)
		}
		sendMessage(Message{
			Type: DelayMessage,
			Data: delayData,
		})
	}
	statistic.DefaultRequestNotify = func(c statistic.Tracker) {
		sendMessage(Message{
			Type: RequestMessage,
			Data: c,
		})
	}
	executor.DefaultProviderLoadedHook = func(providerName string) {
		sendMessage(Message{
			Type: LoadedMessage,
			Data: providerName,
		})
	}
}

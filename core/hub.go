package main

import (
	"cmp"
	"context"
	"net"
	"os"
	"runtime"
	"runtime/debug"
	"sync"
	"sync/atomic"
	"time"

	"github.com/metacubex/mihomo/adapter"
	"github.com/metacubex/mihomo/adapter/outboundgroup"
	"github.com/metacubex/mihomo/adapter/provider"
	"github.com/metacubex/mihomo/common/observable"
	"github.com/metacubex/mihomo/component/mmdb"
	"github.com/metacubex/mihomo/component/resolver"
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
	isInit          atomic.Bool
	logSubscriber   observable.Subscription[log.Event]
	logSubscriberMu sync.Mutex
	proxySnapshot   = map[string]constant.Proxy{}
)

func publishProxySnapshot(proxies map[string]constant.Proxy) {
	selectionLock.Lock()
	defer selectionLock.Unlock()
	publishProxySnapshotLocked(proxies)
}

func publishProxySnapshotLocked(proxies map[string]constant.Proxy) {
	proxySnapshot = proxies
}

func handleInitClash(params *InitParams) bool {
	runLock.Lock()
	defer runLock.Unlock()
	if params.HomeDir == "" {
		return false
	}
	if err := os.MkdirAll(params.HomeDir, 0o700); err != nil {
		return false
	}
	version = params.Version
	constant.SetHomeDir(params.HomeDir)
	GlobalValidationSourceHome = params.ValidationSourceHome
	if GlobalValidationSourceHome == "" {
		GlobalValidationSourceHome = params.HomeDir
	}
	if params.ProfileKey != "" {
		GlobalProfileKey = params.ProfileKey
	}
	if params.ConfigAgeSecretKey != "" {
		GlobalConfigAgeSecretKey = params.ConfigAgeSecretKey
	}
	resetGeoLifecycle()
	isInit.Store(true)
	return true
}

func handleStartListener() bool {
	runLock.Lock()
	defer runLock.Unlock()
	isRunning = true
	updateListeners()
	resolver.ResetConnection()
	if features.Android {
		return true
	}
	if currentConfig == nil {
		isRunning = false
		listener.StopListener()
		return false
	}
	mixedPort := currentConfig.General.MixedPort
	if mixedPort > 0 && listener.GetPorts().MixedPort != mixedPort {
		isRunning = false
		listener.StopListener()
		return false
	}
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
	return isInit.Load()
}

func handleForceGC() {
	log.Infoln("[APP] request force GC")
	runtime.GC()
	if features.Android {
		debug.FreeOSMemory()
	}
}

func handleShutdown() bool {
	stopGeoLifecycle()
	runLock.Lock()
	defer runLock.Unlock()
	isInit.Store(false)
	handleStopLog()
	isRunning = false
	listener.StopListener()
	closeCurrentProviders()
	executor.Shutdown()
	handleForceGC()
	return true
}

func closeCurrentProviders() {
	for _, provider := range tunnel.Providers() {
		closeProvider(provider)
	}
	for _, provider := range tunnel.RuleProviders() {
		closeProvider(provider)
	}
	tunnel.UpdateProxies(
		map[string]constant.Proxy{},
		map[string]cp.ProxyProvider{},
	)
	tunnel.UpdateRules(nil, nil, map[string]cp.RuleProvider{})
	publishProxySnapshot(map[string]constant.Proxy{})
}

func closeProvider(provider any) {
	if closer, ok := provider.(interface{ Close() error }); ok {
		_ = closer.Close()
	}
}

func handleValidateConfig(path string) string {
	buf, err := readFile(path)
	if err != nil {
		return "readFile Error: " + err.Error()
	}
	if len(buf) == 0 {
		return "empty config file or decryption failed"
	}
	return validateConfigData(buf)
}

func validateConfigData(data []byte) string {
	if !isInit.Load() {
		return "not initialized"
	}
	return isolatedValidateConfigData(data)
}

func handleGetProxies() ProxiesData {
	runLock.Lock()
	defer runLock.Unlock()

	normalizeSelectorSelections()
	nameList := config.GetProxyNameList()

	proxies := make(map[string]constant.Proxy)

	for name, proxy := range tunnel.Proxies() {
		proxies[name] = proxy
	}
	providers := tunnel.Providers()
	providerNames := make([]string, 0, len(providers))
	for name := range providers {
		providerNames = append(providerNames, name)
	}
	slices.Sort(providerNames)
	for _, name := range providerNames {
		for _, proxy := range providers[name].Proxies() {
			// Provider nodes have their own namespace. They must not replace a
			// top-level group (including GLOBAL) or its selectable snapshot.
			if _, exists := proxies[proxy.Name()]; !exists {
				proxies[proxy.Name()] = proxy
			}
		}
	}
	publishProxySnapshot(proxies)

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

	var groupMembers map[string]map[string]ProxyGroupMember
	for _, name := range allNames {
		group, ok := proxies[name].Adapter().(interface{ Proxies() []constant.Proxy })
		if !ok {
			continue
		}
		// Resolve ambiguous names from each live group, after its provider
		// ordering and filters. Keep ordinary snapshots flat and compact.
		members := group.Proxies()
		hasAmbiguousMember := false
		for _, member := range members {
			if proxies[member.Name()] != member {
				hasAmbiguousMember = true
				break
			}
		}
		if !hasAmbiguousMember {
			continue
		}
		seen := make(map[string]struct{})
		for _, member := range members {
			memberName := member.Name()
			if _, exists := seen[memberName]; exists {
				continue
			}
			seen[memberName] = struct{}{}
			if proxies[memberName] == member {
				continue
			}
			data := ProxyGroupMember{Name: memberName, Type: member.Type().String()}
			if selected, ok := member.Adapter().(interface{ Now() string }); ok {
				data.Now = selected.Now()
			}
			if groupMembers == nil {
				groupMembers = make(map[string]map[string]ProxyGroupMember)
			}
			if groupMembers[name] == nil {
				groupMembers[name] = make(map[string]ProxyGroupMember)
			}
			groupMembers[name][memberName] = data
		}
	}

	return ProxiesData{
		All:          allNames,
		Proxies:      proxies,
		GroupMembers: groupMembers,
	}
}

func handleChangeProxy(params *ChangeProxyParams) string {
	if params.GroupName == nil || params.ProxyName == nil {
		return "Missing group-name or proxy-name"
	}
	selectionLock.Lock()
	defer selectionLock.Unlock()
	groupName := *params.GroupName
	proxyName := *params.ProxyName
	group := proxySnapshot[groupName]
	if group == nil {
		return "Not found group"
	}
	adapterProxy, ok := group.(*adapter.Proxy)
	if !ok {
		return "Group is not adapter proxy"
	}
	selector, ok := adapterProxy.ProxyAdapter.(outboundgroup.SelectAble)
	if !ok {
		return "Group is not selectable"
	}
	if proxyName == "" {
		selector.ForceSet(proxyName)
	} else if err := selector.Set(proxyName); err != nil {
		return err.Error()
	}
	return ""
}

func handleGetTraffic(onlyStatisticsProxy bool) Traffic {
	up, down := statistic.DefaultManager.NowTraffic(onlyStatisticsProxy)
	return Traffic{Up: up, Down: down}
}

func handleGetTotalTraffic(onlyStatisticsProxy bool) Traffic {
	up, down := statistic.DefaultManager.TotalTraffic(onlyStatisticsProxy)
	return Traffic{Up: up, Down: down}
}

func handleResetTraffic() {
	statistic.DefaultManager.ResetStatistic()
}

func handleAsyncTestDelay(params *TestDelayParams, fn func(*Delay)) {
	go func() {
		testUrl := cmp.Or(params.TestUrl, constant.DefaultTestURL)
		delayData := &Delay{
			Url:   testUrl,
			Name:  params.ProxyName,
			Value: -1,
		}
		if err := delaySem.Acquire(context.Background(), 1); err != nil {
			fn(delayData)
			return
		}
		defer delaySem.Release(1)

		proxy := tunnel.AllProxies()[params.ProxyName]
		if proxy == nil {
			fn(delayData)
			return
		}

		ctx, cancel := context.WithTimeout(context.Background(), time.Millisecond*time.Duration(params.Timeout))
		defer cancel()

		finish := manualDelayEvents.begin(proxy.Name(), testUrl)
		delay, err := proxy.URLTest(ctx, testUrl, nil)
		finish()
		if err == nil {
			// URLTest truncates sub-millisecond successes to zero. Reserve zero
			// for pending UI state without reporting a successful probe as failed.
			delayData.Value = max(int32(delay), 1)
		}
		fn(delayData)
	}()
}

func handleGetConnections() any {
	runLock.Lock()
	defer runLock.Unlock()
	return statistic.DefaultManager.Snapshot()
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

func handleGetExternalProviders() []ExternalProvider {
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
	return eps
}

func lookupExternalProvider(name string) (cp.Provider, bool) {
	runLock.Lock()
	defer runLock.Unlock()
	p, exist := getExternalProvidersRaw()[name]
	return p, exist
}

func handleGetExternalProvider(externalProviderName string) *ExternalProvider {
	externalProvider, exist := lookupExternalProvider(externalProviderName)
	if !exist {
		return nil
	}
	e, err := toExternalProvider(externalProvider)
	if err != nil {
		return nil
	}
	return e
}

func handleUpdateGeoData(
	geoType string,
	geoName string,
	geoURL string,
	fn func(value string),
) {
	if !runLifecycleGeoTask(func(ctx context.Context) {
		path, err := geoResourcePath(geoType, geoName)
		if err == nil {
			err = tryRunGeoUpdate(ctx, func(ctx context.Context) error {
				return updateGeoDataLockedFromURL(ctx, geoType, path, geoURL)
			})
		}
		if err != nil {
			fn(err.Error())
			return
		}
		fn("")
	}) {
		fn(context.Canceled.Error())
	}
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
	runLock.Lock()
	defer runLock.Unlock()
	deviceIdle = suspended
	provider.SetHealthCheckSuspended(suspended)
	reconcileIdleSuspendLocked()
	return true
}

func handleStartLog() {
	runLock.Lock()
	defer runLock.Unlock()
	if !isInit.Load() {
		return
	}
	logSubscriberMu.Lock()
	if logSubscriber != nil {
		log.UnSubscribe(logSubscriber)
	}
	subscriber := log.Subscribe()
	logSubscriber = subscriber
	logSubscriberMu.Unlock()
	go func(subscription observable.Subscription[log.Event]) {
		for logData := range subscription {
			if logData.LogLevel < log.Level() {
				continue
			}

			message := &Message{
				Type: LogMessage,
				Data: logData,
			}
			sendMessage(*message)
		}
	}(subscriber)
}

func handleStopLog() {
	logSubscriberMu.Lock()
	defer logSubscriberMu.Unlock()
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

func handleGetMemory(fn func(value uint64)) {
	go func() {
		fn(statistic.DefaultManager.Memory())
	}()
}

func handleGetConfig(path string) (*config.RawConfig, error) {
	data, err := readFile(path)
	if err != nil {
		return nil, err
	}
	return config.UnmarshalRawConfig(normalizeConfigShortIds(data))
}

func handleCrash() {
	panic("handle invoke crash")
}

func handleUpdateConfig(params *UpdateParams) string {
	updateConfig(params)
	return ""
}

func handleSetupConfig(params *SetupParams) string {
	if !isInit.Load() {
		return "not initialized"
	}
	err := applyConfig(params)
	if err != nil {
		return err.Error()
	}
	return ""
}

func init() {
	tunnel.ModeChangeHook = func(m tunnel.TunnelMode) {
		if configValidationInProgress.Load() {
			return
		}
		sendMessage(Message{
			Type: ModeMessage,
			Data: m.String(),
		})
	}
	adapter.UrlTestHook = func(url string, name string, delay uint16) {
		delayData := manualDelayEvents.message(url, name, delay)
		if delayData == nil {
			return
		}
		sendMessage(Message{
			Type: DelayMessage,
			Data: delayData,
		})
	}
	statistic.DefaultRequestNotify = func(c statistic.Tracker) {
		sendMessage(requestMessage(c))
	}
	executor.DefaultProviderLoadedHook = func(providerName string) {
		sendMessage(Message{
			Type: LoadedMessage,
			Data: providerName,
		})
	}
}

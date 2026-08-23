package main

import (
	"bytes"
	"encoding/json"
	"errors"
	"os"
	"path/filepath"
	"runtime"
	"sync"

	"github.com/metacubex/mihomo/adapter"
	"github.com/metacubex/mihomo/adapter/inbound"
	"github.com/metacubex/mihomo/adapter/outboundgroup"
	"github.com/metacubex/mihomo/adapter/provider"
	"github.com/metacubex/mihomo/component/dialer"
	"github.com/metacubex/mihomo/component/resolver"
	"github.com/metacubex/mihomo/component/updater"
	"github.com/metacubex/mihomo/config"
	"github.com/metacubex/mihomo/constant"
	"github.com/metacubex/mihomo/constant/features"
	cp "github.com/metacubex/mihomo/constant/provider"
	"github.com/metacubex/mihomo/hub"
	"github.com/metacubex/mihomo/hub/executor"
	"github.com/metacubex/mihomo/hub/route"
	"github.com/metacubex/mihomo/listener"
	"github.com/metacubex/mihomo/log"
	rp "github.com/metacubex/mihomo/rules/provider"
	"github.com/metacubex/mihomo/tunnel"
	"golang.org/x/sync/semaphore"
)

var (
	currentConfig *config.Config
	version       = 0
	isRunning     = false
	runLock       sync.Mutex
	// Selector writes and proxySnapshot use this lock. The fixed order is
	// runLock -> selectionLock; proxy changes must never wait for runLock.
	selectionLock sync.Mutex
	delaySem      = semaphore.NewWeighted(50)
)

const defaultTestURL = "http://cp.cloudflare.com/generate_204"

func init() {
	constant.DefaultTestURL = defaultTestURL
}

func getExternalProvidersRaw() map[string]cp.Provider {
	eps := make(map[string]cp.Provider)
	for n, p := range tunnel.Providers() {
		if p.VehicleType() != cp.Compatible {
			eps[n] = p
		}
	}
	for n, p := range tunnel.RuleProviders() {
		if p.VehicleType() != cp.Compatible {
			eps[n] = p
		}
	}
	return eps
}

func toExternalProvider(p cp.Provider) (*ExternalProvider, error) {
	switch p := p.(type) {
	case *provider.ProxySetProvider:
		return &ExternalProvider{
			Name:             p.Name(),
			Type:             p.Type().String(),
			VehicleType:      p.VehicleType().String(),
			Count:            p.Count(),
			UpdateAt:         p.UpdatedAt(),
			Path:             p.Vehicle().Path(),
			SubscriptionInfo: p.GetSubscriptionInfo(),
		}, nil
	case *rp.RuleSetProvider:
		return &ExternalProvider{
			Name:        p.Name(),
			Type:        p.Type().String(),
			VehicleType: p.VehicleType().String(),
			Count:       p.Count(),
			UpdateAt:    p.UpdatedAt(),
			Path:        p.Vehicle().Path(),
		}, nil
	default:
		return nil, errors.New("not external provider")
	}
}

func sideUpdateExternalProvider(p cp.Provider, data []byte) error {
	switch p := p.(type) {
	case *provider.ProxySetProvider:
		_, _, err := p.SideUpdate(data)
		return err
	case *rp.RuleSetProvider:
		_, _, err := p.SideUpdate(data)
		return err
	default:
		return errors.New("not external provider")
	}
}

func updateListeners() {
	if !isRunning {
		return
	}
	if currentConfig == nil {
		return
	}
	listeners := currentConfig.Listeners
	general := currentConfig.General
	listener.PatchInboundListeners(listeners, tunnel.Tunnel, true)

	listener.SetAllowLan(general.AllowLan)
	inbound.SetSkipAuthPrefixes(general.SkipAuthPrefixes)
	inbound.SetAllowedIPs(general.LanAllowedIPs)
	inbound.SetDisAllowedIPs(general.LanDisAllowedIPs)

	listener.SetBindAddress(general.BindAddress)
	listener.ReCreateHTTP(general.Port, tunnel.Tunnel)
	listener.ReCreateSocks(general.SocksPort, tunnel.Tunnel)
	listener.ReCreateRedir(general.RedirPort, tunnel.Tunnel)
	listener.ReCreateTProxy(general.TProxyPort, tunnel.Tunnel)
	listener.ReCreateMixed(general.MixedPort, tunnel.Tunnel)
	listener.ReCreateShadowSocks(general.ShadowSocksConfig, tunnel.Tunnel)
	listener.ReCreateVmess(general.VmessConfig, tunnel.Tunnel)
	listener.ReCreateTuic(general.TuicServer, tunnel.Tunnel)
	if !features.Android {
		general.Tun.Device = normalizeTunDeviceName(general.Tun.Device, runtime.GOOS)
		listener.ReCreateTun(general.Tun, tunnel.Tunnel)
	}
}

func patchSelectGroup(mapping map[string]string) {
	selectionLock.Lock()
	defer selectionLock.Unlock()

	proxies := tunnel.AllProxies()
	for name, proxy := range proxies {
		outbound, ok := proxy.(*adapter.Proxy)
		if !ok {
			continue
		}

		selector, ok := outbound.ProxyAdapter.(outboundgroup.SelectAble)
		if !ok {
			continue
		}

		selected, exist := mapping[name]
		if !exist {
			continue
		}

		if proxySelector, ok := outbound.ProxyAdapter.(*outboundgroup.Selector); ok {
			restoreSelectorSelection(proxySelector, selected)
			continue
		}
		selector.ForceSet(selected)
	}
	publishProxySnapshotLocked(proxies)
}

type selectorState interface {
	outboundgroup.SelectAble
	Now() string
}

func restoreSelectorSelection(selector selectorState, selected string) {
	if err := selector.Set(selected); err != nil {
		normalizeSelectorSelection(selector)
	}
}

func normalizeSelectorSelection(selector selectorState) {
	selector.ForceSet(selector.Now())
}

func normalizeSelectorSelections() {
	selectionLock.Lock()
	defer selectionLock.Unlock()

	for _, proxy := range tunnel.AllProxies() {
		outbound, ok := proxy.(*adapter.Proxy)
		if !ok {
			continue
		}
		selector, ok := outbound.ProxyAdapter.(*outboundgroup.Selector)
		if !ok {
			continue
		}
		normalizeSelectorSelection(selector)
	}
}

func defaultSetupParams() *SetupParams {
	return &SetupParams{
		TestURL:     defaultTestURL,
		SelectedMap: map[string]string{},
	}
}

func isFlClashEncrypted(data []byte) bool {
	return len(data) >= 5 && string(data[:4]) == "FLEN" && data[4] == 0x02
}

func isEncryptedConfig(data []byte) bool {
	return isAgeArmored(data) || isFlClashEncrypted(data)
}

func decryptFlClashIfNeeded(data []byte) ([]byte, error) {
	if isAgeArmored(data) {
		return DecryptFlClashAge(data)
	}
	if !isFlClashEncrypted(data) {
		return data, nil
	}
	return DecryptFlClash(data)
}

func parseConfigPath(path string) (*config.Config, bool, error) {
	data, err := os.ReadFile(path)
	if err != nil || !isEncryptedConfig(data) {
		setDNSAuth(nil)
		cfg, err := executor.ParseWithPath(path)
		return cfg, false, err
	}
	data, err = decryptFlClashIfNeeded(data)
	if err != nil {
		return nil, true, err
	}
	applyDNSAuth()
	cfg, err := executor.ParseWithBytes(data)
	return cfg, true, err
}

func readFile(path string) ([]byte, error) {
	data, err := os.ReadFile(path)
	if err != nil {
		return nil, err
	}
	return decryptFlClashIfNeeded(data)
}

func updateConfig(params *UpdateParams) {
	runLock.Lock()
	defer runLock.Unlock()
	if currentConfig == nil || currentConfig.General == nil {
		return
	}
	general := currentConfig.General
	restartGeo :=
		(params.GeoAutoUpdate != nil && *params.GeoAutoUpdate != general.GeoAutoUpdate) ||
			(params.GeoUpdateInterval != nil && *params.GeoUpdateInterval != general.GeoUpdateInterval)
	if restartGeo {
		stopGeoScheduler()
	}
	if params.MixedPort != nil {
		general.MixedPort = *params.MixedPort
	}
	if params.AllowLan != nil {
		general.AllowLan = *params.AllowLan
	}
	if params.Sniffing != nil {
		general.Sniffing = *params.Sniffing
		tunnel.SetSniffing(general.Sniffing)
	}
	if params.FindProcessMode != nil {
		general.FindProcessMode = *params.FindProcessMode
		tunnel.SetFindProcessMode(general.FindProcessMode)
	}
	if params.TCPConcurrent != nil {
		general.TCPConcurrent = *params.TCPConcurrent
		dialer.SetTcpConcurrent(general.TCPConcurrent)
	}
	if params.Interface != nil {
		general.Interface = *params.Interface
		dialer.DefaultInterface.Store(general.Interface)
	}
	if params.UnifiedDelay != nil {
		general.UnifiedDelay = *params.UnifiedDelay
		adapter.UnifiedDelay.Store(general.UnifiedDelay)
	}
	if params.GeoAutoUpdate != nil {
		general.GeoAutoUpdate = *params.GeoAutoUpdate
		updater.SetGeoAutoUpdate(general.GeoAutoUpdate)
	}
	if params.GeoUpdateInterval != nil {
		general.GeoUpdateInterval = *params.GeoUpdateInterval
		updater.SetGeoUpdateInterval(general.GeoUpdateInterval)
	}
	if params.Mode != nil {
		general.Mode = *params.Mode
		tunnel.SetMode(general.Mode)
	}
	if params.LogLevel != nil {
		general.LogLevel = *params.LogLevel
		log.SetLevel(general.LogLevel)
	}
	if params.IPv6 != nil {
		general.IPv6 = *params.IPv6
		resolver.DisableIPv6 = !general.IPv6
	}
	if params.ExternalController != nil || params.Secret != nil {
		if params.ExternalController != nil {
			currentConfig.Controller.ExternalController = *params.ExternalController
		}
		if params.Secret != nil {
			currentConfig.Controller.Secret = *params.Secret
		}
		route.ReCreateServer(&route.Config{
			Addr:   currentConfig.Controller.ExternalController,
			Secret: currentConfig.Controller.Secret,
		})
	}

	if params.Tun != nil {
		general.Tun.Enable = params.Tun.Enable
		general.Tun.AutoRoute = *params.Tun.AutoRoute
		general.Tun.Device = *params.Tun.Device
		general.Tun.RouteAddress = *params.Tun.RouteAddress
		general.Tun.DNSHijack = *params.Tun.DNSHijack
		general.Tun.Stack = *params.Tun.Stack
	}

	updateListeners()
	if restartGeo {
		restartGeoScheduler()
	}
}

func applyConfig(params *SetupParams) error {
	runLock.Lock()
	defer runLock.Unlock()
	stopGeoScheduler()
	var err error
	isoixConfig := params.RawConfig != ""
	constant.DefaultTestURL = params.TestURL
	if isoixConfig {
		applyDNSAuth()
		currentConfig, err = executor.ParseWithBytes([]byte(params.RawConfig))
	} else {
		currentConfig, isoixConfig, err = parseConfigPath(filepath.Join(constant.Path.HomeDir(), "config.yaml"))
	}
	if err != nil {
		currentConfig, _ = config.ParseRawConfig(config.DefaultRawConfig())
	}
	setMaskedAddrs(isoixConfig)
	hub.ApplyConfig(currentConfig)
	installDNSAuthResolver()
	patchSelectGroup(params.SelectedMap)
	updateListeners()
	restartGeoScheduler()
	return err
}

func UnmarshalJson(data []byte, v any) error {
	decoder := json.NewDecoder(bytes.NewReader(data))
	decoder.UseNumber()
	return decoder.Decode(v)
}

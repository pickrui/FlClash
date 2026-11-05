package main

import (
	"fmt"
	"os"
	"reflect"
	"slices"
	"testing"

	"github.com/metacubex/mihomo/config"
	"github.com/metacubex/mihomo/constant"
	"github.com/metacubex/mihomo/hub/executor"
	"github.com/metacubex/mihomo/tunnel"
)

func setValidationTestHome(t *testing.T) {
	t.Helper()
	previousHome := constant.Path.HomeDir()
	previousSource := GlobalValidationSourceHome
	home := t.TempDir()
	constant.SetHomeDir(home)
	GlobalValidationSourceHome = home
	t.Cleanup(func() {
		constant.SetHomeDir(previousHome)
		GlobalValidationSourceHome = previousSource
	})
}

func TestParseAndValidateConfigDataPreservesRuntimeState(t *testing.T) {
	setValidationTestHome(t)
	previousNames := slices.Clone(config.GetProxyNameList())
	t.Cleanup(func() { config.SetProxyNameList(previousNames) })
	activeNames := []string{"Active first", "Active second"}
	config.SetProxyNameList(activeNames)
	before := executor.GetGeneral()
	candidateMode := tunnel.Global
	if before.Mode == candidateMode {
		candidateMode = tunnel.Direct
	}
	events := captureGeoUpdateEvents(t)

	for _, test := range []struct {
		name    string
		rule    string
		wantErr bool
	}{
		{name: "valid", rule: "MATCH,Candidate"},
		{name: "invalid rule after proxy parsing", rule: "DOMAIN,example.test,Unavailable", wantErr: true},
	} {
		t.Run(test.name, func(t *testing.T) {
			candidate := fmt.Sprintf(`mode: %s
ipv6: true
tcp-concurrent: true
find-process-mode: always
unified-delay: true
interface-name: validation-only
routing-mark: 4242
global-client-fingerprint: chrome
global-ua: validation-only
etag-support: true
keep-alive-idle: 7
keep-alive-interval: 11
disable-keep-alive: true
inbound-tfo: true
inbound-mptcp: true
geodata-loader: standard
geosite-matcher: succinct
proxy-groups:
  - name: Candidate
    type: select
    proxies: [DIRECT]
rules:
  - %s
`, candidateMode.String(), test.rule)
			err := parseAndValidateConfigData([]byte(candidate))
			if (err != nil) != test.wantErr {
				t.Fatalf("validation error = %v, wantErr %v", err, test.wantErr)
			}
			if names := config.GetProxyNameList(); !slices.Equal(names, activeNames) {
				t.Fatalf("active proxy order = %v, want %v", names, activeNames)
			}
			if after := executor.GetGeneral(); !reflect.DeepEqual(after, before) {
				t.Fatalf("validation changed live General:\nbefore: %#v\nafter: %#v", before, after)
			}
			for len(events) > 0 {
				if event := <-events; event.Type == ModeMessage {
					t.Fatalf("candidate validation published mode event: %#v", event)
				}
			}
			if configValidationInProgress.Load() {
				t.Fatal("validation notification suppression was left enabled")
			}
		})
	}

	// Real mode notifications remain enabled after both successful and failed
	// validation; invoke the installed hook without changing tunnel state.
	tunnel.ModeChangeHook(candidateMode)
	select {
	case event := <-events:
		if event.Type != ModeMessage {
			t.Fatalf("event type = %v, want mode", event.Type)
		}
	default:
		t.Fatal("real mode notification remained suppressed")
	}
}

func TestParseAndValidateConfigDataDoesNotOpenPersistentFakeIPCache(t *testing.T) {
	setValidationTestHome(t)
	candidate := []byte(`profile:
  store-fake-ip: true
dns:
  enable: true
  nameserver: [127.0.0.1]
  enhanced-mode: fake-ip
  fake-ip-range: 198.18.0.1/16
rules:
  - MATCH,DIRECT
`)
	if err := parseAndValidateConfigData(candidate); err != nil {
		t.Fatal(err)
	}
	if _, err := os.Stat(constant.Path.Cache()); !os.IsNotExist(err) {
		t.Fatalf("candidate validation opened the persistent cache: %v", err)
	}
}

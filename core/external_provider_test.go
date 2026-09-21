package main

import (
	"encoding/json"
	"fmt"
	"net/http"
	"net/http/httptest"
	"os"
	"os/exec"
	"path/filepath"
	"slices"
	"sync"
	"testing"
	"time"

	"github.com/metacubex/mihomo/config"
	"github.com/metacubex/mihomo/constant"
	"github.com/metacubex/mihomo/tunnel"
)

func TestExternalProviderRequestCompatibility(t *testing.T) {
	for _, test := range []struct{ data, name, kind string }{
		{`"shared"`, "shared", ""},
		{`{"providerName":"shared","providerType":"Proxy"}`, "shared", "Proxy"},
		{`{"providerName":"shared","providerType":"Rule"}`, "shared", "Rule"},
	} {
		var request ExternalProviderRequest
		if err := json.Unmarshal([]byte(test.data), &request); err != nil {
			t.Fatal(err)
		}
		if request.Name != test.name || request.Type != test.kind {
			t.Fatalf("decoded %s as %+v", test.data, request)
		}
	}
	var request ExternalProviderRequest
	if err := json.Unmarshal([]byte(`123`), &request); err == nil {
		t.Fatal("accepted invalid provider request")
	}
}

func TestExternalProvidersKeepSameNamedProxyAndRule(t *testing.T) {
	setValidationTestHome(t)
	proxyData := []byte("proxies:\n  - {name: node, type: ss, server: 127.0.0.1, port: 9, cipher: aes-128-gcm, password: test}\n")
	ruleData := []byte("payload: ['example.com']\n")
	proxyPath := filepath.Join(constant.Path.HomeDir(), "proxy.yaml")
	rulePath := filepath.Join(constant.Path.HomeDir(), "rule.yaml")
	for path, data := range map[string][]byte{proxyPath: proxyData, rulePath: ruleData} {
		if err := os.WriteFile(path, data, 0600); err != nil {
			t.Fatal(err)
		}
	}
	previousNames := slices.Clone(config.GetProxyNameList())
	previousProxies, previousProviders := tunnel.ProxiesSnapshot(), tunnel.ProvidersSnapshot()
	previousRules, previousRuleProviders := tunnel.Rules(), tunnel.RuleProvidersSnapshot()
	var previousSubRules map[string][]constant.Rule
	if currentConfig != nil {
		previousSubRules = currentConfig.SubRules
	}
	t.Cleanup(func() {
		config.SetProxyNameList(previousNames)
		tunnel.UpdateProxies(previousProxies, previousProviders)
		tunnel.UpdateRules(previousRules, previousSubRules, previousRuleProviders)
	})
	raw, err := config.UnmarshalRawConfig([]byte(`proxy-providers:
  shared: {type: file, path: proxy.yaml}
rule-providers:
  shared: {type: file, behavior: domain, format: yaml, path: rule.yaml}
proxy-groups:
  - {name: select, type: select, use: [shared]}
rules: ['RULE-SET,shared,select', 'MATCH,DIRECT']
`))
	if err != nil {
		t.Fatal(err)
	}
	parsed, err := config.ParseRawConfig(raw)
	if err != nil {
		t.Fatal(err)
	}
	defer closeParsedProviders(parsed)
	tunnel.UpdateProxies(parsed.Proxies, parsed.Providers)
	tunnel.UpdateRules(parsed.Rules, parsed.SubRules, parsed.RuleProviders)
	providers := handleGetExternalProviders()
	if len(providers) != 2 || providers[0].Name != "shared" || providers[0].Type != "Proxy" || providers[1].Type != "Rule" {
		t.Fatalf("same-named providers were lost: %+v", providers)
	}
	for _, kind := range []string{"Proxy", "Rule"} {
		p := handleGetExternalProvider("shared", kind)
		if p == nil || p.Type != kind {
			t.Fatalf("lookup %s returned %+v", kind, p)
		}
	}
	if p := handleGetExternalProvider("shared", ""); p == nil || p.Type != "Rule" {
		t.Fatal("legacy lookup changed precedence")
	}
	if p := handleGetExternalProvider("shared", "unknown"); p != nil {
		t.Fatal("unknown type selected a provider")
	}
	invoke := func(kind string, data []byte) string {
		t.Helper()
		result := make(chan string, 1)
		handleSideLoadExternalProvider("shared", kind, data, func(message string) { result <- message })
		select {
		case message := <-result:
			return message
		case <-time.After(3 * time.Second):
			t.Fatal("provider import did not complete")
			return ""
		}
	}
	if message := invoke("Proxy", []byte("invalid: [")); message == "" {
		t.Fatal("invalid proxy import succeeded")
	}
	if stored, err := os.ReadFile(proxyPath); err != nil || string(stored) != string(proxyData) {
		t.Fatal("invalid import replaced the valid proxy file")
	}
	nextRules := []byte("payload: ['new.example.com', 'other.example.com']\n")
	if message := invoke("Rule", nextRules); message != "" {
		t.Fatal(message)
	}
	if stored, err := os.ReadFile(rulePath); err != nil || string(stored) != string(nextRules) {
		t.Fatal("valid rule import was not persisted")
	}
	if stored, err := os.ReadFile(proxyPath); err != nil || string(stored) != string(proxyData) {
		t.Fatal("rule import changed same-named proxy file")
	}
	if p := handleGetExternalProvider("shared", "Rule"); p == nil || p.Count != 2 {
		t.Fatalf("valid flow-style rules were not loaded: %+v", p)
	}
	if message := invoke("Rule", []byte("payload:\n  - new.example.com\n  - [\n")); message == "" {
		t.Fatal("partially malformed rule import succeeded")
	}
	if stored, err := os.ReadFile(rulePath); err != nil || string(stored) != string(nextRules) {
		t.Fatal("invalid rule import replaced the valid rule file")
	}
	if p := handleGetExternalProvider("shared", "Rule"); p == nil || p.Count != 2 {
		t.Fatalf("invalid rule import changed active rules: %+v", p)
	}
	if message := invoke("Rule", []byte("payload: []\n")); message != "" {
		t.Fatal(message)
	}
	if p := handleGetExternalProvider("shared", "Rule"); p == nil || p.Count != 0 {
		t.Fatalf("explicit empty rules were not loaded: %+v", p)
	}
}

func TestExternalProviderUpdateDoesNotOutliveReapply(t *testing.T) {
	const childEnv = "FLCLASH_TEST_PROVIDER_REAPPLY_CHILD"
	if os.Getenv(childEnv) != "1" {
		command := exec.Command(os.Args[0], "-test.run=^TestExternalProviderUpdateDoesNotOutliveReapply$", "-test.count=1")
		command.Env = append(os.Environ(), childEnv+"=1")
		if output, err := command.CombinedOutput(); err != nil {
			t.Fatalf("isolated provider reapply: %v\n%s", err, output)
		}
		return
	}
	setValidationTestHome(t)
	data := func(name string) []byte {
		return []byte(fmt.Sprintf("proxies: [{name: %s, type: ss, server: 127.0.0.1, port: 9, cipher: aes-128-gcm, password: test}]\n", name))
	}
	path := filepath.Join(constant.Path.HomeDir(), "shared.yaml")
	if err := os.WriteFile(path, data("initial"), 0600); err != nil {
		t.Fatal(err)
	}
	started, release := make(chan struct{}), make(chan struct{})
	var startedOnce, releaseOnce sync.Once
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		startedOnce.Do(func() { close(started) })
		<-release
		_, _ = w.Write(data("stale"))
	}))
	defer server.Close()
	defer releaseOnce.Do(func() { close(release) })
	params := defaultSetupParams()
	params.RawConfig = fmt.Sprintf("mixed-port: 0\nexternal-controller: ''\nproxy-providers:\n  shared: {type: http, url: %q, path: shared.yaml, interval: 0}\nproxy-groups:\n  - {name: select, type: select, use: [shared]}\nrules: ['MATCH,DIRECT']\n", server.URL)
	if err := applyConfig(params); err != nil {
		t.Fatal(err)
	}
	defer closeCurrentProviders()
	active := currentConfig
	invalid := *params
	invalid.RawConfig = "proxy-groups: [{name: broken, type: select, proxies: [missing]}]"
	if err := applyConfig(&invalid); err == nil || currentConfig != active {
		t.Fatal("invalid candidate retired the active configuration")
	}
	result := make(chan string, 1)
	handleUpdateExternalProvider("shared", "Proxy", func(message string) { result <- message })
	select {
	case <-started:
	case <-time.After(3 * time.Second):
		t.Fatal("active provider stopped after invalid configuration")
	}
	if err := applyConfig(params); err != nil {
		t.Fatal(err)
	}
	imported := make(chan string, 1)
	handleSideLoadExternalProvider("shared", "Proxy", data("new"), func(message string) { imported <- message })
	if message := <-imported; message != "" {
		t.Fatal(message)
	}
	releaseOnce.Do(func() { close(release) })
	select {
	case message := <-result:
		if message == "" {
			t.Fatal("retired provider update succeeded")
		}
	case <-time.After(3 * time.Second):
		t.Fatal("retired update did not finish")
	}
	stored, err := os.ReadFile(path)
	if err != nil || string(stored) != string(data("new")) {
		t.Fatalf("retired provider replaced new import: %s (%v)", stored, err)
	}
}

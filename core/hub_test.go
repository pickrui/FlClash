package main

import (
	"encoding/json"
	"slices"
	"testing"
	"time"

	"github.com/metacubex/mihomo/adapter"
	"github.com/metacubex/mihomo/adapter/outbound"
	"github.com/metacubex/mihomo/config"
	"github.com/metacubex/mihomo/constant"
	"github.com/metacubex/mihomo/tunnel"
)

func TestPatchSelectGroupPublishesAppliedProxySnapshot(t *testing.T) {
	previousProxies := tunnel.Proxies()
	previousProviders := tunnel.Providers()
	selectionLock.Lock()
	previousSnapshot := proxySnapshot
	selectionLock.Unlock()
	t.Cleanup(func() {
		tunnel.UpdateProxies(previousProxies, previousProviders)
		publishProxySnapshot(previousSnapshot)
	})

	oldProxy := adapter.NewProxy(outbound.NewDirect())
	newProxy := adapter.NewProxy(outbound.NewDirect())
	publishProxySnapshot(map[string]constant.Proxy{"DIRECT": oldProxy})
	tunnel.UpdateProxies(
		map[string]constant.Proxy{"DIRECT": newProxy},
		nil,
	)

	patchSelectGroup(nil)

	selectionLock.Lock()
	got := proxySnapshot["DIRECT"]
	selectionLock.Unlock()
	if got != newProxy {
		t.Fatalf("proxy snapshot = %p, want applied proxy %p", got, newProxy)
	}
}

func TestHandleChangeProxyDoesNotWaitForConfigApply(t *testing.T) {
	runLock.Lock()
	defer runLock.Unlock()

	groupName := "missing"
	proxyName := "node"
	answered := make(chan string, 1)
	go func() {
		answered <- handleChangeProxy(
			&ChangeProxyParams{GroupName: &groupName, ProxyName: &proxyName},
		)
	}()

	select {
	case message := <-answered:
		if message != "Not found group" {
			t.Fatalf("message = %q, want missing group error", message)
		}
	case <-time.After(time.Second):
		t.Fatal("proxy selection waited for the whole config apply")
	}
}

func TestHandleGetProxiesPreservesGroupsWhenProviderNodesShareTheirNames(t *testing.T) {
	setValidationTestHome(t)
	previousNames := slices.Clone(config.GetProxyNameList())
	previousProxies, previousProviders := tunnel.Proxies(), tunnel.Providers()
	selectionLock.Lock()
	previousSnapshot := proxySnapshot
	selectionLock.Unlock()
	t.Cleanup(func() {
		config.SetProxyNameList(previousNames)
		tunnel.UpdateProxies(previousProxies, previousProviders)
		publishProxySnapshot(previousSnapshot)
	})

	raw, err := config.UnmarshalRawConfig([]byte(`proxy-providers:
  cloud:
    type: inline
    payload:
      - {name: Personal, type: ss, server: 127.0.0.1, port: 9, cipher: aes-128-gcm, password: test}
      - {name: GLOBAL, type: ss, server: 127.0.0.1, port: 9, cipher: aes-128-gcm, password: test}
      - {name: Unique, type: ss, server: 127.0.0.1, port: 9, cipher: aes-128-gcm, password: test}
proxy-groups:
  - {name: Personal, type: select, use: [cloud], hidden: false, icon: custom-icon, url: 'https://example.test/check'}
  - {name: Nested, type: select, proxies: [Personal]}
rules: ['MATCH,Personal']
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
	patchSelectGroup(nil)

	for range 128 {
		data := handleGetProxies()
		for _, name := range []string{"GLOBAL", "Personal", "Nested"} {
			if !slices.Contains(data.All, name) || data.Proxies[name] != parsed.Proxies[name] {
				t.Fatalf("provider node replaced live group %q: all=%v", name, data.All)
			}
		}
		personal := data.GroupMembers["Personal"]
		if len(personal) != 2 || personal["Personal"].Name != "Personal" || personal["Personal"].Type != "Shadowsocks" || personal["GLOBAL"].Name != "GLOBAL" || personal["GLOBAL"].Type != "Shadowsocks" {
			t.Fatalf("personal members do not match the live provider nodes: %#v", personal)
		}
		nested := data.GroupMembers["Nested"]
		if len(nested) != 0 {
			t.Fatalf("unambiguous nested members were duplicated in the snapshot: %#v", nested)
		}
		groupName, proxyName := "Personal", "GLOBAL"
		if message := handleChangeProxy(&ChangeProxyParams{GroupName: &groupName, ProxyName: &proxyName}); message != "" {
			t.Fatalf("valid selection failed after reading a snapshot: %s", message)
		}
		proxyName = "Personal"
		if message := handleChangeProxy(&ChangeProxyParams{GroupName: &groupName, ProxyName: &proxyName}); message != "" {
			t.Fatal(message)
		}
	}

	encoded, err := json.Marshal(handleGetProxies())
	if err != nil {
		t.Fatal(err)
	}
	var wire struct {
		Proxies      map[string]map[string]any              `json:"proxies"`
		GroupMembers map[string]map[string]ProxyGroupMember `json:"groupMembers"`
	}
	if err := json.Unmarshal(encoded, &wire); err != nil {
		t.Fatal(err)
	}
	personal := wire.Proxies["Personal"]
	if personal["type"] != "Selector" || personal["hidden"] != false || personal["icon"] != "custom-icon" || personal["testUrl"] != "https://example.test/check" || personal["now"] != "Personal" {
		t.Fatalf("group metadata changed in the wire snapshot: %#v", personal)
	}
	if members, ok := personal["all"].([]any); !ok || len(members) != 3 || members[0] != "Personal" || members[1] != "GLOBAL" || members[2] != "Unique" {
		t.Fatalf("wire snapshot lost original member names: %#v", personal["all"])
	}
	if members := wire.GroupMembers["Personal"]; len(members) != 2 || members["Personal"].Type != "Shadowsocks" {
		t.Fatalf("scoped members were lost during serialization: %#v", members)
	}
}

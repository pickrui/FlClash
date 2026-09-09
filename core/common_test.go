package main

import (
	"errors"
	"slices"
	"testing"

	"github.com/metacubex/mihomo/config"
	"github.com/metacubex/mihomo/constant"
	"github.com/metacubex/mihomo/tunnel"
)

type testSelectable struct {
	selected string
	valid    map[string]bool
	fallback string
}

func TestDefaultTestURLUsesCloudflare(t *testing.T) {
	if constant.DefaultTestURL != defaultTestURL {
		t.Fatalf("DefaultTestURL = %q, want %q", constant.DefaultTestURL, defaultTestURL)
	}
	if params := defaultSetupParams(); params.TestURL != defaultTestURL {
		t.Fatalf("SetupParams.TestURL = %q, want %q", params.TestURL, defaultTestURL)
	}
}

func (selector *testSelectable) Set(name string) error {
	if !selector.valid[name] {
		return errors.New("proxy not exist")
	}
	selector.selected = name
	return nil
}

func (selector *testSelectable) ForceSet(name string) {
	selector.selected = name
}

func (selector *testSelectable) Now() string {
	if selector.valid[selector.selected] {
		return selector.selected
	}
	return selector.fallback
}

func TestRestoreSelectorSelection(t *testing.T) {
	tests := []struct {
		name     string
		selected string
		want     string
	}{
		{name: "keeps existing selection", selected: "second", want: "second"},
		{name: "falls back when selection is missing", selected: "removed", want: "first"},
		{name: "falls back when selection is empty", selected: "", want: "first"},
	}

	for _, test := range tests {
		t.Run(test.name, func(t *testing.T) {
			selector := &testSelectable{
				valid:    map[string]bool{"first": true, "second": true},
				fallback: "first",
			}
			restoreSelectorSelection(selector, test.selected)
			if selector.selected != test.want {
				t.Fatalf("selected = %q, want %q", selector.selected, test.want)
			}
		})
	}
}

func TestNormalizeSelectorSelection(t *testing.T) {
	selector := &testSelectable{
		selected: "removed",
		valid:    map[string]bool{"first": true},
		fallback: "first",
	}
	normalizeSelectorSelection(selector)
	if selector.selected != "first" {
		t.Fatalf("selected = %q, want %q", selector.selected, "first")
	}
}

func TestHandleUpdateConfigBeforeSetup(t *testing.T) {
	previousConfig := currentConfig
	currentConfig = nil
	t.Cleanup(func() {
		currentConfig = previousConfig
	})

	if message := handleUpdateConfig(&UpdateParams{}); message != "" {
		t.Fatalf("message = %q, want empty", message)
	}
}

func TestLogSubscriptionLifecycle(t *testing.T) {
	previousIsInit := isInit.Load()
	isInit.Store(true)
	t.Cleanup(func() {
		isInit.Store(previousIsInit)
		handleStopLog()
	})

	handleStartLog()
	first := logSubscriber
	if first == nil {
		t.Fatal("first log subscription is nil")
	}

	handleStartLog()
	second := logSubscriber
	if second == nil {
		t.Fatal("second log subscription is nil")
	}
	if first == second {
		t.Fatal("log subscription was not replaced")
	}

	handleStopLog()
	if logSubscriber != nil {
		t.Fatal("log subscription was not cleared")
	}
}

func TestApplyConfigRejectsCandidateWithoutReplacingLiveRouting(t *testing.T) {
	setValidationTestHome(t)
	previousConfig, previousURL := currentConfig, constant.DefaultTestURL
	previousNames := slices.Clone(config.GetProxyNameList())
	t.Cleanup(func() {
		currentConfig = previousConfig
		constant.DefaultTestURL = previousURL
		config.SetProxyNameList(previousNames)
	})
	active := &config.Config{General: &config.General{}}
	active.General.MixedPort = 12345
	currentConfig = active
	activeNames := []string{"Active"}
	config.SetProxyNameList(activeNames)
	activeProxies := tunnel.Proxies()
	for _, candidate := range []string{
		"proxy-groups: [",
		"proxy-groups: [{name: Candidate, type: select, proxies: [DIRECT]}]\nrules: ['MATCH,Missing']",
	} {
		params := defaultSetupParams()
		params.RawConfig = candidate
		params.TestURL = "https://candidate.invalid/check"
		if err := applyConfig(params); err == nil {
			t.Fatal("invalid candidate accepted")
		}
		if currentConfig != active {
			t.Fatal("failed candidate replaced active config")
		}
		if constant.DefaultTestURL != previousURL {
			t.Fatal("failed candidate changed test URL")
		}
		if !slices.Equal(config.GetProxyNameList(), activeNames) {
			t.Fatal("failed candidate changed group order")
		}
		for name, proxy := range activeProxies {
			if tunnel.Proxies()[name] != proxy {
				t.Fatalf("failed candidate replaced proxy %s", name)
			}
		}
	}
}

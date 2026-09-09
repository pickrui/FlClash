//go:build cgo

package main

import (
	"reflect"
	"slices"
	"testing"
	"time"

	"github.com/metacubex/mihomo/config"
	"github.com/metacubex/mihomo/hub/executor"
)

func TestIsolatedValidateConfigData(t *testing.T) {
	tests := []struct {
		name    string
		config  string
		wantErr bool
	}{
		{
			name: "valid config",
			config: "proxy-groups:\n" +
				"  - name: Proxy\n" +
				"    type: select\n" +
				"    proxies:\n" +
				"      - DIRECT\n" +
				"rules:\n" +
				"  - MATCH,Proxy\n",
		},
		{
			name: "group without members",
			config: "proxy-groups:\n" +
				"  - name: Proxy\n" +
				"    type: select\n" +
				"rules:\n" +
				"  - MATCH,Proxy\n",
			wantErr: true,
		},
		{
			name: "removed relay group",
			config: "proxy-groups:\n" +
				"  - name: Relay\n" +
				"    type: relay\n" +
				"    proxies:\n" +
				"      - DIRECT\n" +
				"rules:\n" +
				"  - MATCH,Relay\n",
			wantErr: true,
		},
	}

	for _, test := range tests {
		t.Run(test.name, func(t *testing.T) {
			message := isolatedValidateConfigData([]byte(test.config))
			if (message != "") != test.wantErr {
				t.Fatalf("isolatedValidateConfigData() = %q, wantErr %v", message, test.wantErr)
			}
		})
	}
}

func TestIsolatedValidateConfigDataWaitsForRuntimeApply(t *testing.T) {
	setValidationTestHome(t)
	previousNames := slices.Clone(config.GetProxyNameList())
	t.Cleanup(func() { config.SetProxyNameList(previousNames) })
	before := executor.GetGeneral()

	runLock.Lock()
	locked := true
	defer func() {
		if locked {
			runLock.Unlock()
		}
	}()
	config.SetProxyNameList([]string{"Previous"})
	started := make(chan struct{})
	done := make(chan string, 1)
	go func() {
		close(started)
		done <- isolatedValidateConfigData([]byte("rules: [\"MATCH,DIRECT\"]"))
	}()
	<-started
	select {
	case message := <-done:
		t.Fatalf("validation ran while the runtime apply lock was held: %q", message)
	case <-time.After(50 * time.Millisecond):
	}

	// Model a new apply completing while validation is queued. Its freshly
	// published order must be the snapshot validation later preserves.
	appliedNames := []string{"New active group"}
	config.SetProxyNameList(appliedNames)
	runLock.Unlock()
	locked = false
	select {
	case message := <-done:
		if message != "" {
			t.Fatalf("validation failed: %s", message)
		}
	case <-time.After(5 * time.Second):
		t.Fatal("validation did not resume after the runtime apply lock released")
	}
	if names := config.GetProxyNameList(); !slices.Equal(names, appliedNames) {
		t.Fatalf("queued validation reverted newly applied proxy order: %v", names)
	}
	if after := executor.GetGeneral(); !reflect.DeepEqual(after, before) {
		t.Fatal("queued validation changed runtime General settings")
	}
}

package main

import (
	"encoding/json"
	"testing"

	"github.com/metacubex/mihomo/config"
)

func TestTunMTUUpdateReachesLiveConfig(t *testing.T) {
	previous, running := currentConfig, isRunning
	currentConfig = &config.Config{General: &config.General{}}
	isRunning = false
	t.Cleanup(func() { currentConfig, isRunning = previous, running })

	for _, mtu := range []int{1280, 1480, 4064, 9000, 65535, 0, -1, 65536} {
		currentConfig.General.Tun.MTU = 9000
		encoded, err := json.Marshal(map[string]any{"tun": map[string]any{
			"enable": false, "auto-route": false, "device": "FlClash", "stack": "mixed",
			"dns-hijack": []string{}, "route-address": []string{}, "mtu": mtu,
		}})
		if err != nil {
			t.Fatal(err)
		}
		var params UpdateParams
		if err := json.Unmarshal(encoded, &params); err != nil {
			t.Fatal(err)
		}
		if err := updateConfig(&params); err != nil {
			t.Fatal(err)
		}
		want := mtu
		if want < 1280 || want > 65535 {
			want = 9000
		}
		if got := currentConfig.General.Tun.MTU; got != uint32(want) {
			t.Fatalf("MTU %d: live MTU = %d, want %d", mtu, got, want)
		}
	}
}

func TestTunPatchPreservesOmittedFields(t *testing.T) {
	previous, running := currentConfig, isRunning
	currentConfig = &config.Config{General: &config.General{}}
	isRunning = false
	t.Cleanup(func() { currentConfig, isRunning = previous, running })
	currentConfig.General.Tun.MTU = 1480
	currentConfig.General.Tun.Device = "existing-tun"
	currentConfig.General.Tun.AutoRoute = true
	for _, source := range []string{`{"tun":{"enable":false}}`, `{"tun":{"enable":false,"mtu":4064}}`} {
		var params UpdateParams
		if err := json.Unmarshal([]byte(source), &params); err != nil {
			t.Fatal(err)
		}
		if err := updateConfig(&params); err != nil {
			t.Fatal(err)
		}
		wantMTU := uint32(1480)
		if params.Tun.MTU != nil {
			wantMTU = 4064
		}
		tun := currentConfig.General.Tun
		if tun.MTU != wantMTU || tun.Device != "existing-tun" || !tun.AutoRoute {
			t.Fatalf("partial patch discarded existing TUN settings: %+v", tun)
		}
	}
}

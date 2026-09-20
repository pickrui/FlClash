package main

import (
	"encoding/json"
	"testing"

	"github.com/metacubex/mihomo/config"
	C "github.com/metacubex/mihomo/constant"
)

func TestTunStackUpdateReachesLiveConfig(t *testing.T) {
	stubLiveConfig(t)

	for _, test := range []struct {
		name string
		want C.TUNStack
	}{
		{"gvisor", C.TunGvisor},
		{"system", C.TunSystem},
		{"mixed", C.TunMixed},
		{"mips", C.TunMips},
	} {
		t.Run(test.name, func(t *testing.T) {
			raw, err := config.UnmarshalRawConfig([]byte("tun:\n  stack: " + test.name + "\n"))
			if err != nil {
				t.Fatal(err)
			}
			if raw.Tun.Stack != test.want {
				t.Fatalf("YAML stack = %v, want %v", raw.Tun.Stack, test.want)
			}
			var params UpdateParams
			if err := json.Unmarshal([]byte(`{"tun":{"stack":"`+test.name+`"}}`), &params); err != nil {
				t.Fatal(err)
			}
			if err := updateConfig(&params); err != nil {
				t.Fatal(err)
			}
			if got := currentConfig.General.Tun.Stack; got != test.want {
				t.Fatalf("live stack = %v, want %v", got, test.want)
			}
		})
	}
}

func TestTunMTUUpdateReachesLiveConfig(t *testing.T) {
	stubLiveConfig(t)

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
	stubLiveConfig(t)
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

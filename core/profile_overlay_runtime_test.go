package main

import (
	"context"
	"encoding/json"
	"errors"
	"io"
	"net/netip"
	"os"
	"slices"
	"testing"
	"time"

	"github.com/metacubex/mihomo/adapter/outboundgroup"
	mihomoYaml "github.com/metacubex/mihomo/common/yaml"
	"github.com/metacubex/mihomo/config"
	C "github.com/metacubex/mihomo/constant"
)

// This test is driven by makeRealProfileTask output, not a separately maintained
// Go approximation of the app's merge. Build with CGO_ENABLED=0 go test -c and set
// FLCLASH_TEST_ROUTING_CHECKER to that executable when running Flutter's native
// overlay tests. All nodes are synthetic and rejection performs no network I/O.
func TestPersonalOverlayRuntimeFromGeneratedConfig(t *testing.T) {
	path := os.Getenv("FLCLASH_ROUTING_FIXTURE")
	if path == "" {
		t.Skip("set FLCLASH_ROUTING_FIXTURE to the Dart-generated runtime fixture")
	}
	data, err := os.ReadFile(path)
	if err != nil {
		t.Fatal(err)
	}
	var fixture struct {
		Config map[string]any `json:"config"`
		Checks []struct {
			Host     string `json:"host"`
			Target   string `json:"target"`
			Outbound string `json:"outbound"`
			Reject   bool   `json:"reject"`
		} `json:"checks"`
		Selections []struct {
			Group string `json:"group"`
			Name  string `json:"name"`
			Valid bool   `json:"valid"`
		} `json:"selections"`
	}
	if err := json.Unmarshal(data, &fixture); err != nil {
		t.Fatal(err)
	}
	if len(fixture.Checks) == 0 {
		t.Fatal("fixture must contain actual matching assertions")
	}
	setValidationTestHome(t)
	previousNames := slices.Clone(config.GetProxyNameList())
	t.Cleanup(func() { config.SetProxyNameList(previousNames) })
	yamlData, err := mihomoYaml.Marshal(fixture.Config)
	if err != nil {
		t.Fatal(err)
	}
	raw, err := config.UnmarshalRawConfig(yamlData)
	if err != nil {
		t.Fatal(err)
	}
	parsed, err := config.ParseRawConfig(raw)
	if err != nil {
		t.Fatal(err)
	}
	defer closeParsedProviders(parsed)
	for _, check := range fixture.Checks {
		t.Run(check.Host, func(t *testing.T) {
			metadata := &C.Metadata{
				Host: check.Host, NetWork: C.TCP,
				DstIP: netip.MustParseAddr("127.0.0.1"), DstPort: 9,
			}
			var target string
			for _, rule := range parsed.Rules {
				if matched, adapter := rule.Match(metadata, C.RuleMatchHelper{}); matched {
					target = adapter
					break
				}
			}
			if target != check.Target {
				t.Fatalf("matched target %q, want %q", target, check.Target)
			}
			proxy := parsed.Proxies[target]
			if proxy == nil {
				t.Fatalf("matched an unavailable outbound %q", target)
			}
			leaf := proxy
			for depth := 0; ; depth++ {
				if depth > len(parsed.Proxies) {
					t.Fatal("outbound traversal did not terminate")
				}
				next := leaf.Unwrap(metadata, false)
				if next == nil {
					break
				}
				leaf = next
			}
			if leaf.Name() != check.Outbound {
				t.Fatalf("selected outbound %q, want %q", leaf.Name(), check.Outbound)
			}
			if check.Reject {
				if leaf.Type() != C.Reject {
					t.Fatalf("empty group fell back to %s instead of rejecting", leaf.Type())
				}
				ctx, cancel := context.WithTimeout(context.Background(), time.Second)
				defer cancel()
				conn, err := proxy.DialContext(ctx, metadata)
				if err != nil {
					t.Fatal(err)
				}
				defer conn.Close()
				if _, err := conn.Read(make([]byte, 1)); !errors.Is(err, io.EOF) {
					t.Fatalf("empty group connection did not immediately reject: %v", err)
				}
			}
		})
	}
	for _, selection := range fixture.Selections {
		t.Run(selection.Group+"/select/"+selection.Name, func(t *testing.T) {
			proxy := parsed.Proxies[selection.Group]
			if proxy == nil {
				t.Fatalf("missing selector %q", selection.Group)
			}
			selector, ok := proxy.Adapter().(*outboundgroup.Selector)
			if !ok {
				t.Fatalf("%q is not a selector", selection.Group)
			}
			before := selector.Now()
			err := selector.Set(selection.Name)
			if (err == nil) != selection.Valid {
				t.Fatalf("selection %q returned %v, want valid %t", selection.Name, err, selection.Valid)
			}
			want := before
			if selection.Valid {
				want = selection.Name
			}
			if actual := selector.Now(); actual != want {
				t.Fatalf("effective selection %q, want %q", actual, want)
			}
		})
	}
}

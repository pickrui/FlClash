package main

import (
	"strings"
	"testing"

	"gopkg.in/yaml.v3"
)

func TestNormalizeConfigShortIdsRetagsNumericScalars(t *testing.T) {
	input := []byte(`proxies:
  - name: a
    type: vless
    reality-opts:
      public-key: pk
      short-id: 0123
  - name: b
    type: vless
    reality-opts:
      short-id: 123456
  - name: c
    type: vless
    reality-opts:
      short-id: 1e2
`)
	out := normalizeConfigShortIds(input)
	var parsed struct {
		Proxies []struct {
			RealityOpts struct {
				ShortID string `yaml:"short-id"`
			} `yaml:"reality-opts"`
		} `yaml:"proxies"`
	}
	if err := yaml.Unmarshal(out, &parsed); err != nil {
		t.Fatalf("normalized output is not valid yaml: %v", err)
	}
	got := []string{
		parsed.Proxies[0].RealityOpts.ShortID,
		parsed.Proxies[1].RealityOpts.ShortID,
		parsed.Proxies[2].RealityOpts.ShortID,
	}
	want := []string{"0123", "123456", "1e2"}
	for i := range want {
		if got[i] != want[i] {
			t.Fatalf("short-id[%d] = %q, want %q", i, got[i], want[i])
		}
	}
}

func TestNormalizeConfigShortIdsLeavesOtherValuesAlone(t *testing.T) {
	input := []byte(`mixed-port: 7890
proxies:
  - name: a
    type: vless
    port: 443
    reality-opts:
      public-key: pk
      short-id: abcd12
`)
	out := normalizeConfigShortIds(input)
	if string(out) != string(input) {
		t.Fatalf("expected untouched config to be returned as-is, got:\n%s", out)
	}
}

func TestNormalizeConfigShortIdsIgnoresInvalidYaml(t *testing.T) {
	input := []byte("proxies: [::bad")
	if got := normalizeConfigShortIds(input); string(got) != string(input) {
		t.Fatalf("invalid yaml should be returned unchanged")
	}
}

func TestNormalizeConfigShortIdsIgnoresShortIdOutsideRealityOpts(t *testing.T) {
	input := []byte(`some-map:
  short-id: 1234
`)
	out := normalizeConfigShortIds(input)
	if strings.Contains(string(out), `"1234"`) {
		t.Fatalf("short-id outside reality-opts should not be retagged, got:\n%s", out)
	}
}

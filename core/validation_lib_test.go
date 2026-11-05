//go:build cgo

package main

import "testing"

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

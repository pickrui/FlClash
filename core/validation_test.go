//go:build !cgo

package main

import (
	"fmt"
	"io"
	"net/http"
	"net/http/httptest"
	"os"
	"path/filepath"
	"strings"
	"testing"
	"time"

	metaAge "github.com/metacubex/mihomo/component/age"
	"github.com/metacubex/mihomo/component/ca"
	"github.com/metacubex/mihomo/constant"
	"github.com/metacubex/mihomo/tunnel"
)

type testProviderCloser struct {
	closed bool
}

func (provider *testProviderCloser) Close() error {
	provider.closed = true
	return nil
}

func TestCloseProvider(t *testing.T) {
	provider := &testProviderCloser{}
	closeProvider(provider)
	if !provider.closed {
		t.Fatal("closeProvider() did not close the provider")
	}
	closeCurrentProviders()
	closeCurrentProviders()
	if len(tunnel.Providers()) != 0 || len(tunnel.RuleProviders()) != 0 {
		t.Fatal("closeCurrentProviders() did not clear provider maps")
	}
}

func TestValidateConfigData(t *testing.T) {
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
			err := parseConfigData([]byte(test.config))
			if (err != nil) != test.wantErr {
				t.Fatalf("parseConfigData() = %v, wantErr %v", err, test.wantErr)
			}
		})
	}
}

func TestPrepareValidationResourcesCopiesOnlyReferencedFiles(t *testing.T) {
	source := t.TempDir()
	target := t.TempDir()
	oldHome := constant.Path.HomeDir()
	oldSourceHome := GlobalValidationSourceHome
	constant.SetHomeDir(target)
	GlobalValidationSourceHome = source
	t.Cleanup(func() {
		constant.SetHomeDir(oldHome)
		GlobalValidationSourceHome = oldSourceHome
	})
	geoPath := filepath.Join(source, "GeoIP.dat")
	if err := os.WriteFile(geoPath, []byte("geo"), 0o600); err != nil {
		t.Fatal(err)
	}
	keyPath := filepath.Join(source, "keys", "id_ed25519")
	if err := os.MkdirAll(filepath.Dir(keyPath), 0o700); err != nil {
		t.Fatal(err)
	}
	if err := os.WriteFile(keyPath, []byte("private"), 0o600); err != nil {
		t.Fatal(err)
	}
	unrelatedPath := filepath.Join(source, "unrelated.bin")
	if err := os.WriteFile(unrelatedPath, nil, 0o600); err != nil {
		t.Fatal(err)
	}
	if err := os.Truncate(unrelatedPath, 129*1024*1024); err != nil {
		t.Fatal(err)
	}

	config := []byte("proxies:\n" +
		"  - name: Local SSH\n" +
		"    type: ssh\n" +
		"    private-key: keys/id_ed25519\n")
	if err := prepareValidationResources(config); err != nil {
		t.Fatal(err)
	}
	copied, err := os.ReadFile(filepath.Join(target, "GeoIP.dat"))
	if err != nil || string(copied) != "geo" {
		t.Fatalf("copied asset = %q, err = %v", copied, err)
	}
	key, err := os.ReadFile(filepath.Join(target, "keys", "id_ed25519"))
	if err != nil || string(key) != "private" {
		t.Fatalf("copied relative resource = %q, err = %v", key, err)
	}
	if _, err := os.Stat(filepath.Join(target, "unrelated.bin")); !os.IsNotExist(err) {
		t.Fatalf("unexpected unrelated file copy: %v", err)
	}
	if err := os.WriteFile(filepath.Join(target, "GeoIP.dat"), []byte("changed"), 0o600); err != nil {
		t.Fatal(err)
	}
	original, err := os.ReadFile(geoPath)
	if err != nil || string(original) != "geo" {
		t.Fatalf("source asset changed = %q, err = %v", original, err)
	}
}

func TestPrepareValidationResourcesRejectsOversizedReferencedFile(t *testing.T) {
	source := t.TempDir()
	target := t.TempDir()
	oldHome := constant.Path.HomeDir()
	oldSourceHome := GlobalValidationSourceHome
	constant.SetHomeDir(target)
	GlobalValidationSourceHome = source
	t.Cleanup(func() {
		constant.SetHomeDir(oldHome)
		GlobalValidationSourceHome = oldSourceHome
	})
	largePath := filepath.Join(source, "large.pem")
	if err := os.WriteFile(largePath, nil, 0o600); err != nil {
		t.Fatal(err)
	}
	if err := os.Truncate(largePath, 129*1024*1024); err != nil {
		t.Fatal(err)
	}
	if err := prepareValidationResources([]byte("proxies:\n  - name: SSH\n    type: ssh\n    private-key: large.pem\n")); err == nil {
		t.Fatal("prepareValidationResources() accepted an oversized referenced file")
	}
}

func TestPrepareValidationResourcesRejectsSymbolicLink(t *testing.T) {
	source := t.TempDir()
	target := t.TempDir()
	outside := filepath.Join(t.TempDir(), "secret.pem")
	if err := os.WriteFile(outside, []byte("secret"), 0o600); err != nil {
		t.Fatal(err)
	}
	if err := os.Symlink(filepath.Dir(outside), filepath.Join(source, "linked")); err != nil {
		t.Skipf("symbolic links are unavailable: %v", err)
	}
	oldHome := constant.Path.HomeDir()
	oldSourceHome := GlobalValidationSourceHome
	constant.SetHomeDir(target)
	GlobalValidationSourceHome = source
	t.Cleanup(func() {
		constant.SetHomeDir(oldHome)
		GlobalValidationSourceHome = oldSourceHome
	})
	if err := prepareValidationResources(
		[]byte("proxies:\n  - name: SSH\n    type: ssh\n    private-key: linked/secret.pem\n"),
	); err == nil {
		t.Fatal("prepareValidationResources() accepted a symbolic link path")
	}
}

func TestOpenValidationResourceFallback(t *testing.T) {
	source := t.TempDir()
	dataPath := filepath.Join(source, "ASN.mmdb")
	if err := os.WriteFile(dataPath, []byte("asn"), 0o600); err != nil {
		t.Fatal(err)
	}
	sourceRoot, err := os.OpenRoot(source)
	if err != nil {
		t.Fatal(err)
	}
	defer sourceRoot.Close()
	input, err := openValidationResourceFallback(sourceRoot, "ASN.mmdb")
	if err != nil {
		t.Fatal(err)
	}
	defer input.Close()
	data, err := io.ReadAll(input)
	if err != nil {
		t.Fatal(err)
	}
	if string(data) != "asn" {
		t.Fatalf("fallback data = %q, want asn", data)
	}
}

func TestOpenValidationResourceFallbackRejectsSymbolicLink(t *testing.T) {
	source := t.TempDir()
	outside := filepath.Join(t.TempDir(), "ASN.mmdb")
	if err := os.WriteFile(outside, []byte("asn"), 0o600); err != nil {
		t.Fatal(err)
	}
	if err := os.Symlink(outside, filepath.Join(source, "ASN.mmdb")); err != nil {
		t.Skipf("symbolic links are unavailable: %v", err)
	}
	sourceRoot, err := os.OpenRoot(source)
	if err != nil {
		t.Fatal(err)
	}
	defer sourceRoot.Close()
	if input, err := openValidationResourceFallback(sourceRoot, "ASN.mmdb"); err == nil {
		_ = input.Close()
		t.Fatal("fallback accepted a symbolic link")
	}
}

func TestPrepareValidationResourcesRejectsDirectory(t *testing.T) {
	source := t.TempDir()
	target := t.TempDir()
	filePath := filepath.Join(source, "certs", "cert.pem")
	if err := os.MkdirAll(filepath.Dir(filePath), 0o700); err != nil {
		t.Fatal(err)
	}
	if err := os.WriteFile(filePath, []byte("certificate"), 0o600); err != nil {
		t.Fatal(err)
	}
	oldHome := constant.Path.HomeDir()
	oldSourceHome := GlobalValidationSourceHome
	constant.SetHomeDir(target)
	GlobalValidationSourceHome = source
	t.Cleanup(func() {
		constant.SetHomeDir(oldHome)
		GlobalValidationSourceHome = oldSourceHome
	})
	config := []byte("proxies:\n  - name: SSH\n    type: ssh\n    private-key: certs\n")
	if err := prepareValidationResources(config); err == nil {
		t.Fatal("prepareValidationResources() accepted a directory")
	}
}

func TestPrepareValidationResourcesRejectsAbsolutePath(t *testing.T) {
	source := t.TempDir()
	target := t.TempDir()
	outside := filepath.Join(t.TempDir(), "id_ed25519")
	if err := os.WriteFile(outside, []byte("private"), 0o600); err != nil {
		t.Fatal(err)
	}
	oldHome := constant.Path.HomeDir()
	oldSourceHome := GlobalValidationSourceHome
	constant.SetHomeDir(target)
	GlobalValidationSourceHome = source
	t.Cleanup(func() {
		constant.SetHomeDir(oldHome)
		GlobalValidationSourceHome = oldSourceHome
	})
	config := []byte("proxies:\n  - name: SSH\n    type: ssh\n    private-key: " + outside + "\n")
	if err := prepareValidationResources(config); err == nil {
		t.Fatal("prepareValidationResources() accepted an absolute path")
	}
}

func TestPrepareValidationConfigRewritesAbsoluteProviderPathInsideSourceHome(t *testing.T) {
	source := t.TempDir()
	target := t.TempDir()
	relativePath := filepath.Join(
		"profiles",
		"providers",
		"334754661208690688",
		"rules",
		"5562af05d1addce5d9ce8c9a3a68c89e",
	)
	providerPath := filepath.Join(source, relativePath)
	if err := os.MkdirAll(filepath.Dir(providerPath), 0o700); err != nil {
		t.Fatal(err)
	}
	if err := os.WriteFile(
		providerPath,
		[]byte("payload:\n  - example.com\n"),
		0o600,
	); err != nil {
		t.Fatal(err)
	}
	oldHome := constant.Path.HomeDir()
	oldSourceHome := GlobalValidationSourceHome
	constant.SetHomeDir(target)
	GlobalValidationSourceHome = source
	t.Cleanup(func() {
		constant.SetHomeDir(oldHome)
		GlobalValidationSourceHome = oldSourceHome
	})
	configData := []byte(fmt.Sprintf(
		"rule-providers:\n  Local:\n    type: file\n    behavior: domain\n    format: yaml\n    path: %q\n",
		providerPath,
	))

	rawConfig, err := prepareValidationConfig(configData)
	if err != nil {
		t.Fatal(err)
	}
	if got := rawConfig.RuleProvider["Local"]["path"]; got != relativePath {
		t.Fatalf("normalized provider path = %v, want %s", got, relativePath)
	}
	if data, err := os.ReadFile(filepath.Join(target, relativePath)); err != nil ||
		string(data) != "payload:\n  - example.com\n" {
		t.Fatalf("copied provider = %q, err = %v", data, err)
	}

	if err := os.RemoveAll(target); err != nil {
		t.Fatal(err)
	}
	if err := os.MkdirAll(target, 0o700); err != nil {
		t.Fatal(err)
	}
	if err := parseAndValidateConfigData(configData); err != nil {
		t.Fatalf("parseAndValidateConfigData() rejected app-home provider: %v", err)
	}
}

func TestPrepareValidationResourcesCopiesProviderProxyResources(t *testing.T) {
	source := t.TempDir()
	target := t.TempDir()
	providerPath := filepath.Join(source, "providers", "local.yaml")
	keyPath := filepath.Join(source, "keys", "id_ed25519")
	if err := os.MkdirAll(filepath.Dir(providerPath), 0o700); err != nil {
		t.Fatal(err)
	}
	if err := os.MkdirAll(filepath.Dir(keyPath), 0o700); err != nil {
		t.Fatal(err)
	}
	if err := os.WriteFile(providerPath, []byte("proxies:\n  - name: SSH\n    type: ssh\n    private-key: keys/id_ed25519\n"), 0o600); err != nil {
		t.Fatal(err)
	}
	if err := os.WriteFile(keyPath, []byte("private"), 0o600); err != nil {
		t.Fatal(err)
	}
	oldHome := constant.Path.HomeDir()
	oldSourceHome := GlobalValidationSourceHome
	constant.SetHomeDir(target)
	GlobalValidationSourceHome = source
	t.Cleanup(func() {
		constant.SetHomeDir(oldHome)
		GlobalValidationSourceHome = oldSourceHome
	})
	config := []byte("proxy-providers:\n  Local:\n    type: file\n    path: providers/local.yaml\n")
	if err := prepareValidationResources(config); err != nil {
		t.Fatal(err)
	}
	data, err := os.ReadFile(filepath.Join(target, "keys", "id_ed25519"))
	if err != nil || string(data) != "private" {
		t.Fatalf("copied provider resource = %q, err = %v", data, err)
	}
}

func TestPrepareValidationResourcesDecryptsProviderProxyResources(t *testing.T) {
	source := t.TempDir()
	target := t.TempDir()
	providerPath := filepath.Join(source, "providers", "local.age")
	keyPath := filepath.Join(source, "keys", "id_ed25519")
	if err := os.MkdirAll(filepath.Dir(providerPath), 0o700); err != nil {
		t.Fatal(err)
	}
	if err := os.MkdirAll(filepath.Dir(keyPath), 0o700); err != nil {
		t.Fatal(err)
	}
	secretKey, publicKey, err := metaAge.GenX25519KeyPair()
	if err != nil {
		t.Fatal(err)
	}
	encrypted, err := metaAge.EncryptBytes(
		[]byte("proxies:\n  - name: SSH\n    type: ssh\n    server: example.com\n    port: 22\n    username: user\n    private-key: keys/id_ed25519\n"),
		publicKey,
	)
	if err != nil {
		t.Fatal(err)
	}
	if err := os.WriteFile(providerPath, encrypted, 0o600); err != nil {
		t.Fatal(err)
	}
	if err := os.WriteFile(keyPath, []byte("private"), 0o600); err != nil {
		t.Fatal(err)
	}
	oldHome := constant.Path.HomeDir()
	oldSourceHome := GlobalValidationSourceHome
	constant.SetHomeDir(target)
	GlobalValidationSourceHome = source
	t.Cleanup(func() {
		constant.SetHomeDir(oldHome)
		GlobalValidationSourceHome = oldSourceHome
	})
	config := []byte(fmt.Sprintf(
		"proxy-providers:\n  Local:\n    type: file\n    path: providers/local.age\n    age-secret-key: %q\n",
		secretKey,
	))
	if err := prepareValidationResources(config); err != nil {
		t.Fatal(err)
	}
	data, err := os.ReadFile(filepath.Join(target, "keys", "id_ed25519"))
	if err != nil || string(data) != "private" {
		t.Fatalf("copied encrypted provider resource = %q, err = %v", data, err)
	}
}

func TestCollectOutboundResourcePathsKeepsInlineKeyPairInline(t *testing.T) {
	certificate, privateKey, _, err := ca.NewRandomTLSKeyPair(ca.KeyPairTypeP256)
	if err != nil {
		t.Fatal(err)
	}
	paths := map[string]struct{}{}
	err = collectOutboundResourcePaths([]map[string]any{
		{
			"name":        "HTTPS",
			"type":        "http",
			"tls":         true,
			"certificate": certificate,
			"private-key": privateKey,
		},
	}, t.TempDir(), paths)
	if err != nil {
		t.Fatal(err)
	}
	if len(paths) != 0 {
		t.Fatalf("inline key pair was treated as paths: %v", paths)
	}
}

func TestParseAndValidateConfigDataRejectsInvalidFileProvider(t *testing.T) {
	home := t.TempDir()
	oldHome := constant.Path.HomeDir()
	constant.SetHomeDir(home)
	t.Cleanup(func() { constant.SetHomeDir(oldHome) })
	providerPath := filepath.Join(home, "providers", "invalid.yaml")
	if err := os.MkdirAll(filepath.Dir(providerPath), 0o700); err != nil {
		t.Fatal(err)
	}
	if err := os.WriteFile(providerPath, []byte("proxies: invalid"), 0o600); err != nil {
		t.Fatal(err)
	}
	config := "proxy-providers:\n" +
		"  Local:\n" +
		"    type: file\n" +
		"    path: ./providers/invalid.yaml\n" +
		"proxy-groups:\n" +
		"  - name: Proxy\n" +
		"    type: select\n" +
		"    use: [Local]\n" +
		"rules:\n" +
		"  - MATCH,Proxy\n"
	if err := parseAndValidateConfigData([]byte(config)); err == nil {
		t.Fatal("parseAndValidateConfigData() accepted an invalid file provider")
	}
}

func TestParseAndValidateConfigDataDoesNotFilterInvalidProviderEntries(t *testing.T) {
	home := t.TempDir()
	oldHome := constant.Path.HomeDir()
	constant.SetHomeDir(home)
	t.Cleanup(func() { constant.SetHomeDir(oldHome) })
	providerPath := filepath.Join(home, "providers", "mixed.yaml")
	if err := os.MkdirAll(filepath.Dir(providerPath), 0o700); err != nil {
		t.Fatal(err)
	}
	if err := os.WriteFile(
		providerPath,
		[]byte("proxies:\n  - name: Direct\n    type: direct\n  - invalid\n"),
		0o600,
	); err != nil {
		t.Fatal(err)
	}
	config := "proxy-providers:\n" +
		"  Local:\n" +
		"    type: file\n" +
		"    path: ./providers/mixed.yaml\n" +
		"proxy-groups:\n" +
		"  - name: Proxy\n" +
		"    type: select\n" +
		"    use: [Local]\n" +
		"rules:\n" +
		"  - MATCH,Proxy\n"
	if err := parseAndValidateConfigData([]byte(config)); err == nil {
		t.Fatal("parseAndValidateConfigData() filtered an invalid provider entry")
	}
}

func TestParseAndValidateConfigDataDoesNotRunProviderHealthCheck(t *testing.T) {
	home := t.TempDir()
	oldHome := constant.Path.HomeDir()
	constant.SetHomeDir(home)
	t.Cleanup(func() { constant.SetHomeDir(oldHome) })
	requests := make(chan struct{}, 1)
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, _ *http.Request) {
		select {
		case requests <- struct{}{}:
		default:
		}
		w.WriteHeader(http.StatusNoContent)
	}))
	defer server.Close()
	providerPath := filepath.Join(home, "providers", "valid.yaml")
	if err := os.MkdirAll(filepath.Dir(providerPath), 0o700); err != nil {
		t.Fatal(err)
	}
	if err := os.WriteFile(
		providerPath,
		[]byte("proxies:\n  - name: Direct\n    type: direct\n"),
		0o600,
	); err != nil {
		t.Fatal(err)
	}
	config := "proxy-providers:\n" +
		"  Local:\n" +
		"    type: file\n" +
		"    path: ./providers/valid.yaml\n" +
		"    health-check:\n" +
		"      enable: true\n" +
		"      url: " + server.URL + "\n" +
		"      interval: 1\n" +
		"proxy-groups:\n" +
		"  - name: Proxy\n" +
		"    type: select\n" +
		"    use: [Local]\n" +
		"rules:\n" +
		"  - MATCH,Proxy\n"
	if err := parseAndValidateConfigData([]byte(config)); err != nil {
		t.Fatal(err)
	}
	select {
	case <-requests:
		t.Fatal("validator triggered provider health-check network traffic")
	case <-time.After(100 * time.Millisecond):
	}
}

func TestCreateValidationHomeFallsBackWhenSystemTempMissing(t *testing.T) {
	missing := filepath.Join(t.TempDir(), "missing")
	for _, key := range []string{"TMPDIR", "TMP", "TEMP"} {
		t.Setenv(key, missing)
	}
	home := t.TempDir()
	oldHome := constant.Path.HomeDir()
	constant.SetHomeDir(home)
	t.Cleanup(func() { constant.SetHomeDir(oldHome) })
	dir, err := createValidationHome()
	if err != nil {
		t.Fatal(err)
	}
	t.Cleanup(func() { _ = os.RemoveAll(dir) })
	want := filepath.Join(home, "temp") + string(os.PathSeparator)
	if !strings.HasPrefix(dir, want) {
		t.Fatalf("createValidationHome() = %q, want a directory under %q", dir, want)
	}
}

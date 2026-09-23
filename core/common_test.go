package main

import (
	"bufio"
	"bytes"
	"context"
	"encoding/base64"
	"errors"
	"net"
	"net/http"
	"os"
	"path/filepath"
	"slices"
	"testing"
	"time"

	"github.com/metacubex/mihomo/config"
	"github.com/metacubex/mihomo/constant"
	"github.com/metacubex/mihomo/hub/route"
	"github.com/metacubex/mihomo/tunnel"
)

type testSelectable struct {
	selected string
	valid    map[string]bool
	fallback string
}

func stubLiveConfig(t *testing.T) {
	t.Helper()
	previous, running := currentConfig, isRunning
	currentConfig = &config.Config{General: &config.General{}}
	isRunning = false
	t.Cleanup(func() { currentConfig, isRunning = previous, running })
}

func TestEncryptedRuntimeConfigFromDisk(t *testing.T) {
	fixture := os.Getenv("FLCLASH_RUNTIME_CONFIG_FIXTURE")
	if fixture == "" {
		t.Skip("requires the Dart-generated encrypted runtime fixture")
	}
	setValidationTestHome(t)
	ciphertext, err := os.ReadFile(fixture)
	if err != nil {
		t.Fatal(err)
	}
	if !isAgeArmored(ciphertext) {
		t.Fatal("runtime fixture is not Age encrypted")
	}
	path := filepath.Join(constant.Path.HomeDir(), "config.yaml")
	if err := os.WriteFile(path, ciphertext, 0o600); err != nil {
		t.Fatal(err)
	}
	previousKey := GlobalConfigAgeSecretKey
	GlobalConfigAgeSecretKey = os.Getenv("FLCLASH_RUNTIME_CONFIG_TEST_KEY")
	t.Cleanup(func() { GlobalConfigAgeSecretKey = previousKey })
	params := defaultSetupParams()
	if params.RawConfig != "" {
		t.Fatal("runtime startup unexpectedly contains plaintext configuration")
	}
	if err := applyConfig(params); err != nil {
		t.Fatal(err)
	}
	if currentConfig.General.MixedPort != 17890 || len(currentConfig.Rules) != 1 {
		t.Fatal("encrypted runtime file was not applied")
	}
	active := currentConfig
	GlobalConfigAgeSecretKey = base64.StdEncoding.EncodeToString(bytes.Repeat([]byte{9}, 32))
	if err := applyConfig(params); err == nil {
		t.Fatal("runtime file loaded with a different device key")
	}
	if currentConfig != active {
		t.Fatal("failed decryption replaced live configuration")
	}
	stored, err := os.ReadFile(path)
	if err != nil || !bytes.Equal(stored, ciphertext) {
		t.Fatal("core loading changed the encrypted file")
	}
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

func TestExternalControllerConfigKeepsProfileListeners(t *testing.T) {
	cfg := &config.Config{
		General: &config.General{},
		Controller: &config.Controller{
			ExternalController:     "127.0.0.1:9090",
			ExternalControllerTLS:  "127.0.0.1:9443",
			ExternalControllerUnix: "controller.sock",
			ExternalControllerPipe: `\\.\pipe\controller`,
			Secret:                 "secret",
			Cors:                   config.Cors{AllowOrigins: []string{"*"}, AllowPrivateNetwork: true},
		},
		TLS: &config.TLS{Certificate: "cert.pem", PrivateKey: "key.pem"},
	}
	got := externalControllerConfig(cfg)
	if got.Addr != "127.0.0.1:9090" || got.TLSAddr != "127.0.0.1:9443" || got.UnixAddr != "controller.sock" ||
		got.PipeAddr != cfg.Controller.ExternalControllerPipe || got.Secret != "secret" ||
		got.Certificate != "cert.pem" || got.PrivateKey != "key.pem" ||
		!slices.Equal(got.Cors.AllowOrigins, []string{"*"}) || !got.Cors.AllowPrivateNetwork {
		t.Fatalf("controller patch dropped profile settings: %+v", got)
	}
}

func TestUpdateConfigKeepsExternalControllerForUnrelatedPatches(t *testing.T) {
	stubLiveConfig(t)
	previousMode := tunnel.Mode()
	probe, err := net.Listen("tcp", "127.0.0.1:0")
	if err != nil {
		t.Fatal(err)
	}
	address := probe.Addr().String()
	probe.Close()
	secret := "first"
	currentConfig.Controller = &config.Controller{ExternalController: address, Secret: secret}
	currentConfig.TLS = &config.TLS{}
	route.ReCreateServer(externalControllerConfig(currentConfig))
	t.Cleanup(func() {
		tunnel.SetMode(previousMode)
		route.ReCreateServer(&route.Config{})
		for deadline := time.Now().Add(5 * time.Second); time.Now().Before(deadline); time.Sleep(20 * time.Millisecond) {
			conn, err := net.DialTimeout("tcp", address, 100*time.Millisecond)
			if err != nil {
				return
			}
			conn.Close()
		}
	})

	ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
	defer cancel()
	get := func(ctx context.Context, path, token string) (*http.Response, error) {
		request, err := http.NewRequestWithContext(ctx, http.MethodGet, "http://"+address+path, nil)
		if err != nil {
			return nil, err
		}
		request.Header.Set("Authorization", "Bearer "+token)
		return http.DefaultClient.Do(request)
	}
	waitForStatus := func(token string, want int) {
		t.Helper()
		for ctx.Err() == nil {
			if response, err := get(ctx, "/", token); err == nil {
				response.Body.Close()
				if response.StatusCode == want {
					return
				}
			}
			time.Sleep(20 * time.Millisecond)
		}
		t.Fatalf("controller never answered %d for token %q", want, token)
	}
	waitForStatus(secret, http.StatusOK)

	stream, err := get(ctx, "/traffic", secret)
	if err != nil {
		t.Fatal(err)
	}
	defer stream.Body.Close()
	lines := bufio.NewReader(stream.Body)
	if _, err := lines.ReadString('\n'); err != nil {
		t.Fatal(err)
	}
	mode := tunnel.Global
	if err := updateConfig(&UpdateParams{Mode: &mode, ExternalController: &address, Secret: &secret}); err != nil {
		t.Fatal(err)
	}
	if _, err := lines.ReadString('\n'); err != nil {
		t.Fatalf("an unrelated patch restarted the controller: %v", err)
	}

	next := "second"
	if err := updateConfig(&UpdateParams{ExternalController: &address, Secret: &next}); err != nil {
		t.Fatal(err)
	}
	waitForStatus(next, http.StatusOK)
	waitForStatus(secret, http.StatusUnauthorized)
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
	previousAuth := currentDNSAuth()
	t.Cleanup(func() {
		currentConfig = previousConfig
		constant.DefaultTestURL = previousURL
		config.SetProxyNameList(previousNames)
		setDNSAuth(previousAuth)
	})
	active := &config.Config{General: &config.General{}}
	active.General.MixedPort = 12345
	currentConfig = active
	activeNames := []string{"Active"}
	config.SetProxyNameList(activeNames)
	activeProxies := tunnel.Proxies()
	activeAuth := &dnsAuthSettings{suffixes: []string{"managed.example"}}
	setDNSAuth(activeAuth)
	invalid := "proxy-groups: ["
	if err := os.WriteFile(filepath.Join(constant.Path.HomeDir(), "config.yaml"), []byte(invalid), 0o600); err != nil {
		t.Fatal(err)
	}
	for _, candidate := range []string{
		invalid,
		"proxy-groups: [{name: Candidate, type: select, proxies: [DIRECT]}]\nrules: ['MATCH,Missing']",
		"", // the plain config.yaml written above
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
		if currentDNSAuth() != activeAuth {
			t.Fatal("failed candidate changed DNS-Auth for the live config")
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

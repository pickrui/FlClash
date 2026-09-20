package main

import (
	"bufio"
	"encoding/base64"
	"fmt"
	"io"
	"net"
	"net/http"
	"net/netip"
	"strings"
	"testing"
	"time"

	"github.com/metacubex/mihomo/adapter/inbound"
	"github.com/metacubex/mihomo/config"
	C "github.com/metacubex/mihomo/constant"
	authStore "github.com/metacubex/mihomo/listener/auth"
	"github.com/metacubex/mihomo/listener/mixed"
)

func authenticationTestState(t *testing.T) {
	t.Helper()
	authenticator, prefixes := authStore.Default.Authenticator(), inbound.SkipAuthPrefixes()
	stubLiveConfig(t)
	t.Cleanup(func() {
		authStore.Default.SetAuthenticator(authenticator)
		inbound.SetSkipAuthPrefixes(prefixes)
	})
}

func TestAuthenticationRejectsInvalidPatchWithoutChangingLiveState(t *testing.T) {
	authenticationTestState(t)
	valid := []string{"local:old"}
	if err := updateConfig(&UpdateParams{Authentication: &valid}); err != nil {
		t.Fatal(err)
	}
	for _, value := range []string{"missing", ":pass", "user:", "user:p\n", "user:" + strings.Repeat("中", 86)} {
		invalid := []string{"local:new", value}
		port := 23456
		if message := handleUpdateConfig(&UpdateParams{Authentication: &invalid, MixedPort: &port}); message != "invalid local proxy credentials" {
			t.Fatalf("unexpected error: %q", message)
		}
		if !authStore.Default.Authenticator().Verify("local", "old") || currentConfig.General.MixedPort != 0 {
			t.Fatal("invalid update changed the active configuration")
		}
	}
	if err := updateConfig(&UpdateParams{}); err != nil {
		t.Fatal(err)
	}
	if !authStore.Default.Authenticator().Verify("local", "old") {
		t.Fatal("unrelated update cleared auth")
	}
}

// Echo locally after a successful HTTP CONNECT/SOCKS handshake; never dial a remote endpoint.
type authenticationEchoTunnel struct{}

func (authenticationEchoTunnel) HandleTCPConn(conn net.Conn, _ *C.Metadata) {
	defer conn.Close()
	_, _ = io.Copy(conn, conn)
}
func (authenticationEchoTunnel) HandleUDPPacket(C.UDPPacket, *C.Metadata) {}
func (authenticationEchoTunnel) NatTable() C.NatTable                     { return nil }

func dialAuthenticationTest(t *testing.T, address string) net.Conn {
	t.Helper()
	conn, err := net.DialTimeout("tcp", address, time.Second)
	if err != nil {
		t.Fatal(err)
	}
	_ = conn.SetDeadline(time.Now().Add(2 * time.Second))
	t.Cleanup(func() { conn.Close() })
	return conn
}

func checkHTTPAuthentication(t *testing.T, address, credentials string, status int) {
	t.Helper()
	conn := dialAuthenticationTest(t, address)
	defer conn.Close()
	header := ""
	if credentials != "" {
		header = "Proxy-Authorization: Basic " + base64.StdEncoding.EncodeToString([]byte(credentials)) + "\r\n"
	}
	_, err := fmt.Fprintf(conn, "CONNECT example.invalid:443 HTTP/1.1\r\nHost: example.invalid:443\r\n%s\r\n", header)
	if err != nil {
		t.Fatal(err)
	}
	reader := bufio.NewReader(conn)
	response, err := http.ReadResponse(reader, &http.Request{Method: http.MethodConnect})
	if err != nil {
		t.Fatal(err)
	}
	if response.StatusCode != status {
		t.Fatalf("status = %d, want %d", response.StatusCode, status)
	}
	if status == http.StatusOK {
		conn.Write([]byte("echo"))
		data := make([]byte, 4)
		if _, err := io.ReadFull(reader, data); err != nil || string(data) != "echo" {
			t.Fatalf("authenticated tunnel failed: %v", err)
		}
	}
}

func checkSOCKSAuthentication(t *testing.T, address, user, pass string, authEnabled, success bool) {
	t.Helper()
	conn := dialAuthenticationTest(t, address)
	defer conn.Close()
	conn.Write([]byte{5, 2, 0, 2})
	response := make([]byte, 2)
	if _, err := io.ReadFull(conn, response); err != nil {
		t.Fatal(err)
	}
	expectedMethod := byte(0)
	if authEnabled {
		expectedMethod = 2
	}
	if response[0] != 5 || response[1] != expectedMethod {
		t.Fatalf("unexpected method: %v", response)
	}
	if authEnabled {
		packet := append([]byte{1, byte(len(user))}, []byte(user)...)
		packet = append(packet, byte(len(pass)))
		packet = append(packet, []byte(pass)...)
		conn.Write(packet)
		if _, err := io.ReadFull(conn, response); err != nil {
			t.Fatal(err)
		}
		if (response[1] == 0) != success {
			t.Fatalf("unexpected auth response: %v", response)
		}
		if !success {
			return
		}
	}
	conn.Write([]byte{5, 1, 0, 1, 127, 0, 0, 1, 0, 80})
	connected := make([]byte, 10)
	if _, err := io.ReadFull(conn, connected); err != nil || connected[1] != 0 {
		t.Fatalf("connect failed: %v %v", connected, err)
	}
	conn.Write([]byte("echo"))
	data := make([]byte, 4)
	if _, err := io.ReadFull(conn, data); err != nil || string(data) != "echo" {
		t.Fatalf("SOCKS tunnel failed: %v", err)
	}
}

func TestMixedProxyAuthenticationHotUpdate(t *testing.T) {
	authenticationTestState(t)
	allowed, denied := inbound.AllowedIPs(), inbound.DisAllowedIPs()
	inbound.SetAllowedIPs([]netip.Prefix{netip.MustParsePrefix("127.0.0.0/8")})
	inbound.SetDisAllowedIPs(nil)
	t.Cleanup(func() { inbound.SetAllowedIPs(allowed); inbound.SetDisAllowedIPs(denied) })
	exemptions := []netip.Prefix{netip.MustParsePrefix("127.0.0.0/8"), netip.MustParsePrefix("::1/128")}
	currentConfig.General.SkipAuthPrefixes = exemptions
	inbound.SetSkipAuthPrefixes(exemptions)
	users := []string{"local: ;:@ 中文 "}
	if err := updateConfig(&UpdateParams{Authentication: &users}); err != nil {
		t.Fatal(err)
	}
	if inbound.SkipAuthRemoteAddress("127.0.0.1:1234") || inbound.SkipAuthRemoteAddress("[::1]:1234") {
		t.Fatal("loopback auth bypass survived")
	}
	listener, err := mixed.New("127.0.0.1:0", authenticationEchoTunnel{})
	if err != nil {
		t.Fatal(err)
	}
	defer listener.Close()
	checkHTTPAuthentication(t, listener.Address(), "", 407)
	checkHTTPAuthentication(t, listener.Address(), "local:wrong", 403)
	checkHTTPAuthentication(t, listener.Address(), users[0], 200)
	checkSOCKSAuthentication(t, listener.Address(), "local", "wrong", true, false)
	checkSOCKSAuthentication(t, listener.Address(), "local", " ;:@ 中文 ", true, true)
	users = []string{"local:new"}
	if err := updateConfig(&UpdateParams{Authentication: &users}); err != nil {
		t.Fatal(err)
	}
	checkHTTPAuthentication(t, listener.Address(), "local: ;:@ 中文 ", 403)
	checkSOCKSAuthentication(t, listener.Address(), "local", "new", true, true)
	checkHTTPAuthentication(t, listener.Address(), "local:new", 200)
	users = []string{}
	if err := updateConfig(&UpdateParams{Authentication: &users}); err != nil {
		t.Fatal(err)
	}
	if authStore.Default.Authenticator() != nil {
		t.Fatal("authenticator survived disable")
	}
	checkHTTPAuthentication(t, listener.Address(), "", 200)
	checkSOCKSAuthentication(t, listener.Address(), "", "", false, true)
}

func TestAuthenticationColdConfigPreservesCredentials(t *testing.T) {
	previous := config.GetProxyNameList()
	defer config.SetProxyNameList(previous)
	cfg, err := config.Parse([]byte(`{"authentication":["local: ;:@ 中文 "],"skip-auth-prefixes":[],"dns":{"enable":false},"rules":["MATCH,DIRECT"]}`))
	if err != nil {
		t.Fatal(err)
	}
	if len(cfg.Users) != 1 || cfg.Users[0].User != "local" || cfg.Users[0].Pass != " ;:@ 中文 " {
		t.Fatal("cold configuration changed the credentials")
	}
	if len(cfg.General.SkipAuthPrefixes) != 0 {
		t.Fatal("cold configuration exempted loopback")
	}
}

package main

import (
	"encoding/json"
	"net"
	"net/netip"
	"sync"
	"testing"
	"time"

	"github.com/metacubex/mihomo/adapter"
	"github.com/metacubex/mihomo/adapter/outbound"
	"github.com/metacubex/mihomo/adapter/provider"
	"github.com/metacubex/mihomo/config"
	C "github.com/metacubex/mihomo/constant"
	"github.com/metacubex/mihomo/tunnel"
	"github.com/metacubex/mihomo/tunnel/statistic"
)

func resetSuspendTestState(t *testing.T) {
	t.Helper()
	previousRunning := isRunning
	previousConfig := currentConfig
	previousIdle, previousOption, previousOwner := deviceIdle, suspendOnIdle, idleOwnsTunnelSuspend
	previousStatus := tunnel.Status()
	isRunning = true
	currentConfig = nil
	deviceIdle, suspendOnIdle, idleOwnsTunnelSuspend = false, false, false
	t.Cleanup(func() {
		runLock.Lock()
		defer runLock.Unlock()
		isRunning = previousRunning
		currentConfig = previousConfig
		deviceIdle, suspendOnIdle, idleOwnsTunnelSuspend = previousIdle, previousOption, previousOwner
		provider.SetHealthCheckSuspended(previousIdle)
		setSuspendTestTunnelStatus(previousStatus)
	})
}

func setSuspendTestTunnelStatus(status tunnel.TunnelStatus) {
	switch status {
	case tunnel.Running:
		tunnel.OnRunning()
	case tunnel.Inner:
		tunnel.OnInnerLoading()
	case tunnel.Suspend:
		tunnel.OnSuspend()
	}
}

func TestHandleSuspendPreservesTunnelLifecycle(t *testing.T) {
	resetSuspendTestState(t)

	for _, status := range []tunnel.TunnelStatus{tunnel.Running, tunnel.Inner, tunnel.Suspend} {
		t.Run(status.String(), func(t *testing.T) {
			for _, suspended := range []bool{true, false} {
				setSuspendTestTunnelStatus(status)
				if !handleSuspend(suspended) {
					t.Fatal("device idle update failed")
				}
				if got := tunnel.Status(); got != status {
					t.Errorf("handleSuspend(%v) changed tunnel status to %s, want %s", suspended, got, status)
				}
			}
		})
	}
}

func TestSuspendOnIdleDoesNotOwnOtherLifecycleStates(t *testing.T) {
	resetSuspendTestState(t)
	suspendOnIdle = true
	for _, status := range []tunnel.TunnelStatus{tunnel.Inner, tunnel.Suspend} {
		setSuspendTestTunnelStatus(status)
		handleSuspend(true)
		handleSuspend(false)
		if got := tunnel.Status(); got != status || idleOwnsTunnelSuspend {
			t.Fatalf("idle changed lifecycle status %s to %s (owns suspend: %v)", status, got, idleOwnsTunnelSuspend)
		}
	}
}

func TestSuspendOnIdleHotUpdateBeforeSetup(t *testing.T) {
	resetSuspendTestState(t)
	tunnel.OnRunning()
	handleSuspend(true)
	enabled := true
	updateConfig(&UpdateParams{SuspendOnIdle: &enabled})
	if !suspendOnIdle || tunnel.Status() != tunnel.Suspend {
		t.Fatal("enabling idle suspension before config setup did not apply")
	}
	updateConfig(&UpdateParams{})
	if !suspendOnIdle {
		t.Fatal("unrelated config update reset the idle option")
	}
	enabled = false
	updateConfig(&UpdateParams{SuspendOnIdle: &enabled})
	if suspendOnIdle || tunnel.Status() != tunnel.Running || idleOwnsTunnelSuspend {
		t.Fatal("disabling idle suspension did not resume the owned tunnel")
	}
}

func TestSuspendOnIdleWakeWhileStoppedWaitsForExplicitStart(t *testing.T) {
	resetSuspendTestState(t)
	tunnel.OnRunning()
	suspendOnIdle = true
	handleSuspend(true)
	handleStopListener()
	handleSuspend(false)
	enabled := false
	updateConfig(&UpdateParams{SuspendOnIdle: &enabled})
	if tunnel.Status() != tunnel.Suspend || isRunning || !idleOwnsTunnelSuspend {
		t.Fatal("wake or preference change resumed the stopped tunnel")
	}
	currentConfig = &config.Config{General: &config.General{}}
	if !handleStartListener() || tunnel.Status() != tunnel.Running || idleOwnsTunnelSuspend {
		t.Fatal("explicit start did not release the previous idle suspension")
	}
	defer handleStopListener()
}

func TestSuspendOnIdleBeforeStartDoesNotSuspendTunnel(t *testing.T) {
	resetSuspendTestState(t)
	tunnel.OnRunning()
	isRunning = false
	suspendOnIdle = true
	handleSuspend(true)
	if tunnel.Status() != tunnel.Running || idleOwnsTunnelSuspend {
		t.Fatal("device idle changed the stopped tunnel")
	}
	currentConfig = &config.Config{General: &config.General{}}
	if !handleStartListener() || tunnel.Status() != tunnel.Suspend || !idleOwnsTunnelSuspend {
		t.Fatal("explicit start did not apply the current idle preference")
	}
	defer handleStopListener()
}

func TestSuspendOnIdleConcurrentUpdates(t *testing.T) {
	resetSuspendTestState(t)
	tunnel.OnRunning()
	var updates sync.WaitGroup
	updates.Add(2)
	go func() {
		defer updates.Done()
		for i := range 100 {
			handleSuspend(i%2 == 0)
		}
	}()
	go func() {
		defer updates.Done()
		for i := range 100 {
			enabled := i%2 == 0
			updateConfig(&UpdateParams{SuspendOnIdle: &enabled})
		}
	}()
	updates.Wait()
	handleSuspend(false)
	enabled := false
	updateConfig(&UpdateParams{SuspendOnIdle: &enabled})
	if tunnel.Status() != tunnel.Running || idleOwnsTunnelSuspend {
		t.Fatal("concurrent idle and config updates left the tunnel suspended")
	}
}

func TestSuspendOnIdleJSONDefaultsAndCompatibility(t *testing.T) {
	for _, enabled := range []bool{false, true} {
		data, err := json.Marshal(SetupParams{SuspendOnIdle: enabled})
		if err != nil {
			t.Fatal(err)
		}
		var update UpdateParams
		if err := json.Unmarshal(data, &update); err != nil {
			t.Fatal(err)
		}
		if update.SuspendOnIdle == nil || *update.SuspendOnIdle != enabled {
			t.Fatalf("setup and update disagree for idle option %v", enabled)
		}
	}
	setup := defaultSetupParams()
	if err := json.Unmarshal([]byte(`{"test-url":"https://example.com/"}`), setup); err != nil {
		t.Fatal(err)
	}
	if setup.SuspendOnIdle {
		t.Fatal("old setup payload enabled idle suspension")
	}
}

type suspendTestPacket struct {
	data      []byte
	source    net.Addr
	responses chan string
	dropped   chan struct{}
}

func (p *suspendTestPacket) Data() []byte        { return p.data }
func (p *suspendTestPacket) LocalAddr() net.Addr { return p.source }
func (p *suspendTestPacket) Drop() {
	if p.dropped != nil {
		select {
		case p.dropped <- struct{}{}:
		default:
		}
	}
}
func (p *suspendTestPacket) WriteBack(data []byte, _ net.Addr) (int, error) {
	p.responses <- string(data)
	return len(data), nil
}

func TestHandleSuspendKeepsUDPVoiceTrafficFlowing(t *testing.T) {
	resetSuspendTestState(t)
	previousProxies := tunnel.Proxies()
	previousProviders := tunnel.Providers()
	t.Cleanup(func() {
		tunnel.UpdateProxies(previousProxies, previousProviders)
	})
	tunnel.UpdateProxies(map[string]C.Proxy{"DIRECT": adapter.NewProxy(outbound.NewDirect())}, nil)
	tunnel.OnRunning()

	// Exercise the real UDP tunnel and outbound socket with a local media peer.
	echo, err := net.ListenUDP("udp4", &net.UDPAddr{IP: net.IPv4(127, 0, 0, 1)})
	if err != nil {
		t.Fatal(err)
	}
	t.Cleanup(func() { _ = echo.Close() })
	go func() {
		buffer := make([]byte, 1500)
		for {
			n, peer, err := echo.ReadFromUDP(buffer)
			if err != nil {
				return
			}
			if _, err := echo.WriteToUDP(buffer[:n], peer); err != nil {
				return
			}
		}
	}()

	newSession := func() *net.UDPAddr {
		conn, err := net.ListenUDP("udp4", &net.UDPAddr{IP: net.IPv4(127, 0, 0, 1)})
		if err != nil {
			t.Fatal(err)
		}
		source := conn.LocalAddr().(*net.UDPAddr)
		t.Cleanup(func() {
			statistic.DefaultManager.Range(func(tracker statistic.Tracker) bool {
				metadata := tracker.Info().Metadata
				if metadata.SrcIP == source.AddrPort().Addr() && metadata.SrcPort == uint16(source.Port) {
					_ = tracker.Close()
				}
				return true
			})
			_ = conn.Close()
		})
		return source
	}
	assertPacket := func(source *net.UDPAddr, payload string, wantReply bool) {
		t.Helper()
		responses := make(chan string, 1)
		dropped := make(chan struct{}, 1)
		tunnel.Tunnel.HandleUDPPacket(&suspendTestPacket{
			data:      []byte(payload),
			source:    source,
			responses: responses,
			dropped:   dropped,
		}, &C.Metadata{
			NetWork:      C.UDP,
			Type:         C.TUN,
			SrcIP:        source.AddrPort().Addr(),
			SrcPort:      uint16(source.Port),
			DstIP:        netip.MustParseAddr("127.0.0.1"),
			DstPort:      uint16(echo.LocalAddr().(*net.UDPAddr).Port),
			SpecialProxy: "DIRECT",
		})
		if !wantReply {
			select {
			case <-dropped:
			case <-time.After(2 * time.Second):
				t.Fatal("idle suspension did not drop the packet")
			}
			select {
			case got := <-responses:
				t.Fatalf("suspended UDP packet received reply %q", got)
			case <-time.After(100 * time.Millisecond):
			}
			return
		}
		select {
		case got := <-responses:
			if got != payload {
				t.Fatalf("UDP reply = %q, want %q", got, payload)
			}
		case <-time.After(2 * time.Second):
			t.Fatalf("UDP traffic stopped for %q", payload)
		}
	}
	assertExchange := func(source *net.UDPAddr, payload string) {
		t.Helper()
		assertPacket(source, payload, true)
	}

	existingSession := newSession()
	assertExchange(existingSession, "voice before idle")
	handleSuspend(true)
	assertExchange(existingSession, "voice during idle")
	assertExchange(newSession(), "new voice session during idle")
	handleSuspend(false)
	assertExchange(existingSession, "voice after idle")

	enabled := true
	updateConfig(&UpdateParams{SuspendOnIdle: &enabled})
	handleSuspend(true)
	assertPacket(existingSession, "opt-in idle drops voice", false)
	assertPacket(newSession(), "opt-in idle drops new voice", false)
	handleSuspend(false)
	assertExchange(existingSession, "voice after opted-in wake")
	handleSuspend(true)
	enabled = false
	updateConfig(&UpdateParams{SuspendOnIdle: &enabled})
	assertExchange(existingSession, "voice after hot disabling idle suspension")
}

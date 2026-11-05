package main

import (
	"github.com/metacubex/mihomo/config"
	"github.com/metacubex/mihomo/listener"
	"net"
	"strconv"
	"testing"
)

func TestNetworkExclusionPreservesRunIntentAcrossConfigAndManualStop(t *testing.T) {
	resetSuspendTestState(t)
	oldExcluded := networkExcluded
	networkExcluded = false
	defer func() { handleStopListener(); networkExcluded = oldExcluded }()
	probe, err := net.Listen("tcp", "127.0.0.1:0")
	if err != nil {
		t.Fatal(err)
	}
	port := probe.Addr().(*net.TCPAddr).Port
	probe.Close()
	currentConfig = &config.Config{General: &config.General{}}
	currentConfig.General.MixedPort = port
	currentConfig.General.BindAddress = "127.0.0.1"
	if !handleStartListener() || listener.GetPorts().MixedPort != port {
		t.Fatal("listener not started")
	}
	handleSetNetworkExcluded(true)
	if !isRunning || listener.GetPorts().MixedPort != 0 {
		t.Fatal("exclusion did not preserve intent and close listener")
	}
	updateListeners()
	if listener.GetPorts().MixedPort != 0 {
		t.Fatal("config reload bypassed exclusion")
	}
	if !handleStartListener() || listener.GetPorts().MixedPort != 0 {
		t.Fatal("explicit start bypassed exclusion")
	}
	handleSetNetworkExcluded(false)
	conn, err := net.Dial("tcp", net.JoinHostPort("127.0.0.1", strconv.Itoa(port)))
	if err != nil {
		t.Fatalf("listener did not resume: %v", err)
	}
	conn.Close()
	handleSetNetworkExcluded(true)
	handleStopListener()
	handleSetNetworkExcluded(false)
	if isRunning || listener.GetPorts().MixedPort != 0 {
		t.Fatal("network change undid manual stop")
	}
}

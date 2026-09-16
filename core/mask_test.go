package main

import (
	"bytes"
	"net/netip"
	"strings"
	"testing"
	"time"

	"github.com/metacubex/mihomo/constant"
	"github.com/metacubex/mihomo/log"
	"github.com/metacubex/mihomo/tunnel/statistic"
	logrus "github.com/sirupsen/logrus"
)

func TestSuppressCloudOutput(t *testing.T) {
	previous := currentDNSAuth()
	setDNSAuth(&dnsAuthSettings{suffixes: []string{"managed.example"}})
	t.Cleanup(func() { setDNSAuth(previous) })
	markCloudIP("192.0.2.10")
	t.Cleanup(func() { cloudIPs.Clear() })
	previousDomains := cloudOutputDomains.Load()
	setCloudOutputDomains([]string{" api.example ", "backup.example"})
	t.Cleanup(func() { cloudOutputDomains.Store(previousDomains) })
	markCloudIP("2001:db8::10")
	markCloudIP("2001:db8::")

	for _, test := range []struct {
		text string
		want bool
	}{
		{text: "failed to load OIXCLOUD account", want: true},
		{text: "[DNS-Auth] enabled", want: true},
		{text: "[CloudAPI] request failed", want: true},
		{text: "lookup token.NODE.MANAGED.EXAMPLE:443 failed", want: true},
		{text: "Get https://managed.example/api?token=secret: failed", want: true},
		{text: "dial tcp 192.0.2.10:443: failed", want: true},
		{text: "dial tcp [2001:db8::10]:443: failed", want: true},
		{text: "connection ::ffff:192.0.2.10 failed", want: true},
		{text: "connection 2001:db8:: failed", want: true},
		{text: "Get https://API.EXAMPLE/account?token=secret: failed", want: true},
		{text: "lookup sub.backup.example. failed", want: true},
		{text: "lookup unmanaged.example failed", want: false},
		{text: "lookup managed.example.other failed", want: false},
		{text: "lookup notapi.example failed", want: false},
		{text: "lookup api.example.other failed", want: false},
	} {
		t.Run(test.text, func(t *testing.T) {
			if got := shouldSuppressCloudOutput(test.text); got != test.want {
				t.Fatalf("shouldSuppressCloudOutput(%q) = %v; want %v", test.text, got, test.want)
			}
		})
	}
}

type cloudTestTracker struct {
	statistic.Tracker
	info *statistic.TrackerInfo
}

func (tracker cloudTestTracker) ID() string                   { return "test" }
func (tracker cloudTestTracker) Info() *statistic.TrackerInfo { return tracker.info }

func TestCloudTrackersAreNotPublished(t *testing.T) {
	previousDomains := cloudOutputDomains.Load()
	setCloudOutputDomains([]string{"api.example"})
	t.Cleanup(func() { cloudOutputDomains.Store(previousDomains); resetCloudIPs() })
	previousNotify := statistic.DefaultRequestNotify
	t.Cleanup(func() { statistic.DefaultRequestNotify = previousNotify })

	for _, test := range []struct {
		name   string
		info   *statistic.TrackerInfo
		hidden bool
	}{
		{name: "api", info: &statistic.TrackerInfo{Metadata: &constant.Metadata{Host: "api.example", DstIP: netip.MustParseAddr("192.0.2.10")}}, hidden: true},
		{name: "sniffed api", info: &statistic.TrackerInfo{Metadata: &constant.Metadata{SniffHost: "API.EXAMPLE"}}, hidden: true},
		{name: "api ip", info: &statistic.TrackerInfo{Metadata: &constant.Metadata{DstIP: netip.MustParseAddr("192.0.2.10")}}, hidden: true},
		{name: "remote", info: &statistic.TrackerInfo{Metadata: &constant.Metadata{RemoteDst: "api.example:443"}}, hidden: true},
		{name: "chain", info: &statistic.TrackerInfo{Chain: constant.Chain{"oixCloud"}}, hidden: true},
		{name: "provider", info: &statistic.TrackerInfo{ProviderChain: constant.Chain{"oixCloud"}}, hidden: true},
		{name: "rule", info: &statistic.TrackerInfo{RulePayload: "api.example"}, hidden: true},
		{name: "special rule", info: &statistic.TrackerInfo{Metadata: &constant.Metadata{SpecialRules: "api.example"}}, hidden: true},
		{name: "special proxy", info: &statistic.TrackerInfo{Metadata: &constant.Metadata{SpecialProxy: "oixCloud"}}, hidden: true},
		{name: "process", info: &statistic.TrackerInfo{Metadata: &constant.Metadata{ProcessPath: "/apps/oixCloud/client"}}, hidden: true},
		{name: "ordinary", info: &statistic.TrackerInfo{Metadata: &constant.Metadata{Host: "public.example"}}},
	} {
		t.Run(test.name, func(t *testing.T) {
			notified := false
			statistic.DefaultRequestNotify = func(statistic.Tracker) { notified = true }
			manager := &statistic.Manager{}
			tracker := cloudTestTracker{info: test.info}
			manager.Join(tracker)
			if notified == test.hidden || (len(manager.Snapshot().Connections) == 0) != test.hidden {
				t.Fatal("request notification and connection snapshot did not follow the privacy filter")
			}
			if manager.Get(tracker.ID()) == nil {
				t.Fatal("filter removed the live connection from the manager")
			}
		})
	}
}

func TestCloudLogsAreNotPublished(t *testing.T) {
	previousDomains := cloudOutputDomains.Load()
	setCloudOutputDomains([]string{"api.example"})
	t.Cleanup(func() { cloudOutputDomains.Store(previousDomains) })
	previousOutput := logrus.StandardLogger().Out
	previousLevel := log.Level()
	var output bytes.Buffer
	logrus.SetOutput(&output)
	log.SetLevel(log.DEBUG)
	t.Cleanup(func() { logrus.SetOutput(previousOutput); log.SetLevel(previousLevel) })
	subscriber := log.Subscribe()
	defer log.UnSubscribe(subscriber)

	for _, write := range []func(string, ...any){log.Debugln, log.Infoln, log.Warnln, log.Errorln} {
		write("request %s failed", "https://api.example/account?token=private")
		write("oixCloud account failed")
	}
	const ordinary = "ordinary public connection"
	log.Infoln(ordinary)
	select {
	case event := <-subscriber:
		if event.Payload != ordinary {
			t.Fatal("cloud log reached a subscriber")
		}
	case <-time.After(time.Second):
		t.Fatal("ordinary log was not published")
	}
	if text := output.String(); !strings.Contains(text, ordinary) || shouldSuppressCloudOutput(text) {
		t.Fatal("console output did not follow the cloud log filter")
	}
}

package main

import (
	"bytes"
	"context"
	"errors"
	"net"
	"net/http"
	"net/http/httptest"
	"os"
	"path/filepath"
	"slices"
	"strings"
	"testing"
	"time"

	"github.com/metacubex/mihomo/component/geodata"
	"github.com/metacubex/mihomo/component/geodata/router"
	"github.com/metacubex/mihomo/component/mmdb"
	"github.com/metacubex/mihomo/constant"
	"google.golang.org/protobuf/proto"
)

func TestShouldUpdateGeoFiles(t *testing.T) {
	tempDir := t.TempDir()
	recentPath := filepath.Join(tempDir, "recent.dat")
	stalePath := filepath.Join(tempDir, "stale.dat")
	if err := os.WriteFile(recentPath, []byte("recent"), 0o600); err != nil {
		t.Fatal(err)
	}
	if err := os.WriteFile(stalePath, []byte("stale"), 0o600); err != nil {
		t.Fatal(err)
	}
	staleTime := time.Now().Add(-25 * time.Hour)
	if err := os.Chtimes(stalePath, staleTime, staleTime); err != nil {
		t.Fatal(err)
	}

	tests := []struct {
		name  string
		paths []string
		want  bool
	}{
		{name: "no enabled resources", paths: nil, want: false},
		{name: "recent resource", paths: []string{recentPath}, want: false},
		{name: "stale resource", paths: []string{stalePath}, want: true},
		{name: "missing resource", paths: []string{filepath.Join(tempDir, "missing.dat")}, want: true},
	}

	for _, test := range tests {
		t.Run(test.name, func(t *testing.T) {
			if got := shouldUpdateGeoFiles(test.paths, 24*time.Hour); got != test.want {
				t.Fatalf("shouldUpdateGeoFiles() = %v, want %v", got, test.want)
			}
		})
	}
}

func geoTestPaths() map[string]string {
	return map[string]string{
		"MMDB":    constant.Path.MMDB(),
		"ASN":     constant.Path.ASN(),
		"GEOIP":   constant.Path.GeoIP(),
		"GEOSITE": constant.Path.GeoSite(),
	}
}

func setupGeoUpdateServer(
	t *testing.T,
	intercept func(http.ResponseWriter, *http.Request) bool,
) (map[string][]byte, chan string) {
	t.Helper()
	previousHome := constant.Path.HomeDir()
	previousURLs := []string{geodata.MmdbUrl(), geodata.ASNUrl(), geodata.GeoIpUrl(), geodata.GeoSiteUrl()}
	constant.SetHomeDir(t.TempDir())
	readFixture := func(name string) []byte {
		t.Helper()
		data, err := os.ReadFile(filepath.Join("Clash.Meta", "component", "mmdb", "testdata", name))
		if err != nil {
			t.Fatal(err)
		}
		return data
	}
	marshal := func(message proto.Message) []byte {
		t.Helper()
		data, err := proto.Marshal(message)
		if err != nil {
			t.Fatal(err)
		}
		return data
	}
	data := map[string][]byte{
		"MMDB": readFixture("geoip-cn.mmdb"),
		"ASN":  readFixture("asn-64512.mmdb"),
		"GEOIP": marshal(&router.GeoIPList{Entry: []*router.GeoIP{{
			CountryCode: "CN",
			Cidr:        []*router.CIDR{{Ip: []byte{1, 0, 0, 0}, Prefix: 8}},
		}}}),
		"GEOSITE": marshal(&router.GeoSiteList{Entry: []*router.GeoSite{{
			CountryCode: "CN",
			Domain:      []*router.Domain{{Type: router.Domain_Domain, Value: "example.cn"}},
		}}}),
	}
	requests := make(chan string, 16)
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		geoType := strings.TrimPrefix(r.URL.Path, "/")
		requests <- geoType
		if intercept != nil && intercept(w, r) {
			return
		}
		_, _ = w.Write(data[geoType])
	}))
	geodata.SetMmdbUrl(server.URL + "/MMDB")
	geodata.SetASNUrl(server.URL + "/ASN")
	geodata.SetGeoIpUrl(server.URL + "/GEOIP")
	geodata.SetGeoSiteUrl(server.URL + "/GEOSITE")
	t.Cleanup(func() {
		server.Close()
		mmdb.ReloadIP()
		mmdb.ReloadASN()
		geodata.SetMmdbUrl(previousURLs[0])
		geodata.SetASNUrl(previousURLs[1])
		geodata.SetGeoIpUrl(previousURLs[2])
		geodata.SetGeoSiteUrl(previousURLs[3])
		constant.SetHomeDir(previousHome)
	})
	return data, requests
}

func assertGeoRequests(t *testing.T, requests chan string, expected []string) {
	t.Helper()
	var actual []string
	for len(requests) > 0 {
		actual = append(actual, <-requests)
	}
	if !slices.Equal(actual, expected) {
		t.Fatalf("downloaded resources = %v, want %v", actual, expected)
	}
}

func TestUpdateAllGeoDataDownloadsEveryResource(t *testing.T) {
	data, requests := setupGeoUpdateServer(t, nil)
	if err := updateAllGeoData(context.Background()); err != nil {
		t.Fatal(err)
	}
	assertGeoRequests(t, requests, []string{"MMDB", "ASN", "GEOIP", "GEOSITE"})
	for geoType, path := range geoTestPaths() {
		actual, err := os.ReadFile(path)
		if err != nil || !bytes.Equal(actual, data[geoType]) {
			t.Errorf("%s was not installed: %v", geoType, err)
		}
	}
}

func TestUpdateAllGeoDataContinuesAfterResourceFailure(t *testing.T) {
	for _, failed := range [][]string{{"ASN"}, {"ASN", "GEOIP"}} {
		t.Run(strings.Join(failed, "+"), func(t *testing.T) {
			data, requests := setupGeoUpdateServer(t, func(w http.ResponseWriter, r *http.Request) bool {
				if slices.Contains(failed, strings.TrimPrefix(r.URL.Path, "/")) {
					http.Error(w, "unavailable", http.StatusServiceUnavailable)
					return true
				}
				return false
			})
			err := updateAllGeoData(context.Background())
			if err == nil {
				t.Fatal("update did not report failed resources")
			}
			assertGeoRequests(t, requests, []string{"MMDB", "ASN", "GEOIP", "GEOSITE"})
			for geoType, path := range geoTestPaths() {
				actual, readErr := os.ReadFile(path)
				if slices.Contains(failed, geoType) {
					if !strings.Contains(err.Error(), geoType) || !os.IsNotExist(readErr) {
						t.Errorf("failed %s: update error = %v, file error = %v", geoType, err, readErr)
					}
				} else if readErr != nil || !bytes.Equal(actual, data[geoType]) {
					t.Errorf("successful %s was not installed: %v", geoType, readErr)
				}
			}
		})
	}
}

func TestUpdateAllGeoDataStopsAfterCancellation(t *testing.T) {
	ctx, cancel := context.WithCancel(context.Background())
	defer cancel()
	_, requests := setupGeoUpdateServer(t, func(http.ResponseWriter, *http.Request) bool {
		cancel()
		return true
	})
	if err := updateAllGeoData(ctx); !errors.Is(err, context.Canceled) {
		t.Fatalf("canceled update error = %v", err)
	}
	assertGeoRequests(t, requests, []string{"MMDB"})
	if err := updateAllGeoData(ctx); !errors.Is(err, context.Canceled) {
		t.Fatalf("already canceled update error = %v", err)
	}
	assertGeoRequests(t, requests, nil)
}

func TestShouldUpdateGeoDataChecksEveryResource(t *testing.T) {
	previousHome := constant.Path.HomeDir()
	constant.SetHomeDir(t.TempDir())
	t.Cleanup(func() { constant.SetHomeDir(previousHome) })
	paths := geoTestPaths()
	for _, path := range paths {
		if err := os.WriteFile(path, []byte("recent"), 0o600); err != nil {
			t.Fatal(err)
		}
	}
	if shouldUpdateGeoData(24 * time.Hour) {
		t.Fatal("all resources are recent")
	}
	for geoType, path := range paths {
		t.Run(geoType, func(t *testing.T) {
			staleTime := time.Now().Add(-25 * time.Hour)
			if err := os.Chtimes(path, staleTime, staleTime); err != nil {
				t.Fatal(err)
			}
			if !shouldUpdateGeoData(24 * time.Hour) {
				t.Fatal("stale resource did not trigger an update")
			}
			if err := os.Remove(path); err != nil {
				t.Fatal(err)
			}
			if !shouldUpdateGeoData(24 * time.Hour) {
				t.Fatal("missing resource did not trigger an update")
			}
			if err := os.WriteFile(path, []byte("recent"), 0o600); err != nil {
				t.Fatal(err)
			}
		})
	}
}

func TestDownloadGeoDataRejectsDeclaredOversize(t *testing.T) {
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, _ *http.Request) {
		w.Header().Set("Content-Length", "67108865")
		w.WriteHeader(http.StatusOK)
	}))
	defer server.Close()

	if _, err := downloadGeoData(context.Background(), server.URL); err == nil {
		t.Fatal("downloadGeoData() accepted an oversized response")
	}
}

func TestDownloadGeoDataRejectsStreamBeyondLimit(t *testing.T) {
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, _ *http.Request) {
		w.Header().Set("Content-Length", "-1")
		chunk := make([]byte, 1024*1024)
		for range 65 {
			if _, err := w.Write(chunk); err != nil {
				return
			}
		}
	}))
	defer server.Close()

	if _, err := downloadGeoData(context.Background(), server.URL); err == nil {
		t.Fatal("downloadGeoData() accepted a stream beyond the size limit")
	}
}

func TestInvalidGeoUpdatePreservesExistingFile(t *testing.T) {
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, _ *http.Request) {
		_, _ = w.Write([]byte("not a database"))
	}))
	defer server.Close()

	path := filepath.Join(t.TempDir(), "GEOIP.dat")
	original := []byte("existing database")
	if err := os.WriteFile(path, original, 0o600); err != nil {
		t.Fatal(err)
	}
	if err := updateGeoDataLockedFromURL(context.Background(), "GEOIP", path, server.URL); err == nil {
		t.Fatal("updateGeoDataLockedFromURL() accepted invalid GEOIP data")
	}
	current, err := os.ReadFile(path)
	if err != nil {
		t.Fatal(err)
	}
	if string(current) != string(original) {
		t.Fatalf("existing file changed to %q", current)
	}
}

func TestGeoResourcePathRejectsUnexpectedNames(t *testing.T) {
	if _, err := geoResourcePath("GEOIP", "../GEOIP.dat"); err == nil {
		t.Fatal("geoResourcePath() accepted a path")
	}
	if _, err := geoResourcePath("GEOIP", "GEOSITE.dat"); err == nil {
		t.Fatal("geoResourcePath() accepted the wrong resource name")
	}
}

func TestDownloadGeoDataRejectsNonHTTPURL(t *testing.T) {
	if _, err := downloadGeoData(context.Background(), "file:///tmp/geo.dat"); err == nil {
		t.Fatal("downloadGeoData() accepted a non-HTTP URL")
	}
}

func TestManualGeoUpdateRefreshesReadersWithoutRestart(t *testing.T) {
	previousHome := constant.Path.HomeDir()
	constant.SetHomeDir(t.TempDir())
	resetGeoLifecycle()
	mmdb.ReloadIP()
	mmdb.ReloadASN()
	t.Cleanup(func() {
		stopGeoLifecycle()
		mmdb.ReloadIP()
		mmdb.ReloadASN()
		constant.SetHomeDir(previousHome)
	})
	readFixture := func(name string) []byte {
		t.Helper()
		data, err := os.ReadFile(filepath.Join("Clash.Meta", "component", "mmdb", "testdata", name))
		if err != nil {
			t.Fatal(err)
		}
		return data
	}
	for _, test := range []struct {
		geoType string
		path    string
		oldFile string
		newFile string
	}{
		{"MMDB", constant.Path.MMDB(), "geoip-cn.mmdb", "geoip-us.mmdb"},
		{"ASN", constant.Path.ASN(), "asn-64512.mmdb", "asn-64513.mmdb"},
	} {
		t.Run(test.geoType, func(t *testing.T) {
			if err := replaceGeoData(test.geoType, test.path, readFixture(test.oldFile)); err != nil {
				t.Fatal(err)
			}
			ip := net.IPv4(1, 2, 3, 4)
			var oldIP mmdb.IPReader
			var oldASN mmdb.ASNReader
			if test.geoType == "MMDB" {
				oldIP = mmdb.IPInstance()
			} else {
				oldASN = mmdb.ASNInstance()
			}
			data := readFixture(test.newFile)
			server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, _ *http.Request) {
				_, _ = w.Write(data)
			}))
			defer server.Close()
			// The batcher retains its original queue; capture this operation's
			// actual events without attaching a transport or changing the sender.
			previousQueue := priorityMessageQueue
			events := make(chan Message, messageQueueSize)
			priorityMessageQueue = events
			defer func() { priorityMessageQueue = previousQueue }()
			running, initialized := isRunning, isInit.Load()
			done := make(chan string, 1)
			handleUpdateGeoData(test.geoType, filepath.Base(test.path), server.URL, func(value string) {
				done <- value
			})
			select {
			case result := <-done:
				if result != "" {
					t.Fatalf("manual update failed: %s", result)
				}
			case <-time.After(5 * time.Second):
				t.Fatal("manual update did not finish")
			}
			geoLifecycleWG.Wait()
			if isRunning != running || isInit.Load() != initialized {
				t.Fatal("manual update changed the core lifecycle state")
			}
			if len(events) != 2 {
				t.Fatalf("manual update emitted %d events, want start and success only", len(events))
			}
			for _, updating := range []bool{true, false} {
				event := <-events
				status, ok := event.Data.(GeoUpdateStatus)
				if event.Type != GeoUpdateMessage || !ok || status.Type != test.geoType ||
					status.Updating != updating || status.Reload || status.Skipped || status.Error != "" {
					t.Fatalf("unexpected update event: %+v", event)
				}
			}
			if test.geoType == "MMDB" {
				if got := mmdb.IPInstance().LookupCode(ip); len(got) != 1 || got[0] != "us" {
					t.Fatalf("updated country = %v, want [us]", got)
				}
				if got := oldIP.LookupCode(ip); len(got) != 1 || got[0] != "cn" {
					t.Fatalf("in-flight country lookup = %v, want [cn]", got)
				}
			} else {
				if got, _ := mmdb.ASNInstance().LookupASN(ip); got != "64513" {
					t.Fatalf("updated ASN = %s, want 64513", got)
				}
				if got, _ := oldASN.LookupASN(ip); got != "64512" {
					t.Fatalf("in-flight ASN lookup = %s, want 64512", got)
				}
			}
		})
	}
}

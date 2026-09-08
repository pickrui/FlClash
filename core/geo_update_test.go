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

func TestMismatchedGeoUpdatePreservesExistingFile(t *testing.T) {
	for geoType, wrongType := range map[string]string{
		"MMDB": "ASN", "ASN": "MMDB", "GEOIP": "GEOSITE", "GEOSITE": "GEOIP",
	} {
		t.Run(geoType, func(t *testing.T) {
			var data map[string][]byte
			data, _ = setupGeoUpdateServer(t, func(w http.ResponseWriter, _ *http.Request) bool {
				_, _ = w.Write(data[wrongType])
				return true
			})
			path := geoTestPaths()[geoType]
			if err := os.WriteFile(path, data[geoType], 0o600); err != nil {
				t.Fatal(err)
			}
			if err := updateGeoDataLocked(context.Background(), geoType, path); err == nil {
				t.Fatalf("accepted %s data as %s", wrongType, geoType)
			}
			current, err := os.ReadFile(path)
			if err != nil || !bytes.Equal(current, data[geoType]) {
				t.Fatalf("existing %s database changed: %v", geoType, err)
			}
		})
	}
}

func TestValidateMMDBKeepsSupportedCountryLayouts(t *testing.T) {
	fixture, err := os.ReadFile(filepath.Join("Clash.Meta", "component", "mmdb", "testdata", "geoip-cn.mmdb"))
	if err != nil {
		t.Fatal(err)
	}
	encodeString := func(value string) []byte {
		// Every synthetic string here fits in the DB format's one-byte size.
		return append([]byte{0x40 | byte(len(value))}, []byte(value)...)
	}
	countryRecord := append([]byte{0xe1}, encodeString("country")...)
	countryRecord = append(countryRecord, 0xe1)
	countryRecord = append(countryRecord, encodeString("iso_code")...)
	countryRecord = append(countryRecord, encodeString("CN")...)
	metaList := append([]byte{0x02, 0x04}, encodeString("cn")...)
	metaList = append(metaList, encodeString("private")...)
	for _, test := range []struct {
		name, databaseType string
		record             []byte
	}{
		{"sing string", "sing-geoip", encodeString("cn")},
		{"meta string", "Meta-geoip0", encodeString("cn")},
		{"meta list", "Meta-geoip0", metaList},
		{"MaxMind country", "GeoLite2-Country", countryRecord},
		{"custom MaxMind country", "Custom-Country", countryRecord},
	} {
		t.Run(test.name, func(t *testing.T) {
			data := bytes.Replace(fixture, encodeString("cn"), test.record, 1)
			data = bytes.Replace(data, encodeString("sing-geoip"), encodeString(test.databaseType), 1)
			if err := validateGeoData("MMDB", data); err != nil {
				t.Fatalf("supported MMDB layout rejected: %v", err)
			}
		})
	}
}

func TestGeoUpdateErrorsIdentifyRecoverableStage(t *testing.T) {
	data, _ := setupGeoUpdateServer(t, nil)
	t.Run("download", func(t *testing.T) {
		ctx, cancel := context.WithCancel(context.Background())
		cancel()
		err := updateGeoDataLocked(ctx, "GEOIP", constant.Path.GeoIP())
		if err == nil || !strings.HasPrefix(err.Error(), "GEO download failed: ") || !errors.Is(err, context.Canceled) {
			t.Fatalf("download failure lost its stage or cancellation cause: %v", err)
		}
	})
	t.Run("validation", func(t *testing.T) {
		err := updateGeoDataLockedFromURL(context.Background(), "GEOIP", constant.Path.GeoIP(), geodata.GeoSiteUrl())
		if err == nil || !strings.HasPrefix(err.Error(), "invalid GEOIP database file: ") {
			t.Fatalf("validation failure lost its stage: %v", err)
		}
	})
	t.Run("file installation", func(t *testing.T) {
		parent := filepath.Join(t.TempDir(), "file")
		if err := os.WriteFile(parent, data["GEOIP"], 0o600); err != nil {
			t.Fatal(err)
		}
		err := updateGeoDataLocked(context.Background(), "GEOIP", filepath.Join(parent, "GEOIP.dat"))
		var pathError *os.PathError
		if !errors.As(err, &pathError) || strings.HasPrefix(err.Error(), "GEO download failed: ") || strings.HasPrefix(err.Error(), "invalid GEOIP database file: ") {
			t.Fatalf("file installation error was classified as a source failure: %v", err)
		}
	})
}

func TestValidateBundledGeoData(t *testing.T) {
	for geoType, name := range map[string]string{
		"MMDB": "GEOIP.metadb", "ASN": "ASN.mmdb", "GEOIP": "GEOIP.dat", "GEOSITE": "GEOSITE.dat",
	} {
		t.Run(geoType, func(t *testing.T) {
			data, err := os.ReadFile(filepath.Join("..", "assets", "data", name))
			if err != nil {
				t.Fatal(err)
			}
			if err := validateGeoData(geoType, data); err != nil {
				t.Fatalf("bundled %s database rejected: %v", geoType, err)
			}
		})
	}
}

func TestValidateGeoDataRejectsInvalidCNRecords(t *testing.T) {
	for _, test := range []struct {
		name, geoType string
		message       proto.Message
	}{
		{"empty CIDRs", "GEOIP", &router.GeoIPList{Entry: []*router.GeoIP{{CountryCode: "CN"}}}},
		{"invalid prefix", "GEOIP", &router.GeoIPList{Entry: []*router.GeoIP{{CountryCode: "CN", Cidr: []*router.CIDR{{Ip: []byte{1, 0, 0, 0}, Prefix: 33}}}}}},
		{"empty domains", "GEOSITE", &router.GeoSiteList{Entry: []*router.GeoSite{{CountryCode: "CN"}}}},
		{"empty domain value", "GEOSITE", &router.GeoSiteList{Entry: []*router.GeoSite{{CountryCode: "CN", Domain: []*router.Domain{{Type: router.Domain_Domain}}}}}},
		{"invalid domain type", "GEOSITE", &router.GeoSiteList{Entry: []*router.GeoSite{{CountryCode: "CN", Domain: []*router.Domain{{Type: 100, Value: "example.cn"}}}}}},
		{"invalid regex", "GEOSITE", &router.GeoSiteList{Entry: []*router.GeoSite{{CountryCode: "CN", Domain: []*router.Domain{{Type: router.Domain_Regex, Value: "["}}}}}},
	} {
		t.Run(test.name, func(t *testing.T) {
			data, err := proto.Marshal(test.message)
			if err != nil {
				t.Fatal(err)
			}
			if err := validateGeoData(test.geoType, data); err == nil {
				t.Fatal("invalid CN records were accepted")
			}
		})
	}
}

func TestGeoResourcePathAcceptsMMDBAliases(t *testing.T) {
	previousHome := constant.Path.HomeDir()
	previousGeoipName := constant.GeoipName
	t.Cleanup(func() {
		constant.SetHomeDir(previousHome)
		constant.GeoipName = previousGeoipName
	})
	aliases := []string{"Country.mmdb", "geoip.db", "geoip.metadb", "GEOIP.metadb"}
	for _, existingName := range aliases {
		t.Run(existingName, func(t *testing.T) {
			constant.SetHomeDir(t.TempDir())
			existingPath := filepath.Join(constant.Path.HomeDir(), existingName)
			if err := os.WriteFile(existingPath, []byte("database"), 0o600); err != nil {
				t.Fatal(err)
			}
			for _, requestedName := range aliases {
				path, err := geoResourcePath("MMDB", requestedName)
				if err != nil || path != existingPath {
					t.Errorf("geoResourcePath(MMDB, %q) = %q, %v; want %q", requestedName, path, err, existingPath)
				}
			}
		})
	}
}

func TestGeoResourcePathRejectsUnexpectedNames(t *testing.T) {
	for _, test := range []struct{ geoType, name string }{
		{"GEOIP", "../GEOIP.dat"},
		{"GEOIP", "GEOSITE.dat"},
		{"MMDB", "../Country.mmdb"},
		{"MMDB", `..\Country.mmdb`},
		{"MMDB", "folder/geoip.metadb"},
		{"MMDB", "GEOIP.dat"},
		{"ASN", "Country.mmdb"},
		{"GEOSITE", "GEOIP.dat"},
		{"OTHER", "GEOIP.dat"},
	} {
		t.Run(test.geoType+"/"+test.name, func(t *testing.T) {
			if path, err := geoResourcePath(test.geoType, test.name); err == nil || path != "" {
				t.Fatalf("geoResourcePath() accepted an unexpected resource name: %q, %v", path, err)
			}
		})
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

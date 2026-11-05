package main

import (
	"context"
	"net/http"
	"net/http/httptest"
	"os"
	"path/filepath"
	"testing"
	"time"
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
	data, err := downloadGeoData(context.Background(), server.URL)
	if err != nil {
		t.Fatal(err)
	}
	if err := validateGeoData("GEOIP", data); err == nil {
		t.Fatal("validateGeoData() accepted invalid GEOIP data")
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

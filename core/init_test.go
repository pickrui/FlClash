//go:build !cgo

package main

import (
	"encoding/json"
	"os"
	"path/filepath"
	"testing"

	"github.com/metacubex/mihomo/constant"
)

func TestHandleInitClashInitializesApplicationHome(t *testing.T) {
	oldHome := constant.Path.HomeDir()
	oldSourceHome := GlobalValidationSourceHome
	oldIsInit := isInit.Load()
	oldVersion := version
	t.Cleanup(func() {
		constant.SetHomeDir(oldHome)
		GlobalValidationSourceHome = oldSourceHome
		isInit.Store(oldIsInit)
		version = oldVersion
	})

	home := filepath.Join(t.TempDir(), "nested", "app-home")
	params, err := json.Marshal(InitParams{HomeDir: home, Version: 7})
	if err != nil {
		t.Fatal(err)
	}
	if !handleInitClash(string(params)) {
		t.Fatal("handleInitClash() = false")
	}
	if _, err := os.Stat(home); err != nil {
		t.Fatalf("application home was not created: %v", err)
	}
	if got := constant.Path.HomeDir(); got != home {
		t.Fatalf("HomeDir() = %q, want %q", got, home)
	}
	if GlobalValidationSourceHome != home {
		t.Fatalf(
			"GlobalValidationSourceHome = %q, want %q",
			GlobalValidationSourceHome,
			home,
		)
	}
}

func TestHandleInitClashRejectsEmptyHome(t *testing.T) {
	if handleInitClash(`{"version":7}`) {
		t.Fatal("handleInitClash() accepted an empty home directory")
	}
}

func TestValidateConfigDataRequiresInitialization(t *testing.T) {
	oldIsInit := isInit.Load()
	isInit.Store(false)
	t.Cleanup(func() { isInit.Store(oldIsInit) })

	if got := validateConfigData([]byte("rules: []")); got != "not initialized" {
		t.Fatalf("validateConfigData() = %q, want %q", got, "not initialized")
	}
}

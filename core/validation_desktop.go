//go:build !cgo

package main

import (
	"bytes"
	"context"
	"fmt"
	"io"
	"os"
	"os/exec"
	"path/filepath"
	"strings"
	"time"

	"github.com/metacubex/mihomo/constant"
)

const (
	validationTimeout    = 30 * time.Second
	validationHomePrefix = "flclash-validate-"
)

func isolatedValidateConfigData(data []byte) string {
	tempDir, err := createValidationHome()
	if err != nil {
		return "Parse Error: " + err.Error()
	}
	defer os.RemoveAll(tempDir)
	actualHome := constant.Path.HomeDir()

	executable, err := os.Executable()
	if err != nil {
		return "Parse Error: " + err.Error()
	}
	resultPath := filepath.Join(tempDir, "result")
	ctx, cancel := context.WithTimeout(context.Background(), validationTimeout)
	defer cancel()
	cmd := exec.CommandContext(ctx, executable, "--validate-config", tempDir, resultPath)
	environment := make([]string, 0, len(os.Environ())+3)
	for _, entry := range os.Environ() {
		if strings.HasPrefix(entry, "SAFE_PATHS=") ||
			strings.HasPrefix(entry, "SKIP_SAFE_PATH_CHECK=") ||
			strings.HasPrefix(entry, "FLCLASH_VALIDATION_SOURCE_HOME=") {
			continue
		}
		environment = append(environment, entry)
	}
	cmd.Env = append(
		environment,
		"SAFE_PATHS=",
		"SKIP_SAFE_PATH_CHECK=false",
		"FLCLASH_VALIDATION_SOURCE_HOME="+actualHome,
	)
	cmd.Stdin = bytes.NewReader(data)
	cmd.Stdout = io.Discard
	cmd.Stderr = io.Discard
	runErr := cmd.Run()
	if runErr == nil {
		return ""
	}
	if ctx.Err() != nil {
		return "Parse Error: validator process timed out"
	}
	result, readErr := os.ReadFile(resultPath)
	if readErr == nil && len(result) > 0 {
		return "Parse Error: " + string(result)
	}
	return fmt.Sprintf("Parse Error: validator process failed: %v", runErr)
}

func createValidationHome() (string, error) {
	systemTemp := os.TempDir()
	dir, systemErr := os.MkdirTemp(systemTemp, validationHomePrefix)
	if systemErr == nil {
		cleanupStaleValidationHomes(systemTemp)
		return dir, nil
	}
	// Cores started by the elevated Windows helper inherit the service TEMP
	// (C:\Windows\SystemTemp), which does not exist on every system.
	home := constant.Path.HomeDir()
	if home == "" {
		return "", systemErr
	}
	fallback := filepath.Join(home, "temp")
	if err := os.MkdirAll(fallback, 0o700); err != nil {
		return "", err
	}
	dir, err := os.MkdirTemp(fallback, validationHomePrefix)
	if err != nil {
		return "", err
	}
	cleanupStaleValidationHomes(fallback)
	return dir, nil
}

func cleanupStaleValidationHomes(root string) {
	entries, err := os.ReadDir(root)
	if err != nil {
		return
	}
	cutoff := time.Now().Add(-time.Hour)
	for _, entry := range entries {
		if !entry.IsDir() || !strings.HasPrefix(entry.Name(), validationHomePrefix) {
			continue
		}
		info, err := entry.Info()
		if err == nil && info.ModTime().Before(cutoff) {
			_ = os.RemoveAll(filepath.Join(root, entry.Name()))
		}
	}
}

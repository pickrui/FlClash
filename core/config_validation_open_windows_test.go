//go:build windows && !cgo

package main

import (
	"os"
	"syscall"
	"testing"

	"golang.org/x/sys/windows"
)

type validationWindowsFileInfo struct {
	os.FileInfo
	attributes uint32
}

func (info validationWindowsFileInfo) Sys() any {
	return &syscall.Win32FileAttributeData{FileAttributes: info.attributes}
}

func TestShouldFallbackValidationResourceOpen(t *testing.T) {
	err := &os.PathError{
		Op:   "openat",
		Path: "ASN.mmdb",
		Err:  windows.ERROR_INVALID_PARAMETER,
	}
	if !shouldFallbackValidationResourceOpen(err) {
		t.Fatal("Windows invalid parameter error did not enable validation fallback")
	}
	if shouldFallbackValidationResourceOpen(os.ErrNotExist) {
		t.Fatal("unrelated error enabled validation fallback")
	}
}

func TestValidationPathEntryIsLinkRejectsReparsePoint(t *testing.T) {
	info, err := os.Stat(".")
	if err != nil {
		t.Fatal(err)
	}
	if !validationPathEntryIsLink(validationWindowsFileInfo{
		FileInfo:   info,
		attributes: windows.FILE_ATTRIBUTE_REPARSE_POINT,
	}) {
		t.Fatal("Windows reparse point was accepted")
	}
	if validationPathEntryIsLink(validationWindowsFileInfo{
		FileInfo:   info,
		attributes: windows.FILE_ATTRIBUTE_NORMAL,
	}) {
		t.Fatal("regular Windows file was rejected")
	}
}

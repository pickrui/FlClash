//go:build windows

package main

import (
	"errors"
	"os"
	"syscall"

	"golang.org/x/sys/windows"
)

func shouldFallbackValidationResourceOpen(err error) bool {
	return errors.Is(err, windows.ERROR_INVALID_PARAMETER)
}

func validationPathEntryIsLink(info os.FileInfo) bool {
	attributes, ok := info.Sys().(*syscall.Win32FileAttributeData)
	return info.Mode()&os.ModeSymlink != 0 ||
		ok && attributes.FileAttributes&windows.FILE_ATTRIBUTE_REPARSE_POINT != 0
}

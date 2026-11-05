//go:build !windows

package main

import "os"

func shouldFallbackValidationResourceOpen(error) bool {
	return false
}

func validationPathEntryIsLink(info os.FileInfo) bool {
	return info.Mode()&os.ModeSymlink != 0
}

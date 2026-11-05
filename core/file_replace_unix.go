//go:build !windows

package main

import "os"

func replaceFileAtomic(source string, target string) error {
	return os.Rename(source, target)
}

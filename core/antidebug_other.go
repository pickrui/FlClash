//go:build !linux && !darwin

package main

func debuggerPresent() bool {
	return false
}

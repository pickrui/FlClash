//go:build !cgo && !windows

package main

import (
	"io"
	"net"
)

func dial(path string) (io.ReadWriteCloser, error) {
	return net.Dial("unix", path)
}

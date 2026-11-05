//go:build linux && !android

package main

import "golang.org/x/sys/unix"

func setTestStatMode(stat *unix.Stat_t, value uint16)  { stat.Mode = uint32(value) }
func setTestStatLinks(stat *unix.Stat_t, value uint64) { stat.Nlink = value }

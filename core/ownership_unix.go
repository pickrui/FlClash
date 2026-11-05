//go:build (darwin || linux) && !android

package main

import (
	"errors"
	"io"
	"os"
	"sync"
	"sync/atomic"
	"time"

	"github.com/metacubex/mihomo/log"
	"golang.org/x/sys/unix"
)

const reclaimDebounce = 2 * time.Second

var (
	reclaimHomeDir   atomic.Value
	reclaimRequested atomic.Bool
	reclaimRunning   atomic.Bool
	reclaimLock      sync.Mutex
)

func isElevated() bool { return os.Geteuid() == 0 && os.Getuid() > 0 }

// Never follow the home entry itself, and never repair another user's home.
func openReclaimHome(path string, uid int) (*os.File, error) {
	if path == "" || uid <= 0 {
		return nil, unix.EINVAL
	}
	fd, err := unix.Open(path, unix.O_RDONLY|unix.O_DIRECTORY|unix.O_NOFOLLOW|unix.O_CLOEXEC, 0)
	if err != nil {
		return nil, err
	}
	var stat unix.Stat_t
	if err = unix.Fstat(fd, &stat); err == nil && int(stat.Uid) != uid {
		err = unix.EPERM
	}
	if err != nil {
		unix.Close(fd)
		return nil, err
	}
	return os.NewFile(uintptr(fd), path), nil
}

// Keep the system calls injectable so tests can model root-owned entries
// without running the test process as root or changing real file ownership.
type reclaimFileOps struct {
	statAt func(int, string, *unix.Stat_t, int) error
	stat   func(int, *unix.Stat_t) error
	chown  func(int, int, int) error
}

func nativeReclaimFileOps() reclaimFileOps {
	return reclaimFileOps{unix.Fstatat, unix.Fstat, unix.Fchown}
}

func reclaimableStat(stat *unix.Stat_t) bool {
	if stat.Uid != 0 {
		return false
	}
	switch stat.Mode & unix.S_IFMT {
	case unix.S_IFDIR:
		return true
	case unix.S_IFREG:
		return stat.Nlink == 1
	default:
		return false
	}
}

func traversableStat(stat *unix.Stat_t, uid int) bool {
	return stat.Mode&unix.S_IFMT == unix.S_IFDIR && (stat.Uid == 0 || int(stat.Uid) == uid)
}

// Every child is opened relative to an already verified directory descriptor.
// A rename or symlink replacement cannot redirect traversal to another tree.
// Before changing ownership, compare the opened inode with the entry observed
// in that directory and recheck its type, owner, and hard-link count.
func reclaimChildren(dir *os.File, uid, gid, depth int, ops reclaimFileOps) (int, error) {
	if depth >= 64 {
		return 0, unix.ELOOP
	}
	reclaimed := 0
	var firstErr error
	remember := func(err error) {
		if err != nil && firstErr == nil && !errors.Is(err, os.ErrNotExist) && !errors.Is(err, unix.ELOOP) {
			firstErr = err
		}
	}
	for {
		entries, readErr := dir.ReadDir(128)
		for _, entry := range entries {
			name := entry.Name()
			var before unix.Stat_t
			if err := ops.statAt(int(dir.Fd()), name, &before, unix.AT_SYMLINK_NOFOLLOW); err != nil {
				remember(err)
				continue
			}
			directory := traversableStat(&before, uid)
			if !directory && !reclaimableStat(&before) {
				continue
			}
			flags := unix.O_RDONLY | unix.O_NOFOLLOW | unix.O_NONBLOCK | unix.O_CLOEXEC
			if directory {
				flags |= unix.O_DIRECTORY
			}
			fd, err := unix.Openat(int(dir.Fd()), name, flags, 0)
			if err != nil {
				remember(err)
				continue
			}
			func() {
				child := os.NewFile(uintptr(fd), name)
				defer child.Close()
				var opened unix.Stat_t
				if err := ops.stat(fd, &opened); err != nil {
					remember(err)
					return
				}
				if opened.Dev != before.Dev || opened.Ino != before.Ino {
					return
				}
				if directory && traversableStat(&opened, uid) {
					count, err := reclaimChildren(child, uid, gid, depth+1, ops)
					reclaimed += count
					remember(err)
					// Descendants may take time to scan; refresh before fchown.
					if err := ops.stat(fd, &opened); err != nil {
						remember(err)
						return
					}
				}
				if reclaimableStat(&opened) {
					if err := ops.chown(fd, uid, gid); err != nil {
						remember(err)
						return
					}
					reclaimed++
				}
			}()
		}
		if readErr != nil {
			if !errors.Is(readErr, io.EOF) {
				remember(readErr)
			}
			return reclaimed, firstErr
		}
	}
}

func reclaimOwnership(homeDir string) {
	if !isElevated() {
		return
	}
	reclaimLock.Lock()
	defer reclaimLock.Unlock()
	home, err := openReclaimHome(homeDir, os.Getuid())
	if err != nil {
		return
	}
	defer home.Close()
	count, err := reclaimChildren(home, os.Getuid(), os.Getgid(), 0, nativeReclaimFileOps())
	if err != nil {
		log.Warnln("[APP] ownership recovery incomplete: %v", err)
	}
	if count > 0 {
		log.Infoln("[APP] restored ownership of %d elevated data entries", count)
	}
}

func initOwnership(homeDir string) {
	reclaimHomeDir.Store(homeDir)
	reclaimOwnership(homeDir)
}

func flushReclaimOwnership() {
	homeDir, _ := reclaimHomeDir.Load().(string)
	if homeDir != "" {
		reclaimOwnership(homeDir)
	}
}

func scheduleReclaimOwnership() {
	if !isElevated() {
		return
	}
	reclaimRequested.Store(true)
	if !reclaimRunning.CompareAndSwap(false, true) {
		return
	}
	go func() {
		for {
			time.Sleep(reclaimDebounce)
			reclaimRequested.Store(false)
			flushReclaimOwnership()
			reclaimRunning.Store(false)
			// Do another pass if a write finished during the sweep. A competing
			// caller may already own that next pass, in which case we exit.
			if !reclaimRequested.Load() || !reclaimRunning.CompareAndSwap(false, true) {
				return
			}
		}
	}()
}

//go:build (darwin || linux) && !android

package main

import (
	"os"
	"path/filepath"
	"testing"

	"golang.org/x/sys/unix"
)

func TestReclaimHomeRejectsWrongOwnerSymlinksAndFiles(t *testing.T) {
	home := t.TempDir()
	uid := os.Getuid()
	if uid == 0 {
		t.Skip("test models a non-root desktop user")
	}
	file, err := openReclaimHome(home, uid)
	if err != nil {
		t.Fatal(err)
	}
	file.Close()
	os.WriteFile(filepath.Join(home, "file"), nil, 0o600)
	os.Symlink(home, filepath.Join(home, "link"))
	for _, path := range []string{"", filepath.Join(home, "missing"), filepath.Join(home, "file"), filepath.Join(home, "link")} {
		if f, err := openReclaimHome(path, uid); err == nil {
			f.Close()
			t.Fatalf("accepted %q", path)
		}
	}
	if f, err := openReclaimHome(home, uid+1); err == nil {
		f.Close()
		t.Fatal("accepted another user's home")
	}
	if f, err := openReclaimHome(home, 0); err == nil {
		f.Close()
		t.Fatal("accepted a root caller")
	}
}

func TestReclaimOnlyRootOwnedRegularFilesAndDirectories(t *testing.T) {
	cases := []struct {
		uid   uint32
		mode  uint16
		links uint64
		want  bool
	}{
		{0, unix.S_IFREG | 0o600, 1, true}, {0, unix.S_IFDIR | 0o700, 3, true},
		{501, unix.S_IFREG | 0o600, 1, false}, {502, unix.S_IFDIR | 0o700, 2, false},
		{0, unix.S_IFREG | 0o600, 2, false}, {0, unix.S_IFLNK | 0o777, 1, false},
		{0, unix.S_IFIFO | 0o600, 1, false}, {0, unix.S_IFSOCK | 0o600, 1, false},
	}
	for _, c := range cases {
		// Stat_t field widths differ on Darwin and Linux.
		var stat unix.Stat_t
		stat.Uid = c.uid
		setTestStatMode(&stat, c.mode)
		setTestStatLinks(&stat, c.links)
		if got := reclaimableStat(&stat); got != c.want {
			t.Fatalf("%+v: got %v", c, got)
		}
	}
}

func ownershipStat(t *testing.T, path string) unix.Stat_t {
	t.Helper()
	var stat unix.Stat_t
	if err := unix.Lstat(path, &stat); err != nil {
		t.Fatal(err)
	}
	return stat
}

func simulatedRootOps(owners map[uint64]uint32, changes *[]uint64) reclaimFileOps {
	rewrite := func(stat *unix.Stat_t) {
		if uid, ok := owners[uint64(stat.Ino)]; ok {
			stat.Uid = uid
		}
	}
	return reclaimFileOps{
		statAt: func(fd int, name string, stat *unix.Stat_t, flags int) error {
			err := unix.Fstatat(fd, name, stat, flags)
			if err == nil {
				rewrite(stat)
			}
			return err
		},
		stat: func(fd int, stat *unix.Stat_t) error {
			err := unix.Fstat(fd, stat)
			if err == nil {
				rewrite(stat)
			}
			return err
		},
		chown: func(fd, uid, gid int) error {
			if uid != os.Getuid() || gid != os.Getgid() {
				panic("wrong caller identity")
			}
			var stat unix.Stat_t
			if err := unix.Fstat(fd, &stat); err != nil {
				return err
			}
			*changes = append(*changes, uint64(stat.Ino))
			return nil
		},
	}
}

func TestReclaimWalkUsesDescriptorsAndSkipsForeignTreesAndLinks(t *testing.T) {
	home, outside := t.TempDir(), t.TempDir()
	paths := []string{"cache.db", "owned", "root-dir/provider", "foreign-dir/secret"}
	for _, path := range paths {
		target := filepath.Join(home, path)
		if err := os.MkdirAll(filepath.Dir(target), 0o700); err != nil {
			t.Fatal(err)
		}
		if err := os.WriteFile(target, []byte(path), 0o600); err != nil {
			t.Fatal(err)
		}
	}
	os.WriteFile(filepath.Join(outside, "secret"), []byte("outside"), 0o600)
	os.Symlink(outside, filepath.Join(home, "symlink"))
	os.Link(filepath.Join(home, "owned"), filepath.Join(home, "hardlink"))
	unix.Mkfifo(filepath.Join(home, "fifo"), 0o600)
	owners := map[uint64]uint32{}
	for _, path := range []string{"cache.db", "owned", "root-dir", "root-dir/provider", "foreign-dir/secret", "fifo"} {
		stat := ownershipStat(t, filepath.Join(home, path))
		owners[uint64(stat.Ino)] = 0
	}
	stat := ownershipStat(t, filepath.Join(home, "foreign-dir"))
	owners[uint64(stat.Ino)] = uint32(os.Getuid() + 1)
	root, err := openReclaimHome(home, os.Getuid())
	if err != nil {
		t.Fatal(err)
	}
	defer root.Close()
	var changes []uint64
	count, err := reclaimChildren(root, os.Getuid(), os.Getgid(), 0, simulatedRootOps(owners, &changes))
	if err != nil || count != 3 || len(changes) != 3 {
		t.Fatalf("count %d changes %v error %v", count, changes, err)
	}
	for _, path := range []string{"cache.db", "root-dir/provider", "root-dir"} {
		inode := uint64(ownershipStat(t, filepath.Join(home, path)).Ino)
		found := false
		for _, changed := range changes {
			found = found || changed == inode
		}
		if !found {
			t.Fatalf("did not restore %s", path)
		}
	}
}

func TestReclaimRejectsEntryReplacedBetweenStatAndOpen(t *testing.T) {
	for _, link := range []bool{false, true} {
		home, outside := t.TempDir(), t.TempDir()
		target := filepath.Join(home, "entry")
		os.WriteFile(target, []byte("old"), 0o600)
		replacement := filepath.Join(outside, "replacement")
		os.WriteFile(replacement, []byte("untouched"), 0o600)
		original := ownershipStat(t, target)
		var changes []uint64
		ops := simulatedRootOps(map[uint64]uint32{uint64(original.Ino): 0}, &changes)
		statAt := ops.statAt
		ops.statAt = func(fd int, name string, stat *unix.Stat_t, flags int) error {
			err := statAt(fd, name, stat, flags)
			if name == "entry" && err == nil {
				// Keep the old inode allocated, preventing inode-number reuse.
				if err := os.Rename(target, filepath.Join(outside, "old")); err != nil {
					t.Fatal(err)
				}
				if link {
					err = os.Symlink(replacement, target)
				} else {
					err = os.Rename(replacement, target)
				}
				if err != nil {
					t.Fatal(err)
				}
			}
			return err
		}
		root, err := openReclaimHome(home, os.Getuid())
		if err != nil {
			t.Fatal(err)
		}
		count, _ := reclaimChildren(root, os.Getuid(), os.Getgid(), 0, ops)
		root.Close()
		if count != 0 || len(changes) != 0 {
			t.Fatal("changed a substituted entry")
		}
	}
}

func TestUnprivilegedOwnershipRecoveryDoesNothing(t *testing.T) {
	if isElevated() {
		t.Skip("requires an ordinary user")
	}
	home := t.TempDir()
	initOwnership(home)
	scheduleReclaimOwnership()
	flushReclaimOwnership()
	if reclaimRunning.Load() {
		t.Fatal("started privileged recovery without a setuid caller")
	}
}

func TestReclaimRejectsDirectoryReplacedWithAnOutsideSymlink(t *testing.T) {
	home, outside := t.TempDir(), t.TempDir()
	directory := filepath.Join(home, "providers")
	os.Mkdir(directory, 0o700)
	os.WriteFile(filepath.Join(directory, "data"), nil, 0o600)
	os.WriteFile(filepath.Join(outside, "data"), nil, 0o600)
	original := ownershipStat(t, filepath.Join(directory, "data"))
	foreign := ownershipStat(t, filepath.Join(outside, "data"))
	var changes []uint64
	ops := simulatedRootOps(map[uint64]uint32{uint64(original.Ino): 0, uint64(foreign.Ino): 0}, &changes)
	statAt := ops.statAt
	ops.statAt = func(fd int, name string, stat *unix.Stat_t, flags int) error {
		err := statAt(fd, name, stat, flags)
		if name == "providers" && err == nil {
			if err := os.Rename(directory, filepath.Join(outside, "old")); err != nil {
				t.Fatal(err)
			}
			if err := os.Symlink(outside, directory); err != nil {
				t.Fatal(err)
			}
		}
		return err
	}
	root, err := openReclaimHome(home, os.Getuid())
	if err != nil {
		t.Fatal(err)
	}
	defer root.Close()
	count, _ := reclaimChildren(root, os.Getuid(), os.Getgid(), 0, ops)
	if count != 0 || len(changes) != 0 {
		t.Fatal("traversed a substituted parent directory")
	}
}

func TestReclaimReportsFchownFailureWithoutClaimingSuccess(t *testing.T) {
	home := t.TempDir()
	path := filepath.Join(home, "cache.db")
	os.WriteFile(path, nil, 0o600)
	stat := ownershipStat(t, path)
	var changes []uint64
	ops := simulatedRootOps(map[uint64]uint32{uint64(stat.Ino): 0}, &changes)
	ops.chown = func(int, int, int) error { return unix.EPERM }
	root, err := openReclaimHome(home, os.Getuid())
	if err != nil {
		t.Fatal(err)
	}
	defer root.Close()
	count, err := reclaimChildren(root, os.Getuid(), os.Getgid(), 0, ops)
	if count != 0 || err != unix.EPERM {
		t.Fatalf("count %d error %v", count, err)
	}
}

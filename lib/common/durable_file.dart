import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';
import 'package:path/path.dart' as p;
import 'package:win32/win32.dart';

const _moveFileReplaceExisting = 0x1;
const _moveFileWriteThrough = 0x8;

Future<void> durableCreateDirectory(String path) async {
  final directory = Directory(path);
  if (await directory.exists()) {
    return;
  }
  final parent = p.dirname(path);
  if (parent != path) {
    await durableCreateDirectory(parent);
  }
  try {
    await directory.create();
  } on FileSystemException {
    if (!await directory.exists()) {
      rethrow;
    }
  }
  await syncDirectory(parent);
}

Future<void> durableDeleteFile(String path) async {
  final file = File(path);
  if (!await file.exists()) return;
  await file.delete();
  await syncDirectory(p.dirname(path));
}

Future<void> durableDeleteEntity(String path) async {
  final type = await FileSystemEntity.type(path, followLinks: false);
  if (type == FileSystemEntityType.notFound) return;
  if (type == FileSystemEntityType.directory) {
    await Directory(path).delete(recursive: true);
  } else {
    await File(path).delete();
  }
  await syncDirectory(p.dirname(path));
}

Future<void> durableRename(String source, String target) async {
  if (Platform.isWindows) {
    final sourcePointer = source.toNativeUtf16();
    final targetPointer = target.toNativeUtf16();
    try {
      final result = MoveFileEx(
        sourcePointer,
        targetPointer,
        _moveFileReplaceExisting | _moveFileWriteThrough,
      );
      if (result == 0) {
        throw FileSystemException(
          'Durable rename failed with Win32 error ${GetLastError()}',
          target,
        );
      }
    } finally {
      calloc.free(sourcePointer);
      calloc.free(targetPointer);
    }
    return;
  }
  await File(source).rename(target);
  await syncDirectory(p.dirname(source));
  final targetDirectory = p.dirname(target);
  if (targetDirectory != p.dirname(source)) {
    await syncDirectory(targetDirectory);
  }
}

Future<void> durableRenameDirectory(String source, String target) async {
  if (Platform.isWindows) {
    final sourcePointer = source.toNativeUtf16();
    final targetPointer = target.toNativeUtf16();
    try {
      final result = MoveFileEx(
        sourcePointer,
        targetPointer,
        _moveFileReplaceExisting | _moveFileWriteThrough,
      );
      if (result == 0) {
        throw FileSystemException(
          'Durable directory rename failed with Win32 error ${GetLastError()}',
          target,
        );
      }
    } finally {
      calloc.free(sourcePointer);
      calloc.free(targetPointer);
    }
    return;
  }
  await Directory(source).rename(target);
  await syncDirectory(p.dirname(source));
  final targetDirectory = p.dirname(target);
  if (targetDirectory != p.dirname(source)) {
    await syncDirectory(targetDirectory);
  }
}

Future<void> syncDirectory(String path) async {
  if (Platform.isWindows) {
    return;
  }
  final bindings = _UnixFileBindings.instance;
  final pathPointer = path.toNativeUtf8();
  try {
    final descriptor = bindings.open(pathPointer, 0);
    if (descriptor < 0) {
      throw FileSystemException('Unable to open directory for sync', path);
    }
    try {
      if (bindings.fsync(descriptor) != 0) {
        throw FileSystemException('Unable to sync directory', path);
      }
    } finally {
      bindings.close(descriptor);
    }
  } finally {
    calloc.free(pathPointer);
  }
}

class _UnixFileBindings {
  final int Function(Pointer<Utf8>, int) open;
  final int Function(int) fsync;
  final int Function(int) close;

  _UnixFileBindings._(DynamicLibrary library)
    : open = library
          .lookupFunction<
            Int32 Function(Pointer<Utf8>, Int32),
            int Function(Pointer<Utf8>, int)
          >('open'),
      fsync = library.lookupFunction<Int32 Function(Int32), int Function(int)>(
        'fsync',
      ),
      close = library.lookupFunction<Int32 Function(Int32), int Function(int)>(
        'close',
      );

  static final instance = _UnixFileBindings._(DynamicLibrary.process());
}

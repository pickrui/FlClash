import 'dart:async';
import 'dart:io' as io;

import 'package:dio/dio.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/models/models.dart';
import 'package:webdav_client/webdav_client.dart';

bool isSafeDavFileName(String value) {
  if (value.isEmpty || value == '.' || value == '..' || value.length > 255) {
    return false;
  }
  return !value.contains(RegExp(r'[/\\?#\x00-\x1f\x7f]'));
}

class DAVClient {
  late Client client;
  Completer<bool> pingCompleter = Completer();
  late String fileName;

  DAVClient(DAVProps dav) {
    if (!isSafeDavFileName(dav.fileName)) {
      throw const FormatException('invalid WebDAV backup file name');
    }
    client = newClient(dav.uri, user: dav.user, password: dav.password);
    fileName = dav.fileName;
    client.setHeaders({'accept-charset': 'utf-8', 'Content-Type': 'text/xml'});
    client.setConnectTimeout(8000);
    client.setSendTimeout(60000);
    client.setReceiveTimeout(60000);
    pingCompleter.complete(_ping());
  }

  Future<bool> _ping() async {
    try {
      await client.ping();
      return true;
    } catch (_) {
      return false;
    }
  }

  String get root => '/$appName';

  String get backupFile => '$root/$fileName';

  Future<bool> backup(String localFilePath) async {
    await client.mkdir(root);
    final temporaryRemotePath = '$backupFile.upload-${utils.id}';
    try {
      await client.writeFromFile(localFilePath, temporaryRemotePath);
      await client.rename(temporaryRemotePath, backupFile, true);
    } catch (_) {
      try {
        await client.remove(temporaryRemotePath);
      } catch (_) {}
      rethrow;
    }
    return true;
  }

  Future<String> restore() async {
    await client.mkdir(root);
    final backupFilePath = await appPath.tempFilePath;
    final token = CancelToken();
    try {
      await client.read2File(
        backupFile,
        backupFilePath,
        cancelToken: token,
        onProgress: (received, total) {
          if (received > maxBackupArchiveBytes ||
              total > maxBackupArchiveBytes) {
            token.cancel('backup archive exceeds restore limit');
          }
        },
      );
      final file = io.File(backupFilePath);
      if (!await file.exists() || await file.length() > maxBackupArchiveBytes) {
        throw const FormatException('backup archive exceeds restore limit');
      }
      return backupFilePath;
    } catch (_) {
      await io.File(backupFilePath).safeDelete();
      rethrow;
    }
  }
}

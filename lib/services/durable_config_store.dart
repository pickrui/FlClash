import 'dart:convert';
import 'dart:io';

import 'package:fl_clash/common/durable_file.dart';
import 'package:fl_clash/services/age_crypto.dart';
import 'package:fl_clash/services/config_key_store.dart';

class DurableConfigStore {
  final Future<AgeIdentity> Function() _identityProvider;

  DurableConfigStore({required Future<AgeIdentity> Function() identityProvider})
    : _identityProvider = identityProvider;

  Future<Map<String, Object?>?> read(String path) async {
    final target = File(path);
    final temporary = File('$path.tmp');
    final backup = File('$path.old');
    final candidates = [target, temporary, backup];
    final candidateExists = await Future.wait(
      candidates.map((file) => file.exists()),
    );
    if (!candidateExists.any((exists) => exists)) {
      return null;
    }
    late final AgeIdentity identity;
    try {
      identity = await _identityProvider();
    } on ConfigKeyUnavailableException {
      rethrow;
    } catch (error) {
      throw ConfigKeyUnavailableException(error);
    }
    for (final candidate in candidates) {
      if (!await candidate.exists()) {
        continue;
      }
      final Map<String, Object?> value;
      try {
        final plaintext = await AgeCrypto.decrypt(
          await candidate.readAsBytes(),
          identity,
        );
        value = Map<String, Object?>.from(
          jsonDecode(utf8.decode(plaintext)) as Map,
        );
      } catch (_) {
        continue;
      }
      // A readable candidate is authoritative. A failed repair must not fall
      // through to an older config or be reported as an unavailable key.
      if (!identical(candidate, target)) {
        await durableRename(candidate.path, target.path);
      }
      for (final stale in [temporary, backup]) {
        try {
          if (await stale.exists()) {
            await stale.delete();
          }
        } catch (_) {}
      }
      return value;
    }
    // Existing ciphertext must never be replaced by a sanitized preference
    // fallback just because its key is inaccessible or does not match.
    throw const ConfigKeyUnavailableException();
  }

  Future<void> write(String path, Object config) async {
    final identity = await _identityProvider();
    final ciphertext = await AgeCrypto.encrypt(
      utf8.encode(jsonEncode(config)),
      identity.publicKeyBytes,
    );
    final target = File(path);
    await durableCreateDirectory(target.parent.path);
    final temporary = File('$path.tmp');
    if (await temporary.exists()) {
      await temporary.delete();
    }
    await temporary.writeAsBytes(ciphertext, flush: true);
    if (await target.exists()) {
      final backup = File('$path.old');
      if (await backup.exists()) {
        await backup.delete();
      }
      await durableRename(target.path, backup.path);
      try {
        await durableRename(temporary.path, target.path);
        await backup.delete();
      } catch (_) {
        if (!await target.exists() && await backup.exists()) {
          await durableRename(backup.path, target.path);
        }
        rethrow;
      }
    } else {
      await durableRename(temporary.path, target.path);
    }
  }

  Future<void> clear(String path) async {
    for (final file in [File(path), File('$path.tmp'), File('$path.old')]) {
      if (await file.exists()) {
        await file.delete();
      }
    }
  }
}

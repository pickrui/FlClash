import 'dart:io';
import 'dart:convert';

import 'package:archive/archive.dart';
import 'package:drift/native.dart';
import 'package:fl_clash/common/constant.dart';
import 'package:fl_clash/common/task.dart';
import 'package:fl_clash/database/database.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:flutter_test/flutter_test.dart' show TestWidgetsFlutterBinding;
import 'package:path/path.dart' show basename;
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:sqlite3/sqlite3.dart' as sqlite;
import 'package:test/test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory pathProviderDir;

  setUpAll(() {
    pathProviderDir = Directory.systemTemp.createTempSync(
      'flclash_task_test_paths_',
    );
    PathProviderPlatform.instance = _FakePathProvider(pathProviderDir.path);
  });

  tearDownAll(() {
    pathProviderDir.deleteSync(recursive: true);
  });

  group('resolveSafeArchivePath', () {
    test('allows normalized child paths', () {
      expect(
        resolveSafeArchivePath('/tmp/restore', 'profiles/1.yaml'),
        '/tmp/restore/profiles/1.yaml',
      );
    });

    for (final entry in [
      '../outside',
      'profiles/../../outside',
      '/absolute/path',
      r'..\outside',
      r'C:\outside',
    ]) {
      test('rejects $entry', () {
        expect(
          () => resolveSafeArchivePath('/tmp/restore', entry),
          throwsFormatException,
        );
      });
    }
  });

  test('toGroupsTask parses mihomo runtime group type names', () async {
    final groups = await toGroupsTask(
      const ComputeGroupsState(
        proxiesData: ProxiesData(
          proxies: {
            'Proxy': {
              'name': 'Proxy',
              'type': 'Selector',
              'now': 'Node',
              'all': ['Node'],
            },
            'Auto': {
              'name': 'Auto',
              'type': 'URLTest',
              'now': 'Node',
              'all': ['Node'],
            },
            'Node': {'name': 'Node', 'type': 'Shadowsocks'},
          },
          all: ['Proxy', 'Auto', 'Node'],
        ),
        sortType: ProxiesSortType.none,
        delayMap: {},
        selectedMap: {},
        defaultTestUrl: '',
      ),
    );

    expect(groups.map((group) => group.type), [
      GroupType.Selector,
      GroupType.URLTest,
    ]);
  });

  group('extractBackupArchive', () {
    test('extracts regular files inside the staging directory', () async {
      final tempDir = await Directory.systemTemp.createTemp('extract_safe_');
      addTearDown(() => tempDir.delete(recursive: true));
      final archive = Archive()
        ..add(ArchiveFile.string('profiles/1.yaml', 'content'));

      await extractBackupArchive(archive, tempDir.path);

      expect(
        await File('${tempDir.path}/profiles/1.yaml').readAsString(),
        'content',
      );
    });

    test('rejects an entry whose payload does not match its CRC', () async {
      final root = await Directory.systemTemp.createTemp('extract_crc_');
      addTearDown(() => root.delete(recursive: true));
      final archive = Archive()
        ..add(ArchiveFile.noCompress('file.txt', 4, utf8.encode('safe')));
      final bytes = ZipEncoder().encode(archive);
      final payload = utf8.encode('safe');
      var payloadOffset = -1;
      for (var index = 0; index <= bytes.length - payload.length; index++) {
        if (bytes[index] == payload[0] &&
            bytes[index + 1] == payload[1] &&
            bytes[index + 2] == payload[2] &&
            bytes[index + 3] == payload[3]) {
          payloadOffset = index;
          break;
        }
      }
      expect(payloadOffset, greaterThanOrEqualTo(0));
      bytes[payloadOffset] ^= 0x01;
      final corrupted = ZipDecoder().decodeBytes(bytes);

      await expectLater(
        extractBackupArchive(corrupted, '${root.path}/restore'),
        throwsFormatException,
      );
    });

    test('rejects normalized path collisions and clears staging', () async {
      final tempDir = await Directory.systemTemp.createTemp(
        'extract_collision_',
      );
      addTearDown(() async {
        if (await tempDir.exists()) {
          await tempDir.delete(recursive: true);
        }
      });
      final archive = Archive()
        ..add(ArchiveFile.string('dir/../file.txt', 'first'))
        ..add(ArchiveFile.string('file.txt', 'second'));

      await expectLater(
        extractBackupArchive(archive, tempDir.path),
        throwsFormatException,
      );
      expect(await tempDir.exists(), false);
    });

    test('rejects symbolic links', () async {
      final tempDir = await Directory.systemTemp.createTemp('extract_symlink_');
      addTearDown(() async {
        if (await tempDir.exists()) {
          await tempDir.delete(recursive: true);
        }
      });
      final link = ArchiveFile.noData('link')..symbolicLink = '../outside';
      final archive = Archive()..add(link);

      await expectLater(
        extractBackupArchive(archive, tempDir.path),
        throwsFormatException,
      );
    });

    test('rejects too many entries', () async {
      final tempDir = await Directory.systemTemp.createTemp('extract_entries_');
      addTearDown(() async {
        if (await tempDir.exists()) {
          await tempDir.delete(recursive: true);
        }
      });
      final archive = Archive()
        ..add(ArchiveFile.string('a', 'a'))
        ..add(ArchiveFile.string('b', 'b'));

      await expectLater(
        extractBackupArchive(archive, tempDir.path, maxEntries: 1),
        throwsFormatException,
      );
    });

    test('rejects declared single-file and total size overflow', () async {
      final tempDir = await Directory.systemTemp.createTemp('extract_sizes_');
      addTearDown(() async {
        if (await tempDir.exists()) {
          await tempDir.delete(recursive: true);
        }
      });
      final archive = Archive()
        ..add(ArchiveFile.string('a', '1234'))
        ..add(ArchiveFile.string('b', '5678'));

      await expectLater(
        extractBackupArchive(archive, tempDir.path, maxFileBytes: 3),
        throwsFormatException,
      );
      await expectLater(
        extractBackupArchive(
          archive,
          tempDir.path,
          maxFileBytes: 4,
          maxTotalBytes: 7,
        ),
        throwsFormatException,
      );
    });

    test(
      'enforces actual bytes when archive size metadata is forged',
      () async {
        final tempDir = await Directory.systemTemp.createTemp(
          'extract_actual_',
        );
        addTearDown(() async {
          if (await tempDir.exists()) {
            await tempDir.delete(recursive: true);
          }
        });
        final file = ArchiveFile.string('file', '12345')..size = 1;
        final archive = Archive()..add(file);

        await expectLater(
          extractBackupArchive(archive, tempDir.path, maxFileBytes: 3),
          throwsFormatException,
        );
      },
    );
  });

  group('validateBackupArchiveDirectory', () {
    test('accepts a regular archive without extracting it', () async {
      final root = await Directory.systemTemp.createTemp('zip_preflight_ok_');
      addTearDown(() => root.delete(recursive: true));
      final zipPath = '${root.path}/backup.zip';
      final archive = Archive()
        ..add(ArchiveFile.string('profiles/1.yaml', 'profile'));
      await File(zipPath).writeAsBytes(ZipEncoder().encode(archive));

      await expectLater(
        validateBackupArchiveDirectory(zipPath, '${root.path}/restore'),
        completes,
      );
      expect(await Directory('${root.path}/restore').exists(), false);
    });

    test(
      'rejects symbolic links before ZipDecoder reads their content',
      () async {
        final root = await Directory.systemTemp.createTemp(
          'zip_preflight_link_',
        );
        addTearDown(() => root.delete(recursive: true));
        final archive = Archive()
          ..add(
            ArchiveFile.string('link', '../outside')
              ..symbolicLink = '../outside'
              ..mode = 0xa1ff,
          );
        final zipPath = '${root.path}/backup.zip';
        final bytes = ZipEncoder().encode(archive);
        var centralDirectory = -1;
        for (var index = 0; index <= bytes.length - 4; index++) {
          if (bytes[index] == 0x50 &&
              bytes[index + 1] == 0x4b &&
              bytes[index + 2] == 0x01 &&
              bytes[index + 3] == 0x02) {
            centralDirectory = index;
            break;
          }
        }
        expect(centralDirectory, greaterThanOrEqualTo(0));
        bytes[centralDirectory + 5] = 3;
        await File(zipPath).writeAsBytes(bytes);

        await expectLater(
          validateBackupArchiveDirectory(zipPath, '${root.path}/restore'),
          throwsFormatException,
        );
      },
    );
  });

  test('backupTask archives an immutable storage staging directory', () async {
    final staging = await Directory.systemTemp.createTemp('backup_staging_');
    await File('${staging.path}/$backupDatabaseName').writeAsString('database');
    await File(
      '${staging.path}/profiles/1.yaml',
    ).create(recursive: true).then((file) => file.writeAsString('profile'));
    await File(
      '${staging.path}/scripts/2.js',
    ).create(recursive: true).then((file) => file.writeAsString('script'));

    final zipPath = await backupTask({'version': 'test'}, staging.path);
    addTearDown(() => File(zipPath).delete());
    final archive = ZipDecoder().decodeBytes(await File(zipPath).readAsBytes());
    String content(String name) {
      final file = archive.findFile(name);
      expect(file, isNotNull);
      return utf8.decode(file!.content as List<int>);
    }

    expect(content(backupDatabaseName), 'database');
    expect(content('profiles/1.yaml'), 'profile');
    expect(content('scripts/2.js'), 'script');
    expect(json.decode(content(configJsonName)), {'version': 'test'});
    expect(await staging.exists(), false);
  });

  test('backupTask rejects files larger than the restore limit', () async {
    final staging = await Directory.systemTemp.createTemp('backup_oversized_');
    final database = await File(
      '${staging.path}/$backupDatabaseName',
    ).open(mode: FileMode.write);
    await database.truncate(maxBackupFileBytes + 1);
    await database.close();

    await expectLater(
      backupTask({'version': 'test'}, staging.path),
      throwsFormatException,
    );
    expect(await staging.exists(), false);
  });

  test('legacy migration writes only to staging before commit', () async {
    final root = await Directory.systemTemp.createTemp('legacy_restore_');
    addTearDown(() => root.delete(recursive: true));
    final source = Directory('${root.path}/source');
    final staging = Directory('${root.path}/legacy-output');
    final live = Directory('${root.path}/live');
    await File('${source.path}/profiles/legacy-profile.yaml')
        .create(recursive: true)
        .then((file) => file.writeAsString('legacy profile'));
    final liveMarker = File('${live.path}/profiles/keep.yaml');
    await liveMarker
        .create(recursive: true)
        .then((file) => file.writeAsString('keep'));

    final migration = await migrateLegacyBackup(
      {
        'profiles': [
          {
            'id': 'legacy-profile',
            'label': 'Legacy profile',
            'autoUpdateDuration': const Duration(days: 1).inMicroseconds,
          },
        ],
        'scripts': [
          {
            'id': 'legacy-script',
            'label': 'Legacy script',
            'content': 'console.log("legacy")',
          },
        ],
        'rules': <Object?>[],
        'currentProfileId': 'legacy-profile',
      },
      sourcePath: source.path,
      targetPath: staging.path,
      livePath: live.path,
    );

    expect(await liveMarker.readAsString(), 'keep');
    expect(
      await live.list(recursive: true).where((entity) => entity is File).length,
      1,
    );
    expect(migration.fileMigrations, hasLength(2));
    for (final fileMigration in migration.fileMigrations) {
      expect(fileMigration.a, startsWith('${staging.path}/'));
      expect(fileMigration.b, startsWith('${live.path}/'));
      expect(await File(fileMigration.a).exists(), true);
      expect(await File(fileMigration.b).exists(), false);
    }
  });

  test('legacy migration rejects profile ids containing paths', () async {
    final root = await Directory.systemTemp.createTemp('legacy_traversal_');
    addTearDown(() => root.delete(recursive: true));
    final source = Directory('${root.path}/source')..createSync();
    final staging = Directory('${root.path}/staging');
    final live = Directory('${root.path}/live');

    await expectLater(
      migrateLegacyBackup(
        {
          'profiles': [
            {
              'id': '../../outside',
              'autoUpdateDuration': const Duration(days: 1).inMicroseconds,
            },
          ],
        },
        sourcePath: source.path,
        targetPath: staging.path,
        livePath: live.path,
      ),
      throwsFormatException,
    );
  });

  test('legacy migration produces stable ids when retried', () async {
    final root = await Directory.systemTemp.createTemp('legacy_stable_');
    addTearDown(() => root.delete(recursive: true));
    await File(
      '${root.path}/profiles/profile-a.yaml',
    ).create(recursive: true).then((file) => file.writeAsString('profile'));
    Map<String, Object?> legacyData() => {
      'profiles': [
        {
          'id': 'profile-a',
          'label': 'Profile A',
          'autoUpdateDuration': const Duration(days: 1).inMicroseconds,
        },
      ],
      'scripts': [
        {'id': 'script-a', 'label': 'Script A', 'content': 'content'},
      ],
      'rules': [
        {'id': 'rule-a', 'value': 'MATCH,DIRECT'},
      ],
      'currentProfileId': 'profile-a',
    };

    final first = await migrateLegacyBackup(
      legacyData(),
      sourcePath: root.path,
      targetPath: '${root.path}/first',
      livePath: '${root.path}/live',
    );
    final second = await migrateLegacyBackup(
      legacyData(),
      sourcePath: root.path,
      targetPath: '${root.path}/second',
      livePath: '${root.path}/live',
    );

    expect(
      second.profiles.map((item) => item.id),
      first.profiles.map((item) => item.id),
    );
    expect(
      second.scripts.map((item) => item.id),
      first.scripts.map((item) => item.id),
    );
    expect(
      second.rules.map((item) => item.id),
      first.rules.map((item) => item.id),
    );
    expect(
      second.fileMigrations.map((item) => basename(item.b)),
      first.fileMigrations.map((item) => basename(item.b)),
    );
    expect(first.configMap, isNot(contains('profiles')));
    expect(first.configMap, isNot(contains('scripts')));
    expect(first.configMap, isNot(contains('rules')));
  });

  group('restoreTask legacy archive detection', () {
    Future<String> createBackup(
      Directory root,
      Map<String, Object?> config,
    ) async {
      final archive = Archive()
        ..add(ArchiveFile.string(configJsonName, json.encode(config)));
      final path = '${root.path}/backup.zip';
      await File(path).writeAsBytes(ZipEncoder().encode(archive));
      return path;
    }

    test('rejects an unstructured versionless config', () async {
      final root = await Directory.systemTemp.createTemp('legacy_empty_');
      addTearDown(() => root.delete(recursive: true));
      final backup = await createBackup(root, {});

      await expectLater(
        restoreTask(backup, '${root.path}/restore', '${root.path}/live'),
        throwsA(isNotNull),
      );
    });

    test('accepts the stable shape of a legacy empty backup', () async {
      final root = await Directory.systemTemp.createTemp('legacy_valid_');
      addTearDown(() => root.delete(recursive: true));
      final backup = await createBackup(root, {
        'profiles': <Object?>[],
        'scripts': <Object?>[],
        'rules': <Object?>[],
        'appSetting': <String, Object?>{},
        'themeProps': <String, Object?>{},
        'patchClashConfig': <String, Object?>{},
      });

      final migration = await restoreTask(
        backup,
        '${root.path}/restore',
        '${root.path}/live',
      );
      expect(migration.profiles, isEmpty);
      expect(migration.scripts, isEmpty);
      expect(migration.rules, isEmpty);
    });
  });

  group('validateBackupDatabase', () {
    test('rejects empty and schema-less SQLite files', () async {
      final root = await Directory.systemTemp.createTemp('invalid_backup_db_');
      addTearDown(() => root.delete(recursive: true));
      final empty = File('${root.path}/empty.sqlite')..createSync();
      expect(await validateBackupDatabase(empty.path), false);

      final schemaLess = sqlite.sqlite3.open('${root.path}/schema-less.sqlite');
      schemaLess.execute('CREATE TABLE unrelated (id INTEGER)');
      schemaLess.dispose();
      expect(
        await validateBackupDatabase('${root.path}/schema-less.sqlite'),
        false,
      );
    });

    test('accepts a database with the current backup schema', () async {
      final root = await Directory.systemTemp.createTemp('valid_backup_db_');
      addTearDown(() => root.delete(recursive: true));
      final database = Database(
        NativeDatabase(File('${root.path}/database.sqlite')),
      );
      await database.profilesDao.all().get();
      await database.close();

      expect(
        await validateBackupDatabase('${root.path}/database.sqlite'),
        true,
      );
    });

    test(
      'rejects future schemas but accepts repairable orphaned links',
      () async {
        final root = await Directory.systemTemp.createTemp('invalid_schema_');
        addTearDown(() => root.delete(recursive: true));
        final futurePath = '${root.path}/future.sqlite';
        final futureDatabase = Database(NativeDatabase(File(futurePath)));
        await futureDatabase.profilesDao.all().get();
        await futureDatabase.close();
        final futureSqlite = sqlite.sqlite3.open(futurePath);
        futureSqlite.execute('PRAGMA user_version = 4');
        futureSqlite.dispose();
        expect(await validateBackupDatabase(futurePath), false);

        final orphanPath = '${root.path}/orphan.sqlite';
        final orphanDatabase = Database(NativeDatabase(File(orphanPath)));
        await orphanDatabase.profilesDao.all().get();
        await orphanDatabase.close();
        final orphanSqlite = sqlite.sqlite3.open(orphanPath);
        orphanSqlite.execute(
          "INSERT INTO profile_rule_mapping (id, rule_id) VALUES ('orphan', 999)",
        );
        orphanSqlite.dispose();
        expect(await validateBackupDatabase(orphanPath), true);
      },
    );
  });

  test('schema v2 backup validation allows orphan repair', () async {
    final root = await Directory.systemTemp.createTemp('legacy_db_backup_');
    addTearDown(() => root.delete(recursive: true));
    final databasePath = '${root.path}/$backupDatabaseName';
    final database = Database(NativeDatabase(File(databasePath)));
    await database.profilesDao.all().get();
    await database.close();
    final legacyDatabase = sqlite.sqlite3.open(databasePath);
    legacyDatabase.execute('PRAGMA foreign_keys = OFF');
    legacyDatabase.execute(
      "INSERT INTO profile_rule_mapping (id, rule_id) VALUES ('orphan', 999)",
    );
    legacyDatabase.execute('PRAGMA user_version = 2');
    legacyDatabase.dispose();

    expect(await validateBackupDatabase(databasePath), true);
    final restoredDatabase = Database(NativeDatabase(File(databasePath)));
    expect(
      await restoredDatabase.select(restoredDatabase.profileRuleLinks).get(),
      isEmpty,
    );
    await restoredDatabase.close();
  });

  test('makeRealProfileTask applies Geo update preferences', () async {
    final result = await makeRealProfileTask(
      const MakeRealProfileState(
        profilesPath: '/profiles',
        profileId: 1,
        overwriteType: OverwriteType.standard,
        rawConfig: {
          'geo-auto-update': true,
          'geo-update-interval': 99,
          'rules': <String>[],
        },
        realPatchConfig: ClashConfig(
          geoAutoUpdate: false,
          geoUpdateInterval: 2562048,
        ),
        overrideDns: false,
        appendSystemDns: false,
        addedRules: [],
        proxyChains: [],
        profileProxies: [],
        customProxyGroups: [],
        customRules: [],
        defaultUA: 'FlClash',
      ),
    );

    expect(result['geo-auto-update'], false);
    expect(result['geo-update-interval'], defaultGeoUpdateInterval);
  });

  test('makeRealProfileTask exposes the mixed proxy in Docker mode', () async {
    final result = await makeRealProfileTask(
      const MakeRealProfileState(
        profilesPath: '/profiles',
        profileId: 1,
        overwriteType: OverwriteType.standard,
        rawConfig: {
          'allow-lan': false,
          'bind-address': '127.0.0.1',
          'rules': <String>[],
        },
        realPatchConfig: ClashConfig(),
        overrideDns: false,
        appendSystemDns: false,
        addedRules: [],
        proxyChains: [],
        profileProxies: [],
        customProxyGroups: [],
        customRules: [],
        defaultUA: 'FlClash',
        dockerMode: true,
      ),
    );

    expect(result['allow-lan'], true);
    expect(result['bind-address'], '*');
  });

  test('makeRealProfileTask preserves native bind address', () async {
    final result = await makeRealProfileTask(
      const MakeRealProfileState(
        profilesPath: '/profiles',
        profileId: 1,
        overwriteType: OverwriteType.standard,
        rawConfig: {'bind-address': '127.0.0.1', 'rules': <String>[]},
        realPatchConfig: ClashConfig(),
        overrideDns: false,
        appendSystemDns: false,
        addedRules: [],
        proxyChains: [],
        profileProxies: [],
        customProxyGroups: [],
        customRules: [],
        defaultUA: 'FlClash',
      ),
    );

    expect(result['allow-lan'], false);
    expect(result['bind-address'], '127.0.0.1');
  });

  test('makeRealProfileTask injects QUIC block rule when enabled', () async {
    final result = await makeRealProfileTask(
      const MakeRealProfileState(
        profilesPath: '/profiles',
        profileId: 1,
        overwriteType: OverwriteType.standard,
        rawConfig: {
          'rules': ['MATCH,DIRECT'],
        },
        realPatchConfig: ClashConfig(),
        overrideDns: false,
        appendSystemDns: false,
        addedRules: [],
        proxyChains: [],
        profileProxies: [],
        customProxyGroups: [],
        customRules: [],
        defaultUA: 'FlClash',
        blockQuic: true,
      ),
    );

    expect(result['rules'], [
      'SNIFF-PROTOCOL,stun,REJECT-DROP',
      'AND,((NETWORK,udp),(DST-PORT,443)),REJECT',
      'MATCH,DIRECT',
    ]);
  });

  test(
    'makeRealProfileTask applies non-empty custom overwrite lists',
    () async {
      final result = await makeRealProfileTask(
        const MakeRealProfileState(
          profilesPath: '/profiles',
          profileId: 1,
          overwriteType: OverwriteType.custom,
          rawConfig: {
            'proxy-groups': [
              {
                'name': 'Original',
                'type': 'select',
                'proxies': ['DIRECT'],
              },
            ],
            'rules': ['MATCH,Original'],
          },
          realPatchConfig: ClashConfig(),
          overrideDns: false,
          appendSystemDns: false,
          addedRules: [],
          proxyChains: [],
          profileProxies: [],
          customProxyGroups: [
            ProxyGroup(
              name: 'Custom',
              type: GroupType.Selector,
              proxies: ['DIRECT'],
            ),
          ],
          customRules: [Rule(id: 1, value: 'MATCH,Custom')],
          defaultUA: 'FlClash',
        ),
      );

      expect(result['proxy-groups'], [
        {
          'name': 'Custom',
          'type': 'select',
          'proxies': ['DIRECT'],
        },
      ]);
      expect(result['rules'], [
        'SNIFF-PROTOCOL,stun,REJECT-DROP',
        'MATCH,Custom',
      ]);
    },
  );

  test(
    'makeRealProfileTask keeps original values for empty custom lists',
    () async {
      final result = await makeRealProfileTask(
        const MakeRealProfileState(
          profilesPath: '/profiles',
          profileId: 1,
          overwriteType: OverwriteType.standard,
          rawConfig: {
            'proxy-groups': [
              {
                'name': 'Original',
                'type': 'select',
                'proxies': ['DIRECT'],
              },
            ],
            'rules': ['MATCH,Original'],
          },
          realPatchConfig: ClashConfig(),
          overrideDns: false,
          appendSystemDns: false,
          addedRules: [],
          proxyChains: [],
          profileProxies: [],
          customProxyGroups: [],
          customRules: [],
          defaultUA: 'FlClash',
        ),
      );

      expect((result['proxy-groups'] as List).first['name'], 'Original');
      expect(result['rules'], [
        'SNIFF-PROTOCOL,stun,REJECT-DROP',
        'MATCH,Original',
      ]);
    },
  );

  test('custom mode can explicitly clear proxy groups and rules', () async {
    final result = await makeRealProfileTask(
      const MakeRealProfileState(
        profilesPath: '/profiles',
        profileId: 1,
        overwriteType: OverwriteType.custom,
        rawConfig: {
          'proxy-groups': [
            {
              'name': 'Original',
              'type': 'select',
              'proxies': ['DIRECT'],
            },
          ],
          'rules': ['MATCH,Original'],
        },
        realPatchConfig: ClashConfig(),
        overrideDns: false,
        appendSystemDns: false,
        addedRules: [],
        proxyChains: [],
        profileProxies: [],
        customProxyGroups: [],
        customRules: [],
        defaultUA: 'FlClash',
      ),
    );

    expect(result['proxy-groups'], isEmpty);
    expect(result['rules'], ['SNIFF-PROTOCOL,stun,REJECT-DROP']);
  });
}

class _FakePathProvider extends PathProviderPlatform {
  final String path;

  _FakePathProvider(this.path);

  @override
  Future<String?> getTemporaryPath() async => path;

  @override
  Future<String?> getApplicationSupportPath() async => path;

  @override
  Future<String?> getApplicationCachePath() async => path;

  @override
  Future<String?> getDownloadsPath() async => path;
}

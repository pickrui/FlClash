import 'dart:io';

import 'package:fl_clash/common/task.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

void main() {
  late Directory root;
  late String profiles;
  late String scripts;
  late String providers;

  setUp(() {
    root = Directory.systemTemp.createTempSync('flclash-profile-cleanup-');
    profiles = p.join(root.path, 'profiles');
    scripts = p.join(root.path, 'scripts');
    providers = p.join(profiles, 'providers');
  });
  tearDown(() => root.deleteSync(recursive: true));

  File write(String directory, String name) {
    final file = File(p.join(directory, name));
    file.parent.createSync(recursive: true);
    file.writeAsStringSync('fixture');
    return file;
  }

  List<String> scan() => collectUnusedProfilePaths(
    profilesPath: profiles,
    scriptsPath: scripts,
    providersPath: providers,
    profileIds: [1],
    scriptIds: [3],
  );

  test('retains both the source and runtime copy of active profiles', () {
    write(profiles, '1.yaml');
    write(profiles, '.1.yaml');
    write(scripts, '3.js');
    write(p.join(providers, '1'), 'proxy.yaml');
    expect(scan(), isEmpty);
  });

  test(
    'collects obsolete profiles, runtime copies, scripts and provider directories',
    () {
      final old = write(profiles, '2.yaml');
      final runtime = write(profiles, '.2.yaml');
      final script = write(scripts, '4.js');
      write(p.join(providers, '2'), 'proxy.yaml');
      expect(
        scan(),
        unorderedEquals([
          old.path,
          runtime.path,
          script.path,
          p.join(providers, '2'),
        ]),
      );
    },
  );

  test('preserves recovery artifacts and unrecognized user files', () {
    write(profiles, '1.yaml.write-backup-fixture');
    write(profiles, 'notes.txt');
    write(profiles, '99999999999999999999999999.yaml');
    write(scripts, '.script-delete-3.js');
    write(scripts, 'custom.js');
    write(p.join(providers, 'custom'), 'rules.yaml');
    expect(scan(), isEmpty);
  });

  test(
    'does not follow file or directory symlinks',
    () {
      final outside = write(root.path, 'outside.yaml');
      Directory(providers).createSync(recursive: true);
      Link(p.join(profiles, '2.yaml')).createSync(outside.path);
      Link(p.join(providers, '2')).createSync(root.path);
      expect(scan(), isEmpty);
      expect(outside.readAsStringSync(), 'fixture');
    },
    skip: Platform.isWindows ? 'creating symlinks requires privileges' : false,
  );

  test('missing directories have nothing to prune', () {
    expect(scan(), isEmpty);
  });
}

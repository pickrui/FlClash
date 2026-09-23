import 'package:fl_clash/common/oix_params_storage.dart';
import 'package:fl_clash/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';

CloudParams _overseas(CloudParams params) =>
    params.copyWith(level: NetworkLevel.overseas);

void main() {
  test('update changes the params a queued write stored', () async {
    SharedPreferences.setMockInitialValues({
      'cloud_service_config_params': '&mode=premium&tfo=false',
    });

    final saved = CloudParamsStorage.save(
      CloudParams.parse('&mode=premium&tfo=true&simplerules=true&area=hk'),
    );
    final updated = await CloudParamsStorage.update(_overseas);
    await saved;

    expect(
      updated,
      CloudParams.parse('&mode=overseas&tfo=true&simplerules=true&area=hk'),
    );
    expect(await CloudParamsStorage.load(), updated);
  });

  test('a write queued behind update is not overwritten by it', () async {
    SharedPreferences.setMockInitialValues({
      'cloud_service_config_params': '&mode=premium&tfo=false',
    });
    final edited = CloudParams.parse('&mode=emergency&tfo=true');

    await Future.wait([
      CloudParamsStorage.update(_overseas),
      CloudParamsStorage.save(edited),
    ]);

    expect(await CloudParamsStorage.load(), edited);
  });

  test('update migrates the legacy tfo flag before the change', () async {
    SharedPreferences.setMockInitialValues({
      'cloud_service_config_params': '&mode=premium',
      'cloud_service_tfo': true,
    });

    final updated = await CloudParamsStorage.update(_overseas);

    expect(updated, CloudParams.parse('&mode=overseas&tfo=true'));
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.containsKey('cloud_service_tfo'), isFalse);
    expect(await CloudParamsStorage.load(), updated);
  });

  test('a failed change leaves the params and the queue usable', () async {
    SharedPreferences.setMockInitialValues({
      'cloud_service_config_params': '&mode=premium&tfo=false',
    });

    await expectLater(
      CloudParamsStorage.update((_) => throw StateError('change failed')),
      throwsStateError,
    );

    expect(
      await CloudParamsStorage.load(),
      CloudParams.parse('&mode=premium&tfo=false'),
    );
  });
}

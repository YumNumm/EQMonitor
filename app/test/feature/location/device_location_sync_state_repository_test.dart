import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:eqmonitor/feature/location/data/model/device_location_payload.dart';
import 'package:eqmonitor/feature/location/data/model/device_location_sync_state_record.dart';
import 'package:eqmonitor/feature/location/data/repository/device_location_sync_state_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
  });

  test('DeviceLocationPayloadは値比較とJSON round-tripに対応する', () {
    const payload = DeviceLocationPayload(
      region: '130',
      city: '13101',
      tsunamiForecastRegion: '100',
    );

    expect(DeviceLocationPayload.fromJson(payload.toJson()), payload);
  });

  test('DeviceLocationSyncStateRecordはscopeとpayloadをJSON復元する', () {
    const record = DeviceLocationSyncStateRecord(
      scope: DeviceLocationSyncScope(
        apiEndpoint: 'https://api.example.com/v2/device/me/location',
      ),
      payload: DeviceLocationPayload(
        region: '130',
        city: '13101',
        tsunamiForecastRegion: '100',
      ),
    );

    expect(DeviceLocationSyncStateRecord.fromJson(record.toJson()), record);
  });

  test('再生成したRepositoryが最後の送信成功payloadを復元する', () async {
    final first = SharedPreferencesDeviceLocationSyncStateRepository(
      SharedPreferencesAsync(),
    );
    await first.writeLastSent(
      scope: productionScope,
      payload: const DeviceLocationPayload(
        region: '301',
        city: '0820100',
        tsunamiForecastRegion: '201',
      ),
    );

    final recreated = SharedPreferencesDeviceLocationSyncStateRepository(
      SharedPreferencesAsync(),
    );

    expect((await recreated.readLastSent(scope: productionScope))?.toJson(), {
      'region': '301',
      'city': '0820100',
      'tsunamiForecastRegion': '201',
    });
  });

  test('registration generationが異なる成功値は送信済みとして復元しない', () async {
    final repository = SharedPreferencesDeviceLocationSyncStateRepository(
      SharedPreferencesAsync(),
    );
    await repository.writeLastSent(
      scope: productionScope,
      payload: const DeviceLocationPayload(
        region: '301',
        city: '0820100',
        tsunamiForecastRegion: '201',
      ),
    );

    expect(
      await repository.readLastSent(
        scope: const DeviceLocationSyncScope(
          apiEndpoint: 'https://api.example.com/v2/device/me/location',
          registrationGeneration: 'registration-2',
        ),
      ),
      isNull,
    );
  });

  test('API endpointが異なる成功値は送信済みとして復元しない', () async {
    final repository = SharedPreferencesDeviceLocationSyncStateRepository(
      SharedPreferencesAsync(),
    );
    await repository.writeLastSent(
      scope: productionScope,
      payload: const DeviceLocationPayload(
        region: '301',
        city: '0820100',
        tsunamiForecastRegion: '201',
      ),
    );

    expect(
      await repository.readLastSent(
        scope: const DeviceLocationSyncScope(
          apiEndpoint: 'https://staging.example.com/v2/device/me/location',
          registrationGeneration: 'registration-1',
        ),
      ),
      isNull,
    );
  });

  test('不正な保存payloadは送信済みとして復元しない', () async {
    final preferences = SharedPreferencesAsync();
    final repository = SharedPreferencesDeviceLocationSyncStateRepository(
      preferences,
    );

    for (final source in [
      '{"region":301}',
      '{"region":"301","city":true}',
      '{"region":"301","tsunamiForecastRegion":201}',
      '{invalid-json',
    ]) {
      await preferences.setString(
        SharedPreferencesKey.backgroundLocationLastSentPayload.key,
        source,
      );
      expect(
        await repository.readLastSent(scope: productionScope),
        isNull,
        reason: source,
      );
    }
  });

  test('現在地スロットの送信可否を再生成後も復元する', () async {
    final first = SharedPreferencesDeviceLocationSyncStateRepository(
      SharedPreferencesAsync(),
    );
    await first.writeAvailability(DeviceLocationSyncAvailability.enabled);

    final recreated = SharedPreferencesDeviceLocationSyncStateRepository(
      SharedPreferencesAsync(),
    );

    expect(
      await recreated.readAvailability(),
      DeviceLocationSyncAvailability.enabled,
    );
  });

  test('送信可否キーがない場合は未初期化として返す', () async {
    final repository = SharedPreferencesDeviceLocationSyncStateRepository(
      SharedPreferencesAsync(),
    );

    expect(
      await repository.readAvailability(),
      DeviceLocationSyncAvailability.uninitialized,
    );
  });

  test('disabledを再生成後も復元する', () async {
    final first = SharedPreferencesDeviceLocationSyncStateRepository(
      SharedPreferencesAsync(),
    );
    await first.writeAvailability(DeviceLocationSyncAvailability.disabled);

    final recreated = SharedPreferencesDeviceLocationSyncStateRepository(
      SharedPreferencesAsync(),
    );

    expect(
      await recreated.readAvailability(),
      DeviceLocationSyncAvailability.disabled,
    );
  });
}

const productionScope = DeviceLocationSyncScope(
  apiEndpoint: 'https://api.example.com/v2/device/me/location',
  registrationGeneration: 'registration-1',
);

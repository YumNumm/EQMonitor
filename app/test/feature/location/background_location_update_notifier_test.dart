// ignore_for_file: unused_element_parameter

import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/provider/device_id.dart';
import 'package:eqmonitor/feature/devices/data/notifier/device_provisioning_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/earthquake_notification_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/eew_notification_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_region.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/shake_detection_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/earthquake_notification_settings_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/eew_settings_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/shake_detection_settings_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/repository/device_notification_settings_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';

// ---------------------------------------------------------------------------
// Fakes
// ---------------------------------------------------------------------------

class _FakeDeviceProvisioningNotifier extends DeviceProvisioningNotifier {
  @override
  Future<DeviceProvisioningStatus> build() async =>
      DeviceProvisioningStatus.notRequired;
}

class _FakeEewSettingsNotifier extends EewSettingsNotifier {
  @override
  Future<EewNotificationSettings> build() async =>
      const EewNotificationSettings(
        enabled: true,
        startLiveActivity: false,
        onePointEnabled: false,
        regions: [],
      );
}

class _FakeEarthquakeNotificationSettingsNotifier
    extends EarthquakeNotificationSettingsNotifier {
  @override
  Future<EarthquakeNotificationSettings> build() async =>
      const EarthquakeNotificationSettings(
        enabled: true,
        estimatedIntensityEnabled: false,
        regions: [],
      );
}

class _FakeRepo implements DeviceNotificationSettingsRepository {
  _FakeRepo({
    this.shakeEntries = const [],
    this.availableSubRegions = const [],
    this.eewSettings = const EewNotificationSettings(
      enabled: true,
      startLiveActivity: false,
      onePointEnabled: false,
      regions: [],
    ),
    this.eewRegions = const [],
    this.earthquakeSettings = const EarthquakeNotificationSettings(
      enabled: true,
      estimatedIntensityEnabled: false,
      regions: [],
    ),
    this.earthquakeRegions = const [],
  });

  List<ShakeDetectionEntry> shakeEntries;
  List<ShakeDetectionSubRegion> availableSubRegions;
  EewNotificationSettings eewSettings;
  List<NotificationRegion> eewRegions;
  EarthquakeNotificationSettings earthquakeSettings;
  List<NotificationRegion> earthquakeRegions;

  // Track PUT calls for assertions
  final putShakeDetectionCalls = <List<ShakeDetectionEntry>>[];
  final putEewRegionsCalls = <List<NotificationRegion>>[];
  final putEarthquakeRegionsCalls = <List<NotificationRegion>>[];

  @override
  Future<Result<List<ShakeDetectionEntry>, Exception>>
  getShakeDetectionSettings(String deviceId) async => Success(shakeEntries);

  @override
  Future<Result<List<ShakeDetectionSubRegion>, Exception>>
  getShakeDetectionSubRegions(String deviceId) async =>
      Success(availableSubRegions);

  @override
  Future<Result<List<ShakeDetectionEntry>, Exception>>
  putShakeDetectionSettings({
    required String deviceId,
    required List<ShakeDetectionEntry> entries,
  }) async {
    putShakeDetectionCalls.add(entries);
    // Mimic server round-trip: preserve id, null subRegionName
    final stored = entries
        .map(
          (e) => ShakeDetectionEntry(
            id: e.id.isEmpty ? 'server-generated-id' : e.id,
            subRegionId: e.subRegionId,
            subRegionName: null,
            minLevel: e.minLevel,
            isCurrentLocation: e.isCurrentLocation,
          ),
        )
        .toList();
    shakeEntries = stored;
    return Success(stored);
  }

  @override
  Future<Result<EewNotificationSettings, Exception>> getEewSettings(
    String deviceId,
  ) async => Success(eewSettings);

  @override
  Future<Result<List<NotificationRegion>, Exception>> getEewRegions(
    String deviceId,
  ) async => Success(eewRegions);

  @override
  Future<Result<List<NotificationRegion>, Exception>> putEewRegions({
    required String deviceId,
    required List<NotificationRegion> regions,
  }) async {
    putEewRegionsCalls.add(regions);
    eewRegions = regions;
    return Success(regions);
  }

  @override
  Future<Result<EarthquakeNotificationSettings, Exception>>
  getEarthquakeSettings(String deviceId) async => Success(earthquakeSettings);

  @override
  Future<Result<List<NotificationRegion>, Exception>> getEarthquakeRegions(
    String deviceId,
  ) async => Success(earthquakeRegions);

  @override
  Future<Result<List<NotificationRegion>, Exception>> putEarthquakeRegions({
    required String deviceId,
    required List<NotificationRegion> regions,
  }) async {
    putEarthquakeRegionsCalls.add(regions);
    earthquakeRegions = regions;
    return Success(regions);
  }

  @override
  Future<Result<EewNotificationSettings, Exception>> patchEewSettings({
    required String deviceId,
    required bool enabled,
    required bool startLiveActivity,
    required bool onePointEnabled,
  }) => throw UnimplementedError();

  @override
  Future<Result<EarthquakeNotificationSettings, Exception>>
  patchEarthquakeSettings({
    required String deviceId,
    required bool enabled,
    required bool estimatedIntensityEnabled,
  }) => throw UnimplementedError();
}

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

ProviderContainer _createContainer(_FakeRepo repo) => ProviderContainer(
  overrides: [
    deviceProvisioningProvider.overrideWith(
      _FakeDeviceProvisioningNotifier.new,
    ),
    deviceIdProvider.overrideWith((ref) async => 'test-device'),
    deviceNotificationSettingsRepositoryProvider.overrideWith(
      (ref) async => repo,
    ),
    // Prevent cross-notifier reads from blowing up during removeEntry etc.
    eewSettingsProvider.overrideWith(_FakeEewSettingsNotifier.new),
    earthquakeNotificationSettingsProvider.overrideWith(
      _FakeEarthquakeNotificationSettingsNotifier.new,
    ),
  ],
);

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  // ==========================================================================
  // ShakeDetectionSettingsNotifier.updateCurrentLocationSubRegion
  // ==========================================================================
  group('ShakeDetectionSettingsNotifier.updateCurrentLocationSubRegion', () {
    test('cityCode に一致する availableSubRegion があれば subRegionId を更新する', () async {
      final repo = _FakeRepo(
        shakeEntries: const [
          ShakeDetectionEntry(
            id: 'entry-1',
            subRegionId: null,
            subRegionName: null,
            minLevel: api.ShakeDetectionLevel.medium,
            isCurrentLocation: true,
          ),
        ],
        availableSubRegions: const [
          ShakeDetectionSubRegion(id: 'sr-1', code: '0720100', name: '福島市'),
          ShakeDetectionSubRegion(id: 'sr-2', code: '0720300', name: 'いわき市'),
        ],
      );
      final container = _createContainer(repo);
      addTeardownToContainer(container);

      // Wait for build to complete
      await container.read(shakeDetectionSettingsProvider.future);

      final result = await container
          .read(shakeDetectionSettingsProvider.notifier)
          .updateCurrentLocationSubRegion('0720100');

      expect(result, isTrue);
      expect(repo.putShakeDetectionCalls, hasLength(1));
      final putEntries = repo.putShakeDetectionCalls.first;
      expect(putEntries.first.subRegionId, 'sr-1');
      expect(putEntries.first.isCurrentLocation, isTrue);
    });

    test('現在地エントリがない場合は更新せず false を返す', () async {
      final repo = _FakeRepo(
        shakeEntries: const [
          ShakeDetectionEntry(
            id: 'entry-1',
            subRegionId: null,
            subRegionName: null,
            minLevel: api.ShakeDetectionLevel.medium,
            isCurrentLocation: false, // ← 現在地ではない
          ),
        ],
        availableSubRegions: const [
          ShakeDetectionSubRegion(id: 'sr-1', code: '0720100', name: '福島市'),
        ],
      );
      final container = _createContainer(repo);
      addTeardownToContainer(container);

      await container.read(shakeDetectionSettingsProvider.future);

      final result = await container
          .read(shakeDetectionSettingsProvider.notifier)
          .updateCurrentLocationSubRegion('0720100');

      expect(result, isFalse);
      expect(repo.putShakeDetectionCalls, isEmpty);
    });

    test('subRegionId が変化しない場合は PUT せず false を返す', () async {
      final repo = _FakeRepo(
        shakeEntries: const [
          ShakeDetectionEntry(
            id: 'entry-1',
            subRegionId: 'sr-1', // ← 既に sr-1
            subRegionName: null,
            minLevel: api.ShakeDetectionLevel.medium,
            isCurrentLocation: true,
          ),
        ],
        availableSubRegions: const [
          ShakeDetectionSubRegion(id: 'sr-1', code: '0720100', name: '福島市'),
        ],
      );
      final container = _createContainer(repo);
      addTeardownToContainer(container);

      await container.read(shakeDetectionSettingsProvider.future);

      final result = await container
          .read(shakeDetectionSettingsProvider.notifier)
          .updateCurrentLocationSubRegion('0720100');

      expect(result, isFalse);
      expect(repo.putShakeDetectionCalls, isEmpty);
    });

    test(
      'cityCode が availableSubRegions に存在しない場合は subRegionId を null にする',
      () async {
        final repo = _FakeRepo(
          shakeEntries: const [
            ShakeDetectionEntry(
              id: 'entry-1',
              subRegionId: 'sr-1',
              subRegionName: null,
              minLevel: api.ShakeDetectionLevel.medium,
              isCurrentLocation: true,
            ),
          ],
          availableSubRegions: const [
            ShakeDetectionSubRegion(id: 'sr-1', code: '0720100', name: '福島市'),
          ],
        );
        final container = _createContainer(repo);
        addTeardownToContainer(container);

        await container.read(shakeDetectionSettingsProvider.future);

        // 存在しない cityCode を渡す
        final result = await container
            .read(shakeDetectionSettingsProvider.notifier)
            .updateCurrentLocationSubRegion('9999999');

        expect(result, isTrue);
        expect(repo.putShakeDetectionCalls, hasLength(1));
        expect(repo.putShakeDetectionCalls.first.first.subRegionId, isNull);
      },
    );

    test('cityCode が null の場合は subRegionId を null にする', () async {
      final repo = _FakeRepo(
        shakeEntries: const [
          ShakeDetectionEntry(
            id: 'entry-1',
            subRegionId: 'sr-1',
            subRegionName: null,
            minLevel: api.ShakeDetectionLevel.medium,
            isCurrentLocation: true,
          ),
        ],
        availableSubRegions: const [
          ShakeDetectionSubRegion(id: 'sr-1', code: '0720100', name: '福島市'),
        ],
      );
      final container = _createContainer(repo);
      addTeardownToContainer(container);

      await container.read(shakeDetectionSettingsProvider.future);

      final result = await container
          .read(shakeDetectionSettingsProvider.notifier)
          .updateCurrentLocationSubRegion(null);

      expect(result, isTrue);
      expect(repo.putShakeDetectionCalls, hasLength(1));
      expect(repo.putShakeDetectionCalls.first.first.subRegionId, isNull);
    });

    test('都市移動: subRegionId が別の sub_region に更新される', () async {
      final repo = _FakeRepo(
        shakeEntries: const [
          ShakeDetectionEntry(
            id: 'entry-1',
            subRegionId: 'sr-1',
            subRegionName: null,
            minLevel: api.ShakeDetectionLevel.medium,
            isCurrentLocation: true,
          ),
        ],
        availableSubRegions: const [
          ShakeDetectionSubRegion(id: 'sr-1', code: '0720100', name: '福島市'),
          ShakeDetectionSubRegion(id: 'sr-2', code: '0720300', name: 'いわき市'),
        ],
      );
      final container = _createContainer(repo);
      addTeardownToContainer(container);

      await container.read(shakeDetectionSettingsProvider.future);

      final result = await container
          .read(shakeDetectionSettingsProvider.notifier)
          .updateCurrentLocationSubRegion('0720300');

      expect(result, isTrue);
      expect(repo.putShakeDetectionCalls, hasLength(1));
      expect(repo.putShakeDetectionCalls.first.first.subRegionId, 'sr-2');
    });

    test('エントリが空の場合は false を返す', () async {
      final repo = _FakeRepo();
      final container = _createContainer(repo);
      addTeardownToContainer(container);

      await container.read(shakeDetectionSettingsProvider.future);

      final result = await container
          .read(shakeDetectionSettingsProvider.notifier)
          .updateCurrentLocationSubRegion('0720100');

      expect(result, isFalse);
      expect(repo.putShakeDetectionCalls, isEmpty);
    });

    test('連続更新: 状態が正しく遷移する', () async {
      final repo = _FakeRepo(
        shakeEntries: const [
          ShakeDetectionEntry(
            id: 'entry-1',
            subRegionId: null,
            subRegionName: null,
            minLevel: api.ShakeDetectionLevel.medium,
            isCurrentLocation: true,
          ),
        ],
        availableSubRegions: const [
          ShakeDetectionSubRegion(id: 'sr-1', code: '0720100', name: '福島市'),
          ShakeDetectionSubRegion(id: 'sr-2', code: '0720300', name: 'いわき市'),
        ],
      );
      final container = _createContainer(repo);
      addTeardownToContainer(container);

      await container.read(shakeDetectionSettingsProvider.future);
      final notifier = container.read(shakeDetectionSettingsProvider.notifier);

      // 1st update: null → sr-1
      expect(await notifier.updateCurrentLocationSubRegion('0720100'), isTrue);
      // 2nd update: same city → no-op
      expect(await notifier.updateCurrentLocationSubRegion('0720100'), isFalse);
      // 3rd update: sr-1 → sr-2
      expect(await notifier.updateCurrentLocationSubRegion('0720300'), isTrue);

      expect(repo.putShakeDetectionCalls, hasLength(2));
    });
  });

  // ==========================================================================
  // EewSettingsNotifier.updateCurrentLocationRegion
  // ==========================================================================
  group('EewSettingsNotifier.updateCurrentLocationRegion', () {
    test('regionCode が変化した場合に更新する', () async {
      final repo = _FakeRepo(
        eewRegions: const [
          NotificationRegion(
            regionId: 9011,
            regionName: '東京都23区',
            isCurrentLocation: true,
            minJmaIntensity: JmaIntensity.four,
          ),
        ],
      );
      final container = ProviderContainer(
        overrides: [
          deviceProvisioningProvider.overrideWith(
            _FakeDeviceProvisioningNotifier.new,
          ),
          deviceIdProvider.overrideWith((ref) async => 'test-device'),
          deviceNotificationSettingsRepositoryProvider.overrideWith(
            (ref) async => repo,
          ),
          shakeDetectionSettingsProvider.overrideWith(
            _FakeShakeDetectionSettingsNotifier.new,
          ),
          earthquakeNotificationSettingsProvider.overrideWith(
            _FakeEarthquakeNotificationSettingsNotifier.new,
          ),
        ],
      );
      addTeardownToContainer(container);

      await container.read(eewSettingsProvider.future);

      final result = await container
          .read(eewSettingsProvider.notifier)
          .updateCurrentLocationRegion(regionCode: 9012, regionName: '多摩東部');

      expect(result, isTrue);
      expect(repo.putEewRegionsCalls, hasLength(1));
      final regions = repo.putEewRegionsCalls.first;
      final currentLoc = regions.where((r) => r.isCurrentLocation).first;
      expect(currentLoc.regionId, 9012);
      expect(currentLoc.regionName, '多摩東部');
    });

    test('regionCode が同一なら PUT せず false を返す', () async {
      final repo = _FakeRepo(
        eewRegions: const [
          NotificationRegion(
            regionId: 9011,
            regionName: '東京都23区',
            isCurrentLocation: true,
            minJmaIntensity: JmaIntensity.four,
          ),
        ],
      );
      final container = ProviderContainer(
        overrides: [
          deviceProvisioningProvider.overrideWith(
            _FakeDeviceProvisioningNotifier.new,
          ),
          deviceIdProvider.overrideWith((ref) async => 'test-device'),
          deviceNotificationSettingsRepositoryProvider.overrideWith(
            (ref) async => repo,
          ),
          shakeDetectionSettingsProvider.overrideWith(
            _FakeShakeDetectionSettingsNotifier.new,
          ),
          earthquakeNotificationSettingsProvider.overrideWith(
            _FakeEarthquakeNotificationSettingsNotifier.new,
          ),
        ],
      );
      addTeardownToContainer(container);

      await container.read(eewSettingsProvider.future);

      final result = await container
          .read(eewSettingsProvider.notifier)
          .updateCurrentLocationRegion(
            regionCode: 9011,
            regionName: '東京都23区',
          );

      expect(result, isFalse);
      expect(repo.putEewRegionsCalls, isEmpty);
    });

    test('現在地エントリがない場合: orElse で合成された regionId と一致するため false', () async {
      final repo = _FakeRepo(
        eewRegions: const [
          NotificationRegion(
            regionId: 9999,
            regionName: '固定地域',
            isCurrentLocation: false, // ← 現在地ではない
            minJmaIntensity: JmaIntensity.four,
          ),
        ],
      );
      final container = ProviderContainer(
        overrides: [
          deviceProvisioningProvider.overrideWith(
            _FakeDeviceProvisioningNotifier.new,
          ),
          deviceIdProvider.overrideWith((ref) async => 'test-device'),
          deviceNotificationSettingsRepositoryProvider.overrideWith(
            (ref) async => repo,
          ),
          shakeDetectionSettingsProvider.overrideWith(
            _FakeShakeDetectionSettingsNotifier.new,
          ),
          earthquakeNotificationSettingsProvider.overrideWith(
            _FakeEarthquakeNotificationSettingsNotifier.new,
          ),
        ],
      );
      addTeardownToContainer(container);

      await container.read(eewSettingsProvider.future);

      // orElse で regionCode=9012 の合成エントリが作られ、
      // 直後に existing.regionId(9012) == regionCode(9012) で false
      final result = await container
          .read(eewSettingsProvider.notifier)
          .updateCurrentLocationRegion(regionCode: 9012);

      expect(result, isFalse);
      expect(repo.putEewRegionsCalls, isEmpty);
    });

    test('固定地域エントリは保持したまま現在地のみ更新する', () async {
      final repo = _FakeRepo(
        eewRegions: const [
          NotificationRegion(
            regionId: 9999,
            regionName: '固定地域',
            isCurrentLocation: false,
            minJmaIntensity: JmaIntensity.three,
          ),
          NotificationRegion(
            regionId: 9011,
            regionName: '東京都23区',
            isCurrentLocation: true,
            minJmaIntensity: JmaIntensity.four,
          ),
        ],
      );
      final container = ProviderContainer(
        overrides: [
          deviceProvisioningProvider.overrideWith(
            _FakeDeviceProvisioningNotifier.new,
          ),
          deviceIdProvider.overrideWith((ref) async => 'test-device'),
          deviceNotificationSettingsRepositoryProvider.overrideWith(
            (ref) async => repo,
          ),
          shakeDetectionSettingsProvider.overrideWith(
            _FakeShakeDetectionSettingsNotifier.new,
          ),
          earthquakeNotificationSettingsProvider.overrideWith(
            _FakeEarthquakeNotificationSettingsNotifier.new,
          ),
        ],
      );
      addTeardownToContainer(container);

      await container.read(eewSettingsProvider.future);

      final result = await container
          .read(eewSettingsProvider.notifier)
          .updateCurrentLocationRegion(regionCode: 9012, regionName: '多摩東部');

      expect(result, isTrue);
      final regions = repo.putEewRegionsCalls.first;
      expect(regions, hasLength(2));
      expect(
        regions.where((r) => !r.isCurrentLocation).first.regionId,
        9999,
      );
      expect(
        regions.where((r) => r.isCurrentLocation).first.regionId,
        9012,
      );
    });
  });

  // ==========================================================================
  // EarthquakeNotificationSettingsNotifier.updateCurrentLocationRegion
  // ==========================================================================
  group(
    'EarthquakeNotificationSettingsNotifier.updateCurrentLocationRegion',
    () {
      test('regionCode と cityCode の両方が変化した場合に更新する', () async {
        final repo = _FakeRepo(
          earthquakeRegions: const [
            NotificationRegion(
              regionId: 250,
              regionName: '福島県中通り',
              cityCode: '0720100',
              cityName: '福島市',
              isCurrentLocation: true,
              minJmaIntensity: JmaIntensity.four,
            ),
          ],
        );
        final container = ProviderContainer(
          overrides: [
            deviceProvisioningProvider.overrideWith(
              _FakeDeviceProvisioningNotifier.new,
            ),
            deviceIdProvider.overrideWith((ref) async => 'test-device'),
            deviceNotificationSettingsRepositoryProvider.overrideWith(
              (ref) async => repo,
            ),
            eewSettingsProvider.overrideWith(_FakeEewSettingsNotifier.new),
            shakeDetectionSettingsProvider.overrideWith(
              _FakeShakeDetectionSettingsNotifier.new,
            ),
          ],
        );
        addTeardownToContainer(container);

        await container.read(earthquakeNotificationSettingsProvider.future);

        final result = await container
            .read(earthquakeNotificationSettingsProvider.notifier)
            .updateCurrentLocationRegion(
              regionCode: 251,
              regionName: '福島県浜通り',
              cityCode: '0720300',
              cityName: 'いわき市',
            );

        expect(result, isTrue);
        expect(repo.putEarthquakeRegionsCalls, hasLength(1));
        final region = repo.putEarthquakeRegionsCalls.first.first;
        expect(region.regionId, 251);
        expect(region.cityCode, '0720300');
      });

      test('cityCode のみ変化した場合でも更新する', () async {
        final repo = _FakeRepo(
          earthquakeRegions: const [
            NotificationRegion(
              regionId: 250,
              regionName: '福島県中通り',
              cityCode: '0720100',
              cityName: '福島市',
              isCurrentLocation: true,
              minJmaIntensity: JmaIntensity.four,
            ),
          ],
        );
        final container = ProviderContainer(
          overrides: [
            deviceProvisioningProvider.overrideWith(
              _FakeDeviceProvisioningNotifier.new,
            ),
            deviceIdProvider.overrideWith((ref) async => 'test-device'),
            deviceNotificationSettingsRepositoryProvider.overrideWith(
              (ref) async => repo,
            ),
            eewSettingsProvider.overrideWith(_FakeEewSettingsNotifier.new),
            shakeDetectionSettingsProvider.overrideWith(
              _FakeShakeDetectionSettingsNotifier.new,
            ),
          ],
        );
        addTeardownToContainer(container);

        await container.read(earthquakeNotificationSettingsProvider.future);

        // regionCode は同じだが cityCode が異なる
        final result = await container
            .read(earthquakeNotificationSettingsProvider.notifier)
            .updateCurrentLocationRegion(
              regionCode: 250,
              regionName: '福島県中通り',
              cityCode: '0720500',
              cityName: '伊達市',
            );

        expect(result, isTrue);
        expect(repo.putEarthquakeRegionsCalls, hasLength(1));
        final region = repo.putEarthquakeRegionsCalls.first.first;
        expect(region.regionId, 250);
        expect(region.cityCode, '0720500');
        expect(region.cityName, '伊達市');
      });

      test('regionCode と cityCode がどちらも同一なら false', () async {
        final repo = _FakeRepo(
          earthquakeRegions: const [
            NotificationRegion(
              regionId: 250,
              regionName: '福島県中通り',
              cityCode: '0720100',
              cityName: '福島市',
              isCurrentLocation: true,
              minJmaIntensity: JmaIntensity.four,
            ),
          ],
        );
        final container = ProviderContainer(
          overrides: [
            deviceProvisioningProvider.overrideWith(
              _FakeDeviceProvisioningNotifier.new,
            ),
            deviceIdProvider.overrideWith((ref) async => 'test-device'),
            deviceNotificationSettingsRepositoryProvider.overrideWith(
              (ref) async => repo,
            ),
            eewSettingsProvider.overrideWith(_FakeEewSettingsNotifier.new),
            shakeDetectionSettingsProvider.overrideWith(
              _FakeShakeDetectionSettingsNotifier.new,
            ),
          ],
        );
        addTeardownToContainer(container);

        await container.read(earthquakeNotificationSettingsProvider.future);

        final result = await container
            .read(earthquakeNotificationSettingsProvider.notifier)
            .updateCurrentLocationRegion(
              regionCode: 250,
              regionName: '福島県中通り',
              cityCode: '0720100',
              cityName: '福島市',
            );

        expect(result, isFalse);
        expect(repo.putEarthquakeRegionsCalls, isEmpty);
      });

      test('現在地エントリがない場合は false を返す', () async {
        final repo = _FakeRepo(
          earthquakeRegions: const [
            NotificationRegion(
              regionId: 250,
              regionName: '福島県中通り',
              isCurrentLocation: false,
              minJmaIntensity: JmaIntensity.four,
            ),
          ],
        );
        final container = ProviderContainer(
          overrides: [
            deviceProvisioningProvider.overrideWith(
              _FakeDeviceProvisioningNotifier.new,
            ),
            deviceIdProvider.overrideWith((ref) async => 'test-device'),
            deviceNotificationSettingsRepositoryProvider.overrideWith(
              (ref) async => repo,
            ),
            eewSettingsProvider.overrideWith(_FakeEewSettingsNotifier.new),
            shakeDetectionSettingsProvider.overrideWith(
              _FakeShakeDetectionSettingsNotifier.new,
            ),
          ],
        );
        addTeardownToContainer(container);

        await container.read(earthquakeNotificationSettingsProvider.future);

        final result = await container
            .read(earthquakeNotificationSettingsProvider.notifier)
            .updateCurrentLocationRegion(
              regionCode: 251,
              regionName: '福島県浜通り',
              cityCode: '0720300',
              cityName: 'いわき市',
            );

        expect(result, isFalse);
        expect(repo.putEarthquakeRegionsCalls, isEmpty);
      });
    },
  );
}

// ---------------------------------------------------------------------------
// Helpers for container lifecycle
// ---------------------------------------------------------------------------

/// Registers container disposal with test teardown.
void addTeardownToContainer(ProviderContainer container) {
  addTearDown(container.dispose);
}

// Fake notifier for shake detection (used as dependency override in
// EEW/earthquake tests)
class _FakeShakeDetectionSettingsNotifier
    extends ShakeDetectionSettingsNotifier {
  @override
  Future<ShakeDetectionState> build() async => (
    entries: <ShakeDetectionEntry>[],
    availableSubRegions: <ShakeDetectionSubRegion>[],
  );
}

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/provider/jma_parameter/jma_parameter.dart';
import 'package:eqmonitor/core/provider/log/talker.dart' as talker_lib;
import 'package:eqmonitor/feature/devices/data/notifier/device_provisioning_notifier.dart';
import 'package:eqmonitor/feature/location/data/background_location_service.dart';
import 'package:eqmonitor/feature/location/data/jma_region_resolver.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_metadata.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_type.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/shake_detection_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/notification_slots_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/shake_detection_settings_notifier.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_level.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jma_map/jma_map.dart';
import 'package:riverpod/riverpod.dart';
import 'package:talker_flutter/talker_flutter.dart';

const EarthquakeRegionResolution _ibarakiSouthResolution = (
  regionCode: 301,
  regionName: '茨城県南部',
  cityCode: '0820100',
  cityName: '水戸市',
);

// ---------------------------------------------------------------------------
// Fakes
// ---------------------------------------------------------------------------

class _FakeDeviceProvisioningNotifier extends DeviceProvisioningNotifier {
  @override
  Future<DeviceProvisioningStatus> build() async =>
      DeviceProvisioningStatus.notRequired;
}

/// `notificationSlotsProvider` を固定スロットで差し替えるための fake。
/// `updateCurrentLocationRegion` は実装をそのまま検証する。
class _FakeNotificationSlotsNotifier extends NotificationSlotsNotifier {
  new(this._slots);

  final List<NotificationSlot> _slots;

  @override
  Future<List<NotificationSlot>> build() async => _slots;
}

final class _FakeShakeDetectionSettingsNotifier
    extends ShakeDetectionSettingsNotifier {
  @override
  Future<ShakeDetectionState> build() async => (
    entries: const <ShakeDetectionEntry>[],
    availableSubRegions: const <ShakeDetectionSubRegion>[],
  );

  @override
  Future<bool> updateCurrentLocationSubRegion(String? cityCode) async => false;
}

final class _FakeJmaRegionResolver extends JmaRegionResolver {
  new({required this.earthquakeResolution})
    : super(
        cityMapData: JmaMap_JmaMapData(),
        tsunamiMapData: JmaMap_JmaMapData(),
        earthquakeParameter: const EarthquakeParameter(
          metadata: ParameterMetadata(
            type: ParameterType.earthquakeStations,
            schemaVersion: 1,
            sourceVersion: 'test',
            sourceUpdatedAt: null,
            sourceUrls: [],
            sha256: '',
          ),
          prefectures: [],
        ),
      );

  final EarthquakeRegionResolution? earthquakeResolution;
  int resolveEarthquakeRegionCalls = 0;

  @override
  String? resolveCityCode(double latitude, double longitude) => '0820100';

  @override
  String? resolveTsunamiForecastRegionCode(
    double latitude,
    double longitude,
  ) => '201';

  @override
  EarthquakeRegionResolution? resolveEarthquakeRegion(
    double latitude,
    double longitude,
  ) {
    resolveEarthquakeRegionCalls += 1;
    return earthquakeResolution;
  }
}

final class _FakeDeviceLocationApiAdapter implements HttpClientAdapter {
  final putDeviceLocationCalls = <api.DeviceLocationRequest>[];
  final putDeviceLocationJsonCalls = <Map<String, dynamic>>[];

  @override
  void close({bool force = false}) {}

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    if (options.path.endsWith('/device/me/location') &&
        options.method == 'PUT') {
      final requestJson = Map<String, dynamic>.from(
        options.data as Map<String, dynamic>,
      );
      putDeviceLocationJsonCalls.add(requestJson);
      final request = api.DeviceLocationRequest.fromJson(requestJson);
      putDeviceLocationCalls.add(request);
      return _jsonResponse(
        jsonEncode({
          'region': request.region,
          'city': request.city,
          'tsunamiForecastRegion': request.tsunamiForecastRegion,
        }),
      );
    }

    throw UnimplementedError('Unhandled: ${options.method} ${options.path}');
  }
}

/// `ShakeDetectionSettingsNotifier` が読む `apiClientProvider` を差し替える
/// HTTP アダプタ。揺れ検知設定の GET / PUT とサブ地域マスター GET を模倣する。
final class _FakeShakeApiAdapter implements HttpClientAdapter {
  new({
    this.shakeEntries = const [],
    this.availableSubRegions = const [],
  });

  List<ShakeDetectionEntry> shakeEntries;
  List<ShakeDetectionSubRegion> availableSubRegions;

  // PUT で送られた揺れ検知設定を記録する。
  final putShakeDetectionCalls = <List<api.ShakeDetectionSettingRequest>>[];

  @override
  void close({bool force = false}) {}

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    final path = options.path;
    final method = options.method;

    if (path.endsWith('/shake-detection/sub-regions') && method == 'GET') {
      return _jsonResponse(
        jsonEncode([for (final s in availableSubRegions) _subRegionJson(s)]),
      );
    }

    if (path.endsWith('/shake-detection') && method == 'GET') {
      return _jsonResponse(
        jsonEncode([
          for (final e in shakeEntries)
            _shakeResponseJson(
              id: e.id,
              subRegionId: e.subRegionId,
              minLevel: e.minLevel.toApiShakeDetectionLevel,
              isCurrentLocation: e.isCurrentLocation,
            ),
        ]),
      );
    }

    if (path.endsWith('/shake-detection') && method == 'PUT') {
      // `options.data` は Dio の transformer を通す前の値で、enum が
      // instance のまま残る。実際に送信される wire JSON へ round-trip して
      // から decode する。
      final list = (jsonDecode(jsonEncode(options.data)) as List)
          .cast<Map<String, dynamic>>();
      final requests = list
          .map(
            (e) => api.ShakeDetectionSettingRequest.fromJson(
              Map<String, Object?>.from(e),
            ),
          )
          .toList();
      putShakeDetectionCalls.add(requests);
      // サーバ往復を模倣して同じ内容を id 付きで返す。
      return _jsonResponse(
        jsonEncode([
          for (final (i, r) in requests.indexed)
            _shakeResponseJson(
              id: 'srv-$i',
              subRegionId: r.subRegionId,
              minLevel: r.minLevel,
              isCurrentLocation: r.isCurrentLocation,
            ),
        ]),
      );
    }

    throw UnimplementedError('Unhandled: $method $path');
  }
}

ResponseBody _jsonResponse(String body, {int statusCode = 200}) =>
    ResponseBody.fromString(
      body,
      statusCode,
      headers: {
        'content-type': ['application/json'],
      },
    );

Map<String, dynamic> _subRegionJson(ShakeDetectionSubRegion s) => {
  'id': s.id,
  'code': s.code,
  'name': s.name,
};

Map<String, dynamic> _shakeResponseJson({
  required String id,
  required String? subRegionId,
  required api.ShakeDetectionLevel minLevel,
  required bool isCurrentLocation,
}) => {
  'id': id,
  'sub_region_id': subRegionId,
  'min_level': minLevel.toJson(),
  'is_current_location': isCurrentLocation,
  'created_at': '2026-06-30T00:00:00Z',
  'updated_at': '2026-06-30T00:00:00Z',
};

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

ProviderContainer _createShakeContainer(_FakeShakeApiAdapter adapter) {
  final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
    ..httpClientAdapter = adapter;
  return ProviderContainer(
    overrides: [
      deviceProvisioningProvider.overrideWith(
        _FakeDeviceProvisioningNotifier.new,
      ),
      apiClientProvider.overrideWith((ref) async => api.ApiClient(dio)),
    ],
  );
}

ProviderContainer _createSlotsContainer(
  List<NotificationSlot> slots, {
  required _FakeDeviceLocationApiAdapter adapter,
}) {
  final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
    ..httpClientAdapter = adapter;
  return ProviderContainer(
    overrides: [
      apiClientProvider.overrideWith((ref) async => api.ApiClient(dio)),
      notificationSlotsProvider.overrideWith(
        () => _FakeNotificationSlotsNotifier(slots),
      ),
    ],
  );
}

ProviderContainer _createLocationSyncContainer({
  required _FakeDeviceLocationApiAdapter adapter,
  required _FakeJmaRegionResolver resolver,
}) {
  final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
    ..httpClientAdapter = adapter;
  return ProviderContainer(
    overrides: [
      apiClientProvider.overrideWith((ref) async => api.ApiClient(dio)),
      notificationSlotsProvider.overrideWith(
        () => _FakeNotificationSlotsNotifier([
          _currentLocationSlot(regionId: 9080),
        ]),
      ),
      jmaRegionResolverProvider.overrideWith(
        (ref) async => resolver,
      ),
      shakeDetectionSettingsProvider.overrideWith(
        _FakeShakeDetectionSettingsNotifier.new,
      ),
    ],
  );
}

final _applyLiveLocationProvider = FutureProvider<void>((ref) async {
  await const BackgroundLocationSyncCoordinator().applyLocation(ref, 36, 140);
});

final _applyPendingLocationProvider = FutureProvider<void>((ref) async {
  await const BackgroundLocationSyncCoordinator().applyPendingLocation(ref);
});

NotificationSlot _currentLocationSlot({required int? regionId}) =>
    NotificationSlot(
      id: 'slot-cl',
      slotType: NotificationSlotType.currentLocation,
      regionId: regionId,
      regionName: '東京地方',
      cityCode: null,
      cityName: null,
      displayOrder: 0,
      eewEnabled: true,
      eewMinIntensity: JmaIntensity.four,
      eewOverrides: null,
      earthquakeEnabled: true,
      earthquakeMinIntensity: JmaIntensity.one,
      earthquakeOverrides: null,
    );

NotificationSlot _regionSlot({required int regionId}) => NotificationSlot(
  id: 'slot-region',
  slotType: NotificationSlotType.region,
  regionId: regionId,
  regionName: '固定地域',
  cityCode: null,
  cityName: null,
  displayOrder: 1,
  eewEnabled: true,
  eewMinIntensity: JmaIntensity.four,
  eewOverrides: null,
  earthquakeEnabled: true,
  earthquakeMinIntensity: JmaIntensity.one,
  earthquakeOverrides: null,
);

/// Registers container disposal with test teardown.
void addTeardownToContainer(ProviderContainer container) {
  addTearDown(container.dispose);
}

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  talker_lib.talker = Talker(
    settings: TalkerSettings(useConsoleLogs: false),
  );

  // ==========================================================================
  // ShakeDetectionSettingsNotifier.updateCurrentLocationSubRegion
  // ==========================================================================
  group('ShakeDetectionSettingsNotifier.updateCurrentLocationSubRegion', () {
    test('cityCode に一致する availableSubRegion があれば subRegionId を更新する', () async {
      final adapter = _FakeShakeApiAdapter(
        shakeEntries: const [
          ShakeDetectionEntry(
            id: 'entry-1',
            subRegionId: null,
            subRegionName: null,
            minLevel: ShakeDetectionLevel.medium,
            isCurrentLocation: true,
          ),
        ],
        availableSubRegions: const [
          ShakeDetectionSubRegion(id: 'sr-1', code: '0720100', name: '福島市'),
          ShakeDetectionSubRegion(id: 'sr-2', code: '0720300', name: 'いわき市'),
        ],
      );
      final container = _createShakeContainer(adapter);
      addTeardownToContainer(container);

      // Wait for build to complete
      await container.read(shakeDetectionSettingsProvider.future);

      final result = await container
          .read(shakeDetectionSettingsProvider.notifier)
          .updateCurrentLocationSubRegion('0720100');

      expect(result, isTrue);
      expect(adapter.putShakeDetectionCalls, hasLength(1));
      final putEntries = adapter.putShakeDetectionCalls.first;
      expect(putEntries.first.subRegionId, 'sr-1');
      expect(putEntries.first.isCurrentLocation, isTrue);
      // wire JSON では `min_level: "Medium"` として送られる。
      expect(putEntries.first.minLevel, api.ShakeDetectionLevel.medium);
    });

    test('現在地エントリがない場合は更新せず false を返す', () async {
      final adapter = _FakeShakeApiAdapter(
        shakeEntries: const [
          ShakeDetectionEntry(
            id: 'entry-1',
            subRegionId: null,
            subRegionName: null,
            minLevel: ShakeDetectionLevel.medium,
            isCurrentLocation: false, // ← 現在地ではない
          ),
        ],
        availableSubRegions: const [
          ShakeDetectionSubRegion(id: 'sr-1', code: '0720100', name: '福島市'),
        ],
      );
      final container = _createShakeContainer(adapter);
      addTeardownToContainer(container);

      await container.read(shakeDetectionSettingsProvider.future);

      final result = await container
          .read(shakeDetectionSettingsProvider.notifier)
          .updateCurrentLocationSubRegion('0720100');

      expect(result, isFalse);
      expect(adapter.putShakeDetectionCalls, isEmpty);
    });

    test('subRegionId が変化しない場合は PUT せず false を返す', () async {
      final adapter = _FakeShakeApiAdapter(
        shakeEntries: const [
          ShakeDetectionEntry(
            id: 'entry-1',
            subRegionId: 'sr-1', // ← 既に sr-1
            subRegionName: null,
            minLevel: ShakeDetectionLevel.medium,
            isCurrentLocation: true,
          ),
        ],
        availableSubRegions: const [
          ShakeDetectionSubRegion(id: 'sr-1', code: '0720100', name: '福島市'),
        ],
      );
      final container = _createShakeContainer(adapter);
      addTeardownToContainer(container);

      await container.read(shakeDetectionSettingsProvider.future);

      final result = await container
          .read(shakeDetectionSettingsProvider.notifier)
          .updateCurrentLocationSubRegion('0720100');

      expect(result, isFalse);
      expect(adapter.putShakeDetectionCalls, isEmpty);
    });

    test(
      'cityCode が availableSubRegions に存在しない場合は subRegionId を null にする',
      () async {
        final adapter = _FakeShakeApiAdapter(
          shakeEntries: const [
            ShakeDetectionEntry(
              id: 'entry-1',
              subRegionId: 'sr-1',
              subRegionName: null,
              minLevel: ShakeDetectionLevel.medium,
              isCurrentLocation: true,
            ),
          ],
          availableSubRegions: const [
            ShakeDetectionSubRegion(id: 'sr-1', code: '0720100', name: '福島市'),
          ],
        );
        final container = _createShakeContainer(adapter);
        addTeardownToContainer(container);

        await container.read(shakeDetectionSettingsProvider.future);

        // 存在しない cityCode を渡す
        final result = await container
            .read(shakeDetectionSettingsProvider.notifier)
            .updateCurrentLocationSubRegion('9999999');

        expect(result, isTrue);
        expect(adapter.putShakeDetectionCalls, hasLength(1));
        expect(adapter.putShakeDetectionCalls.first.first.subRegionId, isNull);
      },
    );

    test('cityCode が null の場合は subRegionId を null にする', () async {
      final adapter = _FakeShakeApiAdapter(
        shakeEntries: const [
          ShakeDetectionEntry(
            id: 'entry-1',
            subRegionId: 'sr-1',
            subRegionName: null,
            minLevel: ShakeDetectionLevel.medium,
            isCurrentLocation: true,
          ),
        ],
        availableSubRegions: const [
          ShakeDetectionSubRegion(id: 'sr-1', code: '0720100', name: '福島市'),
        ],
      );
      final container = _createShakeContainer(adapter);
      addTeardownToContainer(container);

      await container.read(shakeDetectionSettingsProvider.future);

      final result = await container
          .read(shakeDetectionSettingsProvider.notifier)
          .updateCurrentLocationSubRegion(null);

      expect(result, isTrue);
      expect(adapter.putShakeDetectionCalls, hasLength(1));
      expect(adapter.putShakeDetectionCalls.first.first.subRegionId, isNull);
    });

    test('都市移動: subRegionId が別の sub_region に更新される', () async {
      final adapter = _FakeShakeApiAdapter(
        shakeEntries: const [
          ShakeDetectionEntry(
            id: 'entry-1',
            subRegionId: 'sr-1',
            subRegionName: null,
            minLevel: ShakeDetectionLevel.medium,
            isCurrentLocation: true,
          ),
        ],
        availableSubRegions: const [
          ShakeDetectionSubRegion(id: 'sr-1', code: '0720100', name: '福島市'),
          ShakeDetectionSubRegion(id: 'sr-2', code: '0720300', name: 'いわき市'),
        ],
      );
      final container = _createShakeContainer(adapter);
      addTeardownToContainer(container);

      await container.read(shakeDetectionSettingsProvider.future);

      final result = await container
          .read(shakeDetectionSettingsProvider.notifier)
          .updateCurrentLocationSubRegion('0720300');

      expect(result, isTrue);
      expect(adapter.putShakeDetectionCalls, hasLength(1));
      expect(adapter.putShakeDetectionCalls.first.first.subRegionId, 'sr-2');
    });

    test('エントリが空の場合は false を返す', () async {
      final adapter = _FakeShakeApiAdapter();
      final container = _createShakeContainer(adapter);
      addTeardownToContainer(container);

      await container.read(shakeDetectionSettingsProvider.future);

      final result = await container
          .read(shakeDetectionSettingsProvider.notifier)
          .updateCurrentLocationSubRegion('0720100');

      expect(result, isFalse);
      expect(adapter.putShakeDetectionCalls, isEmpty);
    });

    test('連続更新: 状態が正しく遷移する', () async {
      final adapter = _FakeShakeApiAdapter(
        shakeEntries: const [
          ShakeDetectionEntry(
            id: 'entry-1',
            subRegionId: null,
            subRegionName: null,
            minLevel: ShakeDetectionLevel.medium,
            isCurrentLocation: true,
          ),
        ],
        availableSubRegions: const [
          ShakeDetectionSubRegion(id: 'sr-1', code: '0720100', name: '福島市'),
          ShakeDetectionSubRegion(id: 'sr-2', code: '0720300', name: 'いわき市'),
        ],
      );
      final container = _createShakeContainer(adapter);
      addTeardownToContainer(container);

      await container.read(shakeDetectionSettingsProvider.future);
      final notifier = container.read(shakeDetectionSettingsProvider.notifier);

      // 1st update: null → sr-1
      expect(await notifier.updateCurrentLocationSubRegion('0720100'), isTrue);
      // 2nd update: same city → no-op
      expect(await notifier.updateCurrentLocationSubRegion('0720100'), isFalse);
      // 3rd update: sr-1 → sr-2
      expect(await notifier.updateCurrentLocationSubRegion('0720300'), isTrue);

      expect(adapter.putShakeDetectionCalls, hasLength(2));
    });
  });

  // ==========================================================================
  // NotificationSlotsNotifier.updateCurrentLocationRegion
  //
  // 旧 EewSettingsNotifier / EarthquakeNotificationSettingsNotifier の
  // updateCurrentLocationRegion は統合スロットモデルへ移行し、現在地スロットの
  // regionId 変化のみを判定する単一メソッドに置き換えられた。
  // ==========================================================================
  group('NotificationSlotsNotifier.updateCurrentLocationRegion', () {
    test('位置情報APIへ新フィールドだけを送る', () async {
      final adapter = _FakeDeviceLocationApiAdapter();
      final container = _createSlotsContainer([
        _currentLocationSlot(regionId: 9080),
      ], adapter: adapter);
      addTeardownToContainer(container);

      await container.read(notificationSlotsProvider.future);

      await container
          .read(notificationSlotsProvider.notifier)
          .updateCurrentLocationRegion(
            regionCode: 301,
            regionName: '茨城県南部',
            cityCode: '0820100',
            tsunamiForecastRegionCode: '201',
          );

      expect(adapter.putDeviceLocationJsonCalls, [
        {
          'region': '301',
          'city': '0820100',
          'tsunamiForecastRegion': '201',
        },
      ]);
    });

    test('現在地スロットの regionCode が変化した場合に true を返す', () async {
      final adapter = _FakeDeviceLocationApiAdapter();
      final container = _createSlotsContainer([
        _currentLocationSlot(regionId: 300),
      ], adapter: adapter);
      addTeardownToContainer(container);

      await container.read(notificationSlotsProvider.future);

      final result = await container
          .read(notificationSlotsProvider.notifier)
          .updateCurrentLocationRegion(regionCode: 301, regionName: '茨城県南部');

      expect(result, isTrue);
      expect(adapter.putDeviceLocationCalls, hasLength(1));
      expect(adapter.putDeviceLocationCalls.single.region, '301');
    });

    test('茨城県北部ではregion 300を送る', () async {
      final adapter = _FakeDeviceLocationApiAdapter();
      final container = _createSlotsContainer([
        _currentLocationSlot(regionId: 9080),
      ], adapter: adapter);
      addTeardownToContainer(container);

      await container.read(notificationSlotsProvider.future);

      await container
          .read(notificationSlotsProvider.notifier)
          .updateCurrentLocationRegion(regionCode: 300, regionName: '茨城県北部');

      expect(adapter.putDeviceLocationCalls.single.region, '300');
    });

    test('同じ位置情報payloadを連続送信しない', () async {
      final adapter = _FakeDeviceLocationApiAdapter();
      final container = _createSlotsContainer([
        _currentLocationSlot(regionId: 300),
      ], adapter: adapter);
      addTeardownToContainer(container);

      await container.read(notificationSlotsProvider.future);

      final notifier = container.read(notificationSlotsProvider.notifier);
      await notifier.updateCurrentLocationRegion(
        regionCode: 300,
        regionName: '茨城県北部',
        cityCode: '0820100',
        tsunamiForecastRegionCode: '201',
      );
      final result = await notifier.updateCurrentLocationRegion(
        regionCode: 300,
        regionName: '茨城県北部',
        cityCode: '0820100',
        tsunamiForecastRegionCode: '201',
      );

      expect(result, isFalse);
      expect(adapter.putDeviceLocationCalls, hasLength(1));
    });

    test('津波予報区だけが変わった場合も位置情報を再送する', () async {
      final adapter = _FakeDeviceLocationApiAdapter();
      final container = _createSlotsContainer([
        _currentLocationSlot(regionId: 300),
      ], adapter: adapter);
      addTeardownToContainer(container);

      await container.read(notificationSlotsProvider.future);

      final notifier = container.read(notificationSlotsProvider.notifier);
      await notifier.updateCurrentLocationRegion(
        regionCode: 300,
        cityCode: '0820100',
        tsunamiForecastRegionCode: '201',
      );
      final result = await notifier.updateCurrentLocationRegion(
        regionCode: 300,
        cityCode: '0820100',
        tsunamiForecastRegionCode: '202',
      );

      expect(result, isTrue);
      expect(adapter.putDeviceLocationCalls, hasLength(2));
      expect(
        adapter.putDeviceLocationCalls.last.tsunamiForecastRegion,
        '202',
      );
    });

    test('現在地スロットがない場合は false を返す', () async {
      // 地域スロットのみ存在し、現在地スロットは無い。
      final adapter = _FakeDeviceLocationApiAdapter();
      final container = _createSlotsContainer([
        _regionSlot(regionId: 9999),
      ], adapter: adapter);
      addTeardownToContainer(container);

      await container.read(notificationSlotsProvider.future);

      final result = await container
          .read(notificationSlotsProvider.notifier)
          .updateCurrentLocationRegion(regionCode: 9012, regionName: '多摩東部');

      expect(result, isFalse);
      expect(adapter.putDeviceLocationCalls, isEmpty);
    });
  });

  group('BackgroundLocationSyncCoordinator', () {
    test('live位置更新ではAreaForecastLocalEをregionとして送る', () async {
      final adapter = _FakeDeviceLocationApiAdapter();
      final resolver = _FakeJmaRegionResolver(
        earthquakeResolution: _ibarakiSouthResolution,
      );
      final container = _createLocationSyncContainer(
        adapter: adapter,
        resolver: resolver,
      );
      addTeardownToContainer(container);

      await container.read(_applyLiveLocationProvider.future);

      expect(adapter.putDeviceLocationJsonCalls.single, {
        'region': '301',
        'city': '0820100',
        'tsunamiForecastRegion': '201',
      });
    });

    test('pending位置更新ではAreaForecastLocalEをregionとして送る', () async {
      final messenger =
          TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
      const channel = MethodChannel('background_location_tracker/persistence');
      messenger.setMockMethodCallHandler(channel, (call) async {
        expect(call.method, 'consumePending');
        return {'latitude': 36.0, 'longitude': 140.0};
      });
      addTearDown(() => messenger.setMockMethodCallHandler(channel, null));

      final adapter = _FakeDeviceLocationApiAdapter();
      final resolver = _FakeJmaRegionResolver(
        earthquakeResolution: _ibarakiSouthResolution,
      );
      final container = _createLocationSyncContainer(
        adapter: adapter,
        resolver: resolver,
      );
      addTeardownToContainer(container);

      await container.read(_applyPendingLocationProvider.future);

      expect(adapter.putDeviceLocationJsonCalls.single, {
        'region': '301',
        'city': '0820100',
        'tsunamiForecastRegion': '201',
      });
    });

    test('regionを解決できない場合は再試行してAPIを送らない', () async {
      final adapter = _FakeDeviceLocationApiAdapter();
      final resolver = _FakeJmaRegionResolver(earthquakeResolution: null);
      final container = _createLocationSyncContainer(
        adapter: adapter,
        resolver: resolver,
      );
      addTeardownToContainer(container);

      await container.read(_applyLiveLocationProvider.future);

      expect(resolver.resolveEarthquakeRegionCalls, 3);
      expect(adapter.putDeviceLocationJsonCalls, isEmpty);
    });
  });
}

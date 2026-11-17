import 'dart:convert';
import 'dart:typed_data';

import 'package:background_location_tracker/background_location_tracker.dart';
import 'package:dio/dio.dart';
import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/core/data/preferences/secure/secure_storage.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences.dart'
    as data_prefs;
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:eqmonitor/core/model/environment.dart';
import 'package:eqmonitor/core/provider/environment/environment.dart';
import 'package:eqmonitor/core/provider/log/talker.dart' as talker_lib;
import 'package:eqmonitor/feature/devices/data/notifier/device_provisioning_notifier.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_auth_repository.dart';
import 'package:eqmonitor/feature/location/data/background_location_service.dart';
import 'package:eqmonitor/feature/location/data/model/device_location_payload.dart';
import 'package:eqmonitor/feature/location/data/notifier/current_device_location_notifier.dart';
import 'package:eqmonitor/feature/location/data/repository/device_location_sync_state_repository.dart';
import 'package:eqmonitor/feature/settings/features/debug/debug_provider.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/shake_detection_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/shake_detection_settings_notifier.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_level.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'background_location_startup_test.g.dart';

const _startMonitoringChannelName =
    'dev.flutter.pigeon.background_location_tracker.'
    'BackgroundLocationHostApi.startMonitoring';
const _stopMonitoringChannelName =
    'dev.flutter.pigeon.background_location_tracker.'
    'BackgroundLocationHostApi.stopMonitoring';

@Riverpod(keepAlive: true)
Future<void> testStartupEnsureMonitoring(Ref ref) =>
    const BackgroundLocationSyncCoordinator().ensureMonitoring(ref);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  talker_lib.talker = Talker(settings: TalkerSettings(useConsoleLogs: false));

  setUp(() {
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
    SharedPreferences.setMockInitialValues({});
    FlutterSecureStorage.setMockInitialValues({});
  });

  group('揺れ検知通知を利用できる端末の起動', () {
    test('揺れ検知の設定を取得せず、保存した現在地条件で監視を再宣言する', () async {
      final state = _locationState();
      await state.writeShakeCurrentLocationEnabled(isEnabled: true);
      final harness = await _Harness.create(isShakeAvailable: true);

      await harness.launch();

      expect(harness.adapter.shakeRequests, isEmpty);
      expect(harness.monitoringEvents.toSet(), {'start'});
      // 設定を読み込んだときと同じく、現在地を一度だけ同期する。
      expect(harness.location.refreshCount, 1);

      await harness.container.read(shakeDetectionSettingsProvider.future);
      expect(harness.location.refreshCount, 1);
    });

    test('スロットも保存した現在地条件もなければ監視を止める', () async {
      final state = _locationState();
      await state.writeShakeCurrentLocationEnabled(isEnabled: false);
      final harness = await _Harness.create(isShakeAvailable: true);

      await harness.launch();

      expect(harness.adapter.shakeRequests, isEmpty);
      expect(harness.monitoringEvents.toSet(), {'stop'});
      expect(harness.location.refreshCount, 0);
    });

    test('現在地条件の保存値がない端末は、headless と共有する保存値が有効なら監視を維持する', () async {
      final state = _locationState();
      await state.writeAvailability(DeviceLocationSyncAvailability.enabled);
      final harness = await _Harness.create(isShakeAvailable: true);

      await harness.launch();

      expect(harness.adapter.shakeRequests, isEmpty);
      expect(harness.monitoringEvents.toSet(), {'start'});
      expect(
        await state.readAvailability(),
        DeviceLocationSyncAvailability.enabled,
      );
    });

    test('どの保存値もなければ監視を変更しない', () async {
      final harness = await _Harness.create(isShakeAvailable: true);

      await harness.launch();

      expect(harness.adapter.shakeRequests, isEmpty);
      expect(harness.monitoringEvents, isEmpty);
      expect(
        await _locationState().readAvailability(),
        DeviceLocationSyncAvailability.uninitialized,
      );
    });

    test('設定を読み込むと現在地条件を保存し、次回の起動は取得せずに使う', () async {
      final harness = await _Harness.create(
        isShakeAvailable: true,
        serverShake: [
          _shakeResponse(target: 'current_location', enabled: true),
        ],
      );
      await harness.launch();
      expect(harness.adapter.shakeRequests, isEmpty);

      await harness.container.read(shakeDetectionSettingsProvider.future);
      expect(harness.adapter.shakeRequests, ['GET']);
      expect(await _locationState().readShakeCurrentLocationEnabled(), isTrue);

      final next = await _Harness.create(
        isShakeAvailable: true,
        preferences: harness.preferences,
      );
      await next.launch();

      expect(next.adapter.shakeRequests, isEmpty);
      expect(next.monitoringEvents.toSet(), {'start'});
    });
  });

  group('揺れ検知通知を利用できない端末の起動', () {
    test('サーバー側の無効化を確認済みなら取得しない', () async {
      final harness = await _Harness.create(
        isShakeAvailable: false,
        isDisableConfirmed: true,
        serverSlots: [_currentLocationSlotResponse],
      );

      await harness.launch();

      expect(harness.adapter.shakeRequests, isEmpty);
      expect(harness.monitoringEvents, contains('start'));
      expect(harness.monitoringEvents, isNot(contains('stop')));
    });

    test('未確認なら一度だけ確認し、以後の起動では取得しない', () async {
      final harness = await _Harness.create(isShakeAvailable: false);

      await harness.launch();

      expect(harness.adapter.shakeRequests, ['GET']);
      expect(harness.isDisableConfirmed, isTrue);

      final next = await _Harness.create(
        isShakeAvailable: false,
        preferences: harness.preferences,
      );
      await next.launch();

      expect(next.adapter.shakeRequests, isEmpty);
    });

    test('サーバーに有効な条件が残っていれば無効化してから確認済みにする', () async {
      final harness = await _Harness.create(
        isShakeAvailable: false,
        serverShake: [_shakeResponse(target: 'nationwide', enabled: true)],
      );

      await harness.launch();

      expect(harness.adapter.shakeRequests, ['GET', 'PUT']);
      expect(harness.adapter.lastPutEnabled, [false]);
      expect(harness.isDisableConfirmed, isTrue);
    });

    test('確認に失敗したら確認済みにせず、次回の起動でやり直す', () async {
      final harness = await _Harness.create(
        isShakeAvailable: false,
        shakeStatusCode: 500,
      );

      await harness.launch();

      expect(harness.adapter.shakeRequests, ['GET']);
      expect(harness.isDisableConfirmed, isFalse);

      final next = await _Harness.create(
        isShakeAvailable: false,
        preferences: harness.preferences,
      );
      await next.launch();

      expect(next.adapter.shakeRequests, ['GET']);
      expect(next.isDisableConfirmed, isTrue);
    });

    test('保存した現在地条件が有効でも、利用できない端末では監視の理由にしない', () async {
      final state = _locationState();
      await state.writeShakeCurrentLocationEnabled(isEnabled: true);
      final harness = await _Harness.create(
        isShakeAvailable: false,
        isDisableConfirmed: true,
      );

      await harness.launch();

      expect(harness.monitoringEvents, contains('stop'));
      expect(harness.monitoringEvents, isNot(contains('start')));
      expect(await state.readShakeCurrentLocationEnabled(), isFalse);
    });
  });

  group('確認済みの取り消し', () {
    test('通知条件を保存すると取り消す', () async {
      final harness = await _Harness.create(
        isShakeAvailable: true,
        isDisableConfirmed: true,
      );
      await harness.container.read(shakeDetectionSettingsProvider.future);

      await harness.container
          .read(shakeDetectionSettingsProvider.notifier)
          .save(
            const [
              ShakeDetectionEntry(
                id: '',
                targetType: ShakeDetectionTargetType.nationwide,
                regionCode: null,
                enabled: true,
                minLevel: ShakeDetectionLevel.medium,
              ),
            ],
          );

      expect(harness.isDisableConfirmed, isFalse);
    });

    test('有効な条件を読み込むと取り消す', () async {
      final harness = await _Harness.create(
        isShakeAvailable: true,
        isDisableConfirmed: true,
        serverShake: [_shakeResponse(target: 'nationwide', enabled: true)],
      );

      await harness.container.read(shakeDetectionSettingsProvider.future);

      expect(harness.isDisableConfirmed, isFalse);
    });

    test('端末の資格情報を保存・削除すると取り消す', () async {
      final harness = await _Harness.create(
        isShakeAvailable: false,
        isDisableConfirmed: true,
      );
      final auth = await harness.container.read(
        deviceAuthRepositoryProvider.future,
      );

      await auth.saveToken(token: 'new-token');
      expect(harness.isDisableConfirmed, isFalse);

      await harness.preferences.setBool(
        SharedPreferencesKey.shakeDetectionNotificationsDisabledConfirmed.key,
        true,
      );
      await auth.clearToken();
      expect(harness.isDisableConfirmed, isFalse);
    });
  });
}

SharedPreferencesDeviceLocationSyncStateRepository _locationState() =>
    SharedPreferencesDeviceLocationSyncStateRepository(
      SharedPreferencesAsync(),
    );

Map<String, Object?> _shakeResponse({
  required String target,
  required bool enabled,
}) => {
  'id': 'shake-$target',
  'target_type': target,
  'region_code': null,
  'enabled': enabled,
  'min_level': 'Medium',
  'sound': 'default',
  'interruption_level': 'active',
  'created_at': '2026-09-21T00:00:00Z',
  'updated_at': '2026-09-21T00:00:00Z',
};

const Map<String, Object?> _currentLocationSlotResponse = {
  'id': 'slot-cl',
  'slot_type': 'current_location',
  'region_id': null,
  'region_name': null,
  'city_code': null,
  'city_name': null,
  'display_order': 0,
  'eew_enabled': true,
  'eew_min_intensity': '4',
  'eew_overrides': null,
  'earthquake_enabled': true,
  'earthquake_min_intensity': '3',
  'earthquake_overrides': null,
  'created_at': '2026-06-30T00:00:00Z',
  'updated_at': '2026-06-30T00:00:00Z',
};

final class _Harness._({
  required final ProviderContainer container,
  required final _Adapter adapter,
  required final SharedPreferences preferences,
  required final List<String> monitoringEvents,
  required final _RecordingCurrentDeviceLocation location,
}) {
  bool get isDisableConfirmed =>
      preferences.getBool(
        SharedPreferencesKey.shakeDetectionNotificationsDisabledConfirmed.key,
      ) ??
      false;

  Future<void> launch() =>
      container.read(testStartupEnsureMonitoringProvider.future);

  static Future<_Harness> create({
    required bool isShakeAvailable,
    bool isDisableConfirmed = false,
    List<Map<String, Object?>> serverSlots = const [],
    List<Map<String, Object?>> serverShake = const [],
    int shakeStatusCode = 200,
    SharedPreferences? preferences,
  }) async {
    final prefs = preferences ?? await SharedPreferences.getInstance();
    if (isDisableConfirmed) {
      await prefs.setBool(
        SharedPreferencesKey.shakeDetectionNotificationsDisabledConfirmed.key,
        true,
      );
    }
    final adapter = _Adapter(
      slots: serverSlots,
      shake: serverShake,
      shakeStatusCode: shakeStatusCode,
    );
    final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
      ..httpClientAdapter = adapter;
    final monitoringEvents = <String>[];
    final messenger =
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
    const codec = BackgroundLocationHostApi.pigeonChannelCodec;
    messenger
      ..setMockMessageHandler(_startMonitoringChannelName, (_) async {
        monitoringEvents.add('start');
        return codec.encodeMessage([null]);
      })
      ..setMockMessageHandler(_stopMonitoringChannelName, (_) async {
        monitoringEvents.add('stop');
        return codec.encodeMessage([null]);
      });
    addTearDown(() {
      messenger
        ..setMockMessageHandler(_startMonitoringChannelName, null)
        ..setMockMessageHandler(_stopMonitoringChannelName, null);
    });
    final location = _RecordingCurrentDeviceLocation();
    final container = ProviderContainer(
      retry: (_, _) => null,
      overrides: [
        currentDeviceLocationProvider.overrideWith(() => location),
        data_prefs.sharedPreferencesProvider.overrideWithValue(
          AsyncValue.data(prefs),
        ),
        secureStorageProvider.overrideWith(
          (ref) async => const FlutterSecureStorage(),
        ),
        apiClientProvider.overrideWith((ref) async => api.ApiClient(dio)),
        deviceProvisioningProvider.overrideWith(_Provisioned.new),
        debugProvider.overrideWith(_DebugDisabled.new),
        buildConfigProvider.overrideWithValue(
          _buildConfig(isProduction: !isShakeAvailable),
        ),
      ],
    );
    addTearDown(container.dispose);
    return _Harness._(
      container: container,
      adapter: adapter,
      preferences: prefs,
      monitoringEvents: monitoringEvents,
      location: location,
    );
  }
}

class _RecordingCurrentDeviceLocation extends CurrentDeviceLocation {
  var refreshCount = 0;

  @override
  Future<DeviceLocationPayload?> build() async => null;

  @override
  Future<void> refresh() async {
    refreshCount += 1;
  }
}

BuildConfig _buildConfig({required bool isProduction}) => BuildConfig(
  restApiUrl: '',
  appIdSuffix: '',
  appName: 'EQMonitor',
  commitInformation: 'test',
  flavor: isProduction ? Flavor.prod : Flavor.dev,
  wsApiUrl: '',
  googleIosClientId: '',
  googleAndroidClientId: '',
  buildTimestamp: '',
  buildCommitMessage: '',
  revenueCatApiKeyIos: '',
  revenueCatApiKeyAndroid: '',
  isProduction: isProduction,
);

class _Provisioned extends DeviceProvisioningNotifier {
  @override
  Future<DeviceProvisioningStatus> build() async =>
      DeviceProvisioningStatus.notRequired;
}

class _DebugDisabled extends Debug {
  @override
  Future<bool> build() async => false;
}

final class _Adapter({
  required final List<Map<String, Object?>> slots,
  required var List<Map<String, Object?>> shake,
  required final int shakeStatusCode,
}) implements HttpClientAdapter {
  final shakeRequests = <String>[];
  List<bool>? lastPutEnabled;

  @override
  void close({bool force = false}) {}

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    if (options.path.endsWith('/slots') && options.method == 'GET') {
      return _json(jsonEncode(slots));
    }
    if (options.path.endsWith('/shake-detection')) {
      shakeRequests.add(options.method);
      if (shakeStatusCode != 200) {
        return _json('{"error":"failure"}', statusCode: shakeStatusCode);
      }
      if (options.method == 'PUT') {
        final body = (jsonDecode(jsonEncode(options.data)) as List)
            .cast<Map<String, dynamic>>();
        lastPutEnabled = [for (final item in body) item['enabled'] as bool];
        shake = [
          for (final (index, item) in body.indexed)
            {
              ...item,
              'id': 'shake-$index',
              'created_at': '2026-09-21T00:00:00Z',
              'updated_at': '2026-09-21T00:00:00Z',
            },
        ];
      }
      return _json(
        jsonEncode({'settings': shake, 'requires_reconfiguration': false}),
      );
    }
    throw UnimplementedError('Unhandled: ${options.method} ${options.path}');
  }

  ResponseBody _json(String body, {int statusCode = 200}) =>
      ResponseBody.fromString(
        body,
        statusCode,
        headers: {
          Headers.contentTypeHeader: [Headers.jsonContentType],
        },
      );
}

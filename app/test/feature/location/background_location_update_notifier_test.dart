import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:background_location_tracker/background_location_tracker.dart';
import 'package:dio/dio.dart';
import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/provider/jma_parameter/jma_parameter.dart';
import 'package:eqmonitor/core/provider/log/talker.dart' as talker_lib;
import 'package:eqmonitor/feature/devices/data/notifier/device_provisioning_notifier.dart';
import 'package:eqmonitor/feature/location/data/background_location_service.dart';
import 'package:eqmonitor/feature/location/data/jma_region_resolver.dart';
import 'package:eqmonitor/feature/location/data/model/device_location_payload.dart';
import 'package:eqmonitor/feature/location/data/provider/device_location_sync_scope_provider.dart';
import 'package:eqmonitor/feature/location/data/repository/device_location_sync_state_repository.dart';
import 'package:eqmonitor/feature/location/data/repository/device_location_consumers_repository.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_metadata.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_type.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot_draft.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/shake_detection_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/notification_slots_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/shake_detection_settings_notifier.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';
import 'package:jma_map/jma_map.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'background_location_update_notifier_test.g.dart';

const EarthquakeRegionResolution _ibarakiSouthResolution = (
  regionCode: 301,
  regionName: '茨城県南部',
  cityCode: '0820100',
  cityName: '水戸市',
);

const _peekPendingLocationChannelName =
    'dev.flutter.pigeon.background_location_tracker.'
    'BackgroundLocationHostApi.peekPendingLocation';
const _acknowledgePendingLocationChannelName =
    'dev.flutter.pigeon.background_location_tracker.'
    'BackgroundLocationHostApi.acknowledgePendingLocation';
const _startMonitoringChannelName =
    'dev.flutter.pigeon.background_location_tracker.'
    'BackgroundLocationHostApi.startMonitoring';
const _stopMonitoringChannelName =
    'dev.flutter.pigeon.background_location_tracker.'
    'BackgroundLocationHostApi.stopMonitoring';

const _deviceLocationSyncScope = DeviceLocationSyncScope(
  apiEndpoint: 'https://example.com/v2/device/me/location',
);

// ---------------------------------------------------------------------------
// Fakes
// ---------------------------------------------------------------------------

class _FakeDeviceProvisioningNotifier extends DeviceProvisioningNotifier {
  @override
  Future<DeviceProvisioningStatus> build() async =>
      DeviceProvisioningStatus.notRequired;
}

/// `notificationSlotsProvider` を固定スロットで差し替える fake。
class _FakeNotificationSlotsNotifier extends NotificationSlotsNotifier {
  new({required List<NotificationSlot> slots, this.error}) : _slots = slots;

  final List<NotificationSlot> _slots;
  final Exception? error;

  @override
  Future<List<NotificationSlot>> build() async {
    final error = this.error;
    if (error != null) {
      throw error;
    }
    return _slots;
  }
}

final class _FakeShakeDetectionSettingsNotifier
    extends ShakeDetectionSettingsNotifier {
  new([this.events]);

  final List<String>? events;

  @override
  Future<ShakeDetectionState> build() async => (
    entries: const <ShakeDetectionEntry>[],
    requiresReconfiguration: false,
  );
}

final class _RecordingDeviceLocationSyncStateRepository
    extends SharedPreferencesDeviceLocationSyncStateRepository {
  new({
    required this.events,
    this.availability = DeviceLocationSyncAvailability.enabled,
    this.lastSent,
  }) : lastSentScope = lastSent == null ? null : _deviceLocationSyncScope,
       super(SharedPreferencesAsync());

  final List<String> events;
  DeviceLocationSyncAvailability availability;
  DeviceLocationPayload? lastSent;
  DeviceLocationSyncScope? lastSentScope;

  @override
  Future<DeviceLocationSyncAvailability> readAvailability() async {
    events.add('deviceLocation:readAvailability');
    return availability;
  }

  @override
  Future<void> writeAvailability(
    DeviceLocationSyncAvailability availability,
  ) async {
    events.add('deviceLocation:writeAvailability:${availability.name}');
    this.availability = availability;
  }

  @override
  Future<DeviceLocationPayload?> readLastSent({
    required DeviceLocationSyncScope scope,
  }) async {
    events.add('deviceLocation:readLastSent');
    return lastSentScope == scope ? lastSent : null;
  }

  @override
  Future<void> writeLastSent({
    required DeviceLocationSyncScope scope,
    required DeviceLocationPayload payload,
  }) async {
    events.add('deviceLocation:writeLastSent');
    lastSentScope = scope;
    lastSent = payload;
  }
}

final class const _RecordingBackgroundLocationSyncCoordinator(
  final List<String> events,
) extends BackgroundLocationSyncCoordinator {
  @override
  Future<bool> syncCurrentLocationToAppGroup(
    Ref ref, {
    required EarthquakeRegionResolution? resolution,
  }) async {
    events.add('appEffects:appGroup');
    return true;
  }
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
  new({this.events, this.error});

  final List<String>? events;
  final Exception? error;
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
      events?.add('deviceLocation:send');
      final error = this.error;
      if (error != null) {
        throw error;
      }
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

final class _FakeNotificationSlotsApiAdapter implements HttpClientAdapter {
  new({required List<Map<String, Object?>> slots}) : _slots = slots;

  List<Map<String, Object?>> _slots;
  bool failNextMutation = false;

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
    if (path.endsWith('/slots') && method == 'GET') {
      return _jsonResponse(jsonEncode(_slots));
    }
    if (failNextMutation) {
      failNextMutation = false;
      return _jsonResponse('{"error":"failure"}', statusCode: 500);
    }
    if (path.endsWith('/current-location') && method == 'PUT') {
      _slots = [_currentLocationSlotResponse];
      return _jsonResponse(jsonEncode(_currentLocationSlotResponse));
    }
    if (path.endsWith('/current-location') && method == 'DELETE') {
      _slots = const [];
      return _jsonResponse('null', statusCode: 204);
    }
    if (path.endsWith('/slots') && method == 'PUT') {
      _slots = (options.data as List).isEmpty
          ? const []
          : [_currentLocationSlotResponse];
      return _jsonResponse(jsonEncode(_slots));
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

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

ProviderContainer _createLocationSyncContainer({
  required _FakeDeviceLocationApiAdapter adapter,
  required _FakeJmaRegionResolver resolver,
  List<String>? events,
  SharedPreferencesDeviceLocationSyncStateRepository? stateRepository,
  List<NotificationSlot>? slots,
  Exception? notificationSlotsError,
}) {
  final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
    ..httpClientAdapter = adapter;
  return ProviderContainer(
    retry: (retryCount, error) => null,
    overrides: [
      apiClientProvider.overrideWith((ref) async => api.ApiClient(dio)),
      notificationSlotsProvider.overrideWith(
        () => _FakeNotificationSlotsNotifier(
          slots: slots ?? [_currentLocationSlot(regionId: 9080)],
          error: notificationSlotsError,
        ),
      ),
      jmaRegionResolverProvider.overrideWith(
        (ref) async => resolver,
      ),
      deviceLocationSyncStateRepositoryProvider.overrideWithValue(
        stateRepository ??
            _RecordingDeviceLocationSyncStateRepository(
              events: events ?? <String>[],
            ),
      ),
      deviceLocationSyncScopeProvider.overrideWith(
        (ref) async => _deviceLocationSyncScope,
      ),
      shakeDetectionSettingsProvider.overrideWith(
        () => _FakeShakeDetectionSettingsNotifier(events),
      ),
    ],
  );
}

ProviderContainer _createNotificationSlotsSyncContainer(
  _FakeNotificationSlotsApiAdapter adapter,
) {
  final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
    ..httpClientAdapter = adapter;
  final container = ProviderContainer(
    overrides: [
      deviceProvisioningProvider.overrideWith(
        _FakeDeviceProvisioningNotifier.new,
      ),
      apiClientProvider.overrideWith((ref) async => api.ApiClient(dio)),
      shakeDetectionSettingsProvider.overrideWith(
        () => _FakeShakeDetectionSettingsNotifier(),
      ),
    ],
  );
  unawaited(
    container.read(deviceLocationConsumersRepositoryProvider).updateShake((
      entries: [],
      requiresReconfiguration: false,
    )),
  );
  return container;
}

@Riverpod(keepAlive: true)
Future<void> testApplyLiveLocation(Ref ref) async {
  await const BackgroundLocationSyncCoordinator().applyPendingMessage(
    ref,
    pending: PendingLocationMessage(
      updateId: 'live-id',
      latitude: 36,
      longitude: 140,
      accuracy: 10,
      timestampMillis: 1000,
    ),
  );
}

@Riverpod(keepAlive: true)
Future<void> testApplyPendingLocation(Ref ref) async {
  await const BackgroundLocationSyncCoordinator().applyPendingLocation(ref);
}

@Riverpod(keepAlive: true)
Future<void> testEnsureMonitoring(Ref ref) async {
  await const BackgroundLocationSyncCoordinator().ensureMonitoring(ref);
}

@Riverpod(keepAlive: true)
Future<void> testApplyPendingLocationWithCoordinator(
  Ref ref,
  BackgroundLocationSyncCoordinator coordinator,
) async {
  await coordinator.applyPendingLocation(ref);
}

@Riverpod(keepAlive: true)
Future<void> testApplyPendingMessage(
  Ref ref,
  PendingLocationMessage pending,
) async {
  await const BackgroundLocationSyncCoordinator().applyPendingMessage(
    ref,
    pending: pending,
  );
}

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

/// Registers container disposal with test teardown.
void addTeardownToContainer(ProviderContainer container) {
  addTearDown(container.dispose);
}

void recordPendingLocationAcknowledgements(List<String> events) {
  final messenger =
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
  messenger.setMockMessageHandler(_acknowledgePendingLocationChannelName, (
    message,
  ) async {
    final arguments =
        BackgroundLocationHostApi.pigeonChannelCodec.decodeMessage(message)
            as List<Object?>;
    final consumer = arguments[1] as PendingLocationConsumer;
    events.add('ack:${consumer.name}');
    return BackgroundLocationHostApi.pigeonChannelCodec.encodeMessage([true]);
  });
  addTearDown(
    () => messenger.setMockMessageHandler(
      _acknowledgePendingLocationChannelName,
      null,
    ),
  );
}

void recordMonitoringCalls(List<String> events) {
  final messenger =
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
  messenger.setMockMessageHandler(_startMonitoringChannelName, (_) async {
    events.add('start');
    return BackgroundLocationHostApi.pigeonChannelCodec.encodeMessage([null]);
  });
  messenger.setMockMessageHandler(_stopMonitoringChannelName, (_) async {
    events.add('stop');
    return BackgroundLocationHostApi.pigeonChannelCodec.encodeMessage([null]);
  });
  addTearDown(() {
    messenger.setMockMessageHandler(_startMonitoringChannelName, null);
    messenger.setMockMessageHandler(_stopMonitoringChannelName, null);
  });
}

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  talker_lib.talker = Talker(
    settings: TalkerSettings(useConsoleLogs: false),
  );

  setUp(() {
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
  });

  group('NotificationSlotsNotifier device location sync state', () {
    test('GET成功後に現在地スロット有無を保存する', () async {
      final adapter = _FakeNotificationSlotsApiAdapter(
        slots: [_currentLocationSlotResponse],
      );
      final container = _createNotificationSlotsSyncContainer(adapter);
      addTeardownToContainer(container);

      await container.read(notificationSlotsProvider.future);

      final state = SharedPreferencesDeviceLocationSyncStateRepository(
        SharedPreferencesAsync(),
      );
      expect(
        await state.readAvailability(),
        DeviceLocationSyncAvailability.enabled,
      );

      final withoutCurrentLocation = _createNotificationSlotsSyncContainer(
        _FakeNotificationSlotsApiAdapter(slots: const []),
      );
      addTeardownToContainer(withoutCurrentLocation);
      await withoutCurrentLocation.read(notificationSlotsProvider.future);
      expect(
        await state.readAvailability(),
        DeviceLocationSyncAvailability.disabled,
      );
    });

    test('作成・削除成功後に現在地スロット有無を保存する', () async {
      final monitoringEvents = <String>[];
      recordMonitoringCalls(monitoringEvents);
      final adapter = _FakeNotificationSlotsApiAdapter(slots: const []);
      final container = _createNotificationSlotsSyncContainer(adapter);
      addTeardownToContainer(container);
      final notifier = container.read(notificationSlotsProvider.notifier);
      await container.read(notificationSlotsProvider.future);
      final state = SharedPreferencesDeviceLocationSyncStateRepository(
        SharedPreferencesAsync(),
      );

      await notifier.putCurrentLocation();
      expect(
        await state.readAvailability(),
        DeviceLocationSyncAvailability.enabled,
      );

      await notifier.deleteCurrentLocation();
      expect(
        await state.readAvailability(),
        DeviceLocationSyncAvailability.disabled,
      );
      expect(monitoringEvents, ['stop', 'start', 'start', 'stop']);
    });

    test('一括置換成功後に現在地スロット有無を保存する', () async {
      final monitoringEvents = <String>[];
      recordMonitoringCalls(monitoringEvents);
      final adapter = _FakeNotificationSlotsApiAdapter(slots: const []);
      final container = _createNotificationSlotsSyncContainer(adapter);
      addTeardownToContainer(container);
      final notifier = container.read(notificationSlotsProvider.notifier);
      await container.read(notificationSlotsProvider.future);
      final state = SharedPreferencesDeviceLocationSyncStateRepository(
        SharedPreferencesAsync(),
      );

      await notifier.replaceSlots(const [
        NotificationSlotDraft(
          slotType: NotificationSlotType.currentLocation,
          eewEnabled: true,
          earthquakeEnabled: true,
        ),
      ]);
      expect(
        await state.readAvailability(),
        DeviceLocationSyncAvailability.enabled,
      );

      await notifier.replaceSlots(const []);
      expect(
        await state.readAvailability(),
        DeviceLocationSyncAvailability.disabled,
      );
      expect(monitoringEvents, ['stop', 'start', 'stop']);
    });

    test('API失敗時は現在地スロット有無を先行変更しない', () async {
      final adapter = _FakeNotificationSlotsApiAdapter(slots: const []);
      final container = _createNotificationSlotsSyncContainer(adapter);
      addTeardownToContainer(container);
      await container.read(notificationSlotsProvider.future);
      adapter.failNextMutation = true;

      await expectLater(
        container.read(notificationSlotsProvider.notifier).putCurrentLocation(),
        throwsA(isA<DioException>()),
      );

      final state = SharedPreferencesDeviceLocationSyncStateRepository(
        SharedPreferencesAsync(),
      );
      expect(
        await state.readAvailability(),
        DeviceLocationSyncAvailability.disabled,
      );
    });
  });

  test('起動時に両consumerがなければ残存するOS監視を停止する', () async {
    final monitoringEvents = <String>[];
    recordMonitoringCalls(monitoringEvents);
    final container = _createLocationSyncContainer(
      adapter: _FakeDeviceLocationApiAdapter(),
      resolver: _FakeJmaRegionResolver(earthquakeResolution: null),
      slots: const [],
    );
    addTeardownToContainer(container);

    await container.read(testEnsureMonitoringProvider.future);

    expect(monitoringEvents, ['stop']);
  });

  // ==========================================================================
  // ShakeDetectionSettingsNotifier.updateCurrentLocationSubRegion
  // ==========================================================================
  group('BackgroundLocationSyncCoordinator', () {
    test('通常Engineのlive位置更新ではDevice Location APIを送信しない', () async {
      final adapter = _FakeDeviceLocationApiAdapter();
      final resolver = _FakeJmaRegionResolver(
        earthquakeResolution: _ibarakiSouthResolution,
      );
      final container = _createLocationSyncContainer(
        adapter: adapter,
        resolver: resolver,
      );
      addTeardownToContainer(container);

      await container.read(testApplyLiveLocationProvider.future);

      expect(adapter.putDeviceLocationJsonCalls, isEmpty);
    });

    test('pending位置はappEffectsだけを処理してacknowledgeする', () async {
      final messenger =
          TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
      final events = <String>[];
      final peekedConsumers = <PendingLocationConsumer>[];
      messenger.setMockMessageHandler(_peekPendingLocationChannelName, (
        message,
      ) async {
        final arguments =
            BackgroundLocationHostApi.pigeonChannelCodec.decodeMessage(message)
                as List<Object?>;
        peekedConsumers.add(arguments.single as PendingLocationConsumer);
        return BackgroundLocationHostApi.pigeonChannelCodec.encodeMessage([
          PendingLocationMessage(
            updateId: 'pending-id',
            latitude: 36,
            longitude: 140,
            accuracy: 10,
            timestampMillis: 1000,
          ),
        ]);
      });
      final acknowledgements = <(String, PendingLocationConsumer)>[];
      messenger.setMockMessageHandler(_acknowledgePendingLocationChannelName, (
        message,
      ) async {
        final arguments =
            BackgroundLocationHostApi.pigeonChannelCodec.decodeMessage(message)
                as List<Object?>;
        final acknowledgement = (
          arguments[0] as String,
          arguments[1] as PendingLocationConsumer,
        );
        acknowledgements.add(acknowledgement);
        events.add('ack:${acknowledgement.$2.name}');
        return BackgroundLocationHostApi.pigeonChannelCodec.encodeMessage([
          true,
        ]);
      });
      addTearDown(() {
        messenger.setMockMessageHandler(_peekPendingLocationChannelName, null);
        messenger.setMockMessageHandler(
          _acknowledgePendingLocationChannelName,
          null,
        );
      });

      final adapter = _FakeDeviceLocationApiAdapter(events: events);
      final resolver = _FakeJmaRegionResolver(
        earthquakeResolution: _ibarakiSouthResolution,
      );
      final stateRepository = _RecordingDeviceLocationSyncStateRepository(
        events: events,
      );
      final container = _createLocationSyncContainer(
        adapter: adapter,
        resolver: resolver,
        events: events,
        stateRepository: stateRepository,
      );
      addTeardownToContainer(container);

      await container.read(
        testApplyPendingLocationWithCoordinatorProvider(
          _RecordingBackgroundLocationSyncCoordinator(events),
        ).future,
      );

      expect(adapter.putDeviceLocationJsonCalls, isEmpty);
      expect(peekedConsumers, [PendingLocationConsumer.appEffects]);
      expect(acknowledgements, [
        ('pending-id', PendingLocationConsumer.appEffects),
      ]);
      expect(events, [
        'appEffects:appGroup',
        'ack:appEffects',
      ]);
    });

    test('Device Location API例外時はappEffectsだけをacknowledgeする', () async {
      final messenger =
          TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
      final events = <String>[];
      messenger.setMockMessageHandler(_acknowledgePendingLocationChannelName, (
        message,
      ) async {
        final arguments =
            BackgroundLocationHostApi.pigeonChannelCodec.decodeMessage(message)
                as List<Object?>;
        final consumer = arguments[1] as PendingLocationConsumer;
        events.add('ack:${consumer.name}');
        return BackgroundLocationHostApi.pigeonChannelCodec.encodeMessage([
          true,
        ]);
      });
      addTearDown(
        () => messenger.setMockMessageHandler(
          _acknowledgePendingLocationChannelName,
          null,
        ),
      );

      final adapter = _FakeDeviceLocationApiAdapter(
        events: events,
        error: Exception('api failure'),
      );
      final resolver = _FakeJmaRegionResolver(
        earthquakeResolution: _ibarakiSouthResolution,
      );
      final container = _createLocationSyncContainer(
        adapter: adapter,
        resolver: resolver,
        events: events,
        stateRepository: _RecordingDeviceLocationSyncStateRepository(
          events: events,
        ),
      );
      addTeardownToContainer(container);

      await container.read(
        testApplyPendingMessageProvider(
          PendingLocationMessage(
            updateId: 'retry-id',
            latitude: 36,
            longitude: 140,
            accuracy: 10,
            timestampMillis: 1000,
          ),
        ).future,
      );

      expect(events, isNot(contains('appEffects:shake')));
      expect(events, contains('ack:appEffects'));
      expect(events, isNot(contains('ack:deviceLocation')));
      expect(events, isNot(contains('deviceLocation:writeLastSent')));
    });

    test('通常Engineは未初期化の送信状態を変更しない', () async {
      final events = <String>[];
      recordPendingLocationAcknowledgements(events);
      final state = SharedPreferencesDeviceLocationSyncStateRepository(
        SharedPreferencesAsync(),
      );
      final adapter = _FakeDeviceLocationApiAdapter(events: events);
      final container = _createLocationSyncContainer(
        adapter: adapter,
        resolver: _FakeJmaRegionResolver(
          earthquakeResolution: _ibarakiSouthResolution,
        ),
        events: events,
        stateRepository: state,
      );
      addTeardownToContainer(container);

      await container.read(
        testApplyPendingMessageProvider(
          PendingLocationMessage(
            updateId: 'initialize-enabled-id',
            latitude: 36,
            longitude: 140,
            accuracy: 10,
            timestampMillis: 1000,
          ),
        ).future,
      );

      expect(adapter.putDeviceLocationCalls, isEmpty);
      expect(
        await state.readAvailability(),
        DeviceLocationSyncAvailability.uninitialized,
      );
      expect(events, contains('ack:appEffects'));
      expect(events, isNot(contains('ack:deviceLocation')));
    });

    test('現在地スロットがなくても通常EngineはappEffectsだけをacknowledgeする', () async {
      final events = <String>[];
      recordPendingLocationAcknowledgements(events);
      final state = SharedPreferencesDeviceLocationSyncStateRepository(
        SharedPreferencesAsync(),
      );
      final adapter = _FakeDeviceLocationApiAdapter(events: events);
      final container = _createLocationSyncContainer(
        adapter: adapter,
        resolver: _FakeJmaRegionResolver(
          earthquakeResolution: _ibarakiSouthResolution,
        ),
        events: events,
        stateRepository: state,
        slots: const [],
      );
      addTeardownToContainer(container);

      await container.read(
        testApplyPendingMessageProvider(
          PendingLocationMessage(
            updateId: 'initialize-disabled-id',
            latitude: 36,
            longitude: 140,
            accuracy: 10,
            timestampMillis: 1000,
          ),
        ).future,
      );

      expect(adapter.putDeviceLocationCalls, isEmpty);
      expect(
        await state.readAvailability(),
        DeviceLocationSyncAvailability.uninitialized,
      );
      expect(events, contains('ack:appEffects'));
      expect(events, isNot(contains('ack:deviceLocation')));
    });

    test('未初期化でスロット取得に失敗したらappEffectsだけをacknowledgeする', () async {
      final events = <String>[];
      recordPendingLocationAcknowledgements(events);
      final state = SharedPreferencesDeviceLocationSyncStateRepository(
        SharedPreferencesAsync(),
      );
      final adapter = _FakeDeviceLocationApiAdapter(events: events);
      final container = _createLocationSyncContainer(
        adapter: adapter,
        resolver: _FakeJmaRegionResolver(
          earthquakeResolution: _ibarakiSouthResolution,
        ),
        events: events,
        stateRepository: state,
        notificationSlotsError: Exception('slots failure'),
      );
      addTeardownToContainer(container);

      await container.read(
        testApplyPendingMessageProvider(
          PendingLocationMessage(
            updateId: 'initialize-failure-id',
            latitude: 36,
            longitude: 140,
            accuracy: 10,
            timestampMillis: 1000,
          ),
        ).future,
      );

      expect(adapter.putDeviceLocationCalls, isEmpty);
      expect(
        await state.readAvailability(),
        DeviceLocationSyncAvailability.uninitialized,
      );
      expect(events, contains('ack:appEffects'));
      expect(events, isNot(contains('ack:deviceLocation')));
    });

    for (final testCase in [
      (
        name: 'unchanged',
        availability: DeviceLocationSyncAvailability.enabled,
        lastSent: const DeviceLocationPayload(
          region: '301',
          city: '0820100',
          tsunamiForecastRegion: '201',
        ),
      ),
      (
        name: 'disabled',
        availability: DeviceLocationSyncAvailability.disabled,
        lastSent: null,
      ),
    ]) {
      test('${testCase.name}でも通常EngineはappEffectsだけをacknowledgeする', () async {
        final messenger =
            TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
        final events = <String>[];
        messenger.setMockMessageHandler(
          _acknowledgePendingLocationChannelName,
          (message) async {
            final arguments =
                BackgroundLocationHostApi.pigeonChannelCodec.decodeMessage(
                  message,
                ) as List<Object?>;
            final consumer = arguments[1] as PendingLocationConsumer;
            events.add('ack:${consumer.name}');
            return BackgroundLocationHostApi.pigeonChannelCodec.encodeMessage([
              true,
            ]);
          },
        );
        addTearDown(
          () => messenger.setMockMessageHandler(
            _acknowledgePendingLocationChannelName,
            null,
          ),
        );

        final adapter = _FakeDeviceLocationApiAdapter(events: events);
        final container = _createLocationSyncContainer(
          adapter: adapter,
          resolver: _FakeJmaRegionResolver(
            earthquakeResolution: _ibarakiSouthResolution,
          ),
          events: events,
          stateRepository: _RecordingDeviceLocationSyncStateRepository(
            events: events,
            availability: testCase.availability,
            lastSent: testCase.lastSent,
          ),
        );
        addTeardownToContainer(container);

        await container.read(
          testApplyPendingMessageProvider(
            PendingLocationMessage(
              updateId: '${testCase.name}-id',
              latitude: 36,
              longitude: 140,
              accuracy: 10,
              timestampMillis: 1000,
            ),
          ).future,
        );

        expect(adapter.putDeviceLocationCalls, isEmpty);
        expect(events, isNot(contains('ack:deviceLocation')));
        expect(events, contains('ack:appEffects'));
        expect(events, isNot(contains('deviceLocation:writeLastSent')));
      });
    }

    test('pending位置を反映できない場合はacknowledgeしない', () async {
      final messenger =
          TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
      messenger.setMockMessageHandler(_peekPendingLocationChannelName, (
        message,
      ) async {
        return BackgroundLocationHostApi.pigeonChannelCodec.encodeMessage([
          PendingLocationMessage(
            updateId: 'retry-id',
            latitude: 36,
            longitude: 140,
            accuracy: 10,
            timestampMillis: 1000,
          ),
        ]);
      });
      var acknowledgeCalls = 0;
      messenger.setMockMessageHandler(_acknowledgePendingLocationChannelName, (
        message,
      ) async {
        acknowledgeCalls += 1;
        return BackgroundLocationHostApi.pigeonChannelCodec.encodeMessage([
          true,
        ]);
      });
      addTearDown(() {
        messenger.setMockMessageHandler(_peekPendingLocationChannelName, null);
        messenger.setMockMessageHandler(
          _acknowledgePendingLocationChannelName,
          null,
        );
      });
      final adapter = _FakeDeviceLocationApiAdapter();
      final resolver = _FakeJmaRegionResolver(earthquakeResolution: null);
      final container = _createLocationSyncContainer(
        adapter: adapter,
        resolver: resolver,
      );
      addTeardownToContainer(container);

      await container.read(testApplyPendingLocationProvider.future);

      expect(acknowledgeCalls, 0);
      expect(resolver.resolveEarthquakeRegionCalls, 3);
      expect(adapter.putDeviceLocationJsonCalls, isEmpty);
    });

    test('regionを解決できない場合は再試行してAPIを送らない', () async {
      final adapter = _FakeDeviceLocationApiAdapter();
      final resolver = _FakeJmaRegionResolver(earthquakeResolution: null);
      final container = _createLocationSyncContainer(
        adapter: adapter,
        resolver: resolver,
      );
      addTeardownToContainer(container);

      await container.read(testApplyLiveLocationProvider.future);

      expect(resolver.resolveEarthquakeRegionCalls, 3);
      expect(adapter.putDeviceLocationJsonCalls, isEmpty);
    });
  });
}

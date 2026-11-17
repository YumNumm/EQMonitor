import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:eqmonitor/core/data/preferences/secure/secure_storage.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences.dart'
    as data_prefs;
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/provider/log/talker.dart' as talker_lib;
import 'package:eqmonitor/feature/devices/data/notifier/device_provisioning_notifier.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_auth_repository.dart';
import 'package:eqmonitor/feature/location/data/background_location_monitoring_lifecycle.dart';
import 'package:eqmonitor/feature/location/data/repository/device_location_consumers_repository.dart';
import 'package:eqmonitor/feature/location/data/repository/device_location_sync_state_repository.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_override.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot_draft.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/stored_notification_slots.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/notification_slots_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/repository/notification_slot_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:talker_flutter/talker_flutter.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  talker_lib.talker = Talker(settings: TalkerSettings(useConsoleLogs: false));

  setUp(() {
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
  });

  test('保存値がなければサーバーの応答を待ち、結果を保存する', () async {
    final harness = await _Harness.create(server: [_nationwide]);

    expect(await harness.read(), [_nationwide]);
    expect(harness.repository.getSlotsCount, 1);
    expect(harness.storedSlots, [_nationwide]);
  });

  test('保存値があればサーバーの応答を待たずに返し、裏の確認で差分を反映する', () async {
    final pending = Completer<List<NotificationSlot>>();
    final harness = await _Harness.create(
      stored: [_nationwide],
      pendingServer: pending,
    );
    final states = harness.listen();

    expect(await harness.read(), [_nationwide]);
    await harness.settle();
    expect(harness.repository.getSlotsCount, 1);
    expect(pending.isCompleted, isFalse);
    expect(
      harness.container.read(notificationSlotsProvider).isLoading,
      isFalse,
    );
    expect(states, [
      [_nationwide],
    ]);
    expect(harness.monitoringEvents, ['stop']);

    pending.complete([_nationwide, _currentLocation]);
    await harness.settle();

    expect(states.last, [_nationwide, _currentLocation]);
    expect(harness.storedSlots, [_nationwide, _currentLocation]);
    expect(harness.monitoringEvents, ['stop', 'start']);
    expect(harness.repository.getSlotsCount, 1);
  });

  test('前回値に現在地スロットがあれば、サーバーの応答前に位置情報の監視を再宣言する', () async {
    final harness = await _Harness.create(
      stored: [_currentLocation],
      pendingServer: Completer<List<NotificationSlot>>(),
    );

    await harness.read();

    expect(harness.monitoringEvents, ['start']);
    expect(
      await harness.locationState.readAvailability(),
      DeviceLocationSyncAvailability.enabled,
    );
  });

  test('サーバーの値が前回値と同じなら状態を作り直さない', () async {
    final harness = await _Harness.create(
      stored: [_nationwide],
      server: [_nationwide],
    );
    final states = harness.listen();

    final first = await harness.read();
    await harness.settle();

    expect(harness.repository.getSlotsCount, 1);
    expect(states, hasLength(1));
    expect(
      identical(harness.container.read(notificationSlotsProvider).value, first),
      isTrue,
    );
  });

  test('裏の確認に失敗しても前回値のまま進める', () async {
    final harness = await _Harness.create(
      stored: [_nationwide],
      serverError: DioException(requestOptions: RequestOptions()),
    );

    expect(await harness.read(), [_nationwide]);
    await harness.settle();

    final state = harness.container.read(notificationSlotsProvider);
    expect(state.hasError, isFalse);
    expect(state.value, [_nationwide]);
    expect(await harness.read(), [_nationwide]);
    expect(harness.storedSlots, [_nationwide]);
  });

  test('保存値を読めなければサーバーからの取得へ縮退する', () async {
    final harness = await _Harness.create(
      rawStored: '{"slots":[{"id":1}]}',
      server: [_nationwide],
    );

    expect(await harness.read(), [_nationwide]);
    expect(harness.storedSlots, [_nationwide]);
  });

  test('明示的な再読み込みでは前回値を返さずサーバーの応答を待つ', () async {
    final harness = await _Harness.create(
      stored: [_nationwide],
      server: [_nationwide],
    );
    await harness.read();
    await harness.settle();
    harness.repository.server = [_nationwide, _region];

    harness.container.invalidate(notificationSlotsProvider);

    expect(await harness.read(), [_nationwide, _region]);
    expect(harness.repository.getSlotsCount, 2);
    expect(harness.storedSlots, [_nationwide, _region]);
  });

  group('変更時', () {
    test('書き込みの応答で保存値を更新する', () async {
      final harness = await _Harness.create(server: [_nationwide, _region]);
      await harness.read();
      harness.repository.serverError = StateError('refetch failed');

      await harness.container
          .read(notificationSlotsProvider.notifier)
          .updateRegion(slotId: _region.id, eewEnabled: false);

      expect(harness.storedSlots, [
        _nationwide,
        _region.copyWith(eewEnabled: false),
      ]);
    });

    test('全件置換の応答で保存値を更新する', () async {
      final harness = await _Harness.create(server: [_nationwide]);
      await harness.read();
      harness.repository.serverError = StateError('refetch failed');

      await harness.container
          .read(notificationSlotsProvider.notifier)
          .replaceSlots(const [
            NotificationSlotDraft(
              slotType: NotificationSlotType.currentLocation,
              eewEnabled: true,
              earthquakeEnabled: true,
            ),
          ]);

      expect(harness.storedSlots, [_currentLocation]);
    });

    test('変更後の一覧が確定しない操作では保存値を消し、再取得の結果を保存する', () async {
      final harness = await _Harness.create(server: [_nationwide]);
      await harness.read();
      harness.repository.serverError = StateError('refetch failed');

      await harness.container
          .read(notificationSlotsProvider.notifier)
          .removeRegion(slotId: _region.id);
      expect(harness.storedSlots, isNull);

      harness.repository
        ..serverError = null
        ..server = [_nationwide, _region];
      harness.container.invalidate(notificationSlotsProvider);
      expect(await harness.read(), [_nationwide, _region]);
      expect(harness.storedSlots, [_nationwide, _region]);
    });

    test('裏の確認中に変更したら、変更前の応答で上書きしない', () async {
      final pending = Completer<List<NotificationSlot>>();
      final harness = await _Harness.create(
        stored: [_nationwide, _region],
        pendingServer: pending,
      );
      harness.listen();
      await harness.read();
      harness.repository
        ..pendingServer = null
        ..server = [_nationwide, _region.copyWith(eewEnabled: false)];

      await harness.container
          .read(notificationSlotsProvider.notifier)
          .updateRegion(slotId: _region.id, eewEnabled: false);
      pending.complete([_nationwide, _region]);
      await harness.settle();

      final expected = [_nationwide, _region.copyWith(eewEnabled: false)];
      expect(await harness.read(), expected);
      expect(harness.storedSlots, expected);
    });
  });

  test('端末の資格情報を保存・削除すると保存値を消す', () async {
    final harness = await _Harness.create(stored: [_nationwide]);
    final auth = await harness.container.read(
      deviceAuthRepositoryProvider.future,
    );

    await auth.saveToken(token: 'new-token');
    expect(harness.storedSlots, isNull);

    await harness.preferences.setString(
      SharedPreferencesKey.notificationSlotsCache.key,
      jsonEncode(const StoredNotificationSlots(slots: [_nationwide]).toJson()),
    );
    await auth.clearToken();
    expect(harness.storedSlots, isNull);
  });

  test('保存形式は通知スロットの全項目を往復できる', () {
    const slots = [_nationwide, _currentLocation, _region];

    final decoded = StoredNotificationSlots.fromJson(
      jsonDecode(
        jsonEncode(const StoredNotificationSlots(slots: slots).toJson()),
      ) as Map<String, dynamic>,
    );

    expect(decoded.slots, slots);
  });
}

const _nationwide = NotificationSlot(
  id: 'nationwide',
  slotType: NotificationSlotType.nationwide,
  regionId: null,
  regionName: null,
  cityCode: null,
  cityName: null,
  displayOrder: 0,
  eewEnabled: true,
  eewMinIntensity: JmaIntensity.fiveLower,
  eewOverrides: [
    NotificationOverride(
      minJmaIntensity: JmaIntensity.sixLower,
      sound: 'default',
      interruptionLevel: InterruptionLevel.critical,
    ),
  ],
  earthquakeEnabled: false,
  earthquakeMinIntensity: null,
  earthquakeOverrides: null,
);

const _currentLocation = NotificationSlot(
  id: 'current-location',
  slotType: NotificationSlotType.currentLocation,
  regionId: 350,
  regionName: '東京都２３区',
  cityCode: '1310100',
  cityName: '千代田区',
  displayOrder: 1,
  eewEnabled: true,
  eewMinIntensity: JmaIntensity.four,
  eewOverrides: null,
  earthquakeEnabled: true,
  earthquakeMinIntensity: JmaIntensity.one,
  earthquakeOverrides: [],
);

const _region = NotificationSlot(
  id: 'region',
  slotType: NotificationSlotType.region,
  regionId: 360,
  regionName: '神奈川県東部',
  cityCode: null,
  cityName: null,
  displayOrder: 2,
  eewEnabled: true,
  eewMinIntensity: JmaIntensity.three,
  eewOverrides: null,
  earthquakeEnabled: true,
  earthquakeMinIntensity: JmaIntensity.three,
  earthquakeOverrides: null,
);

final class _Harness {
  new _({
    required this.container,
    required this.repository,
    required this.preferences,
    required this.locationState,
    required this.monitoringEvents,
  });

  final ProviderContainer container;
  final _Repository repository;
  final SharedPreferences preferences;
  final InMemoryDeviceLocationSyncStateRepository locationState;
  final List<String> monitoringEvents;

  Future<List<NotificationSlot>> read() =>
      container.read(notificationSlotsProvider.future);

  List<List<NotificationSlot>> listen() {
    final states = <List<NotificationSlot>>[];
    final subscription = container.listen(notificationSlotsProvider, (_, next) {
      if (next case AsyncData(:final value)) {
        states.add(value);
      }
    });
    addTearDown(subscription.close);
    return states;
  }

  Future<void> settle() async {
    for (var i = 0; i < 20; i++) {
      await Future<void>.delayed(Duration.zero);
    }
  }

  List<NotificationSlot>? get storedSlots {
    final source = preferences.getString(
      SharedPreferencesKey.notificationSlotsCache.key,
    );
    return source == null
        ? null
        : StoredNotificationSlots.fromJson(
            jsonDecode(source) as Map<String, dynamic>,
          ).slots;
  }

  static Future<_Harness> create({
    List<NotificationSlot>? stored,
    String? rawStored,
    List<NotificationSlot> server = const [],
    Completer<List<NotificationSlot>>? pendingServer,
    Object? serverError,
  }) async {
    SharedPreferences.setMockInitialValues({
      SharedPreferencesKey.notificationSlotsCache.key: ?(stored == null
          ? rawStored
          : jsonEncode(StoredNotificationSlots(slots: stored).toJson())),
    });
    FlutterSecureStorage.setMockInitialValues({});
    final preferences = await SharedPreferences.getInstance();
    final repository = _Repository(
      server: server,
      pendingServer: pendingServer,
      serverError: serverError,
    );
    final monitoringEvents = <String>[];
    // 揺れ検知の現在地条件は「なし」と確定させ、スロットだけで監視の要否が決まるようにする。
    final locationState = InMemoryDeviceLocationSyncStateRepository(
      availability: DeviceLocationSyncAvailability.uninitialized,
    );
    final consumers = DeviceLocationConsumersRepository(
      locationState,
      lifecycle: BackgroundLocationMonitoringLifecycle(
        startMonitoring: () async => monitoringEvents.add('start'),
        stopMonitoring: () async => monitoringEvents.add('stop'),
      ),
    );
    await consumers.updateShake((entries: [], requiresReconfiguration: false));
    final container = ProviderContainer(
      retry: (_, _) => null,
      overrides: [
        data_prefs.sharedPreferencesProvider.overrideWithValue(
          AsyncValue.data(preferences),
        ),
        secureStorageProvider.overrideWith(
          (ref) async => const FlutterSecureStorage(),
        ),
        deviceProvisioningProvider.overrideWith(_Provisioned.new),
        notificationSlotRepositoryProvider.overrideWith(
          (ref) async => repository,
        ),
        deviceLocationConsumersRepositoryProvider.overrideWithValue(consumers),
      ],
    );
    addTearDown(container.dispose);
    return _Harness._(
      container: container,
      repository: repository,
      preferences: preferences,
      locationState: locationState,
      monitoringEvents: monitoringEvents,
    );
  }
}

class _Provisioned extends DeviceProvisioningNotifier {
  @override
  Future<DeviceProvisioningStatus> build() async =>
      DeviceProvisioningStatus.notRequired;
}

class _Repository extends NotificationSlotRepository {
  new({required this.server, this.pendingServer, this.serverError})
    : super(api: api.ApiClient(Dio()));

  List<NotificationSlot> server;
  Completer<List<NotificationSlot>>? pendingServer;
  Object? serverError;
  var getSlotsCount = 0;

  @override
  Future<List<NotificationSlot>> getSlots() async {
    getSlotsCount += 1;
    final pending = pendingServer;
    if (pending != null) {
      return pending.future;
    }
    final error = serverError;
    if (error != null) {
      throw error;
    }
    return server;
  }

  @override
  Future<NotificationSlot> updateRegion({
    required String slotId,
    String? regionName,
    String? cityCode,
    String? cityName,
    bool? eewEnabled,
    JmaIntensity? eewMinIntensity,
    List<NotificationOverride>? eewOverrides,
    bool? earthquakeEnabled,
    JmaIntensity? earthquakeMinIntensity,
    List<NotificationOverride>? earthquakeOverrides,
  }) async => _region.copyWith(eewEnabled: eewEnabled ?? _region.eewEnabled);

  @override
  Future<List<NotificationSlot>> replaceSlots(
    List<NotificationSlotDraft> slots,
  ) async => [_currentLocation];

  @override
  Future<void> removeRegion({required String slotId}) async {}
}

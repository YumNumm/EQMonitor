import 'package:eqmonitor/feature/location/data/background_location_permission_provider.dart';
import 'package:eqmonitor/feature/location/data/logic/device_location_sync_service.dart';
import 'package:eqmonitor/feature/location/data/model/device_location_payload.dart';
import 'package:eqmonitor/feature/location/data/notifier/current_device_location_notifier.dart';
import 'package:eqmonitor/feature/location/data/provider/device_location_sync_scope_provider.dart';
import 'package:eqmonitor/feature/location/data/repository/device_location_consumers_repository.dart';
import 'package:eqmonitor/feature/location/data/repository/device_location_sync_state_repository.dart';
import 'package:eqmonitor/feature/location/data/repository/foreground_device_location_repository.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/shake_detection_settings.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_level.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final scope = DeviceLocationSyncScope.fromApiBaseUrl(
    apiBaseUrl: 'https://example.test',
  );
  final position = Position(
    longitude: 139.7,
    latitude: 35.7,
    timestamp: DateTime.utc(2026, 9, 21),
    accuracy: 10,
    altitude: 0,
    altitudeAccuracy: 0,
    heading: 0,
    headingAccuracy: 0,
    speed: 0,
    speedAccuracy: 0,
  );
  const payload = DeviceLocationPayload(region: '350');

  test('granting permission after enabling restarts monitoring and syncs the first location', () async {
    var permission = LocationPermission.denied;
    var positionReads = 0;
    var starts = 0;
    final sent = <DeviceLocationPayload>[];
    final storage = InMemoryDeviceLocationSyncStateRepository();
    final repository = ForegroundDeviceLocationRepository(
      getPermission: () async => permission,
      getPosition: () async {
        positionReads++;
        return position;
      },
      createSyncService: () async => DeviceLocationSyncService(
        scope: scope,
        stateRepository: storage,
        resolvePayload: ({required latitude, required longitude}) async =>
            payload,
        sendPayload: ({required payload}) async {
          sent.add(payload);
        },
      ),
      readLastSent: () => storage.readLastSent(scope: scope),
    );
    const channel =
        'dev.flutter.pigeon.background_location_tracker.BackgroundLocationHostApi.startMonitoring';
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMessageHandler(
          channel,
          (message) async {
            starts++;
            return const StandardMessageCodec().encodeMessage([null]);
          },
        );
    addTearDown(
      () => TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMessageHandler(channel, null),
    );
    final container = ProviderContainer.test(
      overrides: [
        deviceLocationSyncScopeProvider.overrideWith((ref) async => scope),
        deviceLocationSyncStateRepositoryProvider.overrideWithValue(storage),
        foregroundDeviceLocationRepositoryProvider.overrideWithValue(
          repository,
        ),
        backgroundLocationPermissionProvider.overrideWith(
          (ref) async => permission,
        ),
      ],
    );
    final consumers = container.read(deviceLocationConsumersRepositoryProvider);
    await container.read(backgroundLocationPermissionProvider.future);
    await consumers.updateShake((
      entries: [
        const ShakeDetectionEntry(
          id: 'current',
          targetType: ShakeDetectionTargetType.currentLocation,
          regionCode: null,
          enabled: true,
          minLevel: ShakeDetectionLevel.medium,
        ),
      ],
      requiresReconfiguration: false,
    ));
    expect(positionReads, 0);
    expect(sent, isEmpty);
    expect(starts, 1);
    // The permission action and returning from OS settings both invalidate this provider.
    permission = LocationPermission.always;
    container.invalidate(backgroundLocationPermissionProvider);
    await container.read(backgroundLocationPermissionProvider.future);
    await container.pump();
    await consumers.reconcile();
    expect(starts, greaterThan(1));
    expect(positionReads, 1);
    expect(sent, [payload]);
    expect(await container.read(currentDeviceLocationProvider.future), payload);
    await container.read(currentDeviceLocationProvider.notifier).refresh();
    expect(sent, [
      payload,
    ], reason: 'identical regions use shared sync deduplication');
  });

  test('failed initial location sync does not persist a fabricated successful region', () async {
    final storage = InMemoryDeviceLocationSyncStateRepository();
    final repository = ForegroundDeviceLocationRepository(
      getPermission: () async => LocationPermission.always,
      getPosition: () async => position,
      createSyncService: () async => DeviceLocationSyncService(
        scope: scope,
        stateRepository: storage,
        resolvePayload: ({required latitude, required longitude}) async =>
            payload,
        sendPayload: ({required payload}) async => throw StateError('offline'),
      ),
      readLastSent: () => storage.readLastSent(scope: scope),
    );
    final container = ProviderContainer.test(
      overrides: [
        deviceLocationSyncScopeProvider.overrideWith((ref) async => scope),
        foregroundDeviceLocationRepositoryProvider.overrideWithValue(
          repository,
        ),
      ],
    );
    expect(await container.read(currentDeviceLocationProvider.future), isNull);
    await container.read(currentDeviceLocationProvider.notifier).refresh();
    expect(container.read(currentDeviceLocationProvider).hasError, isTrue);
    expect(await storage.readLastSent(scope: scope), isNull);
  });
}

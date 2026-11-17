import 'package:eqmonitor/feature/location/data/background_location_monitoring_lifecycle.dart';
import 'package:eqmonitor/feature/location/data/repository/device_location_consumers_repository.dart';
import 'package:eqmonitor/feature/location/data/repository/device_location_sync_state_repository.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/shake_detection_settings.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_level.dart';
import 'package:flutter_test/flutter_test.dart';

const current = ShakeDetectionEntry(
  id: 'current',
  targetType: ShakeDetectionTargetType.currentLocation,
  regionCode: null,
  enabled: true,
  minLevel: ShakeDetectionLevel.medium,
);

void main() {
  for (final shakeFirst in [true, false]) {
    test(
      'shake-only current location stays enabled in either load order ($shakeFirst)',
      () async {
        final storage = InMemoryDeviceLocationSyncStateRepository(
          availability: DeviceLocationSyncAvailability.disabled,
        );
        final events = <String>[];
        final repository = DeviceLocationConsumersRepository(
          storage,
          lifecycle: BackgroundLocationMonitoringLifecycle(
            startMonitoring: () async {
              events.add('start');
            },
            stopMonitoring: () async {
              events.add('stop');
            },
          ),
        );
        const shake = (entries: [current], requiresReconfiguration: false);
        if (shakeFirst) {
          await repository.updateShake(shake);
          await repository.updateSlots([]);
        } else {
          await repository.updateSlots([]);
          await repository.updateShake(shake);
        }
        expect(
          await storage.readAvailability(),
          DeviceLocationSyncAvailability.enabled,
        );
        expect(events, isNot(contains('stop')));
        // A normal notification refresh must not overwrite the shake consumer.
        await repository.updateSlots([]);
        expect(
          await storage.readAvailability(),
          DeviceLocationSyncAvailability.enabled,
        );
        await repository.updateShake((
          entries: [current.copyWith(enabled: false)],
          requiresReconfiguration: false,
        ));
        expect(
          await storage.readAvailability(),
          DeviceLocationSyncAvailability.disabled,
        );
        expect(events.last, 'stop');
      },
    );
  }

  test(
    'an unknown consumer never disables the persisted headless state',
    () async {
      final storage = InMemoryDeviceLocationSyncStateRepository();
      final repository = DeviceLocationConsumersRepository(storage);
      await repository.updateSlots([]);
      expect(
        await storage.readAvailability(),
        DeviceLocationSyncAvailability.enabled,
      );
    },
  );

  test(
    'a stored shake condition keeps monitoring before settings are loaded',
    () async {
      final storage = InMemoryDeviceLocationSyncStateRepository(
        isShakeCurrentLocationEnabled: true,
      );
      final events = <String>[];
      final repository = DeviceLocationConsumersRepository(
        storage,
        lifecycle: BackgroundLocationMonitoringLifecycle(
          startMonitoring: () async => events.add('start'),
          stopMonitoring: () async => events.add('stop'),
        ),
      );

      await repository.updateSlots([]);

      expect(
        await storage.readAvailability(),
        DeviceLocationSyncAvailability.enabled,
      );
      expect(events, ['start']);
    },
  );

  test(
    'a stored disabled shake condition lets slot removal stop monitoring',
    () async {
      final storage = InMemoryDeviceLocationSyncStateRepository(
        isShakeCurrentLocationEnabled: false,
      );
      final events = <String>[];
      final repository = DeviceLocationConsumersRepository(
        storage,
        lifecycle: BackgroundLocationMonitoringLifecycle(
          startMonitoring: () async => events.add('start'),
          stopMonitoring: () async => events.add('stop'),
        ),
      );

      await repository.updateSlots([]);

      expect(
        await storage.readAvailability(),
        DeviceLocationSyncAvailability.disabled,
      );
      expect(events, ['stop']);
    },
  );

  test(
    'restoring a stored shake condition syncs the location once per launch',
    () async {
      final storage = InMemoryDeviceLocationSyncStateRepository(
        isShakeCurrentLocationEnabled: true,
      );
      final events = <String>[];
      final repository = DeviceLocationConsumersRepository(
        storage,
        lifecycle: BackgroundLocationMonitoringLifecycle(
          startMonitoring: () async => events.add('start'),
          stopMonitoring: () async => events.add('stop'),
        ),
        syncLocation: () async => events.add('sync'),
      );

      await repository.restoreStoredShake();
      expect(events, ['start', 'sync']);

      await repository.restoreStoredShake();
      await repository.updateShake((
        entries: [current],
        requiresReconfiguration: false,
      ));
      expect(events.where((event) => event == 'sync'), hasLength(1));
    },
  );

  test(
    'restoring does nothing without a stored shake condition',
    () async {
      final storage = InMemoryDeviceLocationSyncStateRepository(
        availability: DeviceLocationSyncAvailability.uninitialized,
      );
      final events = <String>[];
      final repository = DeviceLocationConsumersRepository(
        storage,
        lifecycle: BackgroundLocationMonitoringLifecycle(
          startMonitoring: () async => events.add('start'),
          stopMonitoring: () async => events.add('stop'),
        ),
        syncLocation: () async => events.add('sync'),
      );

      await repository.restoreStoredShake();
      await repository.updateSlots([]);

      expect(events, isEmpty);
      expect(
        await storage.readAvailability(),
        DeviceLocationSyncAvailability.uninitialized,
      );
    },
  );

  test('shake conditions are stored for the next launch', () async {
    final storage = InMemoryDeviceLocationSyncStateRepository();
    final repository = DeviceLocationConsumersRepository(
      storage,
      lifecycle: BackgroundLocationMonitoringLifecycle(
        startMonitoring: () async {},
        stopMonitoring: () async {},
      ),
    );

    await repository.updateShake((
      entries: [current],
      requiresReconfiguration: false,
    ));
    expect(storage.isShakeCurrentLocationEnabled, isTrue);

    await repository.updateShake((
      entries: [current.copyWith(enabled: false)],
      requiresReconfiguration: false,
    ));
    expect(storage.isShakeCurrentLocationEnabled, isFalse);

    await repository.updateShake((
      entries: [current],
      requiresReconfiguration: false,
    ));
    await repository.reset();
    expect(storage.isShakeCurrentLocationEnabled, isFalse);
  });

  test(
    'nationwide and manual regions do not require location monitoring',
    () async {
      final storage = InMemoryDeviceLocationSyncStateRepository();
      var stopped = false;
      final repository = DeviceLocationConsumersRepository(
        storage,
        lifecycle: BackgroundLocationMonitoringLifecycle(
          startMonitoring: () async => fail('must not start'),
          stopMonitoring: () async {
            stopped = true;
          },
        ),
      );
      await repository.updateSlots([]);
      await repository.updateShake((
        entries: [
          current.copyWith(targetType: ShakeDetectionTargetType.nationwide),
          current.copyWith(
            targetType: ShakeDetectionTargetType.region,
            regionCode: '350',
          ),
        ],
        requiresReconfiguration: false,
      ));
      expect(
        await storage.readAvailability(),
        DeviceLocationSyncAvailability.disabled,
      );
      expect(stopped, isTrue);
    },
  );

  test(
    'concurrent consumer changes leave the newest aggregate persisted',
    () async {
      final storage = InMemoryDeviceLocationSyncStateRepository();
      final repository = DeviceLocationConsumersRepository(
        storage,
        lifecycle: BackgroundLocationMonitoringLifecycle(
          startMonitoring: () async {},
          stopMonitoring: () async {},
        ),
      );
      await Future.wait([
        repository.updateSlots([]),
        repository.updateShake((
          entries: [current],
          requiresReconfiguration: false,
        )),
        repository.updateShake((entries: [], requiresReconfiguration: false)),
      ]);
      expect(
        await storage.readAvailability(),
        DeviceLocationSyncAvailability.disabled,
      );
      await repository.updateShake((
        entries: [current],
        requiresReconfiguration: false,
      ));
      await repository.reset();
      expect(
        await storage.readAvailability(),
        DeviceLocationSyncAvailability.disabled,
      );
    },
  );
}

import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/location/data/background_location_monitoring_lifecycle.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/shake_detection_settings.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('BackgroundLocationUpdateRetry retries transient failures', () async {
    const retry = BackgroundLocationUpdateRetry(baseDelay: Duration.zero);
    var attempts = 0;

    final result = await retry.run(
      action: () async {
        attempts += 1;
        if (attempts < 3) {
          throw Exception('transient');
        }
        return 'ok';
      },
    );

    expect(result, 'ok');
    expect(attempts, 3);
  });

  test('BackgroundLocationUpdateRetry rethrows final failure', () async {
    const retry = BackgroundLocationUpdateRetry(baseDelay: Duration.zero);
    var attempts = 0;

    await expectLater(
      retry.run(
        action: () async {
          attempts += 1;
          throw Exception('persistent');
        },
      ),
      throwsException,
    );
    expect(attempts, 3);
  });

  test('BackgroundLocationMonitoringPolicy monitors slot current location', () {
    const policy = BackgroundLocationMonitoringPolicy();
    const models = _TestModels();

    final shouldMonitor = policy.shouldMonitor(
      slots: [models.currentLocationSlot()],
      shakeDetectionState: models.shakeDetectionState(
        hasCurrentLocation: false,
      ),
    );

    expect(shouldMonitor, isTrue);
  });

  test(
    'BackgroundLocationMonitoringPolicy monitors shake current location',
    () {
      const policy = BackgroundLocationMonitoringPolicy();
      const models = _TestModels();

      final shouldMonitor = policy.shouldMonitor(
        slots: [],
        shakeDetectionState: models.shakeDetectionState(
          hasCurrentLocation: true,
        ),
      );

      expect(shouldMonitor, isTrue);
    },
  );

  test('BackgroundLocationMonitoringPolicy skips without current location', () {
    const policy = BackgroundLocationMonitoringPolicy();
    const models = _TestModels();

    final shouldMonitor = policy.shouldMonitor(
      slots: [models.regionSlot()],
      shakeDetectionState: models.shakeDetectionState(
        hasCurrentLocation: false,
      ),
    );

    expect(shouldMonitor, isFalse);
  });

  test('BackgroundLocationMonitoringPolicy stops without current location', () {
    const policy = BackgroundLocationMonitoringPolicy();
    const models = _TestModels();

    final shouldStop = policy.shouldStop(
      slots: [models.regionSlot()],
      shakeDetectionState: models.shakeDetectionState(
        hasCurrentLocation: false,
      ),
    );

    expect(shouldStop, isTrue);
  });

  test('BackgroundLocationMonitoringPolicy keeps monitoring when unknown', () {
    const policy = BackgroundLocationMonitoringPolicy();
    const models = _TestModels();

    final shouldStop = policy.shouldStop(
      slots: [models.regionSlot()],
      shakeDetectionState: null,
    );

    expect(shouldStop, isFalse);
  });

  test(
    'BackgroundLocationMonitoringPolicy keeps monitoring with current location',
    () {
      const policy = BackgroundLocationMonitoringPolicy();
      const models = _TestModels();

      final shouldStop = policy.shouldStop(
        slots: [models.currentLocationSlot()],
        shakeDetectionState: models.shakeDetectionState(
          hasCurrentLocation: false,
        ),
      );

      expect(shouldStop, isFalse);
    },
  );
}

final class _TestModels {
  const _TestModels();

  NotificationSlot currentLocationSlot() => const NotificationSlot(
    id: 'slot-cl',
    slotType: NotificationSlotType.currentLocation,
    regionId: 9011,
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

  NotificationSlot regionSlot() => const NotificationSlot(
    id: 'slot-region',
    slotType: NotificationSlotType.region,
    regionId: 130000,
    regionName: '東京都',
    cityCode: null,
    cityName: null,
    displayOrder: 1,
    eewEnabled: true,
    eewMinIntensity: JmaIntensity.four,
    eewOverrides: null,
    earthquakeEnabled: true,
    earthquakeMinIntensity: JmaIntensity.four,
    earthquakeOverrides: null,
  );

  ShakeDetectionState shakeDetectionState({required bool hasCurrentLocation}) =>
      (
        entries: [
          if (hasCurrentLocation)
            const ShakeDetectionEntry(
              id: 'current',
              subRegionId: null,
              subRegionName: null,
              minLevel: api.ShakeDetectionLevel.medium,
              isCurrentLocation: true,
            ),
        ],
        availableSubRegions: <ShakeDetectionSubRegion>[],
      );
}

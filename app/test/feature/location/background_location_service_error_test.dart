import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/location/data/background_location_monitoring_lifecycle.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/earthquake_notification_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/eew_notification_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_region.dart';
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

  test('BackgroundLocationMonitoringPolicy monitors EEW current location', () {
    const policy = BackgroundLocationMonitoringPolicy();
    const models = _BackgroundLocationServiceTestModels();

    final shouldMonitor = policy.shouldMonitor(
      eewSettings: models.eewSettings(hasCurrentLocation: true),
      earthquakeSettings: null,
      shakeDetectionState: models.shakeDetectionState(
        hasCurrentLocation: false,
      ),
    );

    expect(shouldMonitor, isTrue);
  });

  test(
    'BackgroundLocationMonitoringPolicy monitors earthquake current location',
    () {
      const policy = BackgroundLocationMonitoringPolicy();
      const models = _BackgroundLocationServiceTestModels();

      final shouldMonitor = policy.shouldMonitor(
        eewSettings: models.eewSettings(hasCurrentLocation: false),
        earthquakeSettings: models.earthquakeSettings(hasCurrentLocation: true),
        shakeDetectionState: null,
      );

      expect(shouldMonitor, isTrue);
    },
  );

  test(
    'BackgroundLocationMonitoringPolicy monitors shake current location',
    () {
      const policy = BackgroundLocationMonitoringPolicy();
      const models = _BackgroundLocationServiceTestModels();

      final shouldMonitor = policy.shouldMonitor(
        eewSettings: models.eewSettings(hasCurrentLocation: false),
        earthquakeSettings: models.earthquakeSettings(
          hasCurrentLocation: false,
        ),
        shakeDetectionState: models.shakeDetectionState(
          hasCurrentLocation: true,
        ),
      );

      expect(shouldMonitor, isTrue);
    },
  );

  test('BackgroundLocationMonitoringPolicy skips without current location', () {
    const policy = BackgroundLocationMonitoringPolicy();
    const models = _BackgroundLocationServiceTestModels();

    final shouldMonitor = policy.shouldMonitor(
      eewSettings: models.eewSettings(hasCurrentLocation: false),
      earthquakeSettings: models.earthquakeSettings(hasCurrentLocation: false),
      shakeDetectionState: models.shakeDetectionState(
        hasCurrentLocation: false,
      ),
    );

    expect(shouldMonitor, isFalse);
  });

  test('BackgroundLocationMonitoringPolicy stops without current location', () {
    const policy = BackgroundLocationMonitoringPolicy();
    const models = _BackgroundLocationServiceTestModels();

    final shouldStop = policy.shouldStop(
      eewSettings: models.eewSettings(hasCurrentLocation: false),
      earthquakeSettings: models.earthquakeSettings(hasCurrentLocation: false),
      shakeDetectionState: models.shakeDetectionState(
        hasCurrentLocation: false,
      ),
    );

    expect(shouldStop, isTrue);
  });

  test('BackgroundLocationMonitoringPolicy keeps monitoring when unknown', () {
    const policy = BackgroundLocationMonitoringPolicy();
    const models = _BackgroundLocationServiceTestModels();

    final shouldStop = policy.shouldStop(
      eewSettings: models.eewSettings(hasCurrentLocation: false),
      earthquakeSettings: null,
      shakeDetectionState: models.shakeDetectionState(
        hasCurrentLocation: false,
      ),
    );

    expect(shouldStop, isFalse);
  });

  test(
    'BackgroundLocationMonitoringPolicy keeps monitoring with current location',
    () {
      const policy = BackgroundLocationMonitoringPolicy();
      const models = _BackgroundLocationServiceTestModels();

      final shouldStop = policy.shouldStop(
        eewSettings: models.eewSettings(hasCurrentLocation: false),
        earthquakeSettings: models.earthquakeSettings(hasCurrentLocation: true),
        shakeDetectionState: models.shakeDetectionState(
          hasCurrentLocation: false,
        ),
      );

      expect(shouldStop, isFalse);
    },
  );
}

final class _BackgroundLocationServiceTestModels {
  const _BackgroundLocationServiceTestModels();

  EewNotificationSettings eewSettings({required bool hasCurrentLocation}) =>
      EewNotificationSettings(
        enabled: true,
        criticalThreshold: null,
        startLiveActivity: true,
        onePointEnabled: true,
        regions: [
          if (hasCurrentLocation) notificationRegion(isCurrentLocation: true),
        ],
      );

  EarthquakeNotificationSettings earthquakeSettings({
    required bool hasCurrentLocation,
  }) => EarthquakeNotificationSettings(
    enabled: true,
    criticalThreshold: null,
    estimatedIntensityEnabled: false,
    regions: [
      if (hasCurrentLocation) notificationRegion(isCurrentLocation: true),
    ],
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

  NotificationRegion notificationRegion({required bool isCurrentLocation}) =>
      NotificationRegion(
        regionId: 1,
        regionName: 'テスト',
        isCurrentLocation: isCurrentLocation,
        minJmaIntensity: JmaIntensity.four,
      );
}

import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_magnitude.dart';
import 'package:eqmonitor/feature/live_activity/data/model/unified_live_activity_content_state.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/live_activity/data/model/debug_live_activity_preset.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_level.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final debugLiveActivityContentBuilderProvider =
    Provider<DebugLiveActivityContentBuilder>(
      (ref) => const DebugLiveActivityContentBuilder(),
    );

class DebugLiveActivityContentBuilder {
  const new();

  UnifiedLiveActivityContentState unifiedFromPreset({
    required DebugUnifiedPreset preset,
    required String id,
    required DateTime now,
  }) => switch (preset) {
    .shake => shakePreset(id: id, now: now),
    .shakeEscalated => shakeEscalatedPreset(id: id, now: now),
    .shakeEnded => shakeEndedPreset(id: id, now: now),
    .eew => eewPreset(id: id, now: now),
    .earthquake => earthquakePreset(id: id, now: now),
    .allBlocks => allBlocksPreset(id: id, now: now),
    .canceledEew => canceledEewPreset(id: id, now: now),
    .canceledEarthquake => canceledEarthquakePreset(id: id, now: now),
    .magnitudeUnknown => magnitudeUnknownPreset(id: id, now: now),
    .magnitudeOverM8 => magnitudeOverM8Preset(id: id, now: now),
    .noLocation => noLocationPreset(id: id, now: now),
  };

  UnifiedLiveActivityContentState shakePreset({
    required String id,
    required DateTime now,
  }) => snapshot(
    id: id,
    now: now,
    primary: .shakeDetection,
    shakeDetection: shake(now: now),
  );

  UnifiedLiveActivityContentState shakeEscalatedPreset({
    required String id,
    required DateTime now,
  }) => snapshot(
    id: id,
    now: now,
    primary: .shakeDetection,
    shakeDetection: shake(
      now: now,
      level: .stronger,
      locationLevel: .stronger,
      headline: '関東地方で非常に強い揺れを検知しました',
    ),
  );

  UnifiedLiveActivityContentState shakeEndedPreset({
    required String id,
    required DateTime now,
  }) => snapshot(
    id: id,
    now: now,
    primary: .shakeDetection,
    shakeDetection: shake(now: now, status: .ended),
  );

  UnifiedLiveActivityContentState eewPreset({
    required String id,
    required DateTime now,
  }) => snapshot(
    id: id,
    now: now,
    primary: .eew,
    shakeDetection: shake(now: now),
    eew: eew(id: id, now: now),
  );

  UnifiedLiveActivityContentState earthquakePreset({
    required String id,
    required DateTime now,
  }) => snapshot(
    id: id,
    now: now,
    primary: .earthquake,
    earthquake: earthquake(id: id, now: now),
  );

  UnifiedLiveActivityContentState allBlocksPreset({
    required String id,
    required DateTime now,
  }) => snapshot(
    id: id,
    now: now,
    primary: .earthquake,
    shakeDetection: shake(now: now, status: .ended),
    eew: eew(id: id, now: now, isFinal: true),
    earthquake: earthquake(id: id, now: now),
  );

  UnifiedLiveActivityContentState canceledEewPreset({
    required String id,
    required DateTime now,
  }) => snapshot(
    id: id,
    now: now,
    primary: .eew,
    shakeDetection: shake(now: now),
    eew: eew(
      id: id,
      now: now,
      isCanceled: true,
      isFinal: true,
      headline: '緊急地震速報は取り消されました',
    ),
  );

  UnifiedLiveActivityContentState canceledEarthquakePreset({
    required String id,
    required DateTime now,
  }) => snapshot(
    id: id,
    now: now,
    primary: .earthquake,
    earthquake: earthquake(
      id: id,
      now: now,
      isCanceled: true,
      headline: '震源・震度情報は取り消されました',
    ),
  );

  UnifiedLiveActivityContentState magnitudeUnknownPreset({
    required String id,
    required DateTime now,
  }) => snapshot(
    id: id,
    now: now,
    primary: .earthquake,
    earthquake: earthquake(
      id: id,
      now: now,
      magnitude: const EarthquakeMagnitude.unknown(),
    ),
  );

  UnifiedLiveActivityContentState magnitudeOverM8Preset({
    required String id,
    required DateTime now,
  }) => snapshot(
    id: id,
    now: now,
    primary: .earthquake,
    earthquake: earthquake(
      id: id,
      now: now,
      magnitude: const EarthquakeMagnitude.overM8(),
    ),
  );

  UnifiedLiveActivityContentState noLocationPreset({
    required String id,
    required DateTime now,
  }) => snapshot(
    id: id,
    now: now,
    primary: .earthquake,
    shakeDetection: shake(now: now, hasLocation: false),
    eew: eew(id: id, now: now, hasLocation: false),
    earthquake: earthquake(id: id, now: now, hasLocation: false),
  );

  UnifiedLiveActivityContentState snapshot({
    required String id,
    required DateTime now,
    required UnifiedLiveActivityPrimary primary,
    UnifiedShakeDetection? shakeDetection,
    UnifiedEew? eew,
    UnifiedEarthquake? earthquake,
  }) => UnifiedLiveActivityContentState(
    schemaVersion: 2,
    id: id,
    updatedAt: now,
    primary: primary,
    shakeDetection: shakeDetection,
    eew: eew,
    earthquake: earthquake,
  );

  UnifiedShakeDetection shake({
    required DateTime now,
    ShakeDetectionLevel level = ShakeDetectionLevel.strong,
    ShakeDetectionLevel locationLevel = ShakeDetectionLevel.strong,
    UnifiedShakeDetectionStatus status = UnifiedShakeDetectionStatus.active,
    String headline = '関東地方で強い揺れを検知しました',
    bool hasLocation = true,
  }) => UnifiedShakeDetection(
    headline: headline,
    detectedAt: now.subtract(const Duration(seconds: 45)),
    updatedAt: now,
    level: level,
    status: status,
    location: hasLocation
        ? UnifiedShakeDetectionLocation(name: '東京都23区', level: locationLevel)
        : null,
  );

  UnifiedEew eew({
    required String id,
    required DateTime now,
    bool isFinal = false,
    bool isCanceled = false,
    bool hasLocation = true,
    String headline = '茨城県沖で地震 関東地方で強い揺れ',
  }) => UnifiedEew(
    eventId: 'debug-event-$id',
    headline: headline,
    hypocenterName: isCanceled ? null : '茨城県沖',
    magnitude: isCanceled ? null : 6.8,
    depth: isCanceled ? null : 30,
    time: isCanceled ? null : now.subtract(const Duration(minutes: 1)),
    isOriginTime: !isCanceled,
    maxIntensity: isCanceled ? null : .sixLower,
    serialNo: isFinal ? 12 : 3,
    isFinal: isFinal,
    isWarning: !isCanceled,
    isCanceled: isCanceled,
    isPlum: false,
    isLevel: false,
    isOnePoint: false,
    issuedAt: now,
    location: hasLocation
        ? UnifiedEewLocation(
            regionName: '東京都23区',
            forecastIntensity: .fiveLower,
            forecastLpgmIntensity: JmaLpgmIntensity.two,
            arrivalTime: now.add(const Duration(seconds: 30)),
            isPlum: null,
            isWarning: true,
          )
        : null,
  );

  UnifiedEarthquake earthquake({
    required String id,
    required DateTime now,
    EarthquakeMagnitude? magnitude = const EarthquakeMagnitude.value(
      value: 6.8,
    ),
    bool isCanceled = false,
    bool hasLocation = true,
    String headline = '茨城県沖で地震 最大震度6弱',
  }) => UnifiedEarthquake(
    eventId: 'debug-event-$id',
    headline: headline,
    informationType: const [.vxse53],
    issuedAt: now,
    isCanceled: isCanceled,
    hypocenterName: isCanceled ? null : '茨城県沖',
    magnitude: isCanceled ? null : magnitude,
    depth: isCanceled ? null : 30,
    originTime: isCanceled ? null : now.subtract(const Duration(minutes: 1)),
    maxIntensity: isCanceled ? null : JmaIntensity.sixLower,
    location: hasLocation
        ? const UnifiedEarthquakeLocation(
            regionName: '東京都23区',
            maxIntensity: JmaIntensity.fiveLower,
          )
        : null,
  );
}

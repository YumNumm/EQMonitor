import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_display_mode.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_tree.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/live_monitor/data/model/live_monitor_event.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';

final class LiveMonitorEarthquakePresentation {
  const LiveMonitorEarthquakePresentation._({
    required this.displayMode,
    required this.trigger,
    required this.latestPublication,
  });

  factory LiveMonitorEarthquakePresentation.forSplit({
    required Earthquake earthquake,
  }) => LiveMonitorEarthquakePresentation._(
    displayMode: preferredIntensityMode(earthquake: earthquake, trigger: null),
    trigger: null,
    latestPublication: latestSupportedTelegramTrigger(earthquake),
  );

  factory LiveMonitorEarthquakePresentation.forTrigger({
    required Earthquake earthquake,
    required LiveMonitorEarthquakeTrigger trigger,
  }) => LiveMonitorEarthquakePresentation._(
    displayMode: preferredIntensityMode(
      earthquake: earthquake,
      trigger: trigger,
    ),
    trigger: trigger,
    latestPublication: latestSupportedTelegramTrigger(earthquake),
  );

  final IntensityDisplayMode displayMode;
  final LiveMonitorEarthquakeTrigger? trigger;
  final LiveMonitorEarthquakeTrigger? latestPublication;

  DateTime? get publicationAt => switch ((latestPublication, trigger)) {
    (LiveMonitorTelegramTrigger(:final reportedAt), _) => reportedAt,
    (_, LiveMonitorTelegramTrigger(:final reportedAt)) => reportedAt,
    _ => null,
  };
}

IntensityDisplayMode preferredIntensityMode({
  required Earthquake earthquake,
  required LiveMonitorEarthquakeTrigger? trigger,
}) {
  if (trigger == null && earthquake.estimatedIntensityTileUrl != null) {
    return IntensityDisplayMode.estimated;
  }
  final effectiveTrigger =
      trigger ?? latestSupportedTelegramTrigger(earthquake);
  return switch (effectiveTrigger) {
    LiveMonitorTelegramTrigger(kind: .vxse62)
        when earthquake.intensity?.maxLpgmIntensity != null =>
      IntensityDisplayMode.lpgm,
    LiveMonitorEstimatedIntensityTrigger()
        when earthquake.estimatedIntensityTileUrl != null =>
      IntensityDisplayMode.estimated,
    _ => IntensityDisplayMode.jma,
  };
}

List<IntensityRegion> maximumIntensityRegions(Earthquake earthquake) {
  final intensity = earthquake.intensity;
  if (intensity == null || intensity.regions.isEmpty) {
    return const [];
  }
  final maximum = intensity.regions.keys.reduce(
    (left, right) => left.orderIndex >= right.orderIndex ? left : right,
  );
  return List.unmodifiable(intensity.regions[maximum] ?? const []);
}

typedef LiveMonitorIntensityRegionGroup = ({
  JmaIntensity intensity,
  List<IntensityRegion> regions,
});

List<LiveMonitorIntensityRegionGroup> orderedIntensityRegions(
  Earthquake earthquake,
) {
  final entries = [
    ...?earthquake.intensity?.regions.entries,
  ]..sort((left, right) => right.key.orderIndex.compareTo(left.key.orderIndex));
  return List.unmodifiable(
    entries.map(
      (entry) => (
        intensity: entry.key,
        regions: List<IntensityRegion>.unmodifiable(entry.value),
      ),
    ),
  );
}

LiveMonitorEarthquakeTrigger? latestSupportedTelegramTrigger(
  Earthquake earthquake,
) {
  final supported = earthquake.telegramMetadata
      .where(
        (metadata) => switch (metadata.type) {
          .vxse51 || .vxse52 || .vxse53 || .vxse61 || .vxse62 => true,
          .vxse45Forecast || .vxse45Warning => false,
        },
      )
      .toList(growable: false);
  if (supported.isEmpty) {
    return null;
  }
  final latest = supported.reduce(
    (left, right) => left.reportedAt.isAfter(right.reportedAt) ? left : right,
  );
  final kind = switch (latest.type) {
    EarthquakeTelegramType.vxse51 => LiveMonitorEarthquakeTriggerKind.vxse51,
    EarthquakeTelegramType.vxse52 => LiveMonitorEarthquakeTriggerKind.vxse52,
    EarthquakeTelegramType.vxse53 => LiveMonitorEarthquakeTriggerKind.vxse53,
    EarthquakeTelegramType.vxse61 => LiveMonitorEarthquakeTriggerKind.vxse61,
    EarthquakeTelegramType.vxse62 => LiveMonitorEarthquakeTriggerKind.vxse62,
    EarthquakeTelegramType.vxse45Forecast ||
    EarthquakeTelegramType.vxse45Warning => null,
  };
  return kind == null
      ? null
      : LiveMonitorEarthquakeTrigger.telegram(
          kind: kind,
          reportedAt: latest.reportedAt,
        );
}

List<EewTelegramItem> orderedLiveMonitorEews(List<EewTelegramItem> eews) {
  final ordered = [...eews]
    ..sort((left, right) {
      final timeOrder = right.reportTime.compareTo(left.reportTime);
      return timeOrder != 0
          ? timeOrder
          : right.serialNo.compareTo(left.serialNo);
    });
  return List.unmodifiable(ordered);
}

List<ShakeDetectionEvent> orderedLiveMonitorShakes(
  List<ShakeDetectionEvent> shakes,
) {
  final ordered = [...shakes]
    ..sort((left, right) {
      final timeOrder = right.updatedAt.compareTo(left.updatedAt);
      return timeOrder != 0
          ? timeOrder
          : right.serialNo.compareTo(left.serialNo);
    });
  return List.unmodifiable(ordered);
}

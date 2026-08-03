import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_activity_query.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_activity_summary.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_magnitude.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';

class EarthquakeActivitySummaryBuilder {
  const EarthquakeActivitySummaryBuilder();

  EarthquakeActivitySummary build({
    required List<EarthquakePartialNormal> items,
    required EarthquakeActivityQuery query,
  }) {
    var beforeCount = 0;
    var afterCount = 0;
    JmaIntensity? maxIntensity;
    EarthquakeMagnitude? maxMagnitude;
    DateTime? latestOriginTime;

    for (final item in items) {
      final originTime = item.originTime;
      if (originTime == null) {
        continue;
      }
      if (originTime.isBefore(query.baseOriginTime)) {
        beforeCount++;
      } else {
        afterCount++;
      }
      if (latestOriginTime == null || originTime.isAfter(latestOriginTime)) {
        latestOriginTime = originTime;
      }

      final intensity = item.intensity?.maxIntensity;
      if (intensity != null &&
          intensity != JmaIntensity.unknown &&
          (maxIntensity == null ||
              intensity.orderIndex > maxIntensity.orderIndex)) {
        maxIntensity = intensity;
      }

      final magnitude = item.hypocenter?.magnitude;
      final magnitudeRank = switch (magnitude) {
        EarthquakeMagnitudeValue(:final value) => value,
        EarthquakeMagnitudeOverM8() => double.infinity,
        EarthquakeMagnitudeUnknown() || null => null,
      };
      final currentRank = switch (maxMagnitude) {
        EarthquakeMagnitudeValue(:final value) => value,
        EarthquakeMagnitudeOverM8() => double.infinity,
        EarthquakeMagnitudeUnknown() || null => null,
      };
      if (magnitudeRank != null &&
          (currentRank == null || magnitudeRank > currentRank)) {
        maxMagnitude = magnitude;
      }
    }

    return EarthquakeActivitySummary(
      beforeCount: beforeCount,
      afterCount: afterCount,
      maxIntensity: maxIntensity,
      maxMagnitude: maxMagnitude,
      latestOriginTime: latestOriginTime,
    );
  }
}

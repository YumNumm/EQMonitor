import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_activity_bin.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_activity_bin_interval.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_activity_intensity_category.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';

class EarthquakeActivityBinner {
  const new();

  List<EarthquakeActivityBin> build({
    required List<EarthquakePartialNormal> items,
    required EarthquakeActivityBinInterval interval,
  }) {
    final countsByStart =
        <DateTime, Map<EarthquakeActivityIntensityCategory, int>>{};

    for (final item in items) {
      final originTime = item.originTime;
      if (originTime == null) {
        continue;
      }
      final start = interval.align(originTime);
      final counts = countsByStart.putIfAbsent(start, () {
        return {
          for (final category in EarthquakeActivityIntensityCategory.values)
            category: 0,
        };
      });
      final category = EarthquakeActivityIntensityCategory.fromIntensity(
        item.intensity?.maxIntensity,
      );
      counts[category] = (counts[category] ?? 0) + 1;
    }

    final starts = countsByStart.keys.toList()..sort();
    return [
      for (final start in starts)
        EarthquakeActivityBin(
          start: start,
          end: start.add(interval.duration),
          counts: countsByStart[start] ?? const {},
        ),
    ];
  }
}

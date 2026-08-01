import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_activity_intensity_category.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'earthquake_activity_bin.freezed.dart';

@freezed
abstract class EarthquakeActivityBin with _$EarthquakeActivityBin {
  const factory EarthquakeActivityBin({
    required DateTime start,
    required DateTime end,
    required Map<EarthquakeActivityIntensityCategory, int> counts,
  }) = _EarthquakeActivityBin;

  const EarthquakeActivityBin._();

  int get totalCount => counts.values.fold(0, (sum, count) => sum + count);
}

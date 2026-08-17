import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_magnitude.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'earthquake_activity_summary.freezed.dart';

@freezed
abstract class EarthquakeActivitySummary with _$EarthquakeActivitySummary {
  const factory({
    required int beforeCount,
    required int afterCount,
    required JmaIntensity? maxIntensity,
    required EarthquakeMagnitude? maxMagnitude,
    required DateTime? latestOriginTime,
  }) = _EarthquakeActivitySummary;
}

import 'package:eqmonitor_map/src/foundation/frame/map_clock.dart';
import 'package:eqmonitor_map/src/foundation/performance/map_performance_metric.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'map_performance_sample.freezed.dart';

@Freezed(
  copyWith: false,
  map: FreezedMapOptions.none,
  when: FreezedWhenOptions.none,
)
abstract class MapPerformanceSample with _$MapPerformanceSample {
  const factory MapPerformanceSample._({
    required MapPerformanceSchemaVersion schemaVersion,
    required MapClockDomainId clockDomain,
    required MapPerformanceMetricKind kind,
    required Duration monotonicAt,
    required int value,
  }) = _MapPerformanceSample;
}

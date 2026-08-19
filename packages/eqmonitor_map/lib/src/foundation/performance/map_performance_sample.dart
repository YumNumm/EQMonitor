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
  const factory _({
    required MapPerformanceSchemaVersion schemaVersion,
    required MapClockDomainId clockDomain,
    required MapPerformanceMetricKind kind,
    required Duration monotonicAt,
    required int value,
  }) = _MapPerformanceSample;

  factory duration({
    required MapPerformanceSchemaVersion schemaVersion,
    required MapClockDomainId clockDomain,
    required MapPerformanceMetricKind kind,
    required Duration monotonicAt,
    required Duration value,
  }) {
    if (monotonicAt.isNegative || value.isNegative) {
      throw ArgumentError('monotonicAt and value must not be negative');
    }
    if (mapPerformanceMetricUnitOf(kind) != MapPerformanceMetricUnit.duration) {
      throw ArgumentError.value(kind, 'kind', 'must use the duration unit');
    }
    return MapPerformanceSample._(
      schemaVersion: schemaVersion,
      clockDomain: clockDomain,
      kind: kind,
      monotonicAt: monotonicAt,
      value: value.inMicroseconds,
    );
  }

  factory count({
    required MapPerformanceSchemaVersion schemaVersion,
    required MapClockDomainId clockDomain,
    required MapPerformanceMetricKind kind,
    required Duration monotonicAt,
    required int value,
  }) {
    if (monotonicAt.isNegative || value.isNegative) {
      throw ArgumentError('monotonicAt and value must not be negative');
    }
    if (mapPerformanceMetricUnitOf(kind) != MapPerformanceMetricUnit.count) {
      throw ArgumentError.value(kind, 'kind', 'must use the count unit');
    }
    return MapPerformanceSample._(
      schemaVersion: schemaVersion,
      clockDomain: clockDomain,
      kind: kind,
      monotonicAt: monotonicAt,
      value: value,
    );
  }

  factory bytes({
    required MapPerformanceSchemaVersion schemaVersion,
    required MapClockDomainId clockDomain,
    required MapPerformanceMetricKind kind,
    required Duration monotonicAt,
    required int value,
  }) {
    if (monotonicAt.isNegative || value.isNegative) {
      throw ArgumentError('monotonicAt and value must not be negative');
    }
    if (mapPerformanceMetricUnitOf(kind) != MapPerformanceMetricUnit.bytes) {
      throw ArgumentError.value(kind, 'kind', 'must use the bytes unit');
    }
    return MapPerformanceSample._(
      schemaVersion: schemaVersion,
      clockDomain: clockDomain,
      kind: kind,
      monotonicAt: monotonicAt,
      value: value,
    );
  }
}

import 'dart:ui';

import 'package:eqmonitor_map/src/foundation/frame/map_clock.dart';
import 'package:eqmonitor_map/src/foundation/performance/map_performance_metric.dart';
import 'package:eqmonitor_map/src/foundation/performance/map_performance_policy.dart';
import 'package:eqmonitor_map/src/foundation/performance/map_performance_sample.dart';

List<MapPerformanceSample> mapFrameTimingSamples({
  required FrameTiming timing,
  required MapPerformanceSchemaVersion schemaVersion,
  required MapClockDomainId clockDomain,
  required Duration monotonicAt,
  required MapFrameBudget frameBudget,
}) {
  final overrun = timing.totalSpan - frameBudget.duration;

  return [
    MapPerformanceSample.duration(
      schemaVersion: schemaVersion,
      clockDomain: clockDomain,
      kind: MapPerformanceMetricKind.flutterBuild,
      monotonicAt: monotonicAt,
      value: timing.buildDuration,
    ),
    MapPerformanceSample.duration(
      schemaVersion: schemaVersion,
      clockDomain: clockDomain,
      kind: MapPerformanceMetricKind.flutterRaster,
      monotonicAt: monotonicAt,
      value: timing.rasterDuration,
    ),
    MapPerformanceSample.duration(
      schemaVersion: schemaVersion,
      clockDomain: clockDomain,
      kind: MapPerformanceMetricKind.flutterFrameBudgetOverrun,
      monotonicAt: monotonicAt,
      value: overrun.isNegative ? Duration.zero : overrun,
    ),
  ];
}

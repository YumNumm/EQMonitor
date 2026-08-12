import 'dart:ui';

import 'package:eqmonitor_map/src/foundation/frame/map_clock.dart';
import 'package:eqmonitor_map/src/foundation/performance/map_frame_timing_samples.dart';
import 'package:eqmonitor_map/src/foundation/performance/map_performance_metric.dart';
import 'package:eqmonitor_map/src/foundation/performance/map_performance_policy.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final schemaVersion = createMapPerformanceSchemaVersion(value: 1);
  final clockDomain = createMapClockDomainId(value: 'frame-timing-test');
  const monotonicAt = Duration(seconds: 7);
  final timing = FrameTiming(
    vsyncStart: 100,
    buildStart: 200,
    buildFinish: 500,
    rasterStart: 600,
    rasterFinish: 1000,
    rasterFinishWallTime: 900000,
  );

  test('converts synthetic frame durations without reading wall time', () {
    final samples = mapFrameTimingSamples(
      timing: timing,
      schemaVersion: schemaVersion,
      clockDomain: clockDomain,
      monotonicAt: monotonicAt,
      frameBudget: createMapFrameBudget(
        duration: const Duration(microseconds: 700),
      ),
    );

    expect(samples.map((sample) => sample.value), [300, 400, 200]);
    expect(
      samples.every((sample) => sample.schemaVersion == schemaVersion),
      isTrue,
    );
    expect(
      samples.every((sample) => sample.clockDomain == clockDomain),
      isTrue,
    );
    expect(
      samples.every((sample) => sample.monotonicAt == monotonicAt),
      isTrue,
    );
  });

  test('floors frame budget overrun at zero', () {
    final samples = mapFrameTimingSamples(
      timing: timing,
      schemaVersion: schemaVersion,
      clockDomain: clockDomain,
      monotonicAt: monotonicAt,
      frameBudget: createMapFrameBudget(
        duration: const Duration(microseconds: 1000),
      ),
    );

    expect(
      samples.last.kind,
      MapPerformanceMetricKind.flutterFrameBudgetOverrun,
    );
    expect(samples.last.value, 0);
  });
}

import 'package:eqmonitor_map/src/foundation/performance/map_performance_metric.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('defines the exact duration metric catalog', () {
    expect(MapPerformanceMetricKind.values, const [
      MapPerformanceMetricKind.frameReconciliation,
      MapPerformanceMetricKind.tileCover,
      MapPerformanceMetricKind.labelPlacement,
      MapPerformanceMetricKind.renderSubmission,
      MapPerformanceMetricKind.tileRequestQueueWait,
      MapPerformanceMetricKind.tileRequestExecution,
      MapPerformanceMetricKind.decodeQueueWait,
      MapPerformanceMetricKind.decodeExecution,
      MapPerformanceMetricKind.meshBuildQueueWait,
      MapPerformanceMetricKind.meshBuildExecution,
      MapPerformanceMetricKind.gpuUploadQueueWait,
      MapPerformanceMetricKind.gpuUploadExecution,
      MapPerformanceMetricKind.gpuSubmission,
      MapPerformanceMetricKind.gpuCompletion,
      MapPerformanceMetricKind.flutterBuild,
      MapPerformanceMetricKind.flutterRaster,
      MapPerformanceMetricKind.flutterFrameBudgetOverrun,
      MapPerformanceMetricKind.instrumentationOverhead,
    ]);
  });

  test('maps every duration metric to the duration unit', () {
    for (final kind in MapPerformanceMetricKind.values) {
      expect(
        mapPerformanceMetricUnitOf(kind),
        MapPerformanceMetricUnit.duration,
      );
    }
  });
}

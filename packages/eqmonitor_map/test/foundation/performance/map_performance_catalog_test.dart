import 'package:eqmonitor_map/src/foundation/performance/map_performance_metric.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('defines the exact duration metric catalog', () {
    expect(
      MapPerformanceMetricKind.values.where(
        (kind) =>
            mapPerformanceMetricUnitOf(kind) ==
            MapPerformanceMetricUnit.duration,
      ),
      const [
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
      ],
    );
  });
}

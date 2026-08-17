import 'package:eqmonitor_map/src/foundation/performance/map_performance_metric.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('covers every required renderer performance metric', () {
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
      MapPerformanceMetricKind.cacheHit,
      MapPerformanceMetricKind.cacheMiss,
      MapPerformanceMetricKind.tileQueueDepth,
      MapPerformanceMetricKind.gpuBucketCount,
      MapPerformanceMetricKind.labelCandidateCount,
      MapPerformanceMetricKind.labelAcceptedCount,
      MapPerformanceMetricKind.currentCpuBytes,
      MapPerformanceMetricKind.peakCpuBytes,
      MapPerformanceMetricKind.currentGpuBytes,
      MapPerformanceMetricKind.peakGpuBytes,
      MapPerformanceMetricKind.requestBytes,
      MapPerformanceMetricKind.decodeBytes,
    ]);
  });
}

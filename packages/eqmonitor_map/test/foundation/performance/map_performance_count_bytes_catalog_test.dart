import 'package:eqmonitor_map/src/foundation/performance/map_performance_metric.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('defines and maps the exact count and bytes metric catalogs', () {
    const countKinds = [
      MapPerformanceMetricKind.cacheHit,
      MapPerformanceMetricKind.cacheMiss,
      MapPerformanceMetricKind.tileQueueDepth,
      MapPerformanceMetricKind.gpuBucketCount,
      MapPerformanceMetricKind.labelCandidateCount,
      MapPerformanceMetricKind.labelAcceptedCount,
    ];
    const bytesKinds = [
      MapPerformanceMetricKind.currentCpuBytes,
      MapPerformanceMetricKind.peakCpuBytes,
      MapPerformanceMetricKind.currentGpuBytes,
      MapPerformanceMetricKind.peakGpuBytes,
      MapPerformanceMetricKind.requestBytes,
      MapPerformanceMetricKind.decodeBytes,
    ];

    expect(
      MapPerformanceMetricKind.values.where(
        (kind) =>
            mapPerformanceMetricUnitOf(kind) == MapPerformanceMetricUnit.count,
      ),
      countKinds,
    );
    expect(
      MapPerformanceMetricKind.values.where(
        (kind) =>
            mapPerformanceMetricUnitOf(kind) == MapPerformanceMetricUnit.bytes,
      ),
      bytesKinds,
    );
  });
}

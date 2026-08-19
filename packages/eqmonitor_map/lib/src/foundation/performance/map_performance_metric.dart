extension type MapPerformanceSchemaVersion._(int value);

enum MapPerformanceMetricUnit { duration, count, bytes }

enum MapPerformanceMetricKind {
  frameReconciliation,
  tileCover,
  labelPlacement,
  renderSubmission,
  tileRequestQueueWait,
  tileRequestExecution,
  decodeQueueWait,
  decodeExecution,
  meshBuildQueueWait,
  meshBuildExecution,
  gpuUploadQueueWait,
  gpuUploadExecution,
  gpuSubmission,
  gpuCompletion,
  flutterBuild,
  flutterRaster,
  flutterFrameBudgetOverrun,
  instrumentationOverhead,
  cacheHit,
  cacheMiss,
  tileQueueDepth,
  gpuBucketCount,
  labelCandidateCount,
  labelAcceptedCount,
  currentCpuBytes,
  peakCpuBytes,
  currentGpuBytes,
  peakGpuBytes,
  requestBytes,
  decodeBytes,
}

MapPerformanceMetricUnit mapPerformanceMetricUnitOf(
  MapPerformanceMetricKind kind,
) => switch (kind) {
  .frameReconciliation ||
  .tileCover ||
  .labelPlacement ||
  .renderSubmission ||
  .tileRequestQueueWait ||
  .tileRequestExecution ||
  .decodeQueueWait ||
  .decodeExecution ||
  .meshBuildQueueWait ||
  .meshBuildExecution ||
  .gpuUploadQueueWait ||
  .gpuUploadExecution ||
  .gpuSubmission ||
  .gpuCompletion ||
  .flutterBuild ||
  .flutterRaster ||
  .flutterFrameBudgetOverrun ||
  .instrumentationOverhead => .duration,
  .cacheHit ||
  .cacheMiss ||
  .tileQueueDepth ||
  .gpuBucketCount ||
  .labelCandidateCount ||
  .labelAcceptedCount => .count,
  .currentCpuBytes ||
  .peakCpuBytes ||
  .currentGpuBytes ||
  .peakGpuBytes ||
  .requestBytes ||
  .decodeBytes => .bytes,
};

MapPerformanceSchemaVersion createMapPerformanceSchemaVersion({
  required int value,
}) {
  if (value <= 0) {
    throw ArgumentError.value(value, 'value', 'must be positive');
  }

  return MapPerformanceSchemaVersion._(value);
}

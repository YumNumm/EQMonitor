extension type MapPerformanceSchemaVersion._(int value) {}

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
}

MapPerformanceMetricUnit mapPerformanceMetricUnitOf(
  MapPerformanceMetricKind kind,
) => switch (kind) {
  _ => .duration,
};

MapPerformanceSchemaVersion createMapPerformanceSchemaVersion({
  required int value,
}) {
  if (value <= 0) {
    throw ArgumentError.value(value, 'value', 'must be positive');
  }

  return MapPerformanceSchemaVersion._(value);
}

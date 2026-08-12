extension type MapPerformanceSchemaVersion._(int value) {}

enum MapPerformanceMetricUnit { duration, count, bytes }

MapPerformanceSchemaVersion createMapPerformanceSchemaVersion({
  required int value,
}) {
  if (value <= 0) {
    throw ArgumentError.value(value, 'value', 'must be positive');
  }

  return MapPerformanceSchemaVersion._(value);
}

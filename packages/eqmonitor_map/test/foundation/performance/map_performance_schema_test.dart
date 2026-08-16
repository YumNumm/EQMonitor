import 'package:eqmonitor_map/src/foundation/performance/map_performance_metric.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('creates positive schema versions with value equality', () {
    final version = createMapPerformanceSchemaVersion(value: 1);
    final sameVersion = createMapPerformanceSchemaVersion(value: 1);

    expect(version.value, 1);
    expect(version, sameVersion);
    expect(version.hashCode, sameVersion.hashCode);
    expect(
      () => createMapPerformanceSchemaVersion(value: 0),
      throwsArgumentError,
    );
    expect(
      () => createMapPerformanceSchemaVersion(value: -1),
      throwsArgumentError,
    );
  });

  test('defines the exact performance metric units', () {
    expect(MapPerformanceMetricUnit.values, const [
      MapPerformanceMetricUnit.duration,
      MapPerformanceMetricUnit.count,
      MapPerformanceMetricUnit.bytes,
    ]);
  });
}

import 'package:eqmonitor_map/src/foundation/performance/map_performance_policy.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('exposes the exact observation and drop policy values', () {
    expect(MapPerformanceObservationLevel.values, [
      MapPerformanceObservationLevel.off,
      MapPerformanceObservationLevel.aggregate,
      MapPerformanceObservationLevel.detailed,
    ]);
    expect(MapPerformanceDropPolicy.values, [
      MapPerformanceDropPolicy.dropOldest,
      MapPerformanceDropPolicy.dropNewest,
    ]);
  });

  test('creates only positive frame budgets with value semantics', () {
    const duration = Duration(microseconds: 16667);
    final budget = createMapFrameBudget(duration: duration);
    final sameBudget = createMapFrameBudget(duration: duration);

    expect(budget.duration, duration);
    expect(budget, sameBudget);
    expect(budget.hashCode, sameBudget.hashCode);
    for (final invalid in [
      Duration.zero,
      const Duration(microseconds: -1),
    ]) {
      expect(
        () => createMapFrameBudget(duration: invalid),
        throwsArgumentError,
      );
    }
  });

  test('keeps the policy type behind its later validated factory', () {
    const MapPerformancePolicy? policy = null;

    expect(policy, isNull);
  });
}

import 'package:eqmonitor_map/src/foundation/render/map_render_sort_key.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  MapRenderSortKey key(List<int> values) => MapRenderSortKey(
    phasePolicyVersion: values[0],
    phase: values[1],
    declarationOrderWithinPhase: values[2],
    sourceOrder: values[3],
    overscaledTileOrder: values[4],
    featureOrder: values[5],
  );

  test('sorts by phase before phase-local declaration and source fields', () {
    final ordered = [
      key([1, 0, 99, 99, 99, 99]),
      key([1, 1, 0, 99, 99, 99]),
      key([1, 1, 1, 0, 99, 99]),
      key([1, 1, 1, 1, 0, 99]),
      key([1, 1, 1, 1, 1, 0]),
      key([1, 1, 1, 1, 1, 1]),
    ];
    final shuffled = ordered.reversed.toList()..sort(compareMapRenderSortKeys);

    expect(shuffled, ordered);
    final otherPolicy = key([2, 0, 0, 0, 0, 0]);
    expect(
      () => compareMapRenderSortKeys(ordered.first, otherPolicy),
      throwsArgumentError,
    );
  });

  test('rejects nonpositive version and negative ordering fields', () {
    for (final invalid in <List<int>>[
      [0, 0, 0, 0, 0, 0],
      [-1, 0, 0, 0, 0, 0],
      [1, -1, 0, 0, 0, 0],
      [1, 0, -1, 0, 0, 0],
      [1, 0, 0, -1, 0, 0],
      [1, 0, 0, 0, -1, 0],
      [1, 0, 0, 0, 0, -1],
    ]) {
      expect(() => key(invalid), throwsArgumentError);
    }
  });

  test('uses exact reverse canonical order for hit testing', () {
    final keys = [
      for (final phase in [2, 0, 1]) key([1, phase, 0, 0, 0, 0]),
    ];
    final forward = [...keys]..sort(compareMapRenderSortKeys);
    final hitTest = [...keys]..sort(reverseMapRenderSortKeysForHitTest);

    expect(hitTest, forward.reversed);
  });
}

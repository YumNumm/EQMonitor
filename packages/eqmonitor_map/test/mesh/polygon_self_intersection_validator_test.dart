import 'dart:typed_data';

import 'package:eqmonitor_map/src/mesh/fill_mesh_build_exception.dart';
import 'package:eqmonitor_map/src/mesh/polygon_self_intersection_validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('非0面積の自己交差ringを拒否する', () {
    final ring = Int32List.fromList([3, 0, 2, 5, 1, 0, 4, 3, 0, 3]);

    expect(
      () => const PolygonSelfIntersectionValidator().validate(
        rings: [ring],
        maxIntersectionChecks: 32,
      ),
      throwsA(isA<FillMeshSelfIntersectionException>()),
    );
  });

  test('65536頂点の単純境界を有限の比較数で受理する', () {
    const half = 32768;
    final ring = Int32List(half * 4);
    for (var index = 0; index < half; index++) {
      ring[index * 2] = index;
      ring[index * 2 + 1] = 0;
      final reverseIndex = half * 2 - index - 1;
      ring[reverseIndex * 2] = index;
      ring[reverseIndex * 2 + 1] = 1;
    }

    expect(
      () => const PolygonSelfIntersectionValidator().validate(
        rings: [ring],
        maxIntersectionChecks: 1 << 20,
      ),
      returnsNormally,
    );
  });
}

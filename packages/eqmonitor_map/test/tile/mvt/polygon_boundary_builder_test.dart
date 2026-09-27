import 'dart:typed_data';

import 'package:eqmonitor_map/src/tile/mvt/mvt_tile.dart';
import 'package:eqmonitor_map/src/tile/mvt/polygon_boundary_builder.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('polygon の各 ring を閉じた LineString に変換する', () {
    final feature = MvtFeature(
      type: MvtGeometryType.polygon,
      rings: [
        Int32List.fromList([1, 2, 3, 4, 5, 6]),
      ],
      properties: const {'name': 'intensity:4'},
    );

    final result = const PolygonBoundaryBuilder().build(feature: feature);

    expect(result.type, MvtGeometryType.lineString);
    expect(result.rings.single, [1, 2, 3, 4, 5, 6, 1, 2]);
    expect(result.properties, same(feature.properties));
  });

  test('polygon 以外は caller error として拒否する', () {
    final feature = MvtFeature(
      type: MvtGeometryType.lineString,
      rings: [
        Int32List.fromList([1, 2, 3, 4]),
      ],
      properties: const {},
    );

    expect(
      () => const PolygonBoundaryBuilder().build(feature: feature),
      throwsArgumentError,
    );
  });
}

import 'dart:convert';
import 'dart:io';

import 'package:eqmonitor/feature/region_selection/data/repository/prefecture_boundary_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('同梱境界は重複のない47都道府県のPolygon/MultiPolygonを持つ', () async {
    final bytes = await File('assets/prefecture_boundaries.geojson.gz')
        .readAsBytes();
    final data = jsonDecode(
      const PrefectureBoundaryDecoder().decode(bytes),
    ) as Map<String, dynamic>;
    expect(data['type'], 'FeatureCollection');
    final features = (data['features'] as List).cast<Map<String, dynamic>>();
    expect(features, hasLength(47));
    final codes = <String>[];
    for (final feature in features) {
      final properties = feature['properties'] as Map<String, dynamic>;
      codes.add(properties['code'] as String);
      final geometry = feature['geometry'] as Map<String, dynamic>;
      expect(geometry['type'], isIn(['Polygon', 'MultiPolygon']));
      expect(geometry['coordinates'], isNotEmpty);
    }
    expect(codes..sort(), [
      for (var code = 1; code <= 47; code++) '$code'.padLeft(2, '0'),
    ]);
  });
}

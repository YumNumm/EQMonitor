import 'package:test/test.dart';
import 'package:vector_tile/raw/raw_vector_tile.dart';
import 'seismicity_mvt_fixture_mutator.dart';

void main() {
  test('catalog changes one named raw MVT invariant per fixture', () {
    final catalog = buildSeismicityMvtFixtureCatalog();
    final duplicate = buildSeismicityMvtFixtureCatalog();
    final fixtures = catalog.corruptions;
    VectorTile tile(int index) => VectorTile.fromBuffer(fixtures[index].bytes);
    VectorTile_Layer layer(int index) => tile(index).layers.single;
    VectorTile_Feature feature(int index) => layer(index).features.single;

    expect(
      fixtures.map((fixture) => fixture.name),
      'missing_layer duplicate_layer missing_version missing_extent '
              'odd_tags out_of_range_tags repeated_tags wrong_geometry '
              'missing_required_property unknown_key wrong_scalar '
              'multi_set_scalar empty_earthquake_event_id invalid_uuid '
              'float32_overflow truncation'
          .split(' '),
    );
    expect(tile(0).layers, isEmpty);
    expect(tile(1).layers, hasLength(2));
    expect(layer(2).hasVersion(), isFalse);
    expect(layer(3).hasExtent(), isFalse);
    expect(feature(4).tags, [0, 0, 1, 1, 2, 2, 3, 3, 0]);
    expect(feature(5).tags, [0, 0, 1, 4, 2, 2, 3, 3]);
    expect(feature(6).tags, [0, 0, 1, 1, 2, 2, 3, 3, 0, 0]);
    expect(feature(7).type, VectorTile_GeomType.LINESTRING);
    expect(feature(8).tags, [1, 1, 2, 2, 3, 3]);
    expect(layer(9).keys[2], 'unknown');
    expect(layer(10).values[2].hasStringValue(), isTrue);
    expect(layer(11).values[2].hasBoolValue(), isTrue);
    expect(layer(11).values[2].hasDoubleValue(), isTrue);
    expect(layer(12).values[3].stringValue, isEmpty);
    expect(layer(13).values[0].stringValue, 'invalid');
    expect(layer(14).values[2].doubleValue, 1e100);
    expect(
      fixtures[15].bytes,
      catalog.valid.sublist(0, catalog.valid.length - 1),
    );
    expect(duplicate.valid, catalog.valid);
    for (final (index, fixture) in fixtures.indexed) {
      expect(duplicate.corruptions[index].bytes, fixture.bytes);
      if (index < fixtures.length - 1) {
        expect(
          restoreSeismicityMvtFixture(
            index: index,
            bytes: fixture.bytes,
            valid: catalog.valid,
          ),
          catalog.valid,
          reason: fixture.name,
        );
      }
    }
  });
}

List<int> restoreSeismicityMvtFixture({
  required int index,
  required List<int> bytes,
  required List<int> valid,
}) {
  final tile = VectorTile.fromBuffer(bytes);
  final validLayer = VectorTile.fromBuffer(valid).layers.single;
  switch (index) {
    case 0:
      tile.layers.add(validLayer.deepCopy());
    case 1:
      tile.layers.removeLast();
    case 2:
      tile.layers.single.version = validLayer.version;
    case 3:
      tile.layers.single.extent = validLayer.extent;
    case 4 || 5 || 6 || 8:
      tile.layers.single.features.single.tags
        ..clear()
        ..addAll(validLayer.features.single.tags);
    case 7:
      tile.layers.single.features.single.type = validLayer.features.single.type;
    case 9:
      tile.layers.single.keys[2] = validLayer.keys[2];
    case 10 || 11 || 14:
      tile.layers.single.values[2] = validLayer.values[2].deepCopy();
    case 12:
      tile.layers.single.values[3] = validLayer.values[3].deepCopy();
    case 13:
      tile.layers.single.values[0] = validLayer.values[0].deepCopy();
    default:
      throw StateError('unknown fixture index: $index');
  }
  return tile.writeToBuffer();
}

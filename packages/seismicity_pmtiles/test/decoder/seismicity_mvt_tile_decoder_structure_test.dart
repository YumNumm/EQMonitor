import 'package:seismicity_pmtiles/src/decoder/seismicity_mvt_tile_decoder.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';
import 'package:test/test.dart';
import 'package:vector_tile/raw/raw_vector_tile.dart';

import '../support/seismicity_mvt_fixture_mutator.dart';
import '../support/seismicity_mvt_mutation.dart';

void main() {
  final catalog = buildSeismicityMvtFixtureCatalog();
  final valid = catalog.valid;
  final layer = VectorTile.fromBuffer(valid).layers.single;
  final missingVersion = layer.deepCopy()..clearVersion();
  final missingExtent = layer.deepCopy()..clearExtent();
  final cases = <(String, List<int>, Matcher)>[
    (
      'invalid protobuf',
      corruption(catalog, 'truncation'),
      tile('malformed_protobuf'),
    ),
    (
      'negative protobuf message length',
      const [0x1a, 0xff, 0xff, 0xff, 0xff, 0x0f],
      tile('malformed_protobuf'),
    ),
    (
      'zero layers',
      corruption(catalog, 'missing_layer'),
      tile('missing_hypocenters_layer'),
    ),
    (
      'duplicate layers',
      corruption(catalog, 'duplicate_layer'),
      tile('duplicate_hypocenters_layer'),
    ),
    ('unexpected layer', named(valid, 'other'), tile('unexpected_layer')),
    (
      'absent version',
      valid.replaceMvtLayer(at: 0, layer: missingVersion),
      tile('missing_layer_version'),
    ),
    ('wrong version', versioned(valid, 1), tile('unsupported_layer_version')),
    (
      'absent extent',
      valid.replaceMvtLayer(at: 0, layer: missingExtent),
      tile('missing_layer_extent'),
    ),
    ('wrong extent', extent(valid, 0), tile('invalid_layer_extent')),
    ('non-Point', corruption(catalog, 'wrong_geometry'), feature('not_point')),
    (
      'MultiPoint',
      geometry(valid, [17, 0, 0, 2, 2]),
      feature('invalid_point_geometry'),
    ),
    (
      'malformed Point',
      geometry(valid, [9, 0]),
      feature('invalid_point_geometry'),
    ),
  ];
  for (final (name, bytes, matcher) in cases) {
    test('rejects $name before any callback', () {
      var callbacks = 0;
      expect(
        () => decode(bytes: bytes, onHypocenter: () => callbacks++),
        throwsA(matcher),
      );
      expect(callbacks, 0);
    });
  }

  test('rejects tile ID zoom different from dataZoom', () {
    expect(
      () => decode(bytes: valid, tileId: 1, onHypocenter: () {}),
      throwsA(tile('tile_zoom_mismatch', tileId: 1)),
    );
  });
}

List<int> corruption(
  ({List<int> valid, List<({String name, List<int> bytes})> corruptions})
  catalog,
  String name,
) => catalog.corruptions.singleWhere((value) => value.name == name).bytes;

List<int> named(List<int> bytes, String name) {
  final layer = VectorTile.fromBuffer(bytes).layers.single.deepCopy()
    ..name = name;
  return bytes.replaceMvtLayer(at: 0, layer: layer);
}

List<int> versioned(List<int> bytes, int version) {
  final layer = VectorTile.fromBuffer(bytes).layers.single.deepCopy()
    ..version = version;
  return bytes.replaceMvtLayer(at: 0, layer: layer);
}

List<int> extent(List<int> bytes, int value) {
  final layer = VectorTile.fromBuffer(bytes).layers.single.deepCopy()
    ..extent = value;
  return bytes.replaceMvtLayer(at: 0, layer: layer);
}

List<int> geometry(List<int> bytes, List<int> geometry) =>
    bytes.replaceMvtFeature(
      layerAt: 0,
      featureAt: 0,
      geometry: geometry,
    );

int decode({
  required List<int> bytes,
  required void Function() onHypocenter,
  int tileId = 0,
}) => const SeismicityMvtTileDecoder().decode(
  tileId: tileId,
  dataZoom: 0,
  tileBytes: bytes,
  onHypocenter: (_) => onHypocenter(),
);

Matcher tile(String reason, {int tileId = 0}) =>
    isA<SeismicityPmTilesInvalidVectorTileException>()
        .having((error) => error.tileId, 'tileId', tileId)
        .having((error) => error.reason, 'reason', reason);

Matcher feature(String reason) =>
    isA<SeismicityPmTilesInvalidHypocenterFeatureException>()
        .having((error) => error.tileId, 'tileId', 0)
        .having((error) => error.featureIndex, 'featureIndex', 0)
        .having((error) => error.field, 'field', 'geometry')
        .having((error) => error.reason, 'reason', reason);

import 'package:seismicity_pmtiles/src/decoder/seismicity_mvt_tile_decoder.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';
import 'package:test/test.dart';
import 'package:vector_tile/raw/raw_vector_tile.dart';

import '../support/seismicity_mvt_fixture_mutator.dart';
import '../support/seismicity_mvt_mutation.dart';

void main() {
  final catalog = buildSeismicityMvtFixtureCatalog();
  final valid = catalog.valid;
  final cases = <(String, List<int>, Matcher)>[
    (
      'invalid protobuf',
      corruption(catalog, 'truncation'),
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

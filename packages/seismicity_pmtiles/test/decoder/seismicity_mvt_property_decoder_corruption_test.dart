import 'package:seismicity_pmtiles/src/decoder/seismicity_mvt_property_decoder.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';
import 'package:test/test.dart';
import 'package:vector_tile/raw/raw_vector_tile.dart';

import '../support/seismicity_mvt_fixture_builder.dart';
import '../support/seismicity_mvt_fixture_mutator.dart';
import '../support/seismicity_mvt_mutation.dart';

typedef InvalidFeature = SeismicityPmTilesInvalidHypocenterFeatureException;

void main() {
  final catalog = buildSeismicityMvtFixtureCatalog();
  final fixtureCases = <(String, String, String)>[
    ('odd_tags', 'tags', 'odd_tag_count'),
    ('out_of_range_tags', 'origin_time_unix_ms', 'value_index_out_of_range'),
    ('repeated_tags', 'hypocenter_id', 'duplicate_property'),
    ('missing_required_property', 'hypocenter_id', 'missing_required_property'),
    ('unknown_key', 'unknown', 'unknown_property'),
    ('invalid_uuid', 'hypocenter_id', 'invalid_uuid'),
    ('wrong_scalar', 'magnitude', 'wrong_scalar_type'),
    ('multi_set_scalar', 'magnitude', 'invalid_scalar_cardinality'),
    ('empty_earthquake_event_id', 'earthquake_event_id', 'empty_string'),
    ('float32_overflow', 'magnitude', 'float32_overflow'),
  ];
  for (final (name, field, reason) in fixtureCases) {
    final bytes = catalog.corruptions.singleWhere((v) => v.name == name).bytes;
    test('rejects $name with source context', () {
      expect(() => decode(bytes), throwsA(invalid(field, reason)));
    });
  }

  final valid = catalog.valid;
  final directCases = <(String, List<int>, String, String)>[
    ('key index', retag(valid, [4, 0, 1, 1]), 'tags', 'key_index_out_of_range'),
    (
      'missing time',
      retag(valid, [0, 0, 2, 2, 3, 3]),
      'origin_time_unix_ms',
      'missing_required_property',
    ),
    (
      'non-canonical UUID',
      replace(
        valid,
        0,
        SeismicityFixtureScalar.string('00000000-0000-4000-8000-00000000000A'),
      ),
      'hypocenter_id',
      'invalid_uuid',
    ),
    (
      'unsafe time',
      replace(valid, 1, SeismicityFixtureScalar.double(1.5)),
      'origin_time_unix_ms',
      'unsafe_integer',
    ),
  ];
  for (final (name, bytes, field, reason) in directCases) {
    test('rejects $name with source context', () {
      expect(() => decode(bytes), throwsA(invalid(field, reason)));
    });
  }

  test('accepts present empty intensity and determination strings', () {
    final layer = VectorTile.fromBuffer(valid).layers.single;
    layer.keys.addAll(['max_intensity', 'determination_flag']);
    layer.values.add(SeismicityFixtureScalar.string('').raw);
    layer.features.single.tags.addAll([4, 4, 5, 4]);
    final properties = decode(
      createVectorTile(layers: [layer]).writeToBuffer(),
    );
    expect(
      [properties.maxIntensityUtf8, properties.determinationFlagUtf8],
      everyElement(isEmpty),
    );
  });
}

List<int> retag(List<int> bytes, List<int> tags) =>
    bytes.replaceMvtFeature(layerAt: 0, featureAt: 0, tags: tags);

List<int> replace(List<int> bytes, int at, SeismicityFixtureScalar scalar) =>
    bytes.replaceMvtValue(layerAt: 0, valueAt: at, value: scalar.raw);

SeismicityDecodedHypocenterProperties decode(List<int> bytes) {
  final layer = VectorTile.fromBuffer(bytes).layers.single;
  return const SeismicityMvtPropertyDecoder().decode(
    tags: layer.features.single.tags,
    keys: layer.keys,
    values: layer.values,
    tileId: 9,
    featureIndex: 3,
  );
}

Matcher invalid(String field, String reason) => isA<InvalidFeature>()
    .having((error) => error.tileId, 'tileId', 9)
    .having((error) => error.featureIndex, 'featureIndex', 3)
    .having((error) => error.field, 'field', field)
    .having((error) => error.reason, 'reason', reason);

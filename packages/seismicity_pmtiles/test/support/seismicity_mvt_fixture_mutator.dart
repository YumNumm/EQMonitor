import 'package:vector_tile/raw/raw_vector_tile.dart';
import 'seismicity_mvt_fixture_builder.dart';
import 'seismicity_mvt_mutation.dart';

({
  List<int> valid,
  List<({String name, List<int> bytes})> corruptions,
})
buildSeismicityMvtFixtureCatalog() {
  final valid = SeismicityMvtFixtureBuilder().build(
    layerName: 'hypocenters',
    layerVersion: 2,
    layerExtent: 4096,
    featureId: '1',
    featureTags: const [0, 0, 1, 1, 2, 2, 3, 3],
    featureType: VectorTile_GeomType.POINT,
    point: (x: 1, y: 1),
    keys: 'hypocenter_id origin_time_unix_ms magnitude earthquake_event_id'
        .split(
          ' ',
        ),
    values: [
      SeismicityFixtureScalar.string('00000000-0000-4000-8000-000000000001'),
      SeismicityFixtureScalar.signed('1700000000000'),
      SeismicityFixtureScalar.double(5.1),
      SeismicityFixtureScalar.string('event-1'),
    ],
  );
  final layer = VectorTile.fromBuffer(valid).layers.single;
  final missingVersion = layer.deepCopy()..clearVersion();
  final missingExtent = layer.deepCopy()..clearExtent();
  final unknownKey = layer.deepCopy()..keys[2] = 'unknown';
  List<int> replaceLayer(VectorTile_Layer replacement) =>
      valid.replaceMvtLayer(at: 0, layer: replacement);
  List<int> replaceFeature({
    List<int>? tags,
    VectorTile_GeomType? type,
  }) => valid.replaceMvtFeature(
    layerAt: 0,
    featureAt: 0,
    tags: tags,
    type: type,
  );
  List<int> replaceValue({
    required int at,
    required SeismicityFixtureScalar scalar,
  }) => valid.replaceMvtValue(layerAt: 0, valueAt: at, value: scalar.raw);
  final multiSetScalar = SeismicityFixtureScalar.multiple(
    first: SeismicityFixtureScalar.double(5.1),
    second: SeismicityFixtureScalar.boolean(value: true),
  );
  final names =
      'missing_layer duplicate_layer missing_version missing_extent '
              'odd_tags out_of_range_tags repeated_tags wrong_geometry '
              'missing_required_property unknown_key wrong_scalar '
              'multi_set_scalar empty_earthquake_event_id invalid_uuid '
              'float32_overflow truncation'
          .split(' ');
  final bytes = [
    valid.removeMvtLayer(at: 0),
    valid.appendMvtLayer(layer: layer),
    replaceLayer(missingVersion),
    replaceLayer(missingExtent),
    replaceFeature(tags: const [0, 0, 1, 1, 2, 2, 3, 3, 0]),
    replaceFeature(tags: const [0, 0, 1, 4, 2, 2, 3, 3]),
    replaceFeature(tags: const [0, 0, 1, 1, 2, 2, 3, 3, 0, 0]),
    replaceFeature(type: VectorTile_GeomType.LINESTRING),
    replaceFeature(tags: const [1, 1, 2, 2, 3, 3]),
    replaceLayer(unknownKey),
    replaceValue(at: 2, scalar: SeismicityFixtureScalar.string('wrong')),
    replaceValue(at: 2, scalar: multiSetScalar),
    replaceValue(at: 3, scalar: SeismicityFixtureScalar.string('')),
    replaceValue(at: 0, scalar: SeismicityFixtureScalar.string('invalid')),
    replaceValue(at: 2, scalar: SeismicityFixtureScalar.double(1e100)),
    valid.truncateMvtBytes(length: valid.length - 1),
  ];
  return (
    valid: valid,
    corruptions: [
      for (final (index, value) in bytes.indexed)
        (name: names[index], bytes: value),
    ],
  );
}

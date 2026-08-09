// Schema keys and raw protobuf JSON stay literal for deterministic assertions.
// ignore_for_file: lines_longer_than_80_chars
import 'package:test/test.dart';
import 'package:vector_tile/raw/raw_vector_tile.dart';
import 'seismicity_mvt_fixture_builder.dart';

void main() {
  test('schema-v1 Point fixture round-trips every raw scalar in order', () {
    final bytes = SeismicityMvtFixtureBuilder().build(
      layerName: 'hypocenters',
      layerVersion: 2,
      layerExtent: 4096,
      featureId: '7',
      featureTags: const [0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7],
      featureType: VectorTile_GeomType.POINT,
      point: (x: -3, y: 4),
      keys:
          'hypocenter_id origin_time_unix_ms magnitude depth_km max_intensity determination_flag earthquake_event_id geometry_clamped'
              .split(' '),
      values: [
        SeismicityFixtureScalar.string('h-1'),
        SeismicityFixtureScalar.signed('1700'),
        SeismicityFixtureScalar.float(5.5),
        SeismicityFixtureScalar.double(12.25),
        SeismicityFixtureScalar.unsigned('6'),
        SeismicityFixtureScalar.zigZagSigned('-2'),
        SeismicityFixtureScalar.string('e-1'),
        SeismicityFixtureScalar.boolean(value: false),
      ],
    );
    final layer = VectorTile.fromBuffer(bytes).layers.single;
    expect(VectorTile.fromBuffer(bytes).writeToBuffer(), bytes);
    expect(
      layer.writeToJson(),
      '{"1":"hypocenters","2":[{"1":"7","2":[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7],"3":1,"4":[9,5,8]}],"3":["hypocenter_id","origin_time_unix_ms","magnitude","depth_km","max_intensity","determination_flag","earthquake_event_id","geometry_clamped"],"4":[{"1":"h-1"},{"4":"1700"},{"2":5.5},{"3":12.25},{"5":"6"},{"6":"-2"},{"1":"e-1"},{"7":false}],"5":4096,"15":2}',
    );
    final multi = SeismicityFixtureScalar.multiple(
      first: SeismicityFixtureScalar.string('invalid'),
      second: SeismicityFixtureScalar.boolean(value: true),
    ).raw;
    expect((multi.stringValue, multi.boolValue), ('invalid', true));
  });
}

import 'dart:convert';

import 'package:seismicity_pmtiles/src/decoder/seismicity_mvt_property_decoder.dart';
import 'package:test/test.dart';
import 'package:vector_tile/raw/raw_vector_tile.dart';

void main() {
  const decoder = SeismicityMvtPropertyDecoder();

  test('decodes complete schema-v1 properties into canonical typed values', () {
    final properties = decoder.decode(
      tags: List.generate(16, (index) => index ~/ 2),
      keys: schemaKeys,
      values: [
        string('00112233-4455-4677-8899-aabbccddeeff'),
        VectorTile_Value.fromJson('{"4":"1700000000123"}'),
        number(1e-50),
        number(double.parse('-0')),
        string('5弱'),
        string('暫定'),
        string('20260812A'),
        boolean(value: false),
      ],
      tileId: 7,
      featureIndex: 2,
    );

    expect(
      properties.hypocenterId,
      orderedEquals([
        0x00,
        0x11,
        0x22,
        0x33,
        0x44,
        0x55,
        0x46,
        0x77,
        0x88,
        0x99,
        0xaa,
        0xbb,
        0xcc,
        0xdd,
        0xee,
        0xff,
      ]),
    );
    expect(properties.originTimeUnixMilliseconds, 1700000000123);
    expect(properties.magnitude, (canonicalValue: 1e-50, storageValue: 0.0));
    expect(properties.depthKm, (canonicalValue: 0.0, storageValue: 0.0));
    expect(properties.maxIntensityUtf8, orderedEquals(utf8.encode('5弱')));
    expect(
      properties.determinationFlagUtf8,
      orderedEquals(utf8.encode('暫定')),
    );
    expect(
      properties.earthquakeEventIdUtf8,
      orderedEquals(utf8.encode('20260812A')),
    );
    expect(properties.geometryClamped, isFalse);
  });

  test('preserves present empty strings and absent optional properties', () {
    final properties = decoder.decode(
      tags: const [0, 0, 1, 1, 4, 2, 5, 3],
      keys: schemaKeys,
      values: [
        string('00000000-0000-4000-8000-000000000001'),
        VectorTile_Value.fromJson('{"6":"0"}'),
        string(''),
        string(''),
      ],
      tileId: 8,
      featureIndex: 0,
    );

    expect(properties.originTimeUnixMilliseconds, 0);
    expect((properties.magnitude, properties.depthKm), (null, null));
    expect(properties.maxIntensityUtf8, isEmpty);
    expect(properties.determinationFlagUtf8, isEmpty);
    expect(properties.earthquakeEventIdUtf8, isNull);
    expect(properties.geometryClamped, isNull);
  });
}

final List<String> schemaKeys =
    'hypocenter_id origin_time_unix_ms magnitude depth_km max_intensity '
            'determination_flag earthquake_event_id geometry_clamped'
        .split(' ');

VectorTile_Value string(String value) =>
    createVectorTileValue(stringValue: value);

VectorTile_Value number(double value) =>
    createVectorTileValue(doubleValue: value);

VectorTile_Value boolean({required bool value}) =>
    createVectorTileValue(boolValue: value);

import 'dart:typed_data';

import 'package:seismicity_pmtiles/src/decoder/seismicity_decoded_hypocenter.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';
import 'package:test/test.dart';

void main() {
  final id = Uint8List.fromList(List.generate(16, (index) => index));

  test('retains one complete callback-local decoded row', () {
    final row = decoded(id: id, event: Uint8List.fromList([0x45]));

    expect((row.tileId, row.featureIndex), (7, 2));
    expect(row.hypocenterId, orderedEquals(id));
    expect(row.point, (globalX: 10, globalY: 20, longitude: 30, latitude: 40));
    expect(row.originTimeUnixMilliseconds, 1234);
    expect(row.magnitude, (canonicalValue: 1e-50, storageValue: 0.0));
    expect(row.depthKm, (canonicalValue: 0.0, storageValue: 0.0));
    expect(row.maxIntensityUtf8, isEmpty);
    expect(row.determinationFlagUtf8, isEmpty);
    expect(row.earthquakeEventIdUtf8, orderedEquals([0x45]));
    expect(row.geometryClamped, isFalse);
  });

  test('distinguishes missing optionals from present empty bytes', () {
    final missing = decoded(id: id);

    expect((missing.magnitude, missing.depthKm), (null, null));
    expect(missing.maxIntensityUtf8, isNull);
    expect(missing.determinationFlagUtf8, isNull);
    expect(missing.earthquakeEventIdUtf8, isNull);
    expect(missing.geometryClamped, isNull);
    final invalid = throwsA(isA<SeismicityPmTilesException>());
    expect(() => decoded(id: Uint8List(15)), invalid);
    expect(() => decoded(id: id, event: Uint8List(0)), invalid);
  });
}

SeismicityDecodedHypocenter decoded({
  required Uint8List id,
  Uint8List? event,
}) => SeismicityDecodedHypocenter(
  tileId: 7,
  featureIndex: 2,
  hypocenterId: id,
  point: (globalX: 10, globalY: 20, longitude: 30, latitude: 40),
  originTimeUnixMilliseconds: 1234,
  magnitude: event == null ? null : (canonicalValue: 1e-50, storageValue: 0.0),
  depthKm: event == null ? null : (canonicalValue: 0.0, storageValue: 0.0),
  maxIntensityUtf8: event == null ? null : Uint8List(0),
  determinationFlagUtf8: event == null ? null : Uint8List(0),
  earthquakeEventIdUtf8: event,
  geometryClamped: event == null ? null : false,
);

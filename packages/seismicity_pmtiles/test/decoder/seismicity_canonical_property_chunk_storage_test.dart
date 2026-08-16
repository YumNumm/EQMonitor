import 'dart:convert';
import 'dart:typed_data';

import 'package:seismicity_pmtiles/src/decoder/seismicity_canonical_property_chunk.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_decoded_hypocenter.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';
import 'package:test/test.dart';

void main() {
  test('keeps every canonical subcolumn aligned and exactly trimmed', () {
    final chunk = SeismicityCanonicalPropertyChunk(capacity: 2)
      ..add(row: decoded(index: 1, complete: true))
      ..add(row: decoded(index: 2, complete: false));

    expect((chunk.length, chunk.isFull), (2, true));
    final output = chunk.build();
    expect(output.fixed.globalXs, [10, 20]);
    expect(output.fixed.globalYs, [11, 21]);
    expect(output.fixed.magnitudes, [1.5, 0]);
    expect(output.fixed.magnitudeValidity, [1]);
    expect(output.fixed.depthsKm, [0, 0]);
    expect(output.fixed.depthValidity, [0]);
    expect(output.fixed.geometryClampedValues, [1]);
    expect(output.fixed.geometryClampedValidity, [1]);
    expect(output.strings.determinationFlag.dictionaryIndexes, [0, 0]);
    expect(output.strings.determinationFlag.validity, [1]);
    expect(output.strings.determinationFlag.dictionaryUtf8, utf8.encode('震源'));
    expect(output.strings.determinationFlag.dictionaryOffsets, [0, 6]);
    expect(output.strings.earthquakeEventId.dictionaryIndexes, [0, 0]);
    expect(output.strings.earthquakeEventId.validity, [1]);
    expect(output.strings.earthquakeEventId.dictionaryUtf8, utf8.encode('E1'));
    expect(output.strings.earthquakeEventId.dictionaryOffsets, [0, 2]);
    expect(
      () => chunk.add(row: decoded(index: 3, complete: false)),
      throwsA(isA<SeismicityPmTilesInvalidDescriptorException>()),
    );
    expect(chunk.length, 2);
  });

  test('builds one aligned empty sidecar', () {
    final chunk = SeismicityCanonicalPropertyChunk(capacity: 0);

    expect((chunk.length, chunk.isFull), (0, true));
    final output = chunk.build();
    expect(output.fixed.globalXs, isA<Int64List>());
    expect(output.fixed.globalXs, isEmpty);
    expect(output.strings.determinationFlag.dictionaryIndexes, isEmpty);
    expect(output.strings.determinationFlag.dictionaryOffsets, [0]);
    expect(output.strings.earthquakeEventId.dictionaryOffsets, [0]);
  });
}

SeismicityDecodedHypocenter decoded({
  required int index,
  required bool complete,
}) => SeismicityDecodedHypocenter(
  tileId: 1,
  featureIndex: index,
  hypocenterId: Uint8List(16),
  point: (
    globalX: index * 10,
    globalY: index * 10 + 1,
    longitude: 0,
    latitude: 0,
  ),
  originTimeUnixMilliseconds: index,
  magnitude: complete ? (canonicalValue: 1.5, storageValue: 1.5) : null,
  depthKm: null,
  maxIntensityUtf8: null,
  determinationFlagUtf8: complete
      ? Uint8List.fromList(utf8.encode('震源'))
      : null,
  earthquakeEventIdUtf8: complete
      ? Uint8List.fromList(utf8.encode('E1'))
      : null,
  geometryClamped: complete ? true : null,
);

import 'dart:convert';
import 'dart:typed_data';

import 'package:seismicity_pmtiles/src/decoder/seismicity_chunk_builder.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_decoded_hypocenter.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';
import 'package:test/test.dart';

void main() {
  test('composes aligned public columns and exact canonical matching', () {
    final complete = row(index: 0, complete: true);
    final missing = row(index: 1, complete: false);
    final builder = SeismicityChunkBuilder(capacity: 2)
      ..add(record: complete)
      ..add(record: missing);

    expect((builder.length, builder.isFull), (2, true));
    expect(
      builder.uuidEquals(rowIndex: 0, candidate: complete.hypocenterId),
      isTrue,
    );
    expect(builder.matches(localIndex: 0, record: complete), isTrue);
    expect(
      builder.matches(
        localIndex: 0,
        record: row(index: 0, complete: true, originTime: 99),
      ),
      isFalse,
    );
    expect(
      builder.matches(
        localIndex: 0,
        record: row(index: 0, complete: true, maxIntensity: '6弱'),
      ),
      isFalse,
    );
    expect(
      builder.matches(
        localIndex: 0,
        record: row(index: 0, complete: true, globalX: 99),
      ),
      isFalse,
    );

    final chunk = builder.build();
    expect(chunk.hypocenterIds, isA<Uint8List>());
    expect(chunk.latitudes, isA<Float64List>());
    expect(chunk.depthsKm, isA<Float32List>());
    expect(chunk.originTimeUnixMilliseconds, isA<Int64List>());
    expect(chunk.maxIntensityDictionaryIndexes, isA<Uint32List>());
    expect(chunk.hypocenterIds.length, 32);
    expect(chunk.latitudes, [35, 36]);
    expect(chunk.maxIntensityDictionaryIndexes, [0, 0]);
    expect(chunk.maxIntensityValidity, [1]);
    expect(chunk.maxIntensityDictionaryUtf8, utf8.encode('5強'));
    expect(chunk.maxIntensityDictionaryOffsets, [0, 4]);

    expect(
      () => builder.add(record: row(index: 2, complete: true)),
      throwsA(isA<SeismicityPmTilesInvalidDescriptorException>()),
    );
    expect((builder.length, builder.build().latitudes.length), (2, 2));
  });
}

SeismicityDecodedHypocenter row({
  required int index,
  required bool complete,
  int? originTime,
  String maxIntensity = '5強',
  int? globalX,
}) => SeismicityDecodedHypocenter(
  tileId: 1,
  featureIndex: index,
  hypocenterId: Uint8List.fromList(List.generate(16, (i) => index * 16 + i)),
  point: (
    globalX: globalX ?? index,
    globalY: index,
    longitude: 139 + index.toDouble(),
    latitude: 35 + index.toDouble(),
  ),
  originTimeUnixMilliseconds: originTime ?? 10 + index,
  magnitude: complete ? (canonicalValue: 5.1, storageValue: 5.1) : null,
  depthKm: complete ? (canonicalValue: 10.0, storageValue: 10.0) : null,
  maxIntensityUtf8: complete
      ? Uint8List.fromList(utf8.encode(maxIntensity))
      : null,
  determinationFlagUtf8: complete
      ? Uint8List.fromList(utf8.encode('震源'))
      : null,
  earthquakeEventIdUtf8: complete
      ? Uint8List.fromList(utf8.encode('E$index'))
      : null,
  geometryClamped: complete ? false : null,
);

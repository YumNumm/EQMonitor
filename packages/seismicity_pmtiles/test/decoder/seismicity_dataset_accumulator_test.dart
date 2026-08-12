import 'dart:convert';
import 'dart:typed_data';

import 'package:seismicity_pmtiles/src/decoder/seismicity_dataset_accumulator.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_decoded_hypocenter.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';
import 'package:test/test.dart';

void main() {
  test('deduplicates exact UUID rows across bounded chunks', () {
    final accumulator = SeismicityDatasetAccumulator(
      expectedUniqueCount: 3,
      chunkCapacity: 2,
    );
    final records = [row(id: 1), row(id: 2), row(id: 1), row(id: 3)];

    expect(records.map((record) => accumulator.add(record: record)), [
      true,
      true,
      false,
      true,
    ]);
    expect((accumulator.rawCount, accumulator.uniqueCount), (4, 3));
    final chunks = accumulator.buildChunks();
    expect(chunks.map((chunk) => chunk.latitudes.length), [2, 1]);
    expect(chunks.expand((chunk) => chunk.hypocenterIds), [
      ...records[0].hypocenterId,
      ...records[1].hypocenterId,
      ...records[3].hypocenterId,
    ]);
  });

  test('rejects every canonical payload conflict for one UUID', () {
    final conflicts = [
      row(id: 1, globalX: 2),
      row(id: 1, originTime: 2),
      row(id: 1, magnitude: 5.1000001),
      row(id: 1, depth: 11),
      row(id: 1, maxIntensity: '6弱'),
      row(id: 1, determination: '別'),
      row(id: 1, eventId: 'E2'),
      row(id: 1, clamped: true),
    ];
    for (final conflict in conflicts) {
      final accumulator = SeismicityDatasetAccumulator(
        expectedUniqueCount: 1,
        chunkCapacity: 1,
      )..add(record: row(id: 1));
      expect(
        () => accumulator.add(record: conflict),
        throwsA(isA<SeismicityPmTilesDuplicateConflictException>()),
      );
      expect((accumulator.rawCount, accumulator.uniqueCount), (1, 1));
    }
  });

  test('rejects a unique row beyond the descriptor count atomically', () {
    final accumulator = SeismicityDatasetAccumulator(
      expectedUniqueCount: 3,
      chunkCapacity: 2,
    )..add(record: row(id: 1))
     ..add(record: row(id: 2))
     ..add(record: row(id: 3));

    expect(
      () => accumulator.add(record: row(id: 4)),
      throwsA(isA<SeismicityPmTilesInvalidDescriptorException>()),
    );
    expect((accumulator.rawCount, accumulator.uniqueCount), (3, 3));
    expect(accumulator.buildChunks().map((chunk) => chunk.latitudes.length), [
      2,
      1,
    ]);
  });
}

SeismicityDecodedHypocenter row({
  required int id,
  int globalX = 1,
  int originTime = 1,
  double magnitude = 5.1,
  double depth = 10,
  String maxIntensity = '5強',
  String determination = '震源',
  String eventId = 'E1',
  bool clamped = false,
}) => SeismicityDecodedHypocenter(
  tileId: 1,
  featureIndex: id,
  hypocenterId: Uint8List(16)..[15] = id,
  point: (globalX: globalX, globalY: 1, longitude: 139, latitude: 35),
  originTimeUnixMilliseconds: originTime,
  magnitude: (canonicalValue: magnitude, storageValue: 5.099999904632568),
  depthKm: (canonicalValue: depth, storageValue: depth),
  maxIntensityUtf8: Uint8List.fromList(utf8.encode(maxIntensity)),
  determinationFlagUtf8: Uint8List.fromList(utf8.encode(determination)),
  earthquakeEventIdUtf8: Uint8List.fromList(utf8.encode(eventId)),
  geometryClamped: clamped,
);

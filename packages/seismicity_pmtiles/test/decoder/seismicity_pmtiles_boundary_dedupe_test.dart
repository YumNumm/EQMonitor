import 'dart:convert';
import 'dart:typed_data';

import 'package:seismicity_pmtiles/src/decoder/seismicity_dataset_accumulator.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_decoded_hypocenter.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_mvt_point_decoder.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';
import 'package:test/test.dart';

void main() {
  test('deduplicates adjacent and antimeridian boundary copies', () {
    final adjacent = accumulator()
      ..add(record: row(point: point(x: 0, localX: 4092)))
      ..add(record: row(point: point(x: 1, localX: -4)));
    final wrapped = accumulator()
      ..add(record: row(point: point(x: 0, localX: -4)))
      ..add(record: row(point: point(x: 3, localX: 4092)));

    expect((adjacent.rawCount, adjacent.uniqueCount), (2, 1));
    expect((wrapped.rawCount, wrapped.uniqueCount), (2, 1));
  });

  test('rejects every canonical geometry and property conflict', () {
    final conflicts = [
      (row(), row(point: point(x: 0, localX: 4091))),
      (row(), row(originTime: 2)),
      (row(), row(magnitude: 5.1000001)),
      (row(depth: null), row(depth: 0)),
      (row(maxIntensity: null), row(maxIntensity: '')),
      (row(determination: null), row(determination: '')),
      (row(eventId: null), row(eventId: 'E2')),
      (row(clamped: null), row(clamped: false)),
    ];

    for (final conflict in conflicts) {
      final value = accumulator()..add(record: conflict.$1);
      expect(
        () => value.add(record: conflict.$2),
        throwsA(isA<SeismicityPmTilesDuplicateConflictException>()),
      );
    }
  });
}

SeismicityDatasetAccumulator accumulator() => SeismicityDatasetAccumulator(
  expectedUniqueCount: 1,
  chunkCapacity: 1,
);

SeismicityMvtPoint point({required int x, required int localX}) =>
    const SeismicityMvtPointDecoder().decode(
      geometry: [9, (localX << 1) ^ (localX >> 63), 200],
      z: 2,
      x: x,
      y: 0,
      extent: 4096,
      tileId: 1,
      featureIndex: 0,
    );

SeismicityDecodedHypocenter row({
  int id = 1,
  SeismicityMvtPoint? point,
  int originTime = 1,
  double? magnitude = 5.1,
  double? depth = 10,
  String? maxIntensity = '5強',
  String? determination = '震源',
  String? eventId = 'E1',
  bool? clamped = true,
}) => SeismicityDecodedHypocenter(
  tileId: 1,
  featureIndex: id,
  hypocenterId: Uint8List(16)..[15] = id,
  point: point ?? (globalX: 1, globalY: 1, longitude: 139, latitude: 35),
  originTimeUnixMilliseconds: originTime,
  magnitude: magnitude == null
      ? null
      : (canonicalValue: magnitude, storageValue: 5.099999904632568),
  depthKm: depth == null ? null : (canonicalValue: depth, storageValue: depth),
  maxIntensityUtf8: bytes(maxIntensity),
  determinationFlagUtf8: bytes(determination),
  earthquakeEventIdUtf8: bytes(eventId),
  geometryClamped: clamped,
);

Uint8List? bytes(String? value) =>
    value == null ? null : Uint8List.fromList(utf8.encode(value));

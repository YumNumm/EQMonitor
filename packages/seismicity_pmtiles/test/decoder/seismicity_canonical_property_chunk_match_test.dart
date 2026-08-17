import 'dart:convert';
import 'dart:typed_data';

import 'package:seismicity_pmtiles/src/decoder/seismicity_canonical_property_chunk.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_decoded_hypocenter.dart';
import 'package:test/test.dart';

void main() {
  test('matches only exact canonical geometry and properties', () {
    final chunk = SeismicityCanonicalPropertyChunk(capacity: 1)
      ..add(row: row());

    expect(chunk.matches(localIndex: 0, record: row(depth: 0)), isTrue);
    final mismatches = [
      row(globalX: 9),
      row(globalY: 12),
      row(magnitude: 5.1000001),
      row(magnitude: null),
      row(depth: 1),
      row(depth: null),
      row(determination: '別'),
      row(determination: null),
      row(eventId: 'E2'),
      row(eventId: null),
      row(geometryClamped: true),
      row(geometryClamped: null),
    ];
    for (final mismatch in mismatches) {
      expect(chunk.matches(localIndex: 0, record: mismatch), isFalse);
    }
  });

  test('distinguishes absent values from present zero false and empty', () {
    final chunk = SeismicityCanonicalPropertyChunk(capacity: 1)
      ..add(row: absent());

    expect(chunk.matches(localIndex: 0, record: absent()), isTrue);
    for (final present in [
      absent(magnitude: 0),
      absent(depth: 0),
      absent(determination: ''),
      absent(eventId: 'E1'),
      absent(geometryClamped: false),
    ]) {
      expect(chunk.matches(localIndex: 0, record: present), isFalse);
    }
    final empty = SeismicityCanonicalPropertyChunk(capacity: 1)
      ..add(row: absent(determination: ''));
    expect(
      empty.matches(localIndex: 0, record: absent(determination: '')),
      isTrue,
    );
  });
}

SeismicityDecodedHypocenter row({
  int globalX = 10,
  int globalY = 11,
  double? magnitude = 5.1,
  double? depth = -0.0,
  String? determination = '震源',
  String? eventId = '地震E1',
  bool? geometryClamped = false,
}) => SeismicityDecodedHypocenter(
  tileId: 1,
  featureIndex: 0,
  hypocenterId: Uint8List(16),
  point: (globalX: globalX, globalY: globalY, longitude: 0, latitude: 0),
  originTimeUnixMilliseconds: 0,
  magnitude: magnitude == null
      ? null
      : (canonicalValue: magnitude, storageValue: 5.099999904632568),
  depthKm: depth == null ? null : (canonicalValue: depth, storageValue: 0),
  maxIntensityUtf8: null,
  determinationFlagUtf8: bytes(determination),
  earthquakeEventIdUtf8: bytes(eventId),
  geometryClamped: geometryClamped,
);

Uint8List? bytes(String? value) =>
    value == null ? null : Uint8List.fromList(utf8.encode(value));

SeismicityDecodedHypocenter absent({
  double? magnitude,
  double? depth,
  String? determination,
  String? eventId,
  bool? geometryClamped,
}) => row(
  magnitude: magnitude,
  depth: depth,
  determination: determination,
  eventId: eventId,
  geometryClamped: geometryClamped,
);

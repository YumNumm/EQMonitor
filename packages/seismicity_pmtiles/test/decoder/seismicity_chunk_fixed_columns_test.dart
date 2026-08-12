import 'dart:typed_data';

import 'package:seismicity_pmtiles/src/decoder/seismicity_chunk_fixed_columns.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_decoded_hypocenter.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_validity_bitmap.dart';
import 'package:test/test.dart';

void main() {
  final invalid = throwsA(
    isA<SeismicityPmTilesInvalidDescriptorException>(),
  );

  test('stores and trims exact public fixed columns', () {
    final first = decoded(index: 0, number: 0);
    final second = decoded(index: 1);
    final columns = SeismicityChunkFixedColumns(capacity: 2)..add(row: first);

    final trimmed = columns.build();
    expect(
      <int>[
        trimmed.hypocenterIds.length,
        trimmed.latitudes.length,
        trimmed.longitudes.length,
        trimmed.depthsKm.length,
        trimmed.depthValidity.length,
        trimmed.magnitudes.length,
        trimmed.magnitudeValidity.length,
        trimmed.originTimeUnixMilliseconds.length,
      ],
      [16, 1, 1, 1, 1, 1, 1, 1],
    );

    columns.add(row: second);
    expect((columns.length, columns.isFull), (2, true));
    final output = columns.build();
    expect(output.hypocenterIds, orderedEquals(List.generate(32, (i) => i)));
    expect(output.latitudes, isA<Float64List>());
    expect(output.longitudes, isA<Float64List>());
    expect(output.depthsKm, isA<Float32List>());
    expect(output.magnitudes, isA<Float32List>());
    expect(output.originTimeUnixMilliseconds, isA<Int64List>());
    expect(output.latitudes, [35, 36]);
    expect(output.longitudes, [139, 140]);
    expect(output.depthsKm.first, 0);
    expect(output.depthsKm.last.isNaN, isTrue);
    expect(output.magnitudes.first, 0);
    expect(output.magnitudes.last.isNaN, isTrue);
    for (final bitmap in [output.depthValidity, output.magnitudeValidity]) {
      expect(
        SeismicityValidityBitmap.isValid(bytes: bitmap, index: 0),
        isTrue,
      );
      expect(
        SeismicityValidityBitmap.isValid(bytes: bitmap, index: 1),
        isFalse,
      );
    }
    expect(output.originTimeUnixMilliseconds, [1000, 1001]);
    expect(() => columns.add(row: first), invalid);
  });

  test('requires a positive capacity', () {
    expect(() => SeismicityChunkFixedColumns(capacity: 0), invalid);
    expect(() => SeismicityChunkFixedColumns(capacity: -1), invalid);
  });

  test('compares UUID bytes and origin time independently', () {
    final stored = decoded(index: 0);
    final columns = SeismicityChunkFixedColumns(capacity: 1)..add(row: stored);

    expect(
      columns.uuidEquals(rowIndex: 0, candidate: stored.hypocenterId),
      isTrue,
    );
    expect(
      columns.uuidEquals(rowIndex: 0, candidate: Uint8List(16)),
      isFalse,
    );
    expect(
      columns.uuidEquals(rowIndex: 0, candidate: Uint8List(15)),
      isFalse,
    );
    expect(columns.originTimeEquals(rowIndex: 0, candidate: 1000), isTrue);
    expect(columns.originTimeEquals(rowIndex: 0, candidate: 1001), isFalse);
  });

  test('translates constructor and build allocation failures', () {
    for (final fail in allocationFailures) {
      expect(
        () => SeismicityChunkFixedColumns(
          capacity: 1,
          allocate: <T>(create) => fail(),
        ),
        invalid,
      );
      var calls = 0;
      final columns = SeismicityChunkFixedColumns(
        capacity: 1,
        allocate: <T>(create) {
          if (++calls == 2) fail();
          return create();
        },
      )..add(row: decoded(index: 0));
      expect(columns.build, invalid);
      expect(columns.build().latitudes, [35]);
    }
  });
}

final allocationFailures = <Never Function()>[
  () => throw const OutOfMemoryError(),
  () => throw RangeError('injected allocation failure'),
];

SeismicityDecodedHypocenter decoded({
  required int index,
  double? number,
}) => SeismicityDecodedHypocenter(
  tileId: 1,
  featureIndex: index,
  hypocenterId: Uint8List.fromList(List.generate(16, (i) => index * 16 + i)),
  point: (
    globalX: index,
    globalY: index,
    longitude: 139 + index.toDouble(),
    latitude: 35 + index.toDouble(),
  ),
  originTimeUnixMilliseconds: 1000 + index,
  magnitude: number == null
      ? null
      : (canonicalValue: number, storageValue: number),
  depthKm: number == null
      ? null
      : (canonicalValue: number, storageValue: number),
  maxIntensityUtf8: null,
  determinationFlagUtf8: null,
  earthquakeEventIdUtf8: null,
  geometryClamped: null,
);

import 'dart:typed_data';

import 'package:seismicity_pmtiles/src/decoder/seismicity_canonical_fixed_columns.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_decoded_hypocenter.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_validity_bitmap.dart';
import 'package:test/test.dart';

void main() {
  final invalid = throwsA(
    isA<SeismicityPmTilesInvalidDescriptorException>(),
  );

  test('stores exact canonical fixed columns and validity', () {
    final columns = SeismicityCanonicalFixedColumns(capacity: 3)
      ..add(
        row: decoded(
          index: 1,
          number: double.parse('-0.0'),
          geometryClamped: false,
        ),
      )
      ..add(row: decoded(index: 2, number: 2.5, geometryClamped: true))
      ..add(row: decoded(index: 3));

    expect((columns.length, columns.isFull), (3, true));
    final output = columns.build();
    expect(output.globalXs, isA<Int64List>());
    expect(output.globalYs, isA<Int64List>());
    expect(output.magnitudes, isA<Float64List>());
    expect(output.depthsKm, isA<Float64List>());
    expect(output.globalXs, [10, 20, 30]);
    expect(output.globalYs, [11, 21, 31]);
    expect(output.magnitudes, [0, 2.5, 0]);
    expect(output.depthsKm, [0, 2.5, 0]);
    expect(output.magnitudes.first.isNegative, isFalse);
    expect(output.depthsKm.first.isNegative, isFalse);
    expect(output.magnitudeValidity, [3]);
    expect(output.depthValidity, [3]);
    expect(output.geometryClampedValues, [2]);
    expect(output.geometryClampedValidity, [3]);
    expect(
      SeismicityValidityBitmap.isValid(
        bytes: output.geometryClampedValidity,
        index: 2,
      ),
      isFalse,
    );
  });

  test('rejects invalid capacity and additions after full', () {
    expect(() => SeismicityCanonicalFixedColumns(capacity: -1), invalid);
    expect(
      () => SeismicityCanonicalFixedColumns(capacity: 0x40000000),
      invalid,
    );
    final empty = SeismicityCanonicalFixedColumns(capacity: 0);
    expect((empty.length, empty.isFull), (0, true));
    expect(() => empty.add(row: decoded(index: 1)), invalid);
    final output = empty.build();
    expect(output.globalXs, isEmpty);
    expect(output.magnitudeValidity, isEmpty);
  });

  test('trims every typed column below capacity', () {
    final columns = SeismicityCanonicalFixedColumns(capacity: 10)
      ..add(row: decoded(index: 1));

    expect(columns.isFull, isFalse);
    final output = columns.build();
    expect(
      (
        globalXs: output.globalXs.length,
        globalYs: output.globalYs.length,
        magnitudes: output.magnitudes.length,
        magnitudeValidity: output.magnitudeValidity.length,
        depthsKm: output.depthsKm.length,
        depthValidity: output.depthValidity.length,
        geometryValues: output.geometryClampedValues.length,
        geometryValidity: output.geometryClampedValidity.length,
      ),
      (
        globalXs: 1,
        globalYs: 1,
        magnitudes: 1,
        magnitudeValidity: 1,
        depthsKm: 1,
        depthValidity: 1,
        geometryValues: 1,
        geometryValidity: 1,
      ),
    );
  });

  test('translates constructor allocation errors', () {
    for (final fail in allocationFailures) {
      expect(
        () => SeismicityCanonicalFixedColumns(
          capacity: 1,
          allocate: <T>(create) => fail(),
        ),
        invalid,
      );
    }
  });

  test('translates build allocation errors without changing rows', () {
    for (final fail in allocationFailures) {
      var failNextBuild = true;
      var allocationCount = 0;
      final columns = SeismicityCanonicalFixedColumns(
        capacity: 2,
        allocate: <T>(create) {
          allocationCount++;
          if (allocationCount > 1 && failNextBuild) {
            failNextBuild = false;
            fail();
          }
          return create();
        },
      )..add(row: decoded(index: 1));

      expect(columns.build, invalid);
      expect(columns.length, 1);
      expect(columns.build().globalXs, [10]);
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
  bool? geometryClamped,
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
  magnitude: number == null
      ? null
      : (canonicalValue: number, storageValue: number),
  depthKm: number == null
      ? null
      : (canonicalValue: number, storageValue: number),
  maxIntensityUtf8: null,
  determinationFlagUtf8: null,
  earthquakeEventIdUtf8: null,
  geometryClamped: geometryClamped,
);

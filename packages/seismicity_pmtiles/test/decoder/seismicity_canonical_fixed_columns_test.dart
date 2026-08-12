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
    final empty = SeismicityCanonicalFixedColumns(capacity: 0);
    expect((empty.length, empty.isFull), (0, true));
    expect(() => empty.add(row: decoded(index: 1)), invalid);
    final output = empty.build();
    expect(output.globalXs, isEmpty);
    expect(output.magnitudeValidity, isEmpty);
  });
}

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

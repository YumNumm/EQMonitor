import 'dart:typed_data';

import 'package:seismicity_pmtiles/seismicity_pmtiles.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_validity_bitmap.dart'
    show requiredByteLength, setValid;
import 'package:test/test.dart';

void main() {
  test('bitmap uses little bit order across byte boundaries', () {
    final bytes = Uint8List(2);
    for (final index in [0, 7, 8, 15]) {
      setValid(bytes: bytes, index: index);
      expect(
        SeismicityValidityBitmap.isValid(bytes: bytes, index: index),
        isTrue,
      );
    }
    expect(bytes, [0x81, 0x81]);
    expect(() => requiredByteLength(valueCount: -1), throwsCorruptArchive);
  });
}

final throwsCorruptArchive = throwsA(
  isA<SeismicityPmTilesCorruptArchiveException>(),
);

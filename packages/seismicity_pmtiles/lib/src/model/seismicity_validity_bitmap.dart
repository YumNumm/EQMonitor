import 'dart:typed_data';

import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';

int requiredByteLength({required int valueCount}) {
  if (valueCount < 0) {
    throw const SeismicityPmTilesException.corruptArchive(
      reason: 'A validity bitmap cannot represent a negative value count.',
    );
  }
  return (valueCount + 7) ~/ 8;
}

void setValid({required Uint8List bytes, required int index}) {
  bytes[index >> 3] |= 1 << (index & 7);
}

// The locked public API intentionally exposes bitmap reads as a namespace.
// ignore: avoid_classes_with_only_static_members
abstract final class SeismicityValidityBitmap {
  static bool isValid({required Uint8List bytes, required int index}) =>
      bytes[index >> 3] & (1 << (index & 7)) != 0;
}

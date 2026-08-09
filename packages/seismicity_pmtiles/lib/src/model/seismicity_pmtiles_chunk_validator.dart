import 'dart:typed_data';

import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_chunk.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_validity_bitmap.dart';

final class SeismicityPmTilesChunkValidator {
  const SeismicityPmTilesChunkValidator();

  void validate({required SeismicityPmTilesChunk chunk}) {
    final length = chunk.latitudes.length;
    final bitmapLength = requiredByteLength(valueCount: length);
    final expectedLengths = [
      length * 16,
      length,
      length,
      length,
      bitmapLength,
      length,
      bitmapLength,
      length,
      length,
      bitmapLength,
    ];
    final actualLengths = [
      chunk.hypocenterIds.length,
      chunk.latitudes.length,
      chunk.longitudes.length,
      chunk.depthsKm.length,
      chunk.depthValidity.length,
      chunk.magnitudes.length,
      chunk.magnitudeValidity.length,
      chunk.originTimeUnixMilliseconds.length,
      chunk.maxIntensityDictionaryIndexes.length,
      chunk.maxIntensityValidity.length,
    ];
    for (var index = 0; index < actualLengths.length; index++) {
      if (actualLengths[index] != expectedLengths[index]) {
        throw const SeismicityPmTilesException.corruptArchive(
          reason: 'A fixed-width chunk column has an invalid length.',
        );
      }
    }
    for (final bitmap in [
      chunk.depthValidity,
      chunk.magnitudeValidity,
      chunk.maxIntensityValidity,
    ]) {
      validateUnusedTail(bytes: bitmap, valueCount: length);
    }
    validateNullableNumeric(
      values: chunk.depthsKm,
      validity: chunk.depthValidity,
    );
    validateNullableNumeric(
      values: chunk.magnitudes,
      validity: chunk.magnitudeValidity,
    );
  }
}

void validateUnusedTail({required Uint8List bytes, required int valueCount}) {
  final usedBits = valueCount & 7;
  if (usedBits != 0 && bytes.last & (0xff << usedBits) != 0) {
    throw const SeismicityPmTilesException.corruptArchive(
      reason: 'A validity bitmap has nonzero unused tail bits.',
    );
  }
}

void validateNullableNumeric({
  required Float32List values,
  required Uint8List validity,
}) {
  for (var index = 0; index < values.length; index++) {
    final valid = SeismicityValidityBitmap.isValid(
      bytes: validity,
      index: index,
    );
    if (valid ? !values[index].isFinite : !values[index].isNaN) {
      throw const SeismicityPmTilesException.corruptArchive(
        reason: 'A nullable numeric value disagrees with its validity bit.',
      );
    }
  }
}

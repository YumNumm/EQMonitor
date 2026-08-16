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
    validateDictionary(chunk: chunk);
  }
}

void validateDictionary({required SeismicityPmTilesChunk chunk}) {
  final offsets = chunk.maxIntensityDictionaryOffsets;
  final utf8Length = chunk.maxIntensityDictionaryUtf8.length;
  if (offsets.isEmpty || offsets.first != 0) {
    throw const SeismicityPmTilesException.corruptArchive(
      reason: 'Dictionary offsets must start at zero.',
    );
  }
  var previous = 0;
  for (final offset in offsets) {
    if (offset < previous || offset > utf8Length) {
      throw const SeismicityPmTilesException.corruptArchive(
        reason: 'Dictionary offsets are unordered or out of range.',
      );
    }
    previous = offset;
  }
  if (previous != utf8Length) {
    throw const SeismicityPmTilesException.corruptArchive(
      reason: 'The terminal dictionary offset must equal its UTF-8 length.',
    );
  }
  final dictionaryLength = offsets.length - 1;
  for (var index = 0; index < chunk.latitudes.length; index++) {
    if (SeismicityValidityBitmap.isValid(
          bytes: chunk.maxIntensityValidity,
          index: index,
        ) &&
        chunk.maxIntensityDictionaryIndexes[index] >= dictionaryLength) {
      throw const SeismicityPmTilesException.corruptArchive(
        reason: 'A valid dictionary index is out of range.',
      );
    }
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

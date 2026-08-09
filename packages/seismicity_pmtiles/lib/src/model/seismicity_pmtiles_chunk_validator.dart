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
  }
}

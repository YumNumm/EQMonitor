import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'seismicity_pmtiles_chunk.freezed.dart';

@Freezed(equal: false)
abstract class SeismicityPmTilesChunk with _$SeismicityPmTilesChunk {
  const factory({
    required Uint8List hypocenterIds,
    required Float64List latitudes,
    required Float64List longitudes,
    required Float32List depthsKm,
    required Uint8List depthValidity,
    required Float32List magnitudes,
    required Uint8List magnitudeValidity,
    required Int64List originTimeUnixMilliseconds,
    required Uint32List maxIntensityDictionaryIndexes,
    required Uint8List maxIntensityValidity,
    required Uint8List maxIntensityDictionaryUtf8,
    required Uint32List maxIntensityDictionaryOffsets,
  }) = _SeismicityPmTilesChunk;
}

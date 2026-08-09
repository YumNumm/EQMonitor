import 'dart:typed_data';

import 'package:seismicity_pmtiles/seismicity_pmtiles.dart';
import 'package:test/test.dart';

void main() {
  test('columnar chunk preserves buffers without value equality', () {
    final hypocenterIds = Uint8List.fromList([
      0,
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9,
      10,
      11,
      12,
      13,
      14,
      15,
    ]);
    final latitudes = Float64List.fromList([35]);
    final longitudes = Float64List.fromList([139]);
    final depthsKm = Float32List.fromList([0]);
    final depthValidity = Uint8List.fromList([1]);
    final magnitudes = Float32List.fromList([double.nan]);
    final magnitudeValidity = Uint8List.fromList([0]);
    final originTimes = Int64List.fromList([1700000000000]);
    final intensityIndexes = Uint32List.fromList([4]);
    final intensityValidity = Uint8List.fromList([1]);
    final intensityUtf8 = Uint8List.fromList('01234'.codeUnits);
    final intensityOffsets = Uint32List.fromList([0, 1, 2, 3, 4, 5]);
    final chunk = SeismicityPmTilesChunk(
      hypocenterIds: hypocenterIds,
      latitudes: latitudes,
      longitudes: longitudes,
      depthsKm: depthsKm,
      depthValidity: depthValidity,
      magnitudes: magnitudes,
      magnitudeValidity: magnitudeValidity,
      originTimeUnixMilliseconds: originTimes,
      maxIntensityDictionaryIndexes: intensityIndexes,
      maxIntensityValidity: intensityValidity,
      maxIntensityDictionaryUtf8: intensityUtf8,
      maxIntensityDictionaryOffsets: intensityOffsets,
    );
    expect(chunk.hypocenterIds, same(hypocenterIds));
    expect(chunk.latitudes, same(latitudes));
    expect(chunk.longitudes, same(longitudes));
    expect(chunk.depthsKm, same(depthsKm));
    expect(chunk.depthValidity, same(depthValidity));
    expect(chunk.magnitudes, same(magnitudes));
    expect(chunk.magnitudeValidity, same(magnitudeValidity));
    expect(chunk.originTimeUnixMilliseconds, same(originTimes));
    expect(chunk.maxIntensityDictionaryIndexes, same(intensityIndexes));
    expect(chunk.maxIntensityValidity, same(intensityValidity));
    expect(chunk.maxIntensityDictionaryUtf8, same(intensityUtf8));
    expect(chunk.maxIntensityDictionaryOffsets, same(intensityOffsets));
    expect(chunk.depthsKm.single, 0);
    expect(chunk.magnitudes.single.isNaN, isTrue);
    expect(chunk.maxIntensityDictionaryIndexes.single, 4);
    expect(chunk, isNot(chunk.copyWith()));
  });
}

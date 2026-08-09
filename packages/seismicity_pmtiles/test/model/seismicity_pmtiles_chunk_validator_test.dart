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

  test('accepts an exact columnar chunk', () {
    expect(
      () =>
          const SeismicityPmTilesChunkValidator().validate(chunk: validChunk()),
      returnsNormally,
    );
  });

  test('rejects every mismatched fixed-width column and bitmap', () {
    final valid = validChunk();
    final malformed = [
      valid.copyWith(hypocenterIds: Uint8List(31)),
      valid.copyWith(latitudes: Float64List(1)),
      valid.copyWith(longitudes: Float64List(1)),
      valid.copyWith(depthsKm: Float32List(1)),
      valid.copyWith(depthValidity: Uint8List(0)),
      valid.copyWith(magnitudes: Float32List(1)),
      valid.copyWith(magnitudeValidity: Uint8List(0)),
      valid.copyWith(originTimeUnixMilliseconds: Int64List(1)),
      valid.copyWith(maxIntensityDictionaryIndexes: Uint32List(1)),
      valid.copyWith(maxIntensityValidity: Uint8List(0)),
    ];
    malformed.forEach(expectCorrupt);
  });

  test('rejects tail bits and invalid numeric validity pairs', () {
    final valid = validChunk();
    final malformed = [
      valid.copyWith(depthValidity: Uint8List.fromList([5])),
      valid.copyWith(magnitudeValidity: Uint8List.fromList([5])),
      valid.copyWith(maxIntensityValidity: Uint8List.fromList([5])),
      for (final value in [
        double.nan,
        double.infinity,
        double.negativeInfinity,
      ])
        valid.copyWith(depthsKm: Float32List.fromList([value, double.nan])),
      valid.copyWith(
        depthsKm: Float32List.fromList([0, double.nan]),
        depthValidity: Uint8List(1),
      ),
      for (final value in [
        double.nan,
        double.infinity,
        double.negativeInfinity,
      ])
        valid.copyWith(magnitudes: Float32List.fromList([value, double.nan])),
      valid.copyWith(
        magnitudes: Float32List.fromList([0, double.nan]),
        magnitudeValidity: Uint8List(1),
      ),
    ];
    malformed.forEach(expectCorrupt);
  });
}

void expectCorrupt(SeismicityPmTilesChunk chunk) => expect(
  () => const SeismicityPmTilesChunkValidator().validate(chunk: chunk),
  throwsCorruptArchive,
);

final Matcher throwsCorruptArchive = throwsA(
  isA<SeismicityPmTilesCorruptArchiveException>(),
);

SeismicityPmTilesChunk validChunk() => SeismicityPmTilesChunk(
  hypocenterIds: Uint8List(32),
  latitudes: Float64List.fromList([35, 36]),
  longitudes: Float64List.fromList([139, 140]),
  depthsKm: Float32List.fromList([10, double.nan]),
  depthValidity: Uint8List.fromList([1]),
  magnitudes: Float32List.fromList([5, double.nan]),
  magnitudeValidity: Uint8List.fromList([1]),
  originTimeUnixMilliseconds: Int64List.fromList([1, 2]),
  maxIntensityDictionaryIndexes: Uint32List.fromList([0, 999]),
  maxIntensityValidity: Uint8List.fromList([1]),
  maxIntensityDictionaryUtf8: Uint8List.fromList([52]),
  maxIntensityDictionaryOffsets: Uint32List.fromList([0, 1]),
);

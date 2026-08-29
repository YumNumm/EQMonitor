import 'dart:io';
import 'dart:typed_data';

import 'package:pmtiles_v3/pmtiles_v3.dart';
import 'package:pmtiles_v3/src/archive/pmtiles_v3_compression_decoder.dart';
import 'package:test/test.dart';

void main() {
  const decoder = PmTilesV3CompressionDecoder();

  for (final compression in [
    PmTilesV3CompressionDecoder.none,
    PmTilesV3CompressionDecoder.gzipCompression,
  ]) {
    final label = compression == PmTilesV3CompressionDecoder.none
        ? 'none'
        : 'gzip';
    final payload = Uint8List.fromList([10, 20, 30]);
    final encoded = compression == PmTilesV3CompressionDecoder.none
        ? payload
        : Uint8List.fromList(gzip.encode(payload));

    test('$label accepts encoded and decoded N-1/N/N+1 boundaries', () {
      for (final encodedLimit in [encoded.length, encoded.length + 1]) {
        for (final decodedLimit in [payload.length, payload.length + 1]) {
          expect(
            decodeTile(
              decoder: decoder,
              encoded: encoded,
              compression: compression,
              maxEncodedBytes: encodedLimit,
              maxDecodedBytes: decodedLimit,
            ),
            orderedEquals(payload),
          );
        }
      }

      expect(
        () => decodeTile(
          decoder: decoder,
          encoded: encoded,
          compression: compression,
          maxEncodedBytes: encoded.length,
          maxDecodedBytes: payload.length - 1,
        ),
        throwsA(
          isA<PmTilesV3ResourceLimitExceededException>().having(
            (exception) => (exception.resource, exception.actual),
            'resource and actual',
            (PmTilesV3Resource.tileDecoded, payload.length),
          ),
        ),
      );

      expect(
        () => decodeTile(
          decoder: decoder,
          encoded: encoded,
          compression: compression,
          maxEncodedBytes: encoded.length - 1,
          maxDecodedBytes: payload.length,
        ),
        throwsA(
          isA<PmTilesV3ResourceLimitExceededException>().having(
            (exception) => (exception.resource, exception.actual),
            'resource and actual',
            (PmTilesV3Resource.tileEncoded, encoded.length),
          ),
        ),
      );
    });
  }
}

Uint8List decodeTile({
  required PmTilesV3CompressionDecoder decoder,
  required Uint8List encoded,
  required int compression,
  required int maxEncodedBytes,
  required int maxDecodedBytes,
}) => decoder.decodeBounded(
  bytes: encoded,
  compression: compression,
  maxEncodedBytes: maxEncodedBytes,
  maxDecodedBytes: maxDecodedBytes,
  encodedResource: PmTilesV3Resource.tileEncoded,
  decodedResource: PmTilesV3Resource.tileDecoded,
);

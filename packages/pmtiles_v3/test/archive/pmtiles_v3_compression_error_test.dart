import 'dart:typed_data';

import 'package:pmtiles_v3/pmtiles_v3.dart';
import 'package:pmtiles_v3/src/archive/pmtiles_v3_compression_decoder.dart';
import 'package:test/test.dart';

void main() {
  test('malformed gzip remains corruptArchive and exposes no codec error', () {
    const rawMarker = 'raw-gzip-marker';

    expect(
      () => const PmTilesV3CompressionDecoder().decodeBounded(
        bytes: Uint8List.fromList(rawMarker.codeUnits),
        compression: PmTilesV3CompressionDecoder.gzipCompression,
        maxEncodedBytes: 1024,
        maxDecodedBytes: 1024,
        encodedResource: PmTilesV3Resource.directoryEncoded,
        decodedResource: PmTilesV3Resource.directoryDecoded,
      ),
      throwsA(
        isA<PmTilesV3CorruptArchiveException>().having(
          (exception) => exception.toString(),
          'safe diagnostic',
          isNot(contains(rawMarker)),
        ),
      ),
    );
  });
}

import 'dart:io';
import 'dart:typed_data';

import 'package:pmtiles_v3/src/model/pmtiles_v3_exception.dart';

final class PmTilesV3CompressionDecoder {
  const PmTilesV3CompressionDecoder();

  static const none = 1;
  static const gzipCompression = 2;

  void validateSupported({required int compression}) {
    if (compression != none && compression != gzipCompression) {
      throw PmTilesV3Exception.unsupportedCompression(
        compression: compression,
      );
    }
  }

  Uint8List decode({required Uint8List bytes, required int compression}) {
    validateSupported(compression: compression);
    if (compression == none) {
      return Uint8List.fromList(bytes);
    }
    try {
      return Uint8List.fromList(gzip.decode(bytes));
    } on FormatException catch (error) {
      throw PmTilesV3Exception.corruptArchive(
        reason: 'Invalid gzip-compressed PMTiles content: ${error.message}',
      );
    }
  }
}

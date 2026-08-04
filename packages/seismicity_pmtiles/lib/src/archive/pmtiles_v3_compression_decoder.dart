import 'dart:io';
import 'dart:typed_data';

import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';

final class PmTilesV3CompressionDecoder {
  const PmTilesV3CompressionDecoder();

  static const none = 1;
  static const gzipCompression = 2;

  void validateSupported({required int compression}) {
    if (compression != none && compression != gzipCompression) {
      throw SeismicityPmTilesException.unsupportedCompression(
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
      throw SeismicityPmTilesException.corruptArchive(
        reason: 'Invalid gzip-compressed PMTiles content: ${error.message}',
      );
    }
  }
}

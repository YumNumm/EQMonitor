import 'dart:io';
import 'dart:typed_data';

import 'package:pmtiles_v3/src/archive/pmtiles_v3_bounded_bytes_sink.dart';
import 'package:pmtiles_v3/src/model/pmtiles_v3_exception.dart';

final class PmTilesV3CompressionDecoder {
  const new();

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
    } on FormatException {
      throw const PmTilesV3Exception.corruptArchive(
        reason: 'Invalid gzip-compressed PMTiles content.',
      );
    }
  }

  Uint8List decodeBounded({
    required Uint8List bytes,
    required int compression,
    required int maxEncodedBytes,
    required int maxDecodedBytes,
    required PmTilesV3Resource encodedResource,
    required PmTilesV3Resource decodedResource,
  }) {
    validateSupported(compression: compression);
    validateLength(
      length: bytes.length,
      maxBytes: maxEncodedBytes,
      resource: encodedResource,
    );
    if (compression == none) {
      validateLength(
        length: bytes.length,
        maxBytes: maxDecodedBytes,
        resource: decodedResource,
      );
      return Uint8List.fromList(bytes);
    }
    final output = PmTilesV3BoundedBytesSink(
      maxBytes: maxDecodedBytes,
      resource: decodedResource,
    );
    try {
      final conversion = gzip.decoder.startChunkedConversion(output);
      conversion
        ..add(bytes)
        ..close();
      return output.takeBytes();
    } on PmTilesV3ResourceLimitExceededException {
      rethrow;
    } on FormatException {
      throw const PmTilesV3Exception.corruptArchive(
        reason: 'Invalid gzip-compressed PMTiles content.',
      );
    }
  }

  void validateLength({
    required int length,
    required int maxBytes,
    required PmTilesV3Resource resource,
  }) {
    if (maxBytes < 0) {
      throw ArgumentError.value(maxBytes, 'maxBytes');
    }
    if (length > maxBytes) {
      throw PmTilesV3Exception.resourceLimitExceeded(
        resource: resource,
        limitBytes: maxBytes,
        actualBytes: length,
      );
    }
  }
}

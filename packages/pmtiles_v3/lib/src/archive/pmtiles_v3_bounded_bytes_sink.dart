import 'dart:typed_data';

import 'package:pmtiles_v3/src/model/pmtiles_v3_exception.dart';

/// gzip decoderが渡すchunkを、byte budgetを超える前に拒否する同期sink。
final class PmTilesV3BoundedBytesSink implements Sink<List<int>> {
  PmTilesV3BoundedBytesSink({
    required this.maxBytes,
    required this.resource,
  }) {
    if (maxBytes < 0) {
      throw ArgumentError.value(maxBytes, 'maxBytes');
    }
  }

  final int maxBytes;
  final PmTilesV3Resource resource;
  final _bytes = BytesBuilder(copy: false);
  var _byteLength = 0;
  var _isClosed = false;

  @override
  void add(List<int> chunk) {
    if (_isClosed) {
      throw StateError('Cannot add bytes after the sink is closed.');
    }
    if (chunk.length > maxBytes - _byteLength) {
      throw PmTilesV3Exception.resourceLimitExceeded(
        resource: resource,
        limit: maxBytes,
        actual: _byteLength + chunk.length,
      );
    }
    _bytes.add(chunk);
    _byteLength += chunk.length;
  }

  @override
  void close() {
    _isClosed = true;
  }

  Uint8List takeBytes() {
    if (!_isClosed) {
      throw StateError('Cannot take bytes before the sink is closed.');
    }
    return _bytes.takeBytes();
  }
}

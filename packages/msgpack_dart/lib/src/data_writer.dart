part of msgpack_dart;

final int _kScratchSizeInitial = 64;
final int _kScratchSizeRegular = 1024;

class DataWriter {
  Uint8List? _scratchBuffer;
  ByteData? _scratchData;
  int _scratchOffset = 0;

  void writeUint8(int i) {
    _ensureSize(1);
    _scratchData?.setUint8(_scratchOffset, i);
    _scratchOffset += 1;
  }

  void writeInt8(int i) {
    _ensureSize(1);
    _scratchData?.setInt8(_scratchOffset, i);
    _scratchOffset += 1;
  }

  void writeUint16(int i, [Endian endian = Endian.big]) {
    _ensureSize(2);
    _scratchData?.setUint16(_scratchOffset, i, endian);
    _scratchOffset += 2;
  }

  void writeInt16(int i, [Endian endian = Endian.big]) {
    _ensureSize(2);
    _scratchData?.setInt16(_scratchOffset, i, endian);
    _scratchOffset += 2;
  }

  void writeUint32(int i, [Endian endian = Endian.big]) {
    _ensureSize(4);
    _scratchData?.setUint32(_scratchOffset, i, endian);
    _scratchOffset += 4;
  }

  void writeInt32(int i, [Endian endian = Endian.big]) {
    _ensureSize(4);
    _scratchData?.setInt32(_scratchOffset, i, endian);
    _scratchOffset += 4;
  }

  void writeUint64(int i, [Endian endian = Endian.big]) {
    _ensureSize(8);
    _scratchData?.setUint64(_scratchOffset, i, endian);
    _scratchOffset += 8;
  }

  void writeInt64(int i, [Endian endian = Endian.big]) {
    _ensureSize(8);
    _scratchData?.setInt64(_scratchOffset, i, endian);
    _scratchOffset += 8;
  }

  void writeFloat32(double f, [Endian endian = Endian.big]) {
    _ensureSize(4);
    _scratchData?.setFloat32(_scratchOffset, f, endian);
    _scratchOffset += 4;
  }

  void writeFloat64(double f, [Endian endian = Endian.big]) {
    _ensureSize(8);
    _scratchData?.setFloat64(_scratchOffset, f, endian);
    _scratchOffset += 8;
  }

  // The list may be retained until takeBytes is called
  void writeBytes(List<int> bytes) {
    final length = bytes.length;
    if (length == 0) {
      return;
    }
    _ensureSize(length);
    if (_scratchOffset == 0) {
      // we can add it directly
      _builder.add(bytes);
    } else {
      // there is enough room in _scratchBuffer, otherwise _ensureSize
      // would have added _scratchBuffer to _builder and _scratchOffset would
      // be 0
      if (bytes is Uint8List) {
        _scratchBuffer?.setRange(
            _scratchOffset, _scratchOffset + length, bytes);
      } else {
        for (int i = 0; i < length; i++) {
          _scratchBuffer?[_scratchOffset + i] = bytes[i];
        }
      }
      _scratchOffset += length;
    }
  }

  Uint8List takeBytes() {
    if (_builder.isEmpty) {
      // Just take scratch data
      final res = Uint8List.view(
        _scratchBuffer!.buffer,
        _scratchBuffer!.offsetInBytes,
        _scratchOffset,
      );
      _scratchOffset = 0;
      _scratchBuffer = null;
      _scratchData = null;
      return res;
    } else {
      _appendScratchBuffer();
      return _builder.takeBytes();
    }
  }

  void _ensureSize(int size) {
    if (_scratchBuffer == null) {
      // start with small scratch buffer, expand to regular later if needed
      _scratchBuffer = Uint8List(_kScratchSizeInitial);
      _scratchData =
          ByteData.view(_scratchBuffer!.buffer, _scratchBuffer!.offsetInBytes);
    }
    final remaining = _scratchBuffer!.length - _scratchOffset;
    if (remaining < size) {
      _appendScratchBuffer();
    }
  }

  void _appendScratchBuffer() {
    if (_scratchOffset > 0) {
      if (_builder.isEmpty) {
        // We're still on small scratch buffer, move it to _builder
        // and create regular one
        _builder.add(Uint8List.view(
          _scratchBuffer!.buffer,
          _scratchBuffer!.offsetInBytes,
          _scratchOffset,
        ));
        _scratchBuffer = Uint8List(_kScratchSizeRegular);
        _scratchData = ByteData.view(
            _scratchBuffer!.buffer, _scratchBuffer!.offsetInBytes);
      } else {
        _builder.add(
          Uint8List.fromList(
            Uint8List.view(
              _scratchBuffer!.buffer,
              _scratchBuffer!.offsetInBytes,
              _scratchOffset,
            ),
          ),
        );
      }
      _scratchOffset = 0;
    }
  }

  final _builder = BytesBuilder(copy: false);
}

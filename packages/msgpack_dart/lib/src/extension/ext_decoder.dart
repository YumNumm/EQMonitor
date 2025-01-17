part of msgpack_dart;

class ExtTimeStampDecoder implements ExtDecoder {
  @override
  dynamic decodeObject(int extType, Uint8List list) {
    if (extType == 0xFF) {
      if (list.lengthInBytes == 4) {
        final sec = ByteData.view(list.buffer, list.offsetInBytes).getUint32(0);

        return DateTime.fromMillisecondsSinceEpoch(sec * 1000, isUtc: true);
      }
      if (list.lengthInBytes == 8) {
        // 30bit unsigned int: nano seconds
        final data =
            ByteData.view(list.buffer, list.offsetInBytes).getUint64(0);
        final nanoSec = data >> 34;
        final sec = data & 0x3fffffff;
        return DateTime.fromMicrosecondsSinceEpoch(sec * 1000 + nanoSec,
            isUtc: true);
      }
    }
    if (extType == 0x12) {
      final data = ByteData.view(list.buffer, list.offsetInBytes);
      final nanoSec = data.getUint32(0);
      return DateTime.fromMicrosecondsSinceEpoch(nanoSec, isUtc: true);
    }
    throw FormatError('Invalid list length: ${list.lengthInBytes}');
  }
}

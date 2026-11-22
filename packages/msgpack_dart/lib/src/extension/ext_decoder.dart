// ignore_for_file: use_string_in_part_of_directives

part of msgpack_dart;

class ExtTimeStampDecoder implements ExtDecoder {
  @override
  dynamic decodeObject(int extType, Uint8List list) {
    if (extType == 0xFF) {
      final data = ByteData.view(list.buffer, list.offsetInBytes);
      final (seconds, nanoseconds) = switch (list.lengthInBytes) {
        4 => (data.getUint32(0), 0),
        // timestamp 64: 上位30bitがナノ秒、下位34bitが秒。
        // ナノ秒の最上位bitが立つと getUint64 は負数を返すため論理シフトする。
        8 => (data.getUint64(0) & 0x3ffffffff, data.getUint64(0) >>> 34),
        12 => (data.getInt64(4), data.getUint32(0)),
        _ => throw FormatError('Invalid list length: ${list.lengthInBytes}'),
      };
      return DateTime.fromMicrosecondsSinceEpoch(
        seconds * Duration.microsecondsPerSecond + nanoseconds ~/ 1000,
        isUtc: true,
      );
    }
    if (extType == 0x12) {
      final data = ByteData.view(list.buffer, list.offsetInBytes);
      final nanoSec = data.getUint32(0);
      return DateTime.fromMicrosecondsSinceEpoch(nanoSec, isUtc: true);
    }
    throw FormatError('Invalid list length: ${list.lengthInBytes}');
  }
}

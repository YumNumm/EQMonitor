import 'dart:typed_data';

import 'package:msgpack_dart/msgpack_dart.dart';

class const ReplayTimestampEncoder() implements ExtEncoder {
  static const _jstOffset = Duration(hours: 9);

  // msgpack_dart は負の ext type を拒否するため、timestamp の -1 を符号なしの 1 byte で渡す。
  static const _timestampExtType = 0xFF;

  @override
  int extTypeForObject(dynamic object) => object is DateTime
      ? _timestampExtType
      : throw ArgumentError.value(object, 'object', 'Unsupported type');

  // 秒ちょうどの時刻は timestamp 32 に収まるが、KyoshinEewViewer が書く形式に合わせて常に timestamp 64 で書く。
  @override
  Uint8List encodeObject(dynamic object) {
    final wallClock = (object as DateTime).toUtc().add(_jstOffset);
    final micros = wallClock.microsecondsSinceEpoch;
    final seconds = micros ~/ Duration.microsecondsPerSecond;
    final nanoseconds = micros.remainder(Duration.microsecondsPerSecond) * 1000;
    final data = ByteData(8)
      ..setUint32(0, (nanoseconds << 2) | (seconds >>> 32))
      ..setUint32(4, seconds & 0xFFFFFFFF);
    return data.buffer.asUint8List();
  }
}

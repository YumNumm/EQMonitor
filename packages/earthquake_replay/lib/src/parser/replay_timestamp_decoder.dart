import 'dart:typed_data';

import 'package:msgpack_dart/msgpack_dart.dart';

/// EQRP は KyoshinEewViewer に合わせ、JST の壁時計を UTC として timestamp に格納する。
/// 読み込み時に 9 時間戻し、実際の時刻（UTC）として扱えるようにする。
class ReplayTimestampDecoder implements ExtDecoder {
  static const _jstOffset = Duration(hours: 9);

  final _timestampDecoder = ExtTimeStampDecoder();

  @override
  dynamic decodeObject(int extType, Uint8List data) {
    final value = _timestampDecoder.decodeObject(extType, data);
    return value is DateTime ? value.subtract(_jstOffset) : value;
  }
}

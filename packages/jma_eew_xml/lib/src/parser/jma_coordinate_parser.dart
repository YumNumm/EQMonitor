import 'package:jma_eew_xml/src/model/jma_coordinate.dart';

/// ISO 6709 の `±緯度±経度[±高さ]/` を読む。緯度・経度は整数部の桁数で度・度分・度分秒を判別する。
final class const JmaCoordinateParser() {
  static const _plus = 0x2B;
  static const _minus = 0x2D;
  static const _slash = 0x2F;
  static const _dot = 0x2E;

  JmaCoordinate? parse(String value, {required String? datum}) {
    final text = value.trim();
    if (text.isEmpty) {
      return null;
    }
    final parts = <String>[];
    var start = -1;
    for (var i = 0; i < text.length; i++) {
      final c = text.codeUnitAt(i);
      if (c == _plus || c == _minus || c == _slash) {
        if (start >= 0) {
          parts.add(text.substring(start, i));
        }
        start = c == _slash ? -1 : i;
      }
    }
    if (start >= 0) {
      parts.add(text.substring(start));
    }
    if (parts.length < 2 || parts.length > 3) {
      throw FormatException('座標の書式が正しくありません', value);
    }
    final latitude = _angle(parts[0], degreeDigits: 2);
    final longitude = _angle(parts[1], degreeDigits: 3);
    final height = parts.length == 3 ? _height(parts[2]) : null;
    if (latitude == null || longitude == null) {
      throw FormatException('座標の書式が正しくありません', value);
    }
    return JmaCoordinate(
      latitude: latitude,
      longitude: longitude,
      height: height,
      datum: datum,
    );
  }

  double? _angle(String part, {required int degreeDigits}) {
    final sign = part.codeUnitAt(0) == _minus ? -1 : 1;
    final body = part.substring(1);
    final dot = body.indexOf(String.fromCharCode(_dot));
    final integerDigits = dot < 0 ? body.length : dot;
    final number = double.tryParse(body);
    if (number == null) {
      return null;
    }
    if (integerDigits == degreeDigits) {
      return sign * number;
    }
    if (integerDigits == degreeDigits + 2) {
      final degrees = (number / 100).truncateToDouble();
      return sign * (degrees + (number - degrees * 100) / 60);
    }
    if (integerDigits == degreeDigits + 4) {
      final degrees = (number / 10000).truncateToDouble();
      final rest = number - degrees * 10000;
      final minutes = (rest / 100).truncateToDouble();
      return sign * (degrees + minutes / 60 + (rest - minutes * 100) / 3600);
    }
    return null;
  }

  int? _height(String part) {
    final value = double.tryParse(part);
    if (value == null) {
      throw FormatException('高さの書式が正しくありません', part);
    }
    return value.round();
  }
}

import 'package:jma_eew_xml/src/parser/jma_xml_text_decoder.dart';

/// `YYYY-MM-DDThh:mm:ss±hh:mm` を部分文字列を作らずに読む。それ以外の書式は [DateTime.tryParse] に任せる。
final class const JmaDateTimeParser() {
  static const _zero = 0x30;
  static const _plus = 0x2B;
  static const _minus = 0x2D;
  static const _upperZ = 0x5A;
  static const _dot = 0x2E;

  DateTime? parse(String source, int start, int end) {
    var s = start;
    var e = end;
    while (s < e && JmaXmlTextDecoder.isWhitespace(source.codeUnitAt(s))) {
      s++;
    }
    while (e > s && JmaXmlTextDecoder.isWhitespace(source.codeUnitAt(e - 1))) {
      e--;
    }
    return _parseFixed(source, s, e) ??
        DateTime.tryParse(source.substring(s, e))?.toUtc();
  }

  DateTime? _parseFixed(String source, int s, int e) {
    if (e - s < 20) {
      return null;
    }
    final year = _digits(source, s, 4);
    final month = _digits(source, s + 5, 2);
    final day = _digits(source, s + 8, 2);
    final hour = _digits(source, s + 11, 2);
    final minute = _digits(source, s + 14, 2);
    final second = _digits(source, s + 17, 2);
    if (year < 0 ||
        month < 0 ||
        day < 0 ||
        hour < 0 ||
        minute < 0 ||
        second < 0 ||
        source.codeUnitAt(s + 4) != _minus ||
        source.codeUnitAt(s + 7) != _minus ||
        source.codeUnitAt(s + 10) != 0x54 ||
        source.codeUnitAt(s + 13) != 0x3A ||
        source.codeUnitAt(s + 16) != 0x3A) {
      return null;
    }
    var i = s + 19;
    if (source.codeUnitAt(i) == _dot) {
      return null;
    }
    final zone = source.codeUnitAt(i);
    var offsetMinutes = 0;
    if (zone == _upperZ) {
      i++;
    } else if (zone == _plus || zone == _minus) {
      if (e - i != 6 || source.codeUnitAt(i + 3) != 0x3A) {
        return null;
      }
      final offsetHour = _digits(source, i + 1, 2);
      final offsetMinute = _digits(source, i + 4, 2);
      if (offsetHour < 0 || offsetMinute < 0) {
        return null;
      }
      offsetMinutes = offsetHour * 60 + offsetMinute;
      if (zone == _plus) {
        offsetMinutes = -offsetMinutes;
      }
      i += 6;
    } else {
      return null;
    }
    if (i != e) {
      return null;
    }
    return DateTime.utc(year, month, day, hour, minute + offsetMinutes, second);
  }

  int _digits(String source, int start, int count) {
    var value = 0;
    for (var k = 0; k < count; k++) {
      final d = source.codeUnitAt(start + k) - _zero;
      if (d < 0 || d > 9) {
        return -1;
      }
      value = value * 10 + d;
    }
    return value;
  }
}

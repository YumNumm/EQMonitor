import 'package:intl/intl.dart';
import 'package:kyoshin_monitor_api/src/util/jst.dart';

/// タイムゾーン指定子 (`Z` または `±HH:MM` / `±HHMM`) を検出する。
final _timeZoneDesignator = RegExp(r'([zZ]|[+-]\d{2}:?\d{2})$');

/// 文字列からDateTime型に変換
DateTime? dateTimeOrNullFromString(String? value) {
  if (value == null) {
    return null;
  }
  try {
    return dateTimeFromString(value);
  } on FormatException {
    return null;
  }
}

/// 文字列からDateTime型に変換する。
///
/// 強震モニタ / 長周期地震動モニタの Web API は `2026/08/19 00:17:30` のように
/// **タイムゾーン指定のない JST** を返す。素の [DateTime.parse] はこれを端末の
/// ローカル時刻として解釈してしまうため、指定子が無い場合は JST を補って
/// 絶対時刻として解釈する。
///
/// 既にタイムゾーン指定子を持つ文字列はそのまま [DateTime.parse] に渡す。
DateTime dateTimeFromString(String value) {
  final normalized = value.replaceAll('/', '-');
  // 時刻部を持たない文字列にオフセットを付けると parse できないため除外する。
  if (!normalized.contains(':') || _timeZoneDesignator.hasMatch(normalized)) {
    return DateTime.parse(normalized);
  }
  return DateTime.parse('$normalized+09:00');
}

/// DateTime型から文字列に変換
String? dateTimeOrNullToString(DateTime? value) =>
    value != null ? dateTimeToString(value) : null;

/// [DateTime] を Web API と同じ JST の壁時計文字列に変換する。
String dateTimeToString(DateTime value) =>
    DateFormat('yyyy/MM/dd HH:mm:ss').format(value.toJst());

/// 文字列からdouble型に変換
double? doubleOrNullFromString(String? value) =>
    value != null ? double.tryParse(value) : null;

/// double型から文字列に変換
String? doubleOrNullToString(double? value) => value?.toString();

/// 文字列からint型に変換
int? intFromString(String? value) => value != null ? int.tryParse(value) : null;

/// int型から文字列に変換
String? intToString(int? value) => value?.toString();

/// 動的な値からbool値を解析する
bool? boolFromDynamic(dynamic value) {
  if (value == null) {
    return null;
  }
  if (value is bool) {
    return value;
  }
  if (value is String) {
    return value.toLowerCase() == 'true' || value == '1';
  }
  if (value is num) {
    return value == 1;
  }
  return null;
}

/// 文字列から深さを解析する
int? depthFromString(String? value) {
  if (value == null) {
    return null;
  }
  return int.tryParse(value.replaceAll('km', ''));
}

/// 深さを文字列に変換
String? depthToString(int? value) {
  if (value == null) {
    return null;
  }
  return '${value}km';
}

/// 文字列から発生時間を解析する
DateTime? originTimeFromString(String? value) {
  if (value == null) {
    return null;
  }
  try {
    final year = int.parse(value.substring(0, 4));
    final month = int.parse(value.substring(4, 6));
    final day = int.parse(value.substring(6, 8));
    final hour = int.parse(value.substring(8, 10));
    final minute = int.parse(value.substring(10, 12));
    final second = int.parse(value.substring(12, 14));
    return DateTime(year, month, day, hour, minute, second);
  } on Object catch (_) {
    return null;
  }
}

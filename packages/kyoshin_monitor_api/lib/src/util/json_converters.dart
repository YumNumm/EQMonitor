import 'package:intl/intl.dart';

/// 文字列からDateTime型に変換
DateTime? dateTimeOrNullFromString(String? value) =>
    value != null ? dateTimeFromString(value) : null;

DateTime dateTimeFromString(String value) =>
    DateTime.parse(value.replaceAll('/', '-'));

/// DateTime型から文字列に変換
String? dateTimeOrNullToString(DateTime? value) =>
    value != null ? dateTimeToString(value) : null;

String dateTimeToString(DateTime value) =>
    DateFormat('yyyy/MM/dd HH:mm:ss').format(value);

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
  } on FormatException catch (_) {
    return null;
  }
}

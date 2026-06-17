import 'package:freezed_annotation/freezed_annotation.dart';

part 'date.freezed.dart';

@Freezed(toJson: false, fromJson: false)
abstract class Date with _$Date {
  const factory Date({
    required int year,
    required int month,
    required int day,
  }) = _Date;

  const Date._();

  factory Date.fromJson(dynamic json) {
    if (json is String) {
      return Date.parse(json);
    }
    throw CheckedFromJsonException(
      {'value': json},
      'value',
      'Date',
      'Expected a String in yyyy-MM-dd format, got ${json.runtimeType}',
    );
  }

  factory Date.parse(String dateString) {
    final match = RegExp(r'^(\d{4})-(\d{2})-(\d{2})$').firstMatch(dateString);
    if (match == null) {
      throw FormatException('Invalid date format: $dateString');
    }
    return Date(
      year: int.parse(match.group(1)!),
      month: int.parse(match.group(2)!),
      day: int.parse(match.group(3)!),
    );
  }

  factory Date.fromDateTime(DateTime dateTime) =>
      Date(year: dateTime.year, month: dateTime.month, day: dateTime.day);

  String toJson() => toString();

  DateTime toDateTime() => DateTime.utc(year, month, day);

  @override
  String toString() =>
      '${year.toString().padLeft(4, '0')}-'
      '${month.toString().padLeft(2, '0')}-'
      '${day.toString().padLeft(2, '0')}';
}

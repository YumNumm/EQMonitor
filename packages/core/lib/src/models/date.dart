import 'package:freezed_annotation/freezed_annotation.dart';

part 'date.freezed.dart';
part 'date.g.dart';

@freezed
abstract class Date with _$Date {
  const factory Date({
    required int year,
    required int month,
    required int day,
  }) = _Date;

  factory Date.fromJson(Map<String, dynamic> json) => _$DateFromJson(json);

  factory Date.fromDateTime(DateTime dateTime) =>
      Date(year: dateTime.year, month: dateTime.month, day: dateTime.day);
}

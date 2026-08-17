import 'package:freezed_annotation/freezed_annotation.dart';

part 'month.freezed.dart';
part 'month.g.dart';

@freezed
abstract class Month with _$Month {
  const factory({
    required int year,
    required int month,
  }) = _Month;

  factory fromJson(Map<String, dynamic> json) => _$MonthFromJson(json);

  factory fromDateTime(DateTime dateTime) =>
      Month(year: dateTime.year, month: dateTime.month);
}

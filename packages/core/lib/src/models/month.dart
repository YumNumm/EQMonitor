import 'package:freezed_annotation/freezed_annotation.dart';

part 'month.freezed.dart';
part 'month.g.dart';

@freezed
abstract class Month with _$Month {
  const factory Month({
    required int year,
    required int month,
  }) = _Month;

  factory Month.fromJson(Map<String, dynamic> json) => _$MonthFromJson(json);

  factory Month.fromDateTime(DateTime dateTime) =>
      Month(year: dateTime.year, month: dateTime.month);
}

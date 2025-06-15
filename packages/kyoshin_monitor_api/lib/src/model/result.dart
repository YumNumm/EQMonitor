import 'package:freezed_annotation/freezed_annotation.dart';

part 'result.freezed.dart';
part 'result.g.dart';

@freezed
abstract class Result with _$Result {
  const factory Result({required String? status, required String? message}) =
      _Result;

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);
}

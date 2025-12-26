import 'package:freezed_annotation/freezed_annotation.dart';

part 'code_name.freezed.dart';
part 'code_name.g.dart';

/// コードと名前のペア
@freezed
abstract class CodeName with _$CodeName {
  const factory CodeName({
    required String code,
    required String name,
  }) = _CodeName;

  factory CodeName.fromJson(Map<String, dynamic> json) =>
      _$CodeNameFromJson(json);
}

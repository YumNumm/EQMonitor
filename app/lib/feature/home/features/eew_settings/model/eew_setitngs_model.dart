import 'package:freezed_annotation/freezed_annotation.dart';

part 'eew_setitngs_model.freezed.dart';
part 'eew_setitngs_model.g.dart';

@freezed
class EewSetitngs with _$EewSetitngs {
  const factory EewSetitngs({
    @Default(false) bool showCalculatedRegionIntensity,
    @Default(false) bool showCalculatedCityIntensity,
  }) = _EewSetitngs;

  factory EewSetitngs.fromJson(Map<String, dynamic> json) =>
    _$EewSetitngsFromJson(json);
}

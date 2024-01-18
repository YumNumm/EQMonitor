import 'package:freezed_annotation/freezed_annotation.dart';

part 'common.freezed.dart';
part 'common.g.dart';

@freezed
class ParameterRegion with _$ParameterRegion {
  const factory ParameterRegion({
    required String code,
    required String name,
    required String kana,
  }) = _ParameterRegion;

  factory ParameterRegion.fromJson(Map<String, dynamic> json) =>
      _$ParameterRegionFromJson(json);
}

@freezed
class ParameterCity with _$ParameterCity {
  const factory ParameterCity({
    required String code,
    required String name,
    required String kana,
  }) = _ParameterCity;

  factory ParameterCity.fromJson(Map<String, dynamic> json) =>
      _$ParameterCityFromJson(json);
}

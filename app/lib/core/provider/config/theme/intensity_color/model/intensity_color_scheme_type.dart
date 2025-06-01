import 'package:freezed_annotation/freezed_annotation.dart';

part 'intensity_color_scheme_type.freezed.dart';
part 'intensity_color_scheme_type.g.dart';

@freezed
class IntensityColorSchemeType with _$IntensityColorSchemeType {
  const factory IntensityColorSchemeType.predefined({
    required PredefinedScheme scheme,
  }) = _Predefined;

  const factory IntensityColorSchemeType.custom() = _Custom;

  factory IntensityColorSchemeType.fromJson(Map<String, dynamic> json) =>
      _$IntensityColorSchemeTypeFromJson(json);
}

enum PredefinedScheme {
  eqmonitor,
  jma,
  earthQuickly,
  nhk,
}
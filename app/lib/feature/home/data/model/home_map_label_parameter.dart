import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_map_label_parameter.freezed.dart';
part 'home_map_label_parameter.g.dart';

@freezed
abstract class HomeMapLabelParameter with _$HomeMapLabelParameter {
  const factory HomeMapLabelParameter({
    @Default(false) bool showRegionLabel,
    @Default(false) bool showCityLabel,
    @Default(5.0) double regionLabelMinZoom,
    @Default(9.0) double cityLabelMinZoom,
    @Default(14) double regionTextSize,
    @Default(12) double cityTextSize,
    @Default(1.0) double textHaloWidth,
  }) = _HomeMapLabelParameter;

  factory HomeMapLabelParameter.fromJson(Map<String, dynamic> json) =>
      _$HomeMapLabelParameterFromJson(json);
}

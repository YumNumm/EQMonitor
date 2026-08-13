import 'package:eqmonitor/core/util/converter/color_converter.dart';
import 'package:material_ui/material_ui.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'intensity_text_color.freezed.dart';
part 'intensity_text_color.g.dart';

@Freezed(unionKey: 'type')
sealed class IntensityTextColor with _$IntensityTextColor {
  @FreezedUnionValue('auto')
  const factory IntensityTextColor.auto() = IntensityTextColorAuto;

  @FreezedUnionValue('manual')
  const factory IntensityTextColor.manual({
    @ColorJsonConverter() required Color color,
  }) = IntensityTextColorManual;

  factory IntensityTextColor.fromJson(Map<String, dynamic> json) =>
      _$IntensityTextColorFromJson(json);
}

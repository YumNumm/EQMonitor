import 'package:eqmonitor/core/theme/model/intensity_color_entry.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'intensity_colors.freezed.dart';
part 'intensity_colors.g.dart';

@freezed
abstract class IntensityColors with _$IntensityColors {
  const factory IntensityColors({
    required IntensityColorEntry unknown,
    required IntensityColorEntry zero,
    required IntensityColorEntry one,
    required IntensityColorEntry two,
    required IntensityColorEntry three,
    required IntensityColorEntry four,
    required IntensityColorEntry fiveLower,
    required IntensityColorEntry fiveUpper,
    required IntensityColorEntry sixLower,
    required IntensityColorEntry sixUpper,
    required IntensityColorEntry seven,
  }) = _IntensityColors;

  factory IntensityColors.fromJson(Map<String, dynamic> json) =>
      _$IntensityColorsFromJson(json);
}

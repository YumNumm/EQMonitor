import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/theme/model/intensity_color_entry.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'estimated_intensity_colors.freezed.dart';
part 'estimated_intensity_colors.g.dart';

@freezed
abstract class EstimatedIntensityColors with _$EstimatedIntensityColors {
  const factory EstimatedIntensityColors({
    required IntensityColorEntry four,
    required IntensityColorEntry fiveLower,
    required IntensityColorEntry fiveUpper,
    required IntensityColorEntry sixLower,
    required IntensityColorEntry sixUpper,
    required IntensityColorEntry seven,
  }) = _EstimatedIntensityColors;

  factory EstimatedIntensityColors.fromJson(Map<String, dynamic> json) =>
      _$EstimatedIntensityColorsFromJson(json);
}

extension EstimatedIntensityColorsLookup on EstimatedIntensityColors {
  IntensityColorEntry fromJmaIntensity(JmaIntensity intensity) =>
      switch (intensity) {
        JmaIntensity.four => four,
        JmaIntensity.fiveUnknown => fiveLower,
        JmaIntensity.fiveLower => fiveLower,
        JmaIntensity.fiveUpper => fiveUpper,
        JmaIntensity.sixUnknown => sixLower,
        JmaIntensity.sixLower => sixLower,
        JmaIntensity.sixUpper => sixUpper,
        JmaIntensity.seven => seven,
        _ => four, // fallback for intensities below 4
      };
}

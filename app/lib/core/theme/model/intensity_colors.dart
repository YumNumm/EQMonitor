import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/core/theme/model/intensity_color_entry.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'intensity_colors.freezed.dart';
part 'intensity_colors.g.dart';

@freezed
abstract class IntensityColors with _$IntensityColors {
  const factory({
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

  factory fromJson(Map<String, dynamic> json) =>
      _$IntensityColorsFromJson(json);
}

extension IntensityColorsLookup on IntensityColors {
  IntensityColorEntry fromJmaIntensity(JmaIntensity intensity) =>
      switch (intensity) {
        JmaIntensity.unknown => unknown,
        JmaIntensity.zero => zero,
        JmaIntensity.one => one,
        JmaIntensity.two => two,
        JmaIntensity.three => three,
        JmaIntensity.four => four,
        JmaIntensity.fiveUnknown => fiveLower,
        JmaIntensity.fiveLower => fiveLower,
        JmaIntensity.fiveUpper => fiveUpper,
        JmaIntensity.sixUnknown => sixLower,
        JmaIntensity.sixLower => sixLower,
        JmaIntensity.sixUpper => sixUpper,
        JmaIntensity.seven => seven,
      };

  IntensityColorEntry fromJmaLpgmIntensity(JmaLpgmIntensity intensity) =>
      switch (intensity) {
        JmaLpgmIntensity.unknown => unknown,
        JmaLpgmIntensity.zero => zero,
        JmaLpgmIntensity.one => three,
        JmaLpgmIntensity.two => four,
        JmaLpgmIntensity.three => fiveLower,
        JmaLpgmIntensity.four => seven,
      };
}

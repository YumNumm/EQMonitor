import 'package:eqmonitor/feature/earthquake/intensity_color/model/intensity_color_model.dart';
import 'package:eqmonitor/feature/earthquake/intensity_color/model/intensity_color_scheme_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'intensity_color_configuration.freezed.dart';
part 'intensity_color_configuration.g.dart';

@freezed
abstract class IntensityColorConfiguration with _$IntensityColorConfiguration {
  const factory IntensityColorConfiguration({
    required PredefinedScheme schemeType,
    IntensityColorModel? customColors,
  }) = _IntensityColorConfiguration;

  factory IntensityColorConfiguration.fromJson(Map<String, dynamic> json) =>
      _$IntensityColorConfigurationFromJson(json);
}

extension IntensityColorConfigurationExt on IntensityColorConfiguration {
  IntensityColorModel get colorModel {
    if (customColors != null) {
      return customColors!;
    } else {
      return switch (schemeType) {
        PredefinedScheme.eqmonitor => IntensityColorModel.eqmonitor(),
        PredefinedScheme.jma => IntensityColorModel.jma(),
        PredefinedScheme.earthQuickly => IntensityColorModel.earthQuickly(),
        PredefinedScheme.nhk => IntensityColorModel.nhk(),
      };
    }
  }
}

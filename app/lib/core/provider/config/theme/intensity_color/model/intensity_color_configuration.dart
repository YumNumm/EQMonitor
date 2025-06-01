import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_scheme_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'intensity_color_configuration.freezed.dart';
part 'intensity_color_configuration.g.dart';

@freezed
class IntensityColorConfiguration with _$IntensityColorConfiguration {
  const factory IntensityColorConfiguration({
    required IntensityColorSchemeType schemeType,
    IntensityColorModel? customColors,
  }) = _IntensityColorConfiguration;

  factory IntensityColorConfiguration.fromJson(Map<String, dynamic> json) =>
      _$IntensityColorConfigurationFromJson(json);
}

extension IntensityColorConfigurationExt on IntensityColorConfiguration {
  IntensityColorModel get colorModel {
    return schemeType.when(
      predefined: (scheme) => switch (scheme) {
        PredefinedScheme.eqmonitor => IntensityColorModel.eqmonitor(),
        PredefinedScheme.jma => IntensityColorModel.jma(),
        PredefinedScheme.earthQuickly => IntensityColorModel.earthQuickly(),
        PredefinedScheme.nhk => IntensityColorModel.nhk(),
      },
      custom: () => customColors ?? IntensityColorModel.eqmonitor(),
    );
  }
}
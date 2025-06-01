// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'intensity_color_configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_IntensityColorConfiguration _$IntensityColorConfigurationFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_IntensityColorConfiguration',
  json,
  ($checkedConvert) {
    final val = _IntensityColorConfiguration(
      schemeType: $checkedConvert(
        'scheme_type',
        (v) => IntensityColorSchemeType.fromJson(v as Map<String, dynamic>),
      ),
      customColors: $checkedConvert(
        'custom_colors',
        (v) => v == null
            ? null
            : IntensityColorModel.fromJson(v as Map<String, dynamic>),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'schemeType': 'scheme_type',
    'customColors': 'custom_colors',
  },
);

Map<String, dynamic> _$IntensityColorConfigurationToJson(
  _IntensityColorConfiguration instance,
) => <String, dynamic>{
  'scheme_type': instance.schemeType,
  'custom_colors': instance.customColors,
};

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'intensity_color_configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$IntensityColorConfigurationImpl _$$IntensityColorConfigurationImplFromJson(Map<String, dynamic> json) =>
    _$IntensityColorConfigurationImpl(
      schemeType: IntensityColorSchemeType.fromJson(json['schemeType'] as Map<String, dynamic>),
      customColors: json['customColors'] == null ? null : IntensityColorModel.fromJson(json['customColors'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$IntensityColorConfigurationImplToJson(_$IntensityColorConfigurationImpl instance) => <String, dynamic>{
      'schemeType': instance.schemeType.toJson(),
      'customColors': instance.customColors?.toJson(),
    };
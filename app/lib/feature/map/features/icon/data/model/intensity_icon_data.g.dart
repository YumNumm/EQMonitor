// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'intensity_icon_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_IntensityIconData _$IntensityIconDataFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_IntensityIconData',
      json,
      ($checkedConvert) {
        final val = _IntensityIconData(
          jmaIntensity: $checkedConvert(
            'jma_intensity',
            (v) =>
                IntensityIconJmaIntensity.fromJson(v as Map<String, dynamic>),
          ),
          lpgmIntensity: $checkedConvert(
            'lpgm_intensity',
            (v) => IntensityIconJmaLpgmIntensity.fromJson(
              v as Map<String, dynamic>,
            ),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'jmaIntensity': 'jma_intensity',
        'lpgmIntensity': 'lpgm_intensity',
      },
    );

Map<String, dynamic> _$IntensityIconDataToJson(_IntensityIconData instance) =>
    <String, dynamic>{
      'jma_intensity': instance.jmaIntensity,
      'lpgm_intensity': instance.lpgmIntensity,
    };

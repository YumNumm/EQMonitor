// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'city_max_intensity_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CityMaxIntensityResponse _$CityMaxIntensityResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_CityMaxIntensityResponse', json, ($checkedConvert) {
  final val = _CityMaxIntensityResponse(
    responseAt: $checkedConvert(
      'response_at',
      (v) => v == null ? null : DateTime.parse(v as String),
    ),
    items: $checkedConvert(
      'items',
      (v) => (v as List<dynamic>)
          .map((e) => CityMaxIntensityItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
  );
  return val;
}, fieldKeyMap: const {'responseAt': 'response_at'});

Map<String, dynamic> _$CityMaxIntensityResponseToJson(
  _CityMaxIntensityResponse instance,
) => <String, dynamic>{
  'response_at': instance.responseAt?.toIso8601String(),
  'items': instance.items,
};

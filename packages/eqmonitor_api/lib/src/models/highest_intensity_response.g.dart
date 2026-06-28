// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'highest_intensity_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HighestIntensityResponse _$HighestIntensityResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_HighestIntensityResponse', json, ($checkedConvert) {
  final val = _HighestIntensityResponse(
    items: $checkedConvert(
      'items',
      (v) => (v as List<dynamic>)
          .map((e) => HighestIntensityItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$HighestIntensityResponseToJson(
  _HighestIntensityResponse instance,
) => <String, dynamic>{'items': instance.items};

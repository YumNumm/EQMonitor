// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'earthquake_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EarthquakeDetailResponse _$EarthquakeDetailResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_EarthquakeDetailResponse', json, ($checkedConvert) {
  final val = _EarthquakeDetailResponse(
    earthquake: $checkedConvert(
      'earthquake',
      (v) => Earthquake.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$EarthquakeDetailResponseToJson(
  _EarthquakeDetailResponse instance,
) => <String, dynamic>{'earthquake': instance.earthquake};

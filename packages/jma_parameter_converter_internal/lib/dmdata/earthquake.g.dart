// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'earthquake.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EarthquakeParameter _$EarthquakeParameterFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_EarthquakeParameter', json, ($checkedConvert) {
      final val = _EarthquakeParameter(
        responseId: $checkedConvert('responseId', (v) => v as String),
        responseTime: $checkedConvert(
          'responseTime',
          (v) => DateTime.parse(v as String),
        ),
        status: $checkedConvert('status', (v) => v as String),
        changeTime: $checkedConvert(
          'changeTime',
          (v) => DateTime.parse(v as String),
        ),
        version: $checkedConvert('version', (v) => v as String),
        items: $checkedConvert(
          'items',
          (v) => (v as List<dynamic>)
              .map(
                (e) =>
                    EarthquakeParmaeterItem.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$EarthquakeParameterToJson(
  _EarthquakeParameter instance,
) => <String, dynamic>{
  'responseId': instance.responseId,
  'responseTime': instance.responseTime.toIso8601String(),
  'status': instance.status,
  'changeTime': instance.changeTime.toIso8601String(),
  'version': instance.version,
  'items': instance.items,
};

_EarthquakeParmaeterItem _$EarthquakeParmaeterItemFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_EarthquakeParmaeterItem', json, ($checkedConvert) {
  final val = _EarthquakeParmaeterItem(
    region: $checkedConvert(
      'region',
      (v) => ParameterRegion.fromJson(v as Map<String, dynamic>),
    ),
    city: $checkedConvert(
      'city',
      (v) => ParameterCity.fromJson(v as Map<String, dynamic>),
    ),
    noCode: $checkedConvert('noCode', (v) => v as String),
    code: $checkedConvert('code', (v) => v as String),
    name: $checkedConvert('name', (v) => v as String),
    kana: $checkedConvert('kana', (v) => v as String),
    status: $checkedConvert('status', (v) => v as String),
    owner: $checkedConvert('owner', (v) => v as String),
    latitude: $checkedConvert('latitude', (v) => doubleFromString(v as String)),
    longitude: $checkedConvert(
      'longitude',
      (v) => doubleFromString(v as String),
    ),
  );
  return val;
});

Map<String, dynamic> _$EarthquakeParmaeterItemToJson(
  _EarthquakeParmaeterItem instance,
) => <String, dynamic>{
  'region': instance.region,
  'city': instance.city,
  'noCode': instance.noCode,
  'code': instance.code,
  'name': instance.name,
  'kana': instance.kana,
  'status': instance.status,
  'owner': instance.owner,
  'latitude': doubleToString(instance.latitude),
  'longitude': doubleToString(instance.longitude),
};

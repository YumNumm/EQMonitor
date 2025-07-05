// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'tsunami.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TsunamiParameter _$TsunamiParameterFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_TsunamiParameter', json, ($checkedConvert) {
      final val = _TsunamiParameter(
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
                (e) => TsunamiParameterItem.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$TsunamiParameterToJson(_TsunamiParameter instance) =>
    <String, dynamic>{
      'responseId': instance.responseId,
      'responseTime': instance.responseTime.toIso8601String(),
      'status': instance.status,
      'changeTime': instance.changeTime.toIso8601String(),
      'version': instance.version,
      'items': instance.items,
    };

_TsunamiParameterItem _$TsunamiParameterItemFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_TsunamiParameterItem', json, ($checkedConvert) {
  final val = _TsunamiParameterItem(
    area: $checkedConvert('area', (v) => v as String?),
    prefecture: $checkedConvert('prefecture', (v) => v as String),
    code: $checkedConvert('code', (v) => v as String),
    name: $checkedConvert('name', (v) => v as String),
    kana: $checkedConvert('kana', (v) => v as String),
    owner: $checkedConvert('owner', (v) => v as String),
    latitude: $checkedConvert('latitude', (v) => doubleFromString(v as String)),
    longitude: $checkedConvert(
      'longitude',
      (v) => doubleFromString(v as String),
    ),
  );
  return val;
});

Map<String, dynamic> _$TsunamiParameterItemToJson(
  _TsunamiParameterItem instance,
) => <String, dynamic>{
  'area': instance.area,
  'prefecture': instance.prefecture,
  'code': instance.code,
  'name': instance.name,
  'kana': instance.kana,
  'owner': instance.owner,
  'latitude': doubleToString(instance.latitude),
  'longitude': doubleToString(instance.longitude),
};

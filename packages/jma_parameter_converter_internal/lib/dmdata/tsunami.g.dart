// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'tsunami.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TsunamiParameterImpl _$$TsunamiParameterImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$TsunamiParameterImpl',
      json,
      ($checkedConvert) {
        final val = _$TsunamiParameterImpl(
          responseId: $checkedConvert('responseId', (v) => v as String),
          responseTime: $checkedConvert(
              'responseTime', (v) => DateTime.parse(v as String)),
          status: $checkedConvert('status', (v) => v as String),
          changeTime:
              $checkedConvert('changeTime', (v) => DateTime.parse(v as String)),
          version: $checkedConvert('version', (v) => v as String),
          items: $checkedConvert(
              'items',
              (v) => (v as List<dynamic>)
                  .map((e) =>
                      TsunamiParameterItem.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$$TsunamiParameterImplToJson(
        _$TsunamiParameterImpl instance) =>
    <String, dynamic>{
      'responseId': instance.responseId,
      'responseTime': instance.responseTime.toIso8601String(),
      'status': instance.status,
      'changeTime': instance.changeTime.toIso8601String(),
      'version': instance.version,
      'items': instance.items,
    };

_$TsunamiParameterItemImpl _$$TsunamiParameterItemImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$TsunamiParameterItemImpl',
      json,
      ($checkedConvert) {
        final val = _$TsunamiParameterItemImpl(
          area: $checkedConvert('area', (v) => v as String?),
          prefecture: $checkedConvert('prefecture', (v) => v as String),
          code: $checkedConvert('code', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
          kana: $checkedConvert('kana', (v) => v as String),
          owner: $checkedConvert('owner', (v) => v as String),
          latitude:
              $checkedConvert('latitude', (v) => doubleFromString(v as String)),
          longitude: $checkedConvert(
              'longitude', (v) => doubleFromString(v as String)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$TsunamiParameterItemImplToJson(
        _$TsunamiParameterItemImpl instance) =>
    <String, dynamic>{
      'area': instance.area,
      'prefecture': instance.prefecture,
      'code': instance.code,
      'name': instance.name,
      'kana': instance.kana,
      'owner': instance.owner,
      'latitude': doubleToString(instance.latitude),
      'longitude': doubleToString(instance.longitude),
    };

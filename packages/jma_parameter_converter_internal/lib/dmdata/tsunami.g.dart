// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tsunami.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TsunamiParameterImpl _$$TsunamiParameterImplFromJson(
        Map<String, dynamic> json) =>
    _$TsunamiParameterImpl(
      responseId: json['responseId'] as String,
      responseTime: DateTime.parse(json['responseTime'] as String),
      status: json['status'] as String,
      changeTime: DateTime.parse(json['changeTime'] as String),
      version: json['version'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => TsunamiParameterItem.fromJson(e as Map<String, dynamic>))
          .toList(),
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
    _$TsunamiParameterItemImpl(
      area: json['area'] as String?,
      prefecture: json['prefecture'] as String,
      code: json['code'] as String,
      name: json['name'] as String,
      kana: json['kana'] as String,
      owner: json['owner'] as String,
      latitude: doubleFromString(json['latitude'] as String),
      longitude: doubleFromString(json['longitude'] as String),
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

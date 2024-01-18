// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'earthquake.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EarthquakeParameterImpl _$$EarthquakeParameterImplFromJson(
        Map<String, dynamic> json) =>
    _$EarthquakeParameterImpl(
      responseId: json['responseId'] as String,
      responseTime: DateTime.parse(json['responseTime'] as String),
      status: json['status'] as String,
      changeTime: DateTime.parse(json['changeTime'] as String),
      version: json['version'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) =>
              EarthquakeParmaeterItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$EarthquakeParameterImplToJson(
        _$EarthquakeParameterImpl instance) =>
    <String, dynamic>{
      'responseId': instance.responseId,
      'responseTime': instance.responseTime.toIso8601String(),
      'status': instance.status,
      'changeTime': instance.changeTime.toIso8601String(),
      'version': instance.version,
      'items': instance.items,
    };

_$EarthquakeParmaeterItemImpl _$$EarthquakeParmaeterItemImplFromJson(
        Map<String, dynamic> json) =>
    _$EarthquakeParmaeterItemImpl(
      region: ParameterRegion.fromJson(json['region'] as Map<String, dynamic>),
      city: ParameterCity.fromJson(json['city'] as Map<String, dynamic>),
      noCode: json['noCode'] as String,
      code: json['code'] as String,
      name: json['name'] as String,
      kana: json['kana'] as String,
      status: json['status'] as String,
      owner: json['owner'] as String,
      latitude: doubleFromString(json['latitude'] as String),
      longitude: doubleFromString(json['longitude'] as String),
    );

Map<String, dynamic> _$$EarthquakeParmaeterItemImplToJson(
        _$EarthquakeParmaeterItemImpl instance) =>
    <String, dynamic>{
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

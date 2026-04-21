// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'ws_hypocenter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WsHypocenter _$WsHypocenterFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_WsHypocenter',
      json,
      ($checkedConvert) {
        final val = _WsHypocenter(
          regionCode: $checkedConvert('region_code', (v) => (v as num).toInt()),
          originTime: $checkedConvert('origin_time', (v) => v as String),
          regionName: $checkedConvert('region_name', (v) => v as String?),
          magnitude: $checkedConvert(
            'magnitude',
            (v) => (v as num?)?.toDouble(),
          ),
          depthKm: $checkedConvert('depth_km', (v) => (v as num?)?.toDouble()),
        );
        return val;
      },
      fieldKeyMap: const {
        'regionCode': 'region_code',
        'originTime': 'origin_time',
        'regionName': 'region_name',
        'depthKm': 'depth_km',
      },
    );

Map<String, dynamic> _$WsHypocenterToJson(_WsHypocenter instance) =>
    <String, dynamic>{
      'region_code': instance.regionCode,
      'origin_time': instance.originTime,
      'region_name': instance.regionName,
      'magnitude': instance.magnitude,
      'depth_km': instance.depthKm,
    };

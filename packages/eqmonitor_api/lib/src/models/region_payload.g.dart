// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'region_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RegionPayload _$RegionPayloadFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_RegionPayload',
      json,
      ($checkedConvert) {
        final val = _RegionPayload(
          topLeft: $checkedConvert(
            'top_left',
            (v) => LocationPayload.fromJson(v as Map<String, dynamic>),
          ),
          bottomRight: $checkedConvert(
            'bottom_right',
            (v) => LocationPayload.fromJson(v as Map<String, dynamic>),
          ),
        );
        return val;
      },
      fieldKeyMap: const {'topLeft': 'top_left', 'bottomRight': 'bottom_right'},
    );

Map<String, dynamic> _$RegionPayloadToJson(_RegionPayload instance) =>
    <String, dynamic>{
      'top_left': instance.topLeft,
      'bottom_right': instance.bottomRight,
    };

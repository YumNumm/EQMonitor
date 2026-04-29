// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'ws_shake_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WsShakeLocationPayload _$WsShakeLocationPayloadFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_WsShakeLocationPayload', json, ($checkedConvert) {
  final val = _WsShakeLocationPayload(
    latitude: $checkedConvert('latitude', (v) => (v as num).toDouble()),
    longitude: $checkedConvert('longitude', (v) => (v as num).toDouble()),
  );
  return val;
});

Map<String, dynamic> _$WsShakeLocationPayloadToJson(
  _WsShakeLocationPayload instance,
) => <String, dynamic>{
  'latitude': instance.latitude,
  'longitude': instance.longitude,
};

_WsShakeRegionPayload _$WsShakeRegionPayloadFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_WsShakeRegionPayload', json, ($checkedConvert) {
  final val = _WsShakeRegionPayload(
    topLeft: $checkedConvert(
      'topLeft',
      (v) => WsShakeLocationPayload.fromJson(v as Map<String, dynamic>),
    ),
    bottomRight: $checkedConvert(
      'bottomRight',
      (v) => WsShakeLocationPayload.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$WsShakeRegionPayloadToJson(
  _WsShakeRegionPayload instance,
) => <String, dynamic>{
  'topLeft': instance.topLeft,
  'bottomRight': instance.bottomRight,
};

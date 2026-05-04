// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'ws_estimated_intensity_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WsEstimatedIntensityPayload _$WsEstimatedIntensityPayloadFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_WsEstimatedIntensityPayload', json, ($checkedConvert) {
  final val = _WsEstimatedIntensityPayload(
    eventId: $checkedConvert('eventId', (v) => v as String),
    estimatedIntensityKey: $checkedConvert(
      'estimatedIntensityKey',
      (v) => v as String,
    ),
    createdAt: $checkedConvert('createdAt', (v) => DateTime.parse(v as String)),
    hypocenter: $checkedConvert(
      'hypocenter',
      (v) => v == null
          ? null
          : WsEstimatedIntensityHypocenter.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$WsEstimatedIntensityPayloadToJson(
  _WsEstimatedIntensityPayload instance,
) => <String, dynamic>{
  'eventId': instance.eventId,
  'estimatedIntensityKey': instance.estimatedIntensityKey,
  'createdAt': instance.createdAt.toIso8601String(),
  'hypocenter': instance.hypocenter,
};

_WsEstimatedIntensityHypocenter _$WsEstimatedIntensityHypocenterFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_WsEstimatedIntensityHypocenter', json, ($checkedConvert) {
  final val = _WsEstimatedIntensityHypocenter(
    regionCode: $checkedConvert('regionCode', (v) => (v as num).toInt()),
    regionName: $checkedConvert('regionName', (v) => v as String?),
    originTime: $checkedConvert(
      'originTime',
      (v) => DateTime.parse(v as String),
    ),
    magnitude: $checkedConvert('magnitude', (v) => (v as num?)?.toDouble()),
    depthKm: $checkedConvert('depthKm', (v) => (v as num?)?.toDouble()),
  );
  return val;
});

Map<String, dynamic> _$WsEstimatedIntensityHypocenterToJson(
  _WsEstimatedIntensityHypocenter instance,
) => <String, dynamic>{
  'regionCode': instance.regionCode,
  'regionName': instance.regionName,
  'originTime': instance.originTime.toIso8601String(),
  'magnitude': instance.magnitude,
  'depthKm': instance.depthKm,
};

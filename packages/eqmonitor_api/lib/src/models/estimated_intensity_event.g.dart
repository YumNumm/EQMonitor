// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'estimated_intensity_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EstimatedIntensityEvent _$EstimatedIntensityEventFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_EstimatedIntensityEvent', json, ($checkedConvert) {
  final val = _EstimatedIntensityEvent(
    eventId: $checkedConvert('eventId', (v) => v as String),
    estimatedIntensityKey: $checkedConvert(
      'estimatedIntensityKey',
      (v) => v as String,
    ),
    createdAt: $checkedConvert('createdAt', (v) => v as String),
    hypocenter: $checkedConvert(
      'hypocenter',
      (v) => v == null
          ? null
          : EstimatedIntensityHypocenter.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$EstimatedIntensityEventToJson(
  _EstimatedIntensityEvent instance,
) => <String, dynamic>{
  'eventId': instance.eventId,
  'estimatedIntensityKey': instance.estimatedIntensityKey,
  'createdAt': instance.createdAt,
  'hypocenter': ?instance.hypocenter,
};

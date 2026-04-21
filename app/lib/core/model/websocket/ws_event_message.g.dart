// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'ws_event_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WsEventMessage _$WsEventMessageFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_WsEventMessage',
      json,
      ($checkedConvert) {
        final val = _WsEventMessage(
          eventId: $checkedConvert('event_id', (v) => v as String),
          type: $checkedConvert('type', (v) => v as String),
          serialNo: $checkedConvert('serial_no', (v) => (v as num).toInt()),
          reportTime: $checkedConvert(
            'report_time',
            (v) => DateTime.parse(v as String),
          ),
          maxIntensity: $checkedConvert('max_intensity', (v) => v as String?),
          headline: $checkedConvert('headline', (v) => v as String?),
          originTime: $checkedConvert(
            'origin_time',
            (v) => v == null ? null : DateTime.parse(v as String),
          ),
          arrivalTime: $checkedConvert(
            'arrival_time',
            (v) => v == null ? null : DateTime.parse(v as String),
          ),
          hypocenter: $checkedConvert(
            'hypocenter',
            (v) => v == null
                ? null
                : WsHypocenter.fromJson(v as Map<String, dynamic>),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'eventId': 'event_id',
        'serialNo': 'serial_no',
        'reportTime': 'report_time',
        'maxIntensity': 'max_intensity',
        'originTime': 'origin_time',
        'arrivalTime': 'arrival_time',
      },
    );

Map<String, dynamic> _$WsEventMessageToJson(_WsEventMessage instance) =>
    <String, dynamic>{
      'event_id': instance.eventId,
      'type': instance.type,
      'serial_no': instance.serialNo,
      'report_time': instance.reportTime.toIso8601String(),
      'max_intensity': instance.maxIntensity,
      'headline': instance.headline,
      'origin_time': instance.originTime?.toIso8601String(),
      'arrival_time': instance.arrivalTime?.toIso8601String(),
      'hypocenter': instance.hypocenter,
    };

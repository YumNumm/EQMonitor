// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'eew_event_id_serial_no_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EewEventIdSerialNoParam _$EewEventIdSerialNoParamFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_EewEventIdSerialNoParam', json, ($checkedConvert) {
  final val = _EewEventIdSerialNoParam(
    eventId: $checkedConvert('eventId', (v) => v as String),
    serialNo: $checkedConvert('serialNo', (v) => v as num),
  );
  return val;
});

Map<String, dynamic> _$EewEventIdSerialNoParamToJson(
  _EewEventIdSerialNoParam instance,
) => <String, dynamic>{
  'eventId': instance.eventId,
  'serialNo': instance.serialNo,
};

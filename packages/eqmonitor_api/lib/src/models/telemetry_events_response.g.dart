// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'telemetry_events_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TelemetryEventsResponse _$TelemetryEventsResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_TelemetryEventsResponse', json, ($checkedConvert) {
  final val = _TelemetryEventsResponse(
    accepted: $checkedConvert('accepted', (v) => (v as num).toInt()),
    warning: $checkedConvert('warning', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$TelemetryEventsResponseToJson(
  _TelemetryEventsResponse instance,
) => <String, dynamic>{
  'accepted': instance.accepted,
  'warning': ?instance.warning,
};

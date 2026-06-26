// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'telemetry_events_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TelemetryEventsRequest _$TelemetryEventsRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_TelemetryEventsRequest', json, ($checkedConvert) {
  final val = _TelemetryEventsRequest(
    events: $checkedConvert(
      'events',
      (v) => (v as List<dynamic>)
          .map((e) => TelemetryEvent.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$TelemetryEventsRequestToJson(
  _TelemetryEventsRequest instance,
) => <String, dynamic>{'events': instance.events};

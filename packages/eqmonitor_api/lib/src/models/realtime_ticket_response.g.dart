// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'realtime_ticket_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RealtimeTicketResponse _$RealtimeTicketResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_RealtimeTicketResponse', json, ($checkedConvert) {
  final val = _RealtimeTicketResponse(
    url: $checkedConvert('url', (v) => v as String),
    expiresAt: $checkedConvert('expiresAt', (v) => DateTime.parse(v as String)),
    issuedAt: $checkedConvert('issuedAt', (v) => DateTime.parse(v as String)),
  );
  return val;
});

Map<String, dynamic> _$RealtimeTicketResponseToJson(
  _RealtimeTicketResponse instance,
) => <String, dynamic>{
  'url': instance.url,
  'expiresAt': instance.expiresAt.toIso8601String(),
  'issuedAt': instance.issuedAt.toIso8601String(),
};

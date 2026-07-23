// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'ws_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WsRealtimeMessage _$WsRealtimeMessageFromJson(Map<String, dynamic> json) =>
    $checkedCreate('WsRealtimeMessage', json, ($checkedConvert) {
      final val = WsRealtimeMessage(
        data: $checkedConvert(
          'data',
          (v) => RealtimeEventEnvelope.fromJson(v as Map<String, dynamic>),
        ),
        $type: $checkedConvert('type', (v) => v as String?),
      );
      return val;
    }, fieldKeyMap: const {r'$type': 'type'});

WsPingMessage _$WsPingMessageFromJson(Map<String, dynamic> json) =>
    $checkedCreate('WsPingMessage', json, ($checkedConvert) {
      final val = WsPingMessage(
        $type: $checkedConvert('type', (v) => v as String?),
      );
      return val;
    }, fieldKeyMap: const {r'$type': 'type'});

WsReadyMessage _$WsReadyMessageFromJson(Map<String, dynamic> json) =>
    $checkedCreate('WsReadyMessage', json, ($checkedConvert) {
      final val = WsReadyMessage(
        $type: $checkedConvert('type', (v) => v as String?),
      );
      return val;
    }, fieldKeyMap: const {r'$type': 'type'});

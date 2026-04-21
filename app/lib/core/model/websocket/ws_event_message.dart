import 'package:eqmonitor/core/model/websocket/ws_hypocenter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ws_event_message.freezed.dart';
part 'ws_event_message.g.dart';

@freezed
abstract class WsEventMessage with _$WsEventMessage {
  const factory WsEventMessage({
    required String eventId,
    required String type,
    required int serialNo,
    required DateTime reportTime,
    String? maxIntensity,
    String? headline,
    DateTime? originTime,
    DateTime? arrivalTime,
    WsHypocenter? hypocenter,
  }) = _WsEventMessage;

  factory WsEventMessage.fromJson(Map<String, dynamic> json) =>
      _$WsEventMessageFromJson(json);
}

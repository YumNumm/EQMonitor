import 'package:freezed_annotation/freezed_annotation.dart';

part 'ws_pong_message.freezed.dart';
part 'ws_pong_message.g.dart';

/// WebSocket へ送信するpongメッセージ。
@freezed
abstract class WsPongMessage with _$WsPongMessage {
  const factory({
    @Default('pong') String type,
  }) = _WsPongMessage;

  factory fromJson(Map<String, dynamic> json) =>
      _$WsPongMessageFromJson(json);
}

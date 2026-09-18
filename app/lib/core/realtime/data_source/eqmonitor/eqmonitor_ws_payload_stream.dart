import 'dart:async';
import 'dart:convert';

import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/realtime/data_source/eqmonitor/eqmonitor_ws_provider.dart';
import 'package:eqmonitor_websocket/eqmonitor_websocket.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:web_socket/web_socket.dart';

part 'eqmonitor_ws_payload_stream.g.dart';

/// 受信フレームを [WsMessage] にパースして流す。
@riverpod
class EqmonitorWsPayloadStream extends _$EqmonitorWsPayloadStream {
  /// これは状態ではなくイベント列なので、同じ値でも必ず通知する。
  ///
  /// 既定では前回の state と `==` のとき listener に通知されない。
  /// [WsPingMessage] のようにフィールドを持たないメッセージが連続すると
  /// 2 回目以降が観測できなくなる。
  @override
  bool updateShouldNotify(
    AsyncValue<WsMessage> previous,
    AsyncValue<WsMessage> next,
  ) => true;

  @override
  Stream<WsMessage> build() async* {
    final controller = StreamController<WsMessage>();

    ref.listen(eqmonitorWsEventStreamProvider, (_, next) {
      next.whenData((event) {
        switch (event) {
          case TextDataReceived(:final text):
            try {
              final json = jsonDecode(text);
              if (json is! Map<String, dynamic>) {
                talker.error('Invalid JSON: $text');
                return;
              }
              controller.add(WsMessage.fromJson(json));
            } on FormatException catch (exception) {
              talker.error('Invalid JSON: $text', exception);
            } on Object catch (exception, stackTrace) {
              talker.error(
                'Failed to parse WsMessage: $text',
                exception,
                stackTrace,
              );
            }
          case _:
            return;
        }
      });
    });

    ref.onDispose(controller.close);

    yield* controller.stream;
  }
}

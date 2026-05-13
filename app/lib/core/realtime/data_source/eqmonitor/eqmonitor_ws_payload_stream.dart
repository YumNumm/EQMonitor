import 'dart:async';
import 'dart:convert';

import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/realtime/data_source/eqmonitor/eqmonitor_ws_provider.dart';
import 'package:eqmonitor_websocket/eqmonitor_websocket.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:web_socket/web_socket.dart';

part 'eqmonitor_ws_payload_stream.g.dart';

@riverpod
Stream<WsMessage> eqmonitorWsPayloadStream(Ref ref) async* {
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
            final message = WsMessage.fromJson(json);
            controller.add(message);
          } on FormatException catch (exception) {
            talker.error('Invalid JSON: $text', exception);
          }
        case _:
          return;
      }
    });
  });

  ref.onDispose(controller.close);

  yield* controller.stream;
}

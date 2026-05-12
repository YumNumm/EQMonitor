import 'package:eqmonitor/core/realtime/data_source/eqmonitor/eqmonitor_ws_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:web_socket/web_socket.dart';

part 'eqmonitor_ws_stream_provider.g.dart';

@riverpod
Stream<WebSocketEvent> eqmonitorWsStream(Ref ref) async* {
  final websocket = await ref.watch(eqmonitorWebSocketProvider.future);
  yield* websocket.events;
}

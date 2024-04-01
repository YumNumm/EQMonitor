import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:eqapi_types/model/v1/v1_database.dart';
import 'package:eqapi_types/model/v1/websocket/realtime_postgres_changes_payload.dart';
import 'package:eqmonitor/env/env.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:web_socket_client/web_socket_client.dart';

part 'websocket_provider.g.dart';

@Riverpod(keepAlive: true)
WebSocket websocket(WebsocketRef ref) {
  final uri = Uri.parse(Env.wsApiUrl);
  final socket = WebSocket(
    uri,
    headers: {
      HttpHeaders.authorizationHeader: Env.apiAuthorization,
    },
  );
  ref.onDispose(() {
    socket.close(1000, 'Connection closed');
  });
  return socket;
}

@riverpod
ConnectionState websocketStatus(WebsocketStatusRef ref) {
  final socket = ref.read(websocketProvider);

  socket.connection.listen((state) {
    ref.state = state;
  });
  return socket.connection.state;
}

@riverpod
Stream<Map<String, dynamic>> websocketMessages(
  WebsocketMessagesRef ref,
) async* {
  final socket = ref.read(websocketProvider);

  await for (final message in socket.messages) {
    yield jsonDecode(message.toString()) as Map<String, dynamic>;
  }
}

@riverpod
Stream<RealtimePostgresChangesPayloadBase> websocketParsedMessages(
  WebsocketParsedMessagesRef ref,
) {
  final controller = StreamController<RealtimePostgresChangesPayloadBase>();
  ref
    ..listen(websocketMessagesProvider, (previous, next) {
      final value = next.value;
      if (value != null) {
        controller.add(
          RealtimePostgresChangesPayloadBase.fromJson(value),
        );
      }
    })
    ..onDispose(controller.close);
  return controller.stream;
}

@riverpod
Stream<RealtimePostgresChangesPayloadTable<T>>
    realtimePostgresChangesPayloadTableMessage<T extends V1Database>(
  RealtimePostgresChangesPayloadTableMessageRef<T> ref,
) {
  final controller = StreamController<RealtimePostgresChangesPayloadTable<T>>();
  ref
    ..listen(websocketParsedMessagesProvider, (previous, next) {
      final value = next.value;
      final _ = switch (value) {
        RealtimePostgresInsertPayload<T>() => controller.add(value),
        RealtimePostgresUpdatePayload<T>() => controller.add(value),
        RealtimePostgresDeletePayload<T>() => controller.add(value),
        _ => null,
      };
    })
    ..onDispose(controller.close);
  return controller.stream;
}

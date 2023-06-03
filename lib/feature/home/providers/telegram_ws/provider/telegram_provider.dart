import 'dart:async';

import 'package:eqapi_schema/model/telegram_v3.dart';
import 'package:eqmonitor/common/provider/log/talker.dart';
import 'package:eqmonitor/feature/home/providers/telegram_ws/model/socket_status.dart';
import 'package:eqmonitor/feature/home/providers/telegram_ws/provider/telegram_socket_io.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'telegram_provider.g.dart';

@Riverpod(keepAlive: true)
class TelegramWs extends _$TelegramWs {
  late final Talker _talker;
  late final Socket _socket;

  @override
  Stream<TelegramV3> build() {
    _talker = ref.watch(talkerProvider);
    _socket = ref.watch(telegramSocketIoProvider);

    final stream = StreamController<TelegramV3>();
    ref.onDispose(stream.close);
    _socket.on('data', (data) {
      try {
        _talker.logTyped(TelegramWebSocketLog('Data received: $data'));
        final payload = data as Map<String, dynamic>;
        final telegram = TelegramV3.fromJson(payload);
        stream.add(telegram);
        // ignore: avoid_catches_without_on_clauses
      } catch (error, stackTrace) {
        _talker.handle(error, stackTrace);
      }
    });
    return stream.stream;
  }

  void requestSample() {
    _socket.send(['sample/vxse45']);
  }
}

@riverpod
class SocketStatus extends _$SocketStatus {
  @override
  SocketStatusModel build() => const SocketStatusModel();

  void onConnect() => state = state.copyWith(
        connected: true,
      );

  void onDisconnect() => state = state.copyWith(
        connected: false,
      );
}

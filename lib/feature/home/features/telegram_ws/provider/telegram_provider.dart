import 'dart:async';

import 'package:eqapi_types/model/telegram_v3.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/home/features/telegram_ws/model/socket_status.dart';
import 'package:eqmonitor/feature/home/features/telegram_ws/provider/telegram_socket_io.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'telegram_provider.g.dart';

@Riverpod(
  keepAlive: true,
  dependencies: [telegramSocketIo],
)
class TelegramWs extends _$TelegramWs {
  @override
  Stream<TelegramV3> build() {
    final talker = ref.watch(talkerProvider);
    final socket = ref.watch(telegramSocketIoProvider);

    final stream = StreamController<TelegramV3>();
    ref.onDispose(stream.close);
    socket.on('data', (data) {
      try {
        talker.logTyped(TelegramWebSocketLog('Data received: $data'));
        final payload = data as Map<String, dynamic>;
        final telegram = TelegramV3.fromJson(payload);
        stream.add(telegram);
        // ignore: avoid_catches_without_on_clauses
      } catch (error, stackTrace) {
        talker.handle(error, stackTrace);
      }
    });
    return stream.stream;
  }

  void requestSample() =>
      ref.read(telegramSocketIoProvider).send(['sample/vxse45']);
}

@Riverpod(keepAlive: true)
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

import 'dart:developer';
import 'dart:ui';

import 'package:eqmonitor/core/provider/app_lifecycle.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/home/features/telegram_url/provider/telegram_url_provider.dart';
import 'package:eqmonitor/feature/home/features/telegram_ws/provider/telegram_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:socket_io_client/socket_io_client.dart';

part 'telegram_socket_io.g.dart';

@Riverpod(keepAlive: true, dependencies: [])
Socket telegramSocketIo(TelegramSocketIoRef ref) {
  final talker = ref.watch(talkerProvider);
  final url = ref.watch(telegramUrlProvider).wsApiUrl;
  final authorization = ref.watch(telegramUrlProvider).apiAuthorization ?? '';
  final socket = io(
    url,
    OptionBuilder()
        .setTransports(['websocket'])
        .enableReconnection()
        .enableAutoConnect()
        .enableForceNew()
        .setQuery({'key': authorization})
        .build(),
  )
    ..onConnecting(
      (data) => talker.logTyped(TelegramWebSocketLog('Connecting... ($data)')),
    )
    ..onConnect((data) {
      talker.logTyped(TelegramWebSocketLog('Connected ($data)'));
      ref.read(socketStatusProvider.notifier).onConnect();
    })
    ..onDisconnect((data) {
      talker.logTyped(TelegramWebSocketLog('Disconnected ($data)'));
      ref.read(socketStatusProvider.notifier).onDisconnect();
      // 再接続
    })
    ..onAny((event, data) {
      talker.logTyped(
        TelegramWebSocketLog(
          'Event: $event ($data)'
              .replaceAll(url, '**')
              .replaceAll(authorization, '++'),
        ),
      );
    })
    ..onPing((data) {
      log('Ping: $data');
    })
    ..connect();

  // バックグラウンドに入ったら切断
  ref.listen(appLifeCycleProvider, (_, next) {
    if (next == AppLifecycleState.resumed) {
      socket.connect();
    }
  });

  return socket;
}

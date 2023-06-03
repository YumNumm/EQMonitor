import 'dart:developer';

import 'package:eqmonitor/common/provider/log/talker.dart';
import 'package:eqmonitor/feature/home/providers/telegram_url/provider/telegram_url_provider.dart';
import 'package:eqmonitor/feature/home/providers/telegram_ws/provider/telegram_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:socket_io_client/socket_io_client.dart';

part 'telegram_socket_io.g.dart';

@Riverpod(keepAlive: true)
Socket telegramSocketIo(TelegramSocketIoRef ref) {
  final talker = ref.watch(talkerProvider);
  const url =
      'wss://ws.api.eqmonitor.app'; //ref.watch(telegramUrlProvider).wsApiUrl;
  final authorization = ref.watch(telegramUrlProvider).apiAuthorization ?? '';
  final socket = io(
    url,
    OptionBuilder()
        .setTransports(['websocket'])
        .disableAutoConnect()
        .enableReconnection()
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
    })
    ..connect()
    ..onAny((event, data) {
      talker.logTyped(TelegramWebSocketLog('Event: $event ($data)'));
      log('Event: $event ($data)');
    });
  if (kDebugMode) {
    // log url
    talker
      ..logTyped(TelegramWebSocketLog('url: $url'))
      // log authorization
      ..logTyped(TelegramWebSocketLog('authorization: $authorization'));
  }
  return socket;
}

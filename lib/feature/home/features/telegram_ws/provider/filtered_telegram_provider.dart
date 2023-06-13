import 'dart:async';

import 'package:eqapi_schema/eqapi_schema.dart';
import 'package:eqmonitor/feature/home/features/telegram_ws/provider/telegram_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'filtered_telegram_provider.g.dart';

@Riverpod(keepAlive: true)
class FilteredWsTelegram extends _$FilteredWsTelegram {
  @override
  Stream<TelegramV3> build() {
    final controller = StreamController<TelegramV3>();
    ref
      ..listen(telegramWsProvider, (previous, next) {
        final value = next.value;
        if (value != null) {
          if (kDebugMode || value.status != TelegramStatus.normal) {
            controller.add(value);
          }
        }
      })
      ..onDispose(controller.close);
    return controller.stream;
  }
}

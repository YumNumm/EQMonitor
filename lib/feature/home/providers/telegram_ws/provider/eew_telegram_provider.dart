import 'dart:async';

import 'package:eqapi_schema/eqapi_schema.dart';
import 'package:eqmonitor/feature/home/providers/telegram_ws/provider/telegram_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'eew_telegram_provider.g.dart';

@riverpod
class EewWsTelegram extends _$EewWsTelegram {
  @override
  Stream<Vxse45> build() {
    final controller = StreamController<Vxse45>();
    ref
      ..listen(telegramWsProvider, (previous, next) {
        final value = next.value;
        if (value != null) {
          if (value.type == TelegramType.vxse45) {
            // final data = (value, value.body as Vxse45);
            // controller.add(data);
          }
        }
      })
      ..onDispose(controller.close);
    return controller.stream;
  }
}

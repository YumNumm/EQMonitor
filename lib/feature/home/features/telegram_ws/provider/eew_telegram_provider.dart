import 'dart:async';

import 'package:eqapi_schema/eqapi_schema.dart';
import 'package:eqmonitor/feature/home/features/telegram_ws/model/eew_model.dart';
import 'package:eqmonitor/feature/home/features/telegram_ws/provider/telegram_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'eew_telegram_provider.g.dart';

@Riverpod(keepAlive: true)
class EewWsTelegram extends _$EewWsTelegram {
  @override
  Stream<EewWsItem> build() {
    final controller = StreamController<EewWsItem>();
    ref
      ..listen(telegramWsProvider, (previous, next) {
        final value = next.value;
        if (value != null) {
          if (value.type == TelegramType.vxse45) {
            controller.add(
              EewWsItem(
                telegram: value,
                body: value.body as Vxse45,
              ),
            );
          }
        }
      })
      ..onDispose(controller.close);
    return controller.stream;
  }
}

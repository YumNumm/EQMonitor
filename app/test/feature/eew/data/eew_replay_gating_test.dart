import 'package:eqmonitor/core/model/telegram/telegram_info_type.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/core/provider/clock/app_clock.dart';
import 'package:eqmonitor/feature/eew/data/eew.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

EewTelegramItem _eew(String eventId) => EewTelegramItem(
  eventId: eventId,
  status: TelegramStatus.normal,
  infoType: TelegramInfoType.publication,
  serialNo: 1,
  isCanceled: false,
  isLastInfo: false,
  reportTime: DateTime.utc(2024, 1, 1, 7, 10, 16),
  isPlum: false,
);

void main() {
  group('eewProvider のリプレイ連携', () {
    test('リプレイモードに入ると空でライブ受信を遮断すること', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      // eewProvider を読む前にリプレイモードへ入れる
      container
          .read(appClockProvider.notifier)
          .enterReplay(DateTime.utc(2024, 1, 1, 7, 10, 8));

      expect(container.read(eewProvider).value, isEmpty);
    });

    test('リプレイモード中に upsert したEEWが保持されること', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      container
          .read(appClockProvider.notifier)
          .enterReplay(DateTime.utc(2024, 1, 1, 7, 10, 8));
      container.read(eewProvider.notifier).upsert(_eew('20240101161010'));

      final state = container.read(eewProvider).value!;
      expect(state, hasLength(1));
      expect(state.single.eventId, '20240101161010');
    });
  });
}

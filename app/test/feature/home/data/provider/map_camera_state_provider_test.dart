import 'package:eqmonitor/core/model/telegram/telegram_info_type.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/home/data/provider/map_camera_state_provider.dart';
import 'package:test/test.dart';

EewTelegramItem _sampleEew() => EewTelegramItem(
  eventId: '20250101120000',
  status: TelegramStatus.normal,
  infoType: TelegramInfoType.publication,
  serialNo: 1,
  isCanceled: false,
  isLastInfo: false,
  reportTime: DateTime.utc(2025, 1, 1, 12),
  isPlum: false,
);

void main() {
  group('resolveHomeMapCameraUpdateAction', () {
    test('next が空で previous も空なら none', () {
      final action = resolveHomeMapCameraUpdateAction(
        previous: const [],
        next: const [],
      );
      expect(action, HomeMapCameraUpdateAction.none);
    });

    test('next が空で previous に値があれば returnToHome', () {
      final action = resolveHomeMapCameraUpdateAction(
        previous: [_sampleEew()],
        next: const [],
      );
      expect(action, HomeMapCameraUpdateAction.returnToHome);
    });

    test('next に値があれば fitToEews', () {
      final action = resolveHomeMapCameraUpdateAction(
        previous: null,
        next: [_sampleEew()],
      );
      expect(action, HomeMapCameraUpdateAction.fitToEews);
    });
  });
}

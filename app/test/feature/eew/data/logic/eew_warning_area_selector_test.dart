import 'package:eqmonitor/core/model/telegram/telegram_info_type.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/feature/eew/data/logic/eew_warning_area_selector.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const selector = EewWarningAreaSelector();

  test('初回警報でも府県予報区コードを返す', () {
    final result = selector.selectPrefectureCodes(
      events: [
        warningEew(
          eventId: 'initial-warning',
          prefectureCode: '9020',
          regionCode: '202',
          hadWarning: false,
        ),
      ],
    );

    expect(result, ['9020']);
  });

  test('現在警報だけを対象に重複コードを除く', () {
    final result = selector.selectPrefectureCodes(
      events: [
        warningEew(eventId: 'warning-a', prefectureCode: '9011'),
        warningEew(eventId: 'warning-b', prefectureCode: '9011'),
        warningEew(
          eventId: 'canceled',
          prefectureCode: '9020',
          isCanceled: true,
        ),
        warningEew(
          eventId: 'forecast',
          prefectureCode: '9030',
          isWarning: false,
        ),
      ],
    );

    expect(result, ['9011']);
  });
}

EewTelegramItem warningEew({
  required String eventId,
  required String prefectureCode,
  String regionCode = '100',
  bool? isWarning = true,
  bool isCanceled = false,
  bool hadWarning = true,
}) => EewTelegramItem(
  eventId: eventId,
  status: TelegramStatus.normal,
  infoType: TelegramInfoType.publication,
  serialNo: 1,
  isCanceled: isCanceled,
  isLastInfo: false,
  reportTime: DateTime.utc(2026, 8, 17),
  isPlum: false,
  isWarning: isWarning,
  warning: EewWarningInfo(
    regions: [
      EewWarningZoneInfo(code: regionCode, name: '予報区', hadWarning: hadWarning),
    ],
    zones: [
      EewWarningZoneInfo(code: '9910', name: '地方', hadWarning: hadWarning),
    ],
    prefectures: [
      EewWarningZoneInfo(
        code: prefectureCode,
        name: '府県予報区',
        hadWarning: hadWarning,
      ),
    ],
  ),
);

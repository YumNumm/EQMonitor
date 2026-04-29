import 'package:eqmonitor/core/model/telegram/telegram_info_type.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/feature/eew/data/eew_alive_telegram.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:flutter_test/flutter_test.dart';

EewTelegramItem _makeEew({
  bool isCanceled = false,
  bool isPlum = false,
  bool? isWarning,
  DateTime? reportTime,
  DateTime? originTime,
  DateTime? arrivalTime,
  double? magnitude,
  int? depth,
}) {
  return EewTelegramItem(
    eventId: '20250101120000',
    status: TelegramStatus.normal,
    infoType: TelegramInfoType.publication,
    serialNo: 1,
    isCanceled: isCanceled,
    isLastInfo: false,
    reportTime: reportTime ?? DateTime.utc(2025, 1, 1, 12),
    isPlum: isPlum,
    isWarning: isWarning,
    originTime: originTime,
    arrivalTime: arrivalTime,
    hypocenter: (magnitude != null || depth != null)
        ? EewHypocenterInfo(
            code: '350',
            name: 'テスト震源',
            hasLatLng: false,
            magnitude: magnitude,
            depth: depth,
          )
        : null,
  );
}

void main() {
  late EewAliveChecker checker;

  setUp(() {
    checker = EewAliveChecker();
  });

  group('EewAliveChecker.checkMarkAsEventEnded', () {
    group('reportTime が 2 時間以上前の場合 (inHours > 1)', () {
      // Duration.inHours は切り捨てのため、inHours > 1 は実質 2 時間以上を意味する
      test('2 時間超過で true を返すこと', () {
        final reportTime = DateTime.utc(2025, 1, 1, 10);
        final now = DateTime.utc(2025, 1, 1, 12, 0, 1);
        final eew = _makeEew(reportTime: reportTime);

        expect(checker.checkMarkAsEventEnded(eew: eew, now: now), isTrue);
      });

      test('ちょうど 2 時間の場合は true を返すこと (inHours == 2 > 1)', () {
        final reportTime = DateTime.utc(2025, 1, 1, 10);
        final now = DateTime.utc(2025, 1, 1, 12);
        final eew = _makeEew(reportTime: reportTime);

        expect(checker.checkMarkAsEventEnded(eew: eew, now: now), isTrue);
      });

      test('1 時間 59 分の場合は false を返すこと (inHours == 1)', () {
        final reportTime = DateTime.utc(2025, 1, 1, 10);
        final now = DateTime.utc(2025, 1, 1, 11, 59);
        final eew = _makeEew(reportTime: reportTime);

        expect(checker.checkMarkAsEventEnded(eew: eew, now: now), isFalse);
      });
    });

    group('isCanceled の場合', () {
      test('reportTime から 180 秒超過で true を返すこと', () {
        final reportTime = DateTime.utc(2025, 1, 1, 12);
        final now = reportTime.add(const Duration(seconds: 181));
        final eew = _makeEew(isCanceled: true, reportTime: reportTime);

        expect(checker.checkMarkAsEventEnded(eew: eew, now: now), isTrue);
      });

      test('reportTime からちょうど 180 秒の場合は false を返すこと', () {
        final reportTime = DateTime.utc(2025, 1, 1, 12);
        final now = reportTime.add(const Duration(seconds: 180));
        final eew = _makeEew(isCanceled: true, reportTime: reportTime);

        expect(checker.checkMarkAsEventEnded(eew: eew, now: now), isFalse);
      });

      test('179 秒の場合は false を返すこと', () {
        final reportTime = DateTime.utc(2025, 1, 1, 12);
        final now = reportTime.add(const Duration(seconds: 179));
        final eew = _makeEew(isCanceled: true, reportTime: reportTime);

        expect(checker.checkMarkAsEventEnded(eew: eew, now: now), isFalse);
      });
    });

    group('happenedTime が null の場合', () {
      test('originTime も arrivalTime もない場合は false を返すこと', () {
        final reportTime = DateTime.utc(2025, 1, 1, 12);
        final now = reportTime.add(const Duration(seconds: 999));
        final eew = _makeEew(reportTime: reportTime);

        expect(checker.checkMarkAsEventEnded(eew: eew, now: now), isFalse);
      });
    });

    group('magnitude >= 6.0 の場合', () {
      test('happenedTime から 360 秒超過で true を返すこと', () {
        final originTime = DateTime.utc(2025, 1, 1, 12);
        final now = originTime.add(const Duration(seconds: 361));
        final eew = _makeEew(
          originTime: originTime,
          magnitude: 6,
          depth: 50,
        );

        expect(checker.checkMarkAsEventEnded(eew: eew, now: now), isTrue);
      });

      test('ちょうど 360 秒の場合は false を返すこと', () {
        final originTime = DateTime.utc(2025, 1, 1, 12);
        final now = originTime.add(const Duration(seconds: 360));
        final eew = _makeEew(
          originTime: originTime,
          magnitude: 6.5,
          depth: 50,
        );

        expect(checker.checkMarkAsEventEnded(eew: eew, now: now), isFalse);
      });

      test('magnitude = 5.9 は対象外 (depth < 150 の 250s ルールになること)', () {
        final originTime = DateTime.utc(2025, 1, 1, 12);
        final now = originTime.add(const Duration(seconds: 251));
        final eew = _makeEew(
          originTime: originTime,
          magnitude: 5.9,
          depth: 50,
        );

        expect(checker.checkMarkAsEventEnded(eew: eew, now: now), isTrue);
      });
    });

    group('isWarning の場合', () {
      test('happenedTime から 360 秒超過で true を返すこと', () {
        final originTime = DateTime.utc(2025, 1, 1, 12);
        final now = originTime.add(const Duration(seconds: 361));
        final eew = _makeEew(
          originTime: originTime,
          isWarning: true,
          depth: 30,
        );

        expect(checker.checkMarkAsEventEnded(eew: eew, now: now), isTrue);
      });

      test('360 秒以内の場合は false を返すこと', () {
        final originTime = DateTime.utc(2025, 1, 1, 12);
        final now = originTime.add(const Duration(seconds: 300));
        final eew = _makeEew(
          originTime: originTime,
          isWarning: true,
          depth: 30,
        );

        expect(checker.checkMarkAsEventEnded(eew: eew, now: now), isFalse);
      });
    });

    group('depth < 150 の場合', () {
      test('happenedTime から 250 秒超過で true を返すこと', () {
        final originTime = DateTime.utc(2025, 1, 1, 12);
        final now = originTime.add(const Duration(seconds: 251));
        final eew = _makeEew(
          originTime: originTime,
          magnitude: 4,
          depth: 100,
        );

        expect(checker.checkMarkAsEventEnded(eew: eew, now: now), isTrue);
      });

      test('ちょうど 250 秒の場合は false を返すこと', () {
        final originTime = DateTime.utc(2025, 1, 1, 12);
        final now = originTime.add(const Duration(seconds: 250));
        final eew = _makeEew(
          originTime: originTime,
          magnitude: 4,
          depth: 149,
        );

        expect(checker.checkMarkAsEventEnded(eew: eew, now: now), isFalse);
      });

      test('depth が null の場合も 250 秒ルール適用になること', () {
        final originTime = DateTime.utc(2025, 1, 1, 12);
        final now = originTime.add(const Duration(seconds: 251));
        final eew = _makeEew(
          originTime: originTime,
          magnitude: 4,
        );

        expect(checker.checkMarkAsEventEnded(eew: eew, now: now), isTrue);
      });
    });

    group('depth >= 150 の場合', () {
      test('happenedTime から 400 秒超過で true を返すこと', () {
        final originTime = DateTime.utc(2025, 1, 1, 12);
        final now = originTime.add(const Duration(seconds: 401));
        final eew = _makeEew(
          originTime: originTime,
          magnitude: 4,
          depth: 200,
        );

        expect(checker.checkMarkAsEventEnded(eew: eew, now: now), isTrue);
      });

      test('ちょうど 400 秒の場合は false を返すこと', () {
        final originTime = DateTime.utc(2025, 1, 1, 12);
        final now = originTime.add(const Duration(seconds: 400));
        final eew = _makeEew(
          originTime: originTime,
          magnitude: 4,
          depth: 150,
        );

        expect(checker.checkMarkAsEventEnded(eew: eew, now: now), isFalse);
      });

      test('250 秒では終了扱いにならないこと', () {
        final originTime = DateTime.utc(2025, 1, 1, 12);
        final now = originTime.add(const Duration(seconds: 251));
        final eew = _makeEew(
          originTime: originTime,
          magnitude: 4,
          depth: 300,
        );

        expect(checker.checkMarkAsEventEnded(eew: eew, now: now), isFalse);
      });
    });

    group('originTime がない場合は arrivalTime を使うこと', () {
      test('arrivalTime から 250 秒超過で true を返すこと', () {
        final arrivalTime = DateTime.utc(2025, 1, 1, 12);
        final now = arrivalTime.add(const Duration(seconds: 251));
        final eew = _makeEew(
          arrivalTime: arrivalTime,
          magnitude: 4,
          depth: 50,
        );

        expect(checker.checkMarkAsEventEnded(eew: eew, now: now), isTrue);
      });

      test('originTime と arrivalTime の両方がある場合は originTime を使うこと', () {
        final originTime = DateTime.utc(2025, 1, 1, 12);
        // arrivalTime は originTime より後に設定 → happenedDiff < threshold にする
        final arrivalTime = originTime.add(const Duration(seconds: 30));
        // origin から 251 秒経過、arrival から 221 秒経過
        final now = originTime.add(const Duration(seconds: 251));
        final eew = _makeEew(
          originTime: originTime,
          arrivalTime: arrivalTime,
          magnitude: 4,
          depth: 50,
        );

        // originTime が使われると 251 > 250 → true
        expect(checker.checkMarkAsEventEnded(eew: eew, now: now), isTrue);
      });
    });
  });
}

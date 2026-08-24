import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/telegram/telegram_info_type.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/feature/eew/data/logic/eew_deep_hypocenter_intensity_notice.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const notice = EewDeepHypocenterIntensityNotice();
  const epicenterAccuracy1 = EewAccuracyInfo(
    epicenter: 1,
    hypocenter: 1,
    depth: 1,
    magnitudeCalculation: 8,
    numberOfMagnitudeCalculation: 1,
  );

  test('深さ150kmより深く最大震度未発表のときだけ注意文を出す', () {
    expect(notice.shouldShow(eew: _eew(depth: 151)), isTrue);
    expect(notice.shouldShow(eew: _eew(depth: 200)), isTrue);
    expect(
      notice.shouldShow(eew: _eew(depth: 200, maxIntensity: .unknown)),
      isTrue,
    );
  });

  test('深さ150kmより深くても最大震度が発表されていれば注意文を出さない', () {
    expect(
      notice.shouldShow(eew: _eew(depth: 151, maxIntensity: .three)),
      isFalse,
    );
    expect(
      notice.shouldShow(eew: _eew(depth: 200, maxIntensity: .four)),
      isFalse,
    );
  });

  test('深さ150km以下で最大震度未発表でも注意文を出さない', () {
    expect(notice.shouldShow(eew: _eew(depth: 150)), isFalse);
    expect(notice.shouldShow(eew: _eew(depth: 149)), isFalse);
    expect(
      notice.shouldShow(eew: _eew(depth: 10, maxIntensity: .unknown)),
      isFalse,
    );
  });

  test('深さ不明では注意文を出さない', () {
    expect(notice.shouldShow(eew: _eew()), isFalse);
  });

  test('PLUM法では深さ150kmより深くても注意文を出さない', () {
    expect(notice.shouldShow(eew: _eew(depth: 200, isPlum: true)), isFalse);
  });

  test('レベル法では深さ150kmより深くても注意文を出さない', () {
    expect(
      notice.shouldShow(
        eew: _eew(
          depth: 200,
          hasOriginTime: false,
          accuracy: epicenterAccuracy1,
        ),
      ),
      isFalse,
    );
  });

  test('1点検知では深さ150kmより深くても注意文を出さない', () {
    expect(
      notice.shouldShow(eew: _eew(depth: 200, accuracy: epicenterAccuracy1)),
      isFalse,
    );
  });

  test('取消報では注意文を出さない', () {
    expect(
      notice.shouldShow(eew: _eew(depth: 200, isCanceled: true)),
      isFalse,
    );
  });
}

EewTelegramItem _eew({
  int? depth,
  JmaIntensity? maxIntensity,
  bool isPlum = false,
  bool isCanceled = false,
  bool hasOriginTime = true,
  EewAccuracyInfo? accuracy,
}) => EewTelegramItem(
  eventId: 'test',
  status: TelegramStatus.normal,
  infoType: isCanceled
      ? TelegramInfoType.cancellation
      : TelegramInfoType.publication,
  serialNo: 1,
  isCanceled: isCanceled,
  isLastInfo: isCanceled,
  reportTime: DateTime.utc(2026, 8, 22, 12),
  isPlum: isPlum,
  originTime: hasOriginTime ? DateTime.utc(2026, 8, 22, 11, 59, 50) : null,
  hypocenter: EewHypocenterInfo(
    code: 'h1',
    name: 'テスト',
    magnitude: 5,
    depth: depth,
  ),
  forecastIntensity: maxIntensity == null && depth == null
      ? null
      : EewForecastIntensityInfo(
          regions: const [],
          maxIntensity: maxIntensity,
        ),
  accuracy: accuracy,
);

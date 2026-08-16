import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/telegram/telegram_info_type.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/live_activity/data/model/debug_live_activity_preset.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/live_activity/data/repository/debug_live_activity_content_builder.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_level.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const builder = DebugLiveActivityContentBuilder();
  final now = DateTime.utc(2024, 1, 1, 7, 10); // = 16:10 JST

  group('eewFromPreset', () {
    test('warning プリセットは警報フィールドと現在地予想を含む', () {
      final map = builder.eewFromPreset(
        preset: DebugEewPreset.warning,
        eventId: 'ev-1',
        now: now,
      );

      expect(map['eventId'], 'ev-1');
      expect(map['type'], 'eew');
      expect(map['isWarning'], true);
      expect(map['maxIntensity'], '6+');
      expect(map['magnitude'], 7.6);
      expect(map['serialNo'], 32);
      final location = map['location'] as Map<String, dynamic>;
      expect(location['regionName'], '東京都23区');
      expect(location['forecastIntensity'], '5-');
      expect(location['forecastLpgmIntensity'], '2');
    });

    test('canceled プリセットは震源情報を null にする', () {
      final map = builder.eewFromPreset(
        preset: DebugEewPreset.canceled,
        eventId: 'ev-2',
        now: now,
      );

      expect(map['isCanceled'], true);
      expect(map['hypocenterName'], isNull);
      expect(map['magnitude'], isNull);
      expect(map['depth'], isNull);
      expect(map['time'], isNull);
      expect(map['maxIntensity'], isNull);
    });

    test('time は JST オフセット付き・小数秒なしの ISO8601', () {
      final map = builder.eewFromPreset(
        preset: DebugEewPreset.warning,
        eventId: 'ev-1',
        now: now,
      );

      expect(map['time'], '2024-01-01T16:10:00+09:00');
    });
  });

  group('eewFromTelegram', () {
    test('通常の警報 EEW を変換する', () {
      final eew = EewTelegramItem(
        eventId: 'tel-1',
        status: TelegramStatus.normal,
        infoType: TelegramInfoType.publication,
        serialNo: 5,
        isCanceled: false,
        isLastInfo: true,
        reportTime: now,
        isPlum: false,
        isWarning: true,
        originTime: now,
        headline: 'テスト見出し',
        hypocenter: const EewHypocenterInfo(
          code: '100',
          name: '三陸沖',
          magnitude: 7.2,
          depth: 24,
        ),
        forecastIntensity: const EewForecastIntensityInfo(
          regions: [],
          maxIntensity: JmaIntensity.fiveUpper,
        ),
        accuracy: const EewAccuracyInfo(
          epicenter: 3,
          hypocenter: 3,
          depth: 3,
          magnitudeCalculation: 5,
          numberOfMagnitudeCalculation: 5,
        ),
      );

      final map = builder.eewFromTelegram(eew);

      expect(map['eventId'], 'tel-1');
      expect(map['hypocenterName'], '三陸沖');
      expect(map['magnitude'], 7.2);
      expect(map['depth'], 24.0);
      expect(map['maxIntensity'], '5+');
      expect(map['isFinal'], true);
      expect(map['isWarning'], true);
      expect(map['isOriginTime'], true);
      expect(map['isPlum'], false);
      expect(map['headline'], 'テスト見出し');
    });

    test('PLUM は M・深さを隠す', () {
      final eew = EewTelegramItem(
        eventId: 'tel-2',
        status: TelegramStatus.normal,
        infoType: TelegramInfoType.publication,
        serialNo: 1,
        isCanceled: false,
        isLastInfo: false,
        reportTime: now,
        isPlum: true,
        isWarning: false,
        originTime: now,
        hypocenter: const EewHypocenterInfo(
          code: '100',
          name: '関東地方',
          magnitude: 5,
          depth: 10,
        ),
      );

      final map = builder.eewFromTelegram(eew);

      expect(map['isPlum'], true);
      expect(map['magnitude'], isNull);
      expect(map['depth'], isNull);
    });

    test('取消報は震源情報を null にする', () {
      final eew = EewTelegramItem(
        eventId: 'tel-3',
        status: TelegramStatus.normal,
        infoType: TelegramInfoType.publication,
        serialNo: 2,
        isCanceled: true,
        isLastInfo: true,
        reportTime: now,
        isPlum: false,
      );

      final map = builder.eewFromTelegram(eew);

      expect(map['isCanceled'], true);
      expect(map['hypocenterName'], isNull);
      expect(map['magnitude'], isNull);
      expect(map['time'], isNull);
      expect(map['maxIntensity'], isNull);
    });
  });

  group('shake', () {
    test('shakeFromPreset は Level を大文字始まりの文字列に変換する', () {
      final map = builder.shakeFromPreset(
        preset: DebugShakePreset.strong,
        eventId: 'shake-1',
        now: now,
      );

      expect(map['type'], 'shake_detection');
      expect(map['level'], 'Strong');
      final location = map['location'] as Map<String, dynamic>;
      expect(location['intensity'], 3.2);
    });

    test('shakeFromEvent は実データを変換する', () {
      final event = ShakeDetectionEvent(
        eventId: 'shake-2',
        serialNo: 3,
        createdAt: now,
        updatedAt: now,
        expiresAt: now,
        level: ShakeDetectionLevel.stronger,
        pointCount: 4,
        minLat: 35,
        maxLat: 36,
        minLng: 139,
        maxLng: 140,
        changeReasons: const [],
      );

      final map = builder.shakeFromEvent(event);

      expect(map['eventId'], 'shake-2');
      expect(map['level'], 'Stronger');
      expect(map['detectedAt'], '2024-01-01T16:10:00+09:00');
      expect(map['location'], isNull);
    });
  });
}

import 'dart:convert';

import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' show TelegramStatus;
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EarthquakeHistoryParameterEx.updateIntensity', () {
    const param = EarthquakeHistoryParameter();

    test('initial 値を渡すと null に正規化されること', () {
      final updated = param.updateIntensity(
        JmaIntensity.one,
        JmaIntensity.seven,
      );
      expect(updated.intensityGte, isNull);
      expect(updated.intensityLte, isNull);
    });

    test('非 initial 値はそのまま設定されること', () {
      final updated = param.updateIntensity(
        JmaIntensity.three,
        JmaIntensity.fiveLower,
      );
      expect(updated.intensityGte, JmaIntensity.three);
      expect(updated.intensityLte, JmaIntensity.fiveLower);
    });

    test('片方だけ initial 値の場合もう片方は保持されること', () {
      final updated = param.updateIntensity(
        JmaIntensity.one,
        JmaIntensity.four,
      );
      expect(updated.intensityGte, isNull);
      expect(updated.intensityLte, JmaIntensity.four);
    });
  });

  group('EarthquakeHistoryParameterEx.updateMagnitude', () {
    const param = EarthquakeHistoryParameter();

    test('initial 値 (0 / 9) はそれぞれ null に正規化されること', () {
      final updated = param.updateMagnitude(0, 9);
      expect(updated.magnitudeGte, isNull);
      expect(updated.magnitudeLte, isNull);
    });

    test('非 initial 値はそのまま設定されること', () {
      final updated = param.updateMagnitude(3.5, 7.5);
      expect(updated.magnitudeGte, 3.5);
      expect(updated.magnitudeLte, 7.5);
    });

    test('片方が null のときも null として保持されること', () {
      final updated = param.updateMagnitude(null, 5);
      expect(updated.magnitudeGte, isNull);
      expect(updated.magnitudeLte, 5);
    });
  });

  group('EarthquakeHistoryParameterEx.updateDepth', () {
    const param = EarthquakeHistoryParameter();

    test('initial 値 (0 / 700) はそれぞれ null に正規化されること', () {
      final updated = param.updateDepth(0, 700);
      expect(updated.depthGte, isNull);
      expect(updated.depthLte, isNull);
    });

    test('非 initial 値はそのまま設定されること', () {
      final updated = param.updateDepth(20, 100);
      expect(updated.depthGte, 20);
      expect(updated.depthLte, 100);
    });
  });

  group('EarthquakeHistoryParameterEx.updateStatuses', () {
    const param = EarthquakeHistoryParameter();

    test('null を渡すと statuses は null になること', () {
      final updated = param.updateStatuses(null);
      expect(updated.statuses, isNull);
    });

    test('initialStatuses と等しい場合 statuses は null に正規化されること', () {
      final updated = param.updateStatuses(const [TelegramStatus.normal]);
      expect(updated.statuses, isNull);
    });

    test('initialStatuses と異なる場合はそのまま設定されること', () {
      final updated = param.updateStatuses(const [
        TelegramStatus.normal,
        TelegramStatus.test,
      ]);
      expect(updated.statuses, [TelegramStatus.normal, TelegramStatus.test]);
    });

    test('空リストは initialStatuses と異なるので保持されること', () {
      final updated = param.updateStatuses(const []);
      expect(updated.statuses, isEmpty);
      expect(updated.statuses, isNotNull);
    });
  });

  group('EarthquakeHistoryParameter — JSON 文字列経由の往復', () {
    EarthquakeHistoryParameter roundTrip(EarthquakeHistoryParameter v) {
      return EarthquakeHistoryParameter.fromJson(
        jsonDecode(jsonEncode(v.toJson())) as Map<String, dynamic>,
      );
    }

    test('空オブジェクトでも往復できること', () {
      const original = EarthquakeHistoryParameter();
      expect(roundTrip(original), original);
    });

    test('enum 系を含むフィールド設定でも往復できること', () {
      const original = EarthquakeHistoryParameter(
        magnitudeGte: 3,
        magnitudeLte: 7,
        depthGte: 10,
        depthLte: 200,
        intensityGte: JmaIntensity.three,
        intensityLte: JmaIntensity.fiveUpper,
        statuses: [TelegramStatus.normal, TelegramStatus.training],
        epicenterCode: 100,
        epicenterName: '関東',
        regionSearchType: RegionSearchType.prefecture,
        regionCode: '13',
        regionName: '東京都',
        regionIntensityGte: JmaIntensity.two,
        regionIntensityLte: JmaIntensity.seven,
      );
      expect(roundTrip(original), original);
    });
  });
}

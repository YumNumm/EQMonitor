import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/telegram_list/data/model/earthquake_body_diff.dart';
import 'package:eqmonitor/feature/telegram_list/data/model/earthquake_telegram_body_intensity_region_model.dart';
import 'package:eqmonitor/feature/telegram_list/data/model/earthquake_telegram_body_quake_model.dart';
import 'package:eqmonitor/feature/telegram_list/data/repository/earthquake_body_diff_calculator.dart';
import 'package:flutter_test/flutter_test.dart';

/// テスト用ヘルパー: 最低限のフィールドで [EarthquakeTelegramBodyIntensityRegionModel] を生成
EarthquakeTelegramBodyIntensityRegionModel _region(
  String code,
  String name,
  JmaIntensity? intensity,
) {
  return EarthquakeTelegramBodyIntensityRegionModel(
    code: code,
    name: name,
    intensity: intensity,
  );
}

/// テスト用ヘルパー: [EarthquakeTelegramBodyQuakeModel] を生成
EarthquakeTelegramBodyQuakeModel _quake({
  String? magnitude,
  num? depth,
  String? epicenterName,
  JmaIntensity? maxIntensity,
}) {
  return EarthquakeTelegramBodyQuakeModel(
    magnitude: magnitude,
    depth: depth,
    epicenterName: epicenterName,
    maxIntensity: maxIntensity,
  );
}

void main() {
  const calculator = EarthquakeBodyDiffCalculator();

  group('computeIntensityRegionDiff', () {
    test('初報 (previous=null) の場合、全て same になる', () {
      final current = [
        _region('100', '東京都', JmaIntensity.three),
        _region('200', '神奈川県', JmaIntensity.two),
      ];

      final result = calculator.computeIntensityRegionDiff(current: current);

      expect(result, hasLength(2));
      expect(result[0].diffType, IntensityDiffType.same);
      expect(result[0].code, '100');
      expect(result[0].previousIntensity, isNull);
      expect(result[1].diffType, IntensityDiffType.same);
    });

    test('初報 (previous=empty) の場合、全て same になる', () {
      final current = [_region('100', '東京都', JmaIntensity.three)];

      final result = calculator.computeIntensityRegionDiff(
        current: current,
        previous: [],
      );

      expect(result, hasLength(1));
      expect(result[0].diffType, IntensityDiffType.same);
    });

    test('新たに追加された地域を検出する', () {
      final previous = [_region('100', '東京都', JmaIntensity.three)];
      final current = [
        _region('100', '東京都', JmaIntensity.three),
        _region('200', '神奈川県', JmaIntensity.two),
      ];

      final result = calculator.computeIntensityRegionDiff(
        current: current,
        previous: previous,
      );

      expect(result, hasLength(2));
      // 既存地域は same
      expect(result[0].diffType, IntensityDiffType.same);
      expect(result[0].code, '100');
      // 新規地域は added
      expect(result[1].diffType, IntensityDiffType.added);
      expect(result[1].code, '200');
      expect(result[1].previousIntensity, isNull);
    });

    test('震度上方修正 (value4 -> value5minus) を検出する', () {
      final previous = [_region('100', '東京都', JmaIntensity.four)];
      final current = [_region('100', '東京都', JmaIntensity.fiveLower)];

      final result = calculator.computeIntensityRegionDiff(
        current: current,
        previous: previous,
      );

      expect(result, hasLength(1));
      expect(result[0].diffType, IntensityDiffType.upgraded);
      expect(result[0].intensity, JmaIntensity.fiveLower);
      expect(result[0].previousIntensity, JmaIntensity.four);
    });

    test('震度下方修正 (value5plus -> value4) を検出する', () {
      final previous = [_region('100', '東京都', JmaIntensity.fiveUpper)];
      final current = [_region('100', '東京都', JmaIntensity.four)];

      final result = calculator.computeIntensityRegionDiff(
        current: current,
        previous: previous,
      );

      expect(result, hasLength(1));
      expect(result[0].diffType, IntensityDiffType.downgraded);
      expect(result[0].intensity, JmaIntensity.four);
      expect(result[0].previousIntensity, JmaIntensity.fiveUpper);
    });

    test('intensity が null のエントリはスキップされる', () {
      final current = [
        _region('100', '東京都', JmaIntensity.three),
        _region('200', '神奈川県', null),
      ];

      final result = calculator.computeIntensityRegionDiff(current: current);

      expect(result, hasLength(1));
      expect(result[0].code, '100');
    });

    test('複数の差分種別が混在するケース', () {
      final previous = [
        _region('100', '東京都', JmaIntensity.three),
        _region('200', '神奈川県', JmaIntensity.fiveUpper),
      ];
      final current = [
        _region('100', '東京都', JmaIntensity.four), // upgraded
        _region('200', '神奈川県', JmaIntensity.four), // downgraded
        _region('300', '千葉県', JmaIntensity.two), // added
      ];

      final result = calculator.computeIntensityRegionDiff(
        current: current,
        previous: previous,
      );

      expect(result, hasLength(3));
      expect(result[0].diffType, IntensityDiffType.upgraded);
      expect(result[1].diffType, IntensityDiffType.downgraded);
      expect(result[2].diffType, IntensityDiffType.added);
    });
  });

  group('computeHypocenterDiff', () {
    test('差分なしの場合 null を返す', () {
      final quake = _quake(
        magnitude: '5.0',
        depth: 10,
        epicenterName: '東京湾',
        maxIntensity: JmaIntensity.four,
      );

      final result = calculator.computeHypocenterDiff(
        current: quake,
        previous: quake,
      );

      expect(result, isNull);
    });

    test('current が null の場合 null を返す', () {
      final result = calculator.computeHypocenterDiff(
        current: null,
        previous: _quake(magnitude: '5.0'),
      );

      expect(result, isNull);
    });

    test('both null の場合 null を返す', () {
      final result = calculator.computeHypocenterDiff(current: null);

      expect(result, isNull);
    });

    test('マグニチュードの変化を検出する', () {
      final previous = _quake(
        magnitude: '5.0',
        depth: 10,
        epicenterName: '東京湾',
      );
      final current = _quake(magnitude: '5.5', depth: 10, epicenterName: '東京湾');

      final result = calculator.computeHypocenterDiff(
        current: current,
        previous: previous,
      );

      expect(result, isNotNull);
      expect(result!.hasMagnitudeChange(), isTrue);
      expect(result.oldMagnitude, '5.0');
      expect(result.newMagnitude, '5.5');
      expect(result.hasDepthChange(), isFalse);
      expect(result.hasEpicenterNameChange(), isFalse);
    });

    test('深さの変化を検出する', () {
      final previous = _quake(
        magnitude: '5.0',
        depth: 10,
        epicenterName: '東京湾',
      );
      final current = _quake(magnitude: '5.0', depth: 30, epicenterName: '東京湾');

      final result = calculator.computeHypocenterDiff(
        current: current,
        previous: previous,
      );

      expect(result, isNotNull);
      expect(result!.hasDepthChange(), isTrue);
      expect(result.oldDepth, 10);
      expect(result.newDepth, 30);
      expect(result.hasMagnitudeChange(), isFalse);
    });

    test('震源名の変化を検出する', () {
      final previous = _quake(epicenterName: '東京湾');
      final current = _quake(epicenterName: '相模湾');

      final result = calculator.computeHypocenterDiff(
        current: current,
        previous: previous,
      );

      expect(result, isNotNull);
      expect(result!.hasEpicenterNameChange(), isTrue);
      expect(result.oldEpicenterName, '東京湾');
      expect(result.newEpicenterName, '相模湾');
    });

    test('最大震度の変化を検出する', () {
      final previous = _quake(maxIntensity: JmaIntensity.four);
      final current = _quake(maxIntensity: JmaIntensity.fiveLower);

      final result = calculator.computeHypocenterDiff(
        current: current,
        previous: previous,
      );

      expect(result, isNotNull);
      expect(result!.hasMaxIntensityChange(), isTrue);
      expect(result.oldMaxIntensity, JmaIntensity.four);
      expect(result.newMaxIntensity, JmaIntensity.fiveLower);
    });

    test('初報 (previous=null) で値がある場合は差分あり', () {
      final current = _quake(magnitude: '5.0', depth: 10, epicenterName: '東京湾');

      final result = calculator.computeHypocenterDiff(current: current);

      expect(result, isNotNull);
      expect(result!.hasMagnitudeChange(), isTrue);
      expect(result.oldMagnitude, isNull);
      expect(result.newMagnitude, '5.0');
    });
  });
}

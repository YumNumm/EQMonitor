import 'dart:convert';

import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_config_model.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EarthquakeHistoryConfig — デフォルト値', () {
    test('デフォルト値の生成', () {
      const config = EarthquakeHistoryConfig(
        list: EarthquakeHistoryListConfig(),
        detail: EarthquakeHistoryDetailConfig(),
      );
      expect(config.list.isFillBackground, isTrue);
      expect(config.list.designatedRegionSearchType, isNull);
      expect(config.detail.fillMode, EarthquakeHistoryFillMode.auto);
      expect(
        config.detail.stationDisplayMode,
        StationDisplayMode.maxFocused,
      );
      expect(
        config.detail.hypocenterDisplayMode,
        HypocenterDisplayMode.zoomFade,
      );
      expect(config.detail.showHypocenterError, isFalse);
      expect(config.detail.showStationLabel, isFalse);
      expect(config.detail.useEstimatedIntensityWhenAvailable, isTrue);
      expect(config.detail.showLegend, isTrue);
      expect(config.detail.showingLpgmIntensity, isFalse);
      expect(config.detail.showStation, isTrue);
    });
  });

  group('EarthquakeHistoryConfig — JSON 往復', () {
    EarthquakeHistoryConfig roundTrip(EarthquakeHistoryConfig v) {
      return EarthquakeHistoryConfig.fromJson(
        jsonDecode(jsonEncode(v.toJson())) as Map<String, dynamic>,
      );
    }

    test('デフォルト値の往復', () {
      const original = EarthquakeHistoryConfig(
        list: EarthquakeHistoryListConfig(),
        detail: EarthquakeHistoryDetailConfig(),
      );
      expect(roundTrip(original), original);
    });

    test('全フィールドカスタムでも往復できること', () {
      const original = EarthquakeHistoryConfig(
        list: EarthquakeHistoryListConfig(
          isFillBackground: false,
          designatedRegionSearchType: RegionSearchType.city,
          designatedRegionCode: '13101',
          designatedRegionName: '千代田区',
        ),
        detail: EarthquakeHistoryDetailConfig(
          fillMode: EarthquakeHistoryFillMode.none,
          stationDisplayMode: StationDisplayMode.allMinimized,
          hypocenterDisplayMode: HypocenterDisplayMode.alwaysOpaque,
          showHypocenterError: true,
          showStationLabel: true,
          useEstimatedIntensityWhenAvailable: false,
          showLegend: false,
          showingLpgmIntensity: true,
          showStation: false,
        ),
      );
      expect(roundTrip(original), original);
    });

    test(
      '不明な enum 値 (fillMode) は @JsonKey の unknownEnumValue で auto に fallback',
      () {
        const defaults = EarthquakeHistoryConfig(
          list: EarthquakeHistoryListConfig(),
          detail: EarthquakeHistoryDetailConfig(),
        );
        final json =
            jsonDecode(jsonEncode(defaults.toJson())) as Map<String, dynamic>;
        (json['detail'] as Map<String, dynamic>)['fill_mode'] = 'unknownValue';
        final decoded = EarthquakeHistoryConfig.fromJson(json);
        expect(decoded.detail.fillMode, EarthquakeHistoryFillMode.auto);
      },
    );

    test('旧 matchIcon 値は unknownEnumValue で auto にマッピングされる', () {
      const defaults = EarthquakeHistoryConfig(
        list: EarthquakeHistoryListConfig(),
        detail: EarthquakeHistoryDetailConfig(),
      );
      final json =
          jsonDecode(jsonEncode(defaults.toJson())) as Map<String, dynamic>;
      (json['detail'] as Map<String, dynamic>)['fill_mode'] = 'matchIcon';
      final decoded = EarthquakeHistoryConfig.fromJson(json);
      expect(decoded.detail.fillMode, EarthquakeHistoryFillMode.auto);
    });
  });

  group('RegionSearchType enum', () {
    test('prefecture / city の 2 値', () {
      expect(RegionSearchType.values.length, 2);
      expect(RegionSearchType.values, [
        RegionSearchType.prefecture,
        RegionSearchType.city,
      ]);
    });
  });

  group('EarthquakeHistoryFillMode enum', () {
    test('全列挙値', () {
      expect(EarthquakeHistoryFillMode.values, [
        EarthquakeHistoryFillMode.none,
        EarthquakeHistoryFillMode.auto,
        EarthquakeHistoryFillMode.region,
        EarthquakeHistoryFillMode.city,
      ]);
    });
  });
}

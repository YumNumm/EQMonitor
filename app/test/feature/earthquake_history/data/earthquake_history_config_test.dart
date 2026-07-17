import 'dart:convert';

import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_config_model.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EarthquakeHistoryConfig — デフォルト値', () {
    test('デフォルト値の生成', () {
      const config = EarthquakeHistoryConfig(
        list: EarthquakeHistoryListConfig(),
      );
      expect(config.list.isFillBackground, isTrue);
      expect(config.list.designatedRegionSearchType, isNull);
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
      );
      expect(roundTrip(original), original);
    });
  });

  group('RegionSearchType enum', () {
    test('prefecture / region / city / station の 4 値', () {
      expect(RegionSearchType.values.length, 4);
      expect(RegionSearchType.values, [
        RegionSearchType.prefecture,
        RegionSearchType.region,
        RegionSearchType.city,
        RegionSearchType.station,
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

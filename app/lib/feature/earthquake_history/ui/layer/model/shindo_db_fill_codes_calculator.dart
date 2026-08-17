import 'package:eqmonitor/feature/earthquake_history/data/model/shindo_db_intensity_class.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/shindo_db_intensity_tree.dart';

/// 震度DB塗り潰しレイヤーの階級ごとの対象コードを算出する。
class ShindoDbFillCodesCalculator {
  const ShindoDbFillCodesCalculator();

  /// 階級ごとの塗り潰し対象コード (orderIndex 昇順 = 低階級→高階級)。
  /// 低階級から順にレイヤー追加することで高階級レイヤーが上に来る。
  Map<
    ShindoDbIntensityClass,
    ({List<String> regionCodes, List<String> cityCodes})
  >
  compute(ShindoDbIntensityTree tree) {
    // region / city ごとの最大階級を事前計算。
    // 複数階級に観測点が跨る場合は最大階級にのみ含め、
    // 半透明 fill の重なりによる混色を防ぐ。
    final regionMaxClass = <String, ShindoDbIntensityClass>{};
    final cityMaxClass = <String, ShindoDbIntensityClass>{};
    for (final entry in tree.tree.entries) {
      final cls = entry.key;
      for (final pref in entry.value) {
        for (final cityNode in pref.cities) {
          final regionCode = cityNode.region.code;
          final currentRegion = regionMaxClass[regionCode];
          if (currentRegion == null ||
              cls.orderIndex > currentRegion.orderIndex) {
            regionMaxClass[regionCode] = cls;
          }
          final cityCode = cityNode.city.code;
          final currentCity = cityMaxClass[cityCode];
          if (currentCity == null || cls.orderIndex > currentCity.orderIndex) {
            cityMaxClass[cityCode] = cls;
          }
        }
      }
    }

    final sortedClasses =
        tree.tree.keys.where((cls) => cls.colorJmaIntensity != null).toList()
          ..sort((a, b) => a.orderIndex.compareTo(b.orderIndex));

    final result =
        <
          ShindoDbIntensityClass,
          ({List<String> regionCodes, List<String> cityCodes})
        >{};
    for (final cls in sortedClasses) {
      final cityCodes = <String>[];
      final regionCodes = <String>[];
      for (final pref in tree.tree[cls] ?? <ShindoDbPrefectureNode>[]) {
        for (final cityNode in pref.cities) {
          final cityCode = cityNode.city.code;
          if (cityMaxClass[cityCode] == cls && !cityCodes.contains(cityCode)) {
            cityCodes.add(cityCode);
          }
          final regionCode = cityNode.region.code;
          if (regionMaxClass[regionCode] == cls &&
              !regionCodes.contains(regionCode)) {
            regionCodes.add(regionCode);
          }
        }
      }
      result[cls] = (regionCodes: regionCodes, cityCodes: cityCodes);
    }
    return result;
  }
}

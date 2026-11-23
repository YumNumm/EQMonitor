import 'package:eqmonitor/feature/parameter/data/model/earthquake/earthquake_parameter.dart';

class const RegionCodeMapping._() {
  /// 市区町村コードから所属都道府県コードを返す。
  ///
  /// city.code の上 2 桁が prefecture.code の上 2 桁と一致する規則を利用する
  /// 市区町村コードの先頭2桁を都道府県コードとして扱う。
  ///
  /// 一致する都道府県が存在しない場合は `null` を返す。
  static String? prefectureCodeOfCity(
    String cityCode,
    List<EarthquakeParameterPrefectureItem> prefectures,
  ) {
    final cityPrefix = cityCode.substring(0, 2);
    for (final pref in prefectures) {
      if (pref.code.substring(0, 2) == cityPrefix) {
        return pref.code;
      }
    }
    return null;
  }
}

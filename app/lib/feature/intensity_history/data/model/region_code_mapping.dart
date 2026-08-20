import 'package:eqmonitor/feature/parameter/data/model/earthquake/earthquake_parameter.dart';

// 調査結論:
// 地図レイヤ `areaForecastLocalE` のフィーチャは細分区域コード
// （EarthquakeParameterRegionItem.code）に、`areaInformationCityQuake` の
// フィーチャは市区町村コード（EarthquakeParameterCityItem.code）に対応する。
//
// `earthquake_intensity.dart` の `forecastLocalEIntensityPairs` では、
// `pref.cities.isEmpty` の場合に `pref.prefecture.prefecture.code`（都道府県コード）を
// そのまま `areaForecastLocalE` の code として使用している前例がある。
// しかし全フィーチャが都道府県コードに対応しているとは限らないため、
// `regionCodesOfPrefecture` は EarthquakeParameter の regions コード（細分区域）を
// 返す実装とする（安全側）。

/// 都道府県コード・市区町村コード・細分区域コードの相互変換ロジックを集約する。
class RegionCodeMapping {
  const new _();

  /// 市区町村コードから所属都道府県コードを返す。
  ///
  /// city.code の上 2 桁が prefecture.code の上 2 桁と一致する規則を利用する
  /// (`city_selector.dart` の `substring(0,2)` ロジックに準拠)。
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

  /// 都道府県コードに対応する `areaForecastLocalE` 細分区域コード群を返す。
  ///
  /// EarthquakeParameter の `regions[].code` が細分区域コードに対応する。
  /// 存在しない場合は空リストを返す。
  static List<String> regionCodesOfPrefecture(
    String prefectureCode,
    List<EarthquakeParameterPrefectureItem> prefectures,
  ) {
    for (final pref in prefectures) {
      if (pref.code == prefectureCode) {
        return pref.regions.map((r) => r.code).toList();
      }
    }
    return const [];
  }

  /// 都道府県コードに対応する市区町村コード群を返す。
  ///
  /// 存在しない場合は空リストを返す。
  static List<String> cityCodesOfPrefecture(
    String prefectureCode,
    List<EarthquakeParameterPrefectureItem> prefectures,
  ) {
    for (final pref in prefectures) {
      if (pref.code == prefectureCode) {
        return pref.regions.expand((r) => r.cities.map((c) => c.code)).toList();
      }
    }
    return const [];
  }

  /// 細分区域コードから所属都道府県コードと名前を返す。
  ///
  /// [regionCode] に一致する `regions[].code` を持つ都道府県を検索する。
  /// 一致する都道府県が存在しない場合は `null` を返す。
  static ({String code, String name})? prefectureOfRegionCode(
    String regionCode,
    List<EarthquakeParameterPrefectureItem> prefectures,
  ) {
    for (final pref in prefectures) {
      for (final region in pref.regions) {
        if (region.code == regionCode) {
          return (code: pref.code, name: pref.name.ja);
        }
      }
    }
    return null;
  }
}

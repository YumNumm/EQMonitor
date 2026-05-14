import 'package:eqmonitor/core/provider/jma_parameter/jma_parameter.dart';
import 'package:eqmonitor/core/provider/map/jma_map_provider.dart';
import 'package:eqmonitor/core/provider/map/jma_map_utility.dart';
import 'package:jma_map/jma_map.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'jma_region_resolver.g.dart';

@Riverpod(keepAlive: true)
Future<JmaRegionResolver> jmaRegionResolver(Ref ref) async {
  final jmaMapData = await ref.watch(jmaMapProvider.future);
  final jmaParameter = await ref.watch(jmaParameterProvider.future);
  return JmaRegionResolver(
    eewMapData: jmaMapData[JmaMapType.areaForecastLocalEew]!,
    cityMapData: jmaMapData[JmaMapType.areaInformationCity]!,
    earthquakeParameter: jmaParameter.earthquake,
  );
}

/// 地震情報マッチング用に解決された地域情報。
typedef EarthquakeRegionResolution = ({
  int regionCode,
  String regionName,
  String cityCode,
  String cityName,
});

/// GPS座標からJMA細分区域（area_forecast_local_eew）および
/// 市区町村（area_information_city）コードを解決するクラス。
/// geobaseのpoint-in-polygonを使用。
class JmaRegionResolver {
  JmaRegionResolver({
    required this.eewMapData,
    required this.cityMapData,
    required EarthquakeParameter earthquakeParameter,
  }) : _cityToRegion = buildCityToRegionLookup(earthquakeParameter);

  final JmaMap_JmaMapData eewMapData;
  final JmaMap_JmaMapData cityMapData;
  final _utility = JmaMapUtility();

  /// 市区町村コード → 親一次細分化地域 のルックアップ。
  /// `earthquake_param.regions[].cities[]` から構築される。
  final Map<String, EarthquakeParentRegion> _cityToRegion;

  /// [latitude], [longitude] が含まれるJMA細分区域コードを返す。
  /// 見つからない場合はnullを返す。
  /// 緊急地震速報の予報区 (`area_forecast_local_eew`) コード。
  int? resolveRegionCode(double latitude, double longitude) {
    final result = _utility.findNearestItem(
      JmaMap_LatLng(lat: latitude, lng: longitude),
      eewMapData,
    );
    final item = result.item;
    if (item == null) {
      return null;
    }
    final codeStr = item.property.code;
    return int.tryParse(codeStr);
  }

  /// [latitude], [longitude] が含まれるJMA細分区域名を返す。
  String? resolveRegionName(double latitude, double longitude) {
    final result = _utility.findNearestItem(
      JmaMap_LatLng(lat: latitude, lng: longitude),
      eewMapData,
    );
    final item = result.item;
    if (item == null) {
      return null;
    }
    return item.property.name;
  }

  /// [latitude], [longitude] が含まれる市区町村コードを返す。
  /// 見つからない場合はnullを返す。
  String? resolveCityCode(double latitude, double longitude) {
    final result = _utility.findNearestItem(
      JmaMap_LatLng(lat: latitude, lng: longitude),
      cityMapData,
    );
    return result.item?.property.code;
  }

  /// [latitude], [longitude] が含まれる市区町村名を返す。
  String? resolveCityName(double latitude, double longitude) {
    final result = _utility.findNearestItem(
      JmaMap_LatLng(lat: latitude, lng: longitude),
      cityMapData,
    );
    return result.item?.property.name;
  }

  /// 地震情報マッチング用に GPS 座標から市区町村と
  /// その親一次細分化地域を同時に解決する。
  ///
  /// `cityMapData` から市区町村を得たのち、
  /// `earthquake_param.regions[].cities[]` から親 region を逆引きする。
  /// 市区町村が解決できない、もしくは親 region が見つからない場合は null。
  ///
  /// EEW 用の `resolveRegionCode` とは別系統のコード (`area_information_city`,
  /// 一次細分化地域コード) を返すので注意。
  EarthquakeRegionResolution? resolveEarthquakeRegion(
    double latitude,
    double longitude,
  ) {
    final result = _utility.findNearestItem(
      JmaMap_LatLng(lat: latitude, lng: longitude),
      cityMapData,
    );
    final item = result.item;
    if (item == null) {
      return null;
    }
    final cityCode = item.property.code;
    final cityName = item.property.name;
    final parent = _cityToRegion[cityCode];
    if (parent == null) {
      return null;
    }
    return (
      regionCode: parent.code,
      regionName: parent.name,
      cityCode: cityCode,
      cityName: cityName,
    );
  }
}

/// 市区町村コード → 親一次細分化地域コード/名のペア。
class EarthquakeParentRegion {
  const EarthquakeParentRegion({required this.code, required this.name});

  final int code;
  final String name;
}

/// `earthquake_param.regions[].cities[]` を走査し、
/// 市区町村コード → 親一次細分化地域 のルックアップを構築する。
///
/// テスト容易性のため公開する。
Map<String, EarthquakeParentRegion> buildCityToRegionLookup(
  EarthquakeParameter param,
) {
  final lookup = <String, EarthquakeParentRegion>{};
  for (final prefecture in param.prefectures) {
    for (final region in prefecture.regions) {
      final regionCode = int.tryParse(region.code);
      if (regionCode == null) {
        continue;
      }
      final parent = EarthquakeParentRegion(
        code: regionCode,
        name: region.name.ja,
      );
      for (final city in region.cities) {
        lookup[city.code] = parent;
      }
    }
  }
  return lookup;
}

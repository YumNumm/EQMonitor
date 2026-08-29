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
    cityMapData: jmaMapData.areaInformationCity,
    tsunamiMapData: jmaMapData.areaTsunami,
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

/// GPS座標から地震情報の細分区域、市区町村、津波予報区を解決するクラス。
/// geobaseのpoint-in-polygonを使用。
class JmaRegionResolver {
  new({
    required this.cityMapData,
    required this.tsunamiMapData,
    required EarthquakeParameter earthquakeParameter,
  }) : _cityToRegion = CityToRegionLookupBuilder.build(earthquakeParameter);

  final JmaMap_JmaMapData cityMapData;
  final JmaMap_JmaMapData tsunamiMapData;
  final _utility = JmaMapUtility();

  /// 市区町村コード → 親一次細分化地域 のルックアップ。
  /// `earthquake_param.regions[].cities[]` から構築される。
  final Map<String, EarthquakeParentRegion> _cityToRegion;

  /// [latitude], [longitude] に最も近い津波予報区コードを返す。
  String? resolveTsunamiForecastRegionCode(
    double latitude,
    double longitude,
  ) {
    final result = _utility.findNearestItem(
      JmaMap_LatLng(lat: latitude, lng: longitude),
      tsunamiMapData,
    );
    return result.item?.property.code;
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
  const new({required this.code, required this.name});

  final int code;
  final String name;
}

/// `earthquake_param.regions[].cities[]` を走査し、
/// 市区町村コード → 親一次細分化地域 のルックアップを構築する。
class CityToRegionLookupBuilder {
  static Map<String, EarthquakeParentRegion> build(EarthquakeParameter param) {
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
}

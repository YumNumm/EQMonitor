import 'package:eqmonitor/core/provider/map/jma_map_provider.dart';
import 'package:eqmonitor/core/provider/map/jma_map_utility.dart';
import 'package:jma_map/jma_map.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'jma_region_resolver.g.dart';

@Riverpod(keepAlive: true)
Future<JmaRegionResolver> jmaRegionResolver(Ref ref) async {
  final jmaMapData = await ref.watch(jmaMapProvider.future);
  return JmaRegionResolver(
    eewMapData: jmaMapData[JmaMapType.areaForecastLocalEew]!,
    cityMapData: jmaMapData[JmaMapType.areaInformationCity]!,
  );
}

/// GPS座標からJMA細分区域（area_forecast_local_eew）および
/// 市区町村（area_information_city）コードを解決するクラス。
/// geobaseのpoint-in-polygonを使用。
class JmaRegionResolver {
  JmaRegionResolver({required this.eewMapData, required this.cityMapData});

  final JmaMap_JmaMapData eewMapData;
  final JmaMap_JmaMapData cityMapData;
  final _utility = JmaMapUtility();

  /// [latitude], [longitude] が含まれるJMA細分区域コードを返す。
  /// 見つからない場合はnullを返す。
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
}

import 'package:eqmonitor/core/provider/map/jma_map_provider.dart';
import 'package:eqmonitor/core/provider/map/jma_map_utility.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jma_map/jma_map.dart';
import 'package:lat_lng/lat_lng.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'nearest_jma_feature.g.dart';

@riverpod
Future<JmaMap_JmaMapData_JmaMapDataItem?> jmaMapAreaForecastLocalEewInside(
  Ref ref,
  LatLng latLng,
) async {
  final jmaMap = await ref.watch(jmaMapProvider.future);
  final jmaMapUtility = ref.watch(jmaMapUtilityProvider);

  final jmaMapData = jmaMap[JmaMapType.areaForecastLocalEew]!;

  final nearestJmaFeature = jmaMapUtility.findNearestItem(
    JmaMap_LatLng(lat: latLng.lat, lng: latLng.lon),
    jmaMapData,
  );

  return nearestJmaFeature;
}

@riverpod
Future<JmaMap_JmaMapData_JmaMapDataItem?> jmaMapAreaForecastLocalEInside(
  Ref ref,
  LatLng latLng,
) async {
  final jmaMap = await ref.watch(jmaMapProvider.future);
  final jmaMapUtility = ref.watch(jmaMapUtilityProvider);

  final jmaMapData = jmaMap[JmaMapType.areaForecastLocalE]!;

  final nearestJmaFeature = jmaMapUtility.findNearestItem(
    JmaMap_LatLng(lat: latLng.lat, lng: latLng.lon),
    jmaMapData,
  );

  return nearestJmaFeature;
}

@riverpod
Future<JmaMap_JmaMapData_JmaMapDataItem?> jmaMapAreaInformationCityInside(
  Ref ref,
  LatLng latLng,
) async {
  final jmaMap = await ref.watch(jmaMapProvider.future);
  final jmaMapUtility = ref.watch(jmaMapUtilityProvider);

  final jmaMapData = jmaMap[JmaMapType.areaInformationCity]!;

  final nearestJmaFeature = jmaMapUtility.findNearestItem(
    JmaMap_LatLng(lat: latLng.lat, lng: latLng.lon),
    jmaMapData,
  );

  return nearestJmaFeature;
}

@riverpod
Future<JmaMap_JmaMapData_JmaMapDataItem?> jmaMapAreaTsunamiNearest(
  Ref ref,
  LatLng latLng,
) async {
  final jmaMap = await ref.watch(jmaMapProvider.future);
  final jmaMapUtility = ref.watch(jmaMapUtilityProvider);

  final jmaMapData = jmaMap[JmaMapType.areaTsunami]!;

  final nearestJmaFeature = jmaMapUtility.findNearestItem(
    JmaMap_LatLng(lat: latLng.lat, lng: latLng.lon),
    jmaMapData,
  );

  return nearestJmaFeature;
}

import 'package:eqmonitor/core/provider/map/jma_map_provider.dart';
import 'package:eqmonitor/feature/location/data/jma_map_isolate.dart';
import 'package:eqmonitor/feature/location/data/model/map_data_item.dart';
import 'package:lat_lng/lat_lng.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'nearest_jma_feature.g.dart';

@riverpod
Future<MapDataItem?> jmaMapAreaForecastLocalEewInside(
  Ref ref,
  LatLng latLng,
) async {
  final isolate = await ref.watch(jmaMapIsolateProvider.future);
  return isolate.calculateNearestElement(
    latitude: latLng.lat,
    longitude: latLng.lon,
    type: JmaMapType.areaForecastLocalEew,
  );
}

@riverpod
Future<MapDataItem?> jmaMapAreaForecastLocalEInside(
  Ref ref,
  LatLng latLng,
) async {
  final isolate = await ref.watch(jmaMapIsolateProvider.future);
  return isolate.calculateNearestElement(
    latitude: latLng.lat,
    longitude: latLng.lon,
    type: JmaMapType.areaForecastLocalE,
  );
}

@riverpod
Future<MapDataItem?> jmaMapAreaInformationCityInside(
  Ref ref,
  LatLng latLng,
) async {
  final isolate = await ref.watch(jmaMapIsolateProvider.future);
  return isolate.calculateNearestElement(
    latitude: latLng.lat,
    longitude: latLng.lon,
    type: JmaMapType.areaInformationCity,
  );
}

@riverpod
Future<MapDataItem?> jmaMapAreaTsunamiNearest(
  Ref ref,
  LatLng latLng,
) async {
  final isolate = await ref.watch(jmaMapIsolateProvider.future);
  return isolate.calculateNearestElement(
    latitude: latLng.lat,
    longitude: latLng.lon,
    type: JmaMapType.areaTsunami,
  );
}

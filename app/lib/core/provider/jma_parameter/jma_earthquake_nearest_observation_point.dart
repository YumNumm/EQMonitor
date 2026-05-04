import 'package:collection/collection.dart';
import 'package:eqmonitor/core/provider/jma_parameter/jma_parameter.dart';
import 'package:geobase/geobase.dart';
import 'package:lat_lng/lat_lng.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'jma_earthquake_nearest_observation_point.g.dart';

@riverpod
Future<(EarthquakeParameterStationItem, double)?>
jmaEarthquakeNearestObservationPoint(Ref ref, LatLng latLng) async {
  final parameter = ref.watch(jmaParameterProvider).value;
  if (parameter == null) {
    throw Exception('parameter is null');
  }

  final earthquake = parameter.earthquake;
  final points = earthquake.prefectures
      .expand((prefecture) => prefecture.regions)
      .expand((region) => region.cities)
      .expand((city) => city.stations);

  return minBy(
    points.map((point) => (point, point.distanceTo(latLng))),
    (point) => point.$2,
  );
}

extension on EarthquakeParameterStationItem {
  double distanceTo(LatLng latLng) {
    final referencePoint = Geographic(lon: latLng.lon, lat: latLng.lat);
    final point = Geographic(lon: location.lon, lat: location.lat);
    return referencePoint.distanceTo2D(point);
  }
}

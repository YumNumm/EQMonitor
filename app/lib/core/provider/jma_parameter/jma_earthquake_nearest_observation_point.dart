import 'package:collection/collection.dart';
import 'package:eqmonitor/core/provider/jma_parameter/jma_parameter.dart';
import 'package:geobase/geobase.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jma_parameter_api_client/jma_parameter_api_client.dart';
import 'package:lat_lng/lat_lng.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'jma_earthquake_nearest_observation_point.g.dart';

@riverpod
Future<(EarthquakeParameterStationItem, double)?>
jmaEarthquakeNearestObservationPoint(Ref ref, LatLng latLng) async {
  final parameter = ref.watch(jmaParameterProvider).valueOrNull;
  if (parameter == null) {
    throw Exception('parameter is null');
  }

  final earthquake = parameter.earthquake;
  final points = earthquake.regions.expand(
    (region) => region.cities.expand((city) => city.stations),
  );

  return minBy(
    points.map((point) => (point, point.distanceTo(latLng))),
    (point) => point.$2,
  );
}

extension on EarthquakeParameterStationItem {
  double distanceTo(LatLng latLng) {
    final referencePoint = Geographic(lon: latLng.lon, lat: latLng.lat);
    final point = Geographic(lon: longitude, lat: latitude);
    return referencePoint.distanceTo2D(point);
  }
}

import 'package:eqmonitor/core/provider/kmoni_observation_points/provider/kyoshin_observation_points_provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kyoshin_observation_point_types/kyoshin_observation_point.pb.dart';
import 'package:latlong2/latlong.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'location.g.dart';

@riverpod
Stream<Position> locationStream(LocationStreamRef ref) async* {
  final stream = Geolocator.getPositionStream(
    locationSettings: const LocationSettings(
      accuracy: LocationAccuracy.low,
    ),
  );

  final lastKnownPosition = await Geolocator.getLastKnownPosition();
  if (lastKnownPosition != null) {
    yield lastKnownPosition;
  }

  final currentPosition = await Geolocator.getCurrentPosition(
    locationSettings: const LocationSettings(
      accuracy: LocationAccuracy.low,
    ),
  );
  yield currentPosition;

  await for (final event in stream) {
    yield event;
  }
}

@riverpod
Stream<(KyoshinObservationPoint, double km)> closestKmoniObservationPointStream(
  ClosestKmoniObservationPointStreamRef ref,
) async* {
  final kmoniObservationPoints = ref.watch(kyoshinObservationPointsProvider);

  final currentPosition = ref.watch(locationStreamProvider);
  if (currentPosition case AsyncData(:final value)) {
    final currentPosition = LatLng(value.latitude, value.longitude);
    final closest = kmoniObservationPoints.points
        .map(
          (e) => (
            e,
            const Distance().as(
              LengthUnit.Kilometer,
              LatLng(e.location.latitude, e.location.longitude),
              currentPosition,
            )
          ),
        )
        .reduce((a, b) => a.$2 < b.$2 ? a : b);

    yield closest;
  }
}

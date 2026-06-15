import 'dart:async';

import 'package:eqmonitor/core/provider/kmoni_observation_points/provider/kyoshin_observation_points_provider.dart';
import 'package:eqmonitor/feature/parameter/data/model/parameter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'location.g.dart';

@riverpod
Stream<Position> locationStream(Ref ref) async* {
  final controller = StreamController<Position>();
  ref.onDispose(controller.close);

  ref.listen(
    _locationStreamProvider,
    (_, next) {
      switch (next) {
        case AsyncData(:final value):
          // Round to 3 decimal places (~110m) to avoid re-fetching on tiny GPS fluctuations.
          final lat = (value.latitude * 1000).round() / 1000;
          final lng = (value.longitude * 1000).round() / 1000;
          controller.add(
            Position(
              latitude: lat,
              longitude: lng,
              timestamp: value.timestamp,
              accuracy: value.accuracy,
              altitude: value.altitude,
              altitudeAccuracy: value.altitudeAccuracy,
              heading: value.heading,
              headingAccuracy: value.headingAccuracy,
              speed: value.speed,
              speedAccuracy: value.speedAccuracy,
              floor: value.floor,
              isMocked: value.isMocked,
            ),
          );
        case AsyncError(:final error, :final stackTrace):
          controller.addError(error, stackTrace);
        case AsyncLoading():
          break;
      }
    },
  );

  yield* controller.stream;
}

@riverpod
Stream<Position> _locationStream(Ref ref) async* {
  final stream = Geolocator.getPositionStream(
    locationSettings: const LocationSettings(
      accuracy: .low,
    ),
  );

  final lastKnownPosition = await Geolocator.getLastKnownPosition();
  if (lastKnownPosition != null) {
    yield lastKnownPosition;
  }

  final currentPosition = await Geolocator.getCurrentPosition(
    locationSettings: const LocationSettings(
      accuracy: .low,
      distanceFilter: 100,
    ),
  );
  yield currentPosition;

  await for (final event in stream) {
    yield event;
  }
}

/// 近隣の強震観測点
@riverpod
Stream<(KyoshinObservationPoint, double km)> closestKmoniObservationPointStream(
  Ref ref,
) async* {
  final kmoniObservationPoints = await ref.watch(
    kyoshinObservationPointsProvider.future,
  );

  final currentPosition = ref.watch(locationStreamProvider);
  if (currentPosition case AsyncData(:final value)) {
    final currentPosition = LatLng(
      value.latitude,
      value.longitude,
    );
    final closest = kmoniObservationPoints.points
        .map(
          (e) => (
            e,
            const Distance().as(
              LengthUnit.Kilometer,
              LatLng(e.location.lat, e.location.lon),
              currentPosition,
            ),
          ),
        )
        .reduce((a, b) => a.$2 < b.$2 ? a : b);

    yield closest;
  }
}

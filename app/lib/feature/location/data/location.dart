import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'location.g.dart';

@riverpod
Stream<Position> locationStream(LocationStreamRef ref) async* {
  final stream = Geolocator.getPositionStream(
    locationSettings: const LocationSettings(
      accuracy: LocationAccuracy.low,
    ),
  );

  final currentPosition = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.low,
  );
  yield currentPosition;

  await for (final event in stream) {
    yield event;
  }
}

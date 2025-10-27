import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:maplibre/maplibre.dart';

part 'map_camera_state.freezed.dart';

@freezed
abstract class MapCameraState with _$MapCameraState {
  const factory MapCameraState({
    required Geographic center,
    required double zoom,
    @Default(0.0) double bearing,
    @Default(0.0) double pitch,
    @Default(true) bool isAtHome,
  }) = _MapCameraState;

  factory MapCameraState.home() => const MapCameraState(
    center: Geographic(lon: 137, lat: 37.5),
    zoom: 5,
  );
}

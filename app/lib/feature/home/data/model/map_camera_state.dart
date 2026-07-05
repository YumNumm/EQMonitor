import 'package:eqmonitor/feature/map/utils/map_zoom_calculator.dart';
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
    center: Geographic(lon: JapanBounds.centerLng, lat: JapanBounds.centerLat),
    zoom: 5.5,
  );
}

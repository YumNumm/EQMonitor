import 'package:eqmonitor/feature/map/data/model/map_camera.dart';

sealed class const MapCameraBoundsFitResult();

final class const MapCameraBoundsFitSucceeded({
  required final MapCamera camera,
}) extends MapCameraBoundsFitResult;

final class const MapCameraBoundsFitInvalid({
  required final MapCameraBoundsFitInvalidReason reason,
}) extends MapCameraBoundsFitResult;

enum MapCameraBoundsFitInvalidReason {
  nonFiniteBounds,
  invalidBounds,
  invalidViewport,
  invalidDevicePixelRatio,
  invalidPadding,
  paddingConsumesViewport,
  invalidZoomRange,
}

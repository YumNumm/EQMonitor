import 'package:eqmonitor_map/src/geo/map_camera.dart';

typedef SubmitMapCameraCandidate = bool Function(MapCamera camera);

/// Keeps the published camera unchanged until its candidate Scene is accepted.
final class MapCameraCandidateOwner {
  MapCameraCandidateOwner({required MapCamera initialCamera})
    : _committedCamera = initialCamera;

  MapCamera _committedCamera;

  MapCamera get committedCamera => _committedCamera;

  bool commitCandidate({
    required MapCamera candidate,
    required SubmitMapCameraCandidate submitCandidate,
  }) {
    if (!submitCandidate(candidate)) {
      return false;
    }
    _committedCamera = candidate;
    return true;
  }
}

import 'package:eqmonitor_map/src/geo/map_camera.dart';
import 'package:eqmonitor_map/src/widget/map_camera_candidate_owner.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/map_camera_candidate_scene_fixture.dart';

void main() {
  test(
    'candidate becomes visible only after its Scene submission succeeds',
    () {
      final owner = MapCameraCandidateOwner(
        initialCamera: MapCameraCandidateSceneFixture.initial,
      );
      MapCamera? cameraVisibleDuringSubmission;

      final committed = owner.commitCandidate(
        candidate: MapCameraCandidateSceneFixture.candidate,
        submitCandidate: (_) {
          cameraVisibleDuringSubmission = owner.committedCamera;
          return true;
        },
      );

      expect(committed, isTrue);
      expect(
        cameraVisibleDuringSubmission,
        MapCameraCandidateSceneFixture.initial,
      );
      expect(
        owner.committedCamera,
        MapCameraCandidateSceneFixture.candidate,
      );
    },
  );

  test('rejected candidate leaves committed camera unchanged', () {
    final owner = MapCameraCandidateOwner(
      initialCamera: MapCameraCandidateSceneFixture.initial,
    );

    final committed = owner.commitCandidate(
      candidate: MapCameraCandidateSceneFixture.candidate,
      submitCandidate: (_) => false,
    );

    expect(committed, isFalse);
    expect(owner.committedCamera, MapCameraCandidateSceneFixture.initial);
  });
}

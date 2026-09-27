import 'package:eqmonitor_map/src/renderer/map_scene_frame_submission.dart';
import 'package:eqmonitor_map/src/widget/map_camera_candidate_owner.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/map_camera_candidate_scene_fixture.dart';

void main() {
  test('Scene validation exception leaves committed camera unchanged', () {
    final fixture = MapCameraCandidateSceneFixture();
    final owner = MapCameraCandidateOwner(
      initialCamera: MapCameraCandidateSceneFixture.initial,
    );

    expect(
      () => owner.commitCandidate(
        candidate: MapCameraCandidateSceneFixture.candidate,
        submitCandidate: fixture.submitOverflow,
      ),
      throwsA(
        isA<MapSceneFrameValidationException>()
            .having(
              (error) => error.reason,
              'reason',
              MapSceneFrameValidationFailureReason.nodeCountExceeded,
            )
            .having((error) => error.actualNodeCount, 'actualNodeCount', 2),
      ),
    );
    expect(owner.committedCamera, MapCameraCandidateSceneFixture.initial);
  });

  test('unexpected render exception propagates without changing camera', () {
    final owner = MapCameraCandidateOwner(
      initialCamera: MapCameraCandidateSceneFixture.initial,
    );

    expect(
      () => owner.commitCandidate(
        candidate: MapCameraCandidateSceneFixture.candidate,
        submitCandidate: (_) => throw StateError('unexpected renderer bug'),
      ),
      throwsStateError,
    );
    expect(owner.committedCamera, MapCameraCandidateSceneFixture.initial);
  });
}

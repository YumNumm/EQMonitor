import 'package:eqmonitor_map/src/flutter_scene/flutter_scene_orthographic_projection.dart';
import 'package:eqmonitor_map/src/flutter_scene/scene_spike_camera.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vector_math/vector_math.dart' as scene_math;

void main() {
  group('createSceneSpikeCameraSetup', () {
    test('builds a projection covering the camera standoff', () {
      final setup = createSceneSpikeCameraSetup();

      expect(setup.projection.worldHalfHeight, 1.2);
      // depthHalfExtent must reach past the camera's standoff from the
      // drawn plane, or every quad is clipped before rasterization.
      expect(setup.projection.depthHalfExtent, closeTo(3.2, 0.000001));
    });

    test('places the camera node at the standoff distance', () {
      final setup = createSceneSpikeCameraSetup();

      final expectedTransform = scene_math.Matrix4.translationValues(
        0,
        0,
        -2,
      );
      expect(
        setup.camera.node.localTransform.storage,
        expectedTransform.storage,
      );
    });

    test('the camera reuses the same projection instance', () {
      final setup = createSceneSpikeCameraSetup();

      final cameraProjection =
          setup.camera.projection as FlutterSceneOrthographicProjection;
      expect(cameraProjection.projection, same(setup.projection));
    });
  });
}

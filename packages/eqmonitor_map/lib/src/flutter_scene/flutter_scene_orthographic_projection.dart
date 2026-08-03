import 'package:eqmonitor_map/src/renderer/eqmonitor_orthographic_projection.dart';
import 'package:flutter_scene/scene.dart' as scene;
import 'package:vector_math/vector_math.dart' as scene_math;

class FlutterSceneOrthographicProjection implements scene.CameraProjection {
  const FlutterSceneOrthographicProjection({required this.projection});

  final EqmonitorOrthographicProjection projection;

  @override
  scene_math.Matrix4 getProjectionMatrix(double aspectRatio) =>
      scene_math.Matrix4.fromList(
        projection.matrixFor(aspectRatio: aspectRatio).storage,
      );
}

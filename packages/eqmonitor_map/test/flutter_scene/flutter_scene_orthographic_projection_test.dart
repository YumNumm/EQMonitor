import 'package:eqmonitor_map/src/flutter_scene/flutter_scene_orthographic_projection.dart';
import 'package:eqmonitor_map/src/renderer/eqmonitor_orthographic_projection.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('delegates projection matrix creation to the pure projection', () {
    final pure = EqmonitorOrthographicProjection(
      worldHalfHeight: 2,
      depthHalfExtent: 3,
    );
    final projection = FlutterSceneOrthographicProjection(projection: pure);

    final actual = projection.getProjectionMatrix(1.5).storage;
    final expected = pure.matrixFor(aspectRatio: 1.5).storage;
    for (var index = 0; index < actual.length; index++) {
      expect(actual[index], closeTo(expected[index], 0.000001));
    }
  });
}

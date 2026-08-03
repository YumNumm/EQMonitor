import 'package:eqmonitor_map/eqmonitor_map.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vector_math/vector_math_64.dart';

void main() {
  test('maps north-up world bounds to clip space without bearing or pitch', () {
    final projection = EqmonitorOrthographicProjection(worldHalfHeight: 1);
    final matrix = projection.matrixFor(aspectRatio: 2);

    expect(matrix.transform3(Vector3(-2, -1, 0)), Vector3(-1, -1, 0));
    expect(matrix.transform3(Vector3(2, 1, 0)), Vector3(1, 1, 0));
  });

  test('rejects a non-finite or non-positive world half height', () {
    for (final worldHalfHeight in [0.0, -1.0, double.nan, double.infinity]) {
      expect(
        () => EqmonitorOrthographicProjection(
          worldHalfHeight: worldHalfHeight,
        ),
        throwsArgumentError,
      );
    }
  });

  test('rejects a non-finite or non-positive aspect ratio', () {
    final projection = EqmonitorOrthographicProjection(worldHalfHeight: 1);

    for (final aspectRatio in [0.0, -1.0, double.nan, double.infinity]) {
      expect(
        () => projection.matrixFor(aspectRatio: aspectRatio),
        throwsArgumentError,
      );
    }
  });
}

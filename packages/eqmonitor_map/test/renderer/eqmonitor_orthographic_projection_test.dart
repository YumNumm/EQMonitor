import 'package:eqmonitor_map/eqmonitor_map.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vector_math/vector_math_64.dart';

void main() {
  test('maps north-up world bounds to clip space without bearing or pitch', () {
    final projection = EqmonitorOrthographicProjection(
      worldHalfHeight: 1,
      depthHalfExtent: 1,
    );
    final matrix = projection.matrixFor(aspectRatio: 2);

    expect(matrix.transform3(Vector3(-2, -1, 0)), Vector3(-1, -1, 0));
    expect(matrix.transform3(Vector3(2, 1, 0)), Vector3(1, 1, 0));
  });

  test('keeps view-space depth within the half extent inside clip space', () {
    final projection = EqmonitorOrthographicProjection(
      worldHalfHeight: 1.2,
      depthHalfExtent: 3.2,
    );
    final matrix = projection.matrixFor(aspectRatio: 0.5);

    for (final viewDepth in [-3.2, -2.0, 0.0, 2.0, 3.2]) {
      expect(
        matrix.transform3(Vector3(0, 0, viewDepth)).z,
        inInclusiveRange(-1, 1),
        reason: 'view-space depth $viewDepth must survive clipping',
      );
    }
  });

  test('clips view-space depth beyond the half extent', () {
    final projection = EqmonitorOrthographicProjection(
      worldHalfHeight: 1.2,
      depthHalfExtent: 1,
    );
    final matrix = projection.matrixFor(aspectRatio: 0.5);

    expect(matrix.transform3(Vector3(0, 0, 2)).z.abs(), greaterThan(1));
  });

  test('rejects a non-finite or non-positive world half height', () {
    for (final worldHalfHeight in [0.0, -1.0, double.nan, double.infinity]) {
      expect(
        () => EqmonitorOrthographicProjection(
          worldHalfHeight: worldHalfHeight,
          depthHalfExtent: 1,
        ),
        throwsArgumentError,
      );
    }
  });

  test('rejects a non-finite or non-positive depth half extent', () {
    for (final depthHalfExtent in [0.0, -1.0, double.nan, double.infinity]) {
      expect(
        () => EqmonitorOrthographicProjection(
          worldHalfHeight: 1,
          depthHalfExtent: depthHalfExtent,
        ),
        throwsArgumentError,
      );
    }
  });

  test('rejects a non-finite or non-positive aspect ratio', () {
    final projection = EqmonitorOrthographicProjection(
      worldHalfHeight: 1,
      depthHalfExtent: 1,
    );

    for (final aspectRatio in [0.0, -1.0, double.nan, double.infinity]) {
      expect(
        () => projection.matrixFor(aspectRatio: aspectRatio),
        throwsArgumentError,
      );
    }
  });
}

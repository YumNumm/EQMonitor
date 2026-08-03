import 'package:vector_math/vector_math_64.dart';

class EqmonitorOrthographicProjection {
  factory EqmonitorOrthographicProjection({required double worldHalfHeight}) {
    if (!worldHalfHeight.isFinite || worldHalfHeight <= 0) {
      throw ArgumentError.value(
        worldHalfHeight,
        'worldHalfHeight',
        'must be finite and positive',
      );
    }
    return EqmonitorOrthographicProjection._(
      worldHalfHeight: worldHalfHeight,
    );
  }

  const EqmonitorOrthographicProjection._({required this.worldHalfHeight});

  final double worldHalfHeight;

  Matrix4 matrixFor({required double aspectRatio}) {
    if (!aspectRatio.isFinite || aspectRatio <= 0) {
      throw ArgumentError.value(
        aspectRatio,
        'aspectRatio',
        'must be finite and positive',
      );
    }
    return makeOrthographicMatrix(
      -aspectRatio * worldHalfHeight,
      aspectRatio * worldHalfHeight,
      -worldHalfHeight,
      worldHalfHeight,
      -1,
      1,
    );
  }
}

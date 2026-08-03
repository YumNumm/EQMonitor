import 'package:vector_math/vector_math_64.dart';

class EqmonitorOrthographicProjection {
  factory EqmonitorOrthographicProjection({
    required double worldHalfHeight,
    required double depthHalfExtent,
  }) {
    if (!worldHalfHeight.isFinite || worldHalfHeight <= 0) {
      throw ArgumentError.value(
        worldHalfHeight,
        'worldHalfHeight',
        'must be finite and positive',
      );
    }
    if (!depthHalfExtent.isFinite || depthHalfExtent <= 0) {
      throw ArgumentError.value(
        depthHalfExtent,
        'depthHalfExtent',
        'must be finite and positive',
      );
    }
    return EqmonitorOrthographicProjection._(
      worldHalfHeight: worldHalfHeight,
      depthHalfExtent: depthHalfExtent,
    );
  }

  const EqmonitorOrthographicProjection._({
    required this.worldHalfHeight,
    required this.depthHalfExtent,
  });

  final double worldHalfHeight;

  /// View-space depth that stays inside the clip range on either side of the
  /// camera plane.
  ///
  /// Geometry past it is clipped before rasterization, so this has to cover
  /// the camera's standoff from the drawn plane.
  final double depthHalfExtent;

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
      -depthHalfExtent,
      depthHalfExtent,
    );
  }
}

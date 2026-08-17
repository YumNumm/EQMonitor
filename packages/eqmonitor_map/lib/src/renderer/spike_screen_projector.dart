import 'dart:ui';

import 'package:vector_math/vector_math_64.dart';

class SpikeScreenProjector {
  const new();

  Offset fromClip({
    required Vector3 clip,
    required Size logicalSize,
    required double devicePixelRatio,
  }) {
    if (!clip.x.isFinite || !clip.y.isFinite || !clip.z.isFinite) {
      throw ArgumentError.value(clip, 'clip', 'coordinates must be finite');
    }
    if (!logicalSize.width.isFinite ||
        !logicalSize.height.isFinite ||
        logicalSize.width <= 0 ||
        logicalSize.height <= 0) {
      throw ArgumentError.value(
        logicalSize,
        'logicalSize',
        'dimensions must be finite and positive',
      );
    }
    if (!devicePixelRatio.isFinite || devicePixelRatio <= 0) {
      throw ArgumentError.value(
        devicePixelRatio,
        'devicePixelRatio',
        'must be finite and positive',
      );
    }
    return Offset(
      (clip.x + 1) / 2 * logicalSize.width,
      (1 - clip.y) / 2 * logicalSize.height,
    );
  }
}

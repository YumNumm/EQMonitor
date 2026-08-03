import 'package:flutter/foundation.dart';
import 'package:vector_math/vector_math_64.dart';

/// A validated vertex range for one frame-local partial mesh upload.
///
/// This hot-path value intentionally does not use Freezed or JSON
/// serialization.
@immutable
class SpikeDirtyRange {
  factory SpikeDirtyRange({required int start, required int count}) {
    RangeError.checkNotNegative(start, 'start');
    if (count <= 0) {
      throw RangeError.value(count, 'count', 'must be positive');
    }
    return SpikeDirtyRange._(start: start, count: count);
  }

  const SpikeDirtyRange._({required this.start, required this.count});

  final int start;
  final int count;

  @override
  bool operator ==(covariant SpikeDirtyRange other) =>
      start == other.start && count == other.count;

  @override
  int get hashCode => start.hashCode ^ count.hashCode;
}

/// An immutable six-vertex quad update backed by frame-local typed arrays.
///
/// This hot-path input intentionally does not use Freezed or JSON
/// serialization.
@immutable
class SpikeMeshFrame {
  const SpikeMeshFrame._({
    required this.positions,
    required this.colors,
    required this.positionDirtyRange,
    required this.colorDirtyRange,
  });

  factory SpikeMeshFrame.initial() {
    final positions = Float32List.fromList([
      -0.5,
      -0.5,
      0,
      0.5,
      -0.5,
      0,
      0.5,
      0.5,
      0,
      -0.5,
      -0.5,
      0,
      0.5,
      0.5,
      0,
      -0.5,
      0.5,
      0,
    ]);
    final colors = Float32List.fromList([
      1,
      0,
      0,
      1,
      0,
      1,
      0,
      1,
      0,
      0,
      1,
      1,
      1,
      0,
      0,
      1,
      0,
      0,
      1,
      1,
      1,
      1,
      0,
      1,
    ]);
    return SpikeMeshFrame._(
      positions: positions.asUnmodifiableView(),
      colors: colors.asUnmodifiableView(),
      positionDirtyRange: null,
      colorDirtyRange: null,
    );
  }

  final Float32List positions;
  final Float32List colors;
  final SpikeDirtyRange? positionDirtyRange;
  final SpikeDirtyRange? colorDirtyRange;

  SpikeMeshFrame moveVertex({
    required int vertexIndex,
    required Vector3 position,
  }) {
    if (vertexIndex < 0 || vertexIndex >= 6) {
      throw RangeError.range(vertexIndex, 0, 5, 'vertexIndex');
    }
    if (!position.x.isFinite || !position.y.isFinite || !position.z.isFinite) {
      throw ArgumentError.value(
        position,
        'position',
        'coordinates must be finite',
      );
    }
    final offset = vertexIndex * 3;
    final nextPositions = Float32List.fromList(positions)
      ..[offset] = position.x
      ..[offset + 1] = position.y
      ..[offset + 2] = position.z;
    return SpikeMeshFrame._(
      positions: nextPositions.asUnmodifiableView(),
      colors: colors,
      positionDirtyRange: SpikeDirtyRange(start: vertexIndex, count: 1),
      colorDirtyRange: null,
    );
  }

  SpikeMeshFrame recolorVertex({
    required int vertexIndex,
    required Vector4 color,
  }) {
    if (vertexIndex < 0 || vertexIndex >= 6) {
      throw RangeError.range(vertexIndex, 0, 5, 'vertexIndex');
    }
    if (!color.x.isFinite ||
        !color.y.isFinite ||
        !color.z.isFinite ||
        !color.w.isFinite) {
      throw ArgumentError.value(color, 'color', 'components must be finite');
    }
    final offset = vertexIndex * 4;
    final nextColors = Float32List.fromList(colors)
      ..[offset] = color.x
      ..[offset + 1] = color.y
      ..[offset + 2] = color.z
      ..[offset + 3] = color.w;
    return SpikeMeshFrame._(
      positions: positions,
      colors: nextColors.asUnmodifiableView(),
      positionDirtyRange: null,
      colorDirtyRange: SpikeDirtyRange(start: vertexIndex, count: 1),
    );
  }

  SpikeMeshFrame updateVertex({
    required int vertexIndex,
    required Vector3 position,
    required Vector4 color,
  }) {
    final positionFrame = moveVertex(
      vertexIndex: vertexIndex,
      position: position,
    );
    final colorFrame = positionFrame.recolorVertex(
      vertexIndex: vertexIndex,
      color: color,
    );
    return SpikeMeshFrame._(
      positions: colorFrame.positions,
      colors: colorFrame.colors,
      positionDirtyRange: SpikeDirtyRange(start: vertexIndex, count: 1),
      colorDirtyRange: colorFrame.colorDirtyRange,
    );
  }
}

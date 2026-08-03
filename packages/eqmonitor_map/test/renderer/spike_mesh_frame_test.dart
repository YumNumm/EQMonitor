import 'dart:typed_data';

import 'package:eqmonitor_map/eqmonitor_map.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vector_math/vector_math_64.dart';

void main() {
  test('changes one vertex and exposes the exact dirty range', () {
    final initial = SpikeMeshFrame.initial();
    final next = initial.moveVertex(
      vertexIndex: 2,
      position: Vector3(0.75, 0.5, 0),
    );

    expect(next.positionDirtyRange, SpikeDirtyRange(start: 2, count: 1));
    expect(next.colorDirtyRange, isNull);
    expect(next.positions.sublist(6, 9), [0.75, 0.5, 0]);
    expect(initial.positions.sublist(6, 9), isNot([0.75, 0.5, 0]));
  });

  test('recolors one vertex without uploading positions', () {
    final next = SpikeMeshFrame.initial().recolorVertex(
      vertexIndex: 4,
      color: Vector4(1, 0, 0, 1),
    );

    expect(next.positionDirtyRange, isNull);
    expect(next.colorDirtyRange, SpikeDirtyRange(start: 4, count: 1));
    expect(next.colors.sublist(16, 20), [1, 0, 0, 1]);
  });

  test('updates position and color with both exact dirty ranges', () {
    final next = SpikeMeshFrame.initial().updateVertex(
      vertexIndex: 5,
      position: Vector3(-0.75, 0.25, 0),
      color: Vector4(0, 1, 0, 1),
    );

    expect(next.positionDirtyRange, SpikeDirtyRange(start: 5, count: 1));
    expect(next.colorDirtyRange, SpikeDirtyRange(start: 5, count: 1));
    expect(next.positions.sublist(15, 18), [-0.75, 0.25, 0]);
    expect(next.colors.sublist(20, 24), [0, 1, 0, 1]);
  });

  test('stores one six-vertex quad in immutable typed arrays', () {
    final frame = SpikeMeshFrame.initial();

    expect(frame.positions, isA<Float32List>());
    expect(frame.colors, isA<Float32List>());
    expect(frame.positions, hasLength(18));
    expect(frame.colors, hasLength(24));
    expect(() => frame.positions[0] = 0, throwsUnsupportedError);
    expect(() => frame.colors[0] = 0, throwsUnsupportedError);
  });

  test('rejects invalid dirty ranges', () {
    expect(
      () => SpikeDirtyRange(start: -1, count: 1),
      throwsRangeError,
    );
    expect(
      () => SpikeDirtyRange(start: 0, count: 0),
      throwsRangeError,
    );
  });

  test('rejects vertex indices outside the six-vertex quad', () {
    final frame = SpikeMeshFrame.initial();

    for (final vertexIndex in [-1, 6]) {
      expect(
        () => frame.moveVertex(
          vertexIndex: vertexIndex,
          position: Vector3.zero(),
        ),
        throwsRangeError,
      );
    }
  });

  test('rejects non-finite vertex attributes', () {
    final frame = SpikeMeshFrame.initial();

    expect(
      () => frame.moveVertex(
        vertexIndex: 0,
        position: Vector3(double.nan, 0, 0),
      ),
      throwsArgumentError,
    );
    expect(
      () => frame.recolorVertex(
        vertexIndex: 0,
        color: Vector4(0, 0, double.infinity, 1),
      ),
      throwsArgumentError,
    );
  });
}

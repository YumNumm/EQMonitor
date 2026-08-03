import 'dart:ui';

import 'package:eqmonitor_map/src/renderer/spike_screen_projector.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vector_math/vector_math_64.dart';

void main() {
  test('projects north to the top in logical pixels at every DPR', () {
    const projector = SpikeScreenProjector();

    expect(
      projector.fromClip(
        clip: Vector3(0, 1, 0),
        logicalSize: const Size(200, 100),
        devicePixelRatio: 3,
      ),
      const Offset(100, 0),
    );
    expect(
      projector.fromClip(
        clip: Vector3(1, -1, 0),
        logicalSize: const Size(100, 200),
        devicePixelRatio: 1,
      ),
      const Offset(100, 200),
    );
  });

  test('recalculates logical pixels for a resized viewport', () {
    const projector = SpikeScreenProjector();
    final clip = Vector3(0.5, -0.5, 0);

    expect(
      projector.fromClip(
        clip: clip,
        logicalSize: const Size(200, 100),
        devicePixelRatio: 2,
      ),
      const Offset(150, 75),
    );
    expect(
      projector.fromClip(
        clip: clip,
        logicalSize: const Size(400, 200),
        devicePixelRatio: 2,
      ),
      const Offset(300, 150),
    );
  });

  test('rejects invalid logical dimensions and device pixel ratios', () {
    const projector = SpikeScreenProjector();
    final clip = Vector3.zero();

    for (final logicalSize in [
      const Size(0, 100),
      const Size(100, -1),
      const Size(double.infinity, 100),
    ]) {
      expect(
        () => projector.fromClip(
          clip: clip,
          logicalSize: logicalSize,
          devicePixelRatio: 1,
        ),
        throwsArgumentError,
      );
    }
    for (final devicePixelRatio in [
      0.0,
      -1.0,
      double.nan,
      double.infinity,
    ]) {
      expect(
        () => projector.fromClip(
          clip: clip,
          logicalSize: const Size(100, 100),
          devicePixelRatio: devicePixelRatio,
        ),
        throwsArgumentError,
      );
    }
  });

  test('rejects a non-finite clip coordinate', () {
    const projector = SpikeScreenProjector();

    expect(
      () => projector.fromClip(
        clip: Vector3(double.nan, 0, 0),
        logicalSize: const Size(100, 100),
        devicePixelRatio: 1,
      ),
      throwsArgumentError,
    );
  });
}

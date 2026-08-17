import 'package:eqmonitor_map/src/renderer/spike_screen_projector.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart';

class SpikeLabelPaintLayout {
  const new({
    required this.anchor,
    required this.paintOffset,
  });

  final Offset anchor;
  final Offset paintOffset;
}

class SpikeLabelLayout {
  const new({
    required this.projectionMatrix,
    required this.geographicAnchor,
    required this.logicalSize,
    required this.devicePixelRatio,
    required this.label,
    required this.style,
  });

  final Matrix4 projectionMatrix;
  final Vector3 geographicAnchor;
  final Size logicalSize;
  final double devicePixelRatio;
  final String label;
  final TextStyle style;

  SpikeLabelPaintLayout calculate() {
    final homogeneousAnchor = projectionMatrix.transform(
      Vector4(
        geographicAnchor.x,
        geographicAnchor.y,
        geographicAnchor.z,
        1,
      ),
    );
    if (homogeneousAnchor.w == 0) {
      throw StateError('Label anchor cannot be projected with w = 0.');
    }
    final anchor = const SpikeScreenProjector().fromClip(
      clip: Vector3(
        homogeneousAnchor.x / homogeneousAnchor.w,
        homogeneousAnchor.y / homogeneousAnchor.w,
        homogeneousAnchor.z / homogeneousAnchor.w,
      ),
      logicalSize: logicalSize,
      devicePixelRatio: devicePixelRatio,
    );
    final textPainter = TextPainter(
      text: TextSpan(text: label, style: style),
      textDirection: TextDirection.ltr,
    )..layout();
    return SpikeLabelPaintLayout(
      anchor: anchor,
      paintOffset: Offset(
        anchor.dx - textPainter.width / 2,
        anchor.dy - textPainter.height / 2,
      ),
    );
  }
}

class SpikeLabelPainter extends CustomPainter {
  const new({
    required this.projectionMatrix,
    required this.geographicAnchor,
    required this.logicalSize,
    required this.devicePixelRatio,
    required this.label,
    required this.style,
  });

  final Matrix4 projectionMatrix;
  final Vector3 geographicAnchor;
  final Size logicalSize;
  final double devicePixelRatio;
  final String label;
  final TextStyle style;

  @override
  void paint(Canvas canvas, Size size) {
    final layout = SpikeLabelLayout(
      projectionMatrix: projectionMatrix,
      geographicAnchor: geographicAnchor,
      logicalSize: logicalSize,
      devicePixelRatio: devicePixelRatio,
      label: label,
      style: style,
    ).calculate();
    TextPainter(
        text: TextSpan(text: label, style: style),
        textDirection: TextDirection.ltr,
      )
      ..layout()
      ..paint(canvas, layout.paintOffset);
  }

  @override
  bool shouldRepaint(covariant SpikeLabelPainter oldDelegate) =>
      oldDelegate.projectionMatrix != projectionMatrix ||
      oldDelegate.geographicAnchor != geographicAnchor ||
      oldDelegate.logicalSize != logicalSize ||
      oldDelegate.devicePixelRatio != devicePixelRatio ||
      oldDelegate.label != label ||
      oldDelegate.style != style;
}

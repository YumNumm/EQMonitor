import 'package:eqmonitor_map/src/flutter_scene/spike_label_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vector_math/vector_math_64.dart';

void main() {
  test('centers the measured label on the projected geographic anchor', () {
    const logicalSize = Size(200, 100);
    const label = '震源';
    const style = TextStyle(fontSize: 20);
    final layout = SpikeLabelLayout(
      projectionMatrix: Matrix4.identity(),
      geographicAnchor: Vector3.zero(),
      logicalSize: logicalSize,
      devicePixelRatio: 2,
      label: label,
      style: style,
    ).calculate();
    final textPainter = TextPainter(
      text: const TextSpan(text: label, style: style),
      textDirection: TextDirection.ltr,
    )..layout();

    expect(layout.anchor, const Offset(100, 50));
    expect(
      layout.paintOffset,
      Offset(
        100 - textPainter.width / 2,
        50 - textPainter.height / 2,
      ),
    );
  });
}

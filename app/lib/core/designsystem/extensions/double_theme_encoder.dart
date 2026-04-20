import 'dart:ui' as ui;

import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

class DoubleThemeEncoder extends ThemeEncoder<double> {
  const DoubleThemeEncoder();

  @override
  double lerp(double a, double b, double t) => ui.lerpDouble(a, b, t) ?? a;
}

const doubleThemeEncoder = DoubleThemeEncoder();

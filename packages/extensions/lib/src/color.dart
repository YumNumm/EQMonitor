import 'dart:ui';

extension ColorEx on Color {
  int get sRgbValue {
    final sRgb = withValues(
      colorSpace: ColorSpace.sRGB,
    );
    final r = (sRgb.r * 255).toInt();
    final g = (sRgb.g * 255).toInt();
    final b = (sRgb.b * 255).toInt();
    return r << 16 | g << 8 | b;
  }
}

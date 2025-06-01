import 'dart:ui';

/// Color クラスの拡張機能
extension ColorCode on Color {
  /// sRGB色空間における Hexカラーコードを取得
  int get hex {
    // 色をsRGBに変換
    final color = withValues(colorSpace: ColorSpace.sRGB);
    // color.{r,g,b}は0~1までの値なので、255倍にする
    final r = (color.r * 255).toInt();
    final g = (color.g * 255).toInt();
    final b = (color.b * 255).toInt();
    return (r << 16) + (g << 8) + b;
  }
}

import 'dart:math' as math;

class HsvColor {
  /// 任意のRGB値からHSV値を生成する
  /// [r] 赤の値(0-255)
  /// [g] 緑の値(0-255)
  /// [b] 青の値(0-255)
  /// [a] アルファ値(0-255)
  factory fromRgb(num r, num g, num b, num a) {
    assert(r >= 0 && r <= 255, 'r must be between 0 and 255');
    assert(g >= 0 && g <= 255, 'g must be between 0 and 255');
    assert(b >= 0 && b <= 255, 'b must be between 0 and 255');
    assert(a >= 0 && a <= 255, 'a must be between 0 and 255');

    final red = r / 0xFF;
    final green = g / 0xFF;
    final blue = b / 0xFF;

    final max = math.max(red, math.max(green, blue));
    final min = math.min(red, math.min(green, blue));
    final delta = max - min;

    final alpha = a / 0xFF;
    // 無彩色は色相を持たないため、除算より先に扱う。
    final hue = switch (max) {
      _ when delta == 0 => 0.0,
      _ when max == red => 60.0 * (((green - blue) / delta) % 6),
      _ when max == green => 60.0 * (((blue - red) / delta) + 2),
      _ => 60.0 * (((red - green) / delta) + 4),
    };
    final saturation = max == .0 ? 0.0 : delta / max;
    final value = max;

    return HsvColor._fromAHSV(alpha, hue, saturation, value);
  }

  const new _fromAHSV(this.alpha, this.hue, this.saturation, this.value)
    : assert(alpha >= 0.0, 'alpha must be between 0.0 and 1.0'),
      assert(alpha <= 1.0, 'alpha must be between 0.0 and 1.0'),
      assert(hue >= 0.0, 'hue must be between 0.0 and 360.0'),
      assert(hue <= 360.0, 'hue must be between 0.0 and 360.0'),
      assert(saturation >= 0.0, 'saturation must be between 0.0 and 1.0'),
      assert(saturation <= 1.0, 'saturation must be between 0.0 and 1.0'),
      assert(value >= 0.0, 'value must be between 0.0 and 1.0'),
      assert(value <= 1.0, 'value must be between 0.0 and 1.0');

  final double alpha;
  final double hue;
  final double saturation;
  final double value;
}

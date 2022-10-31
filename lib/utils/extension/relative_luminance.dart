import 'dart:math';

import 'package:flutter/material.dart';

/// 背景色が明るい色であれば、黒を、暗い色であれば白を返す
/// ref: https://zenn.dev/mryhryki/articles/2020-11-12-hatena-background-color
extension OnPrimary on Color {
  Color get onPrimary {
    final darkRatio = getContrastRatio(this, Colors.black);
    final lightRatio = getContrastRatio(this, Colors.white);

    return darkRatio > lightRatio ? Colors.black : Colors.white;
  }
}

/// コントラスト比を取得
/// [color1]と[color2]間のコントラスト比を計算します
///
double getContrastRatio(Color color1, Color color2) {
  final luminance1 = color1.computeLuminance();
  final luminance2 = color2.computeLuminance();

  final bright = max(luminance1, luminance2);
  final dark = min(luminance1, luminance2);
  return (bright + 0.05) / (dark + 0.05);
}

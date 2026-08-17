import 'package:material_ui/material_ui.dart';

/// WCAG コントラスト比に基づく前景色の導出ユーティリティ。
class ContrastColorUtil {
  const new _();

  /// [background]に対してWCAGコントラスト比がより高い前景色（黒/白）を導出する。
  ///
  /// 白/黒それぞれと[background]とのコントラスト比を計算し、
  /// より読みやすい（コントラスト比が高い）方を返す。
  /// - 白とのコントラスト比: `1.05 / (Lbg + 0.05)`
  /// - 黒とのコントラスト比: `(Lbg + 0.05) / 0.05`
  static Color onColorForBackground(Color background) {
    final luminance = background.computeLuminance();
    final contrastWithWhite = 1.05 / (luminance + 0.05);
    final contrastWithBlack = (luminance + 0.05) / 0.05;
    return contrastWithBlack >= contrastWithWhite ? Colors.black : Colors.white;
  }
}

import 'package:eqmonitor/core/designsystem/extensions/typography_theme_extension.dart';
import 'package:material_ui/material_ui.dart';

/// Live Activity は文字サイズに応じた光学サイズが自動で効く。Flutter では明示しないと既定値のまま字形と字間がずれる。
class EewCardFlexTextStyle extends TextStyle {
  new({
    required double size,
    required FontWeight weight,
    required Color color,
  }) : super(
         fontFamily: primaryFontFamily,
         fontFamilyFallback: japaneseFontFamilyFallback,
         fontSize: size,
         height: EewCardCodeTextStyle.lineHeight,
         fontWeight: weight,
         fontVariations: [
           FontVariation.opticalSize(size),
           FontVariation.weight(weight.value.toDouble()),
         ],
         letterSpacing: 0,
         color: color,
       );
}

class EewCardCodeTextStyle extends TextStyle {
  new({
    required double size,
    required FontWeight weight,
    required Color color,
  }) : super(
         fontFamily: codeFontFamily,
         fontFamilyFallback: japaneseFontFamilyFallback,
         fontSize: size,
         height: lineHeight,
         fontWeight: weight,
         fontVariations: [FontVariation.weight(weight.value.toDouble())],
         letterSpacing: 0,
         color: color,
       );

  static const lineHeight = 1.25;
}

import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:flutter/material.dart';

/// 震源要素（マグニチュード・深さ・震源地など）のラベル/値表示で共通利用する
/// TextStyle 拡張。
extension EarthquakeInfoTextStyle on TextTheme {
  TextStyle labelStyle(TextStyle base) {
    return base.copyWith(
      color: base.color!.withValues(alpha: 0.8),
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle valueStyle(TextStyle base) {
    return base.copyWith(
      fontWeight: FontWeight.bold,
      fontFamily: FontFamily.notoSansJP,
    );
  }
}

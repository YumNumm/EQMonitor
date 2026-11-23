import 'package:material_ui/material_ui.dart';

class const EstimatedIntensityScaleColorResolver() {
  // 各震度階級の下限に気象庁の推計震度分布図の階級色を置き、その間を補間する。
  static const anchors = <(int, Color)>[
    (35, Color(0xFFFAE696)),
    (45, Color(0xFFFFE600)),
    (50, Color(0xFFFF9900)),
    (55, Color(0xFFFF2800)),
    (60, Color(0xFFA50021)),
    (65, Color(0xFFB40068)),
    (70, Color(0xFF6E0040)),
  ];

  Color resolve({required int tenths}) {
    if (tenths <= anchors.first.$1) {
      return anchors.first.$2;
    }
    for (var index = 1; index < anchors.length; index++) {
      final (upperTenths, upperColor) = anchors[index];
      if (tenths > upperTenths) {
        continue;
      }
      final (lowerTenths, lowerColor) = anchors[index - 1];
      return Color.lerp(
            lowerColor,
            upperColor,
            (tenths - lowerTenths) / (upperTenths - lowerTenths),
          ) ??
          upperColor;
    }
    return anchors.last.$2;
  }
}

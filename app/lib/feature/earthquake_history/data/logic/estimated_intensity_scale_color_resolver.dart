import 'package:eqmonitor/core/theme/model/estimated_intensity_colors.dart';
import 'package:material_ui/material_ui.dart';

class const EstimatedIntensityScaleColorResolver({
  required final EstimatedIntensityColors colors,
}) {
  // 各震度階級の計測震度の中央に階級色を置き、その間を補間する。
  List<(double, Color)> get anchors => [
    (40, colors.four.background),
    (47.5, colors.fiveLower.background),
    (52.5, colors.fiveUpper.background),
    (57.5, colors.sixLower.background),
    (62.5, colors.sixUpper.background),
    (67.5, colors.seven.background),
  ];

  Color resolve({required int tenths}) {
    final points = anchors;
    if (tenths <= points.first.$1) {
      return points.first.$2;
    }
    for (var index = 1; index < points.length; index++) {
      final (upperTenths, upperColor) = points[index];
      if (tenths > upperTenths) {
        continue;
      }
      final (lowerTenths, lowerColor) = points[index - 1];
      return Color.lerp(
            lowerColor,
            upperColor,
            (tenths - lowerTenths) / (upperTenths - lowerTenths),
          ) ??
          upperColor;
    }
    return points.last.$2;
  }
}

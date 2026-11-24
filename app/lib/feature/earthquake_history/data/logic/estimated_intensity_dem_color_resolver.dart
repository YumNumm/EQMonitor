import 'package:collection/collection.dart';
import 'package:eqmonitor/core/extension/kyoshin_color_map_model.dart';
import 'package:eqmonitor/core/theme/model/estimated_intensity_colors.dart';
import 'package:eqmonitor/feature/earthquake_history/data/logic/estimated_intensity_scale_color_resolver.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/estimated_intensity_dem_display_mode.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/estimated_intensity_dem_palette.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_color_map_model.dart';
import 'package:material_ui/material_ui.dart';

class const EstimatedIntensityDemColorResolver({
  required final EstimatedIntensityDemDisplayMode displayMode,
  required final EstimatedIntensityDemPalette palette,
  required final EstimatedIntensityColors classColors,
  required final List<KyoshinColorMapModel> kyoshinColorMap,
}) {
  static const minTenths = 35;
  static const maxTenths = 70;

  Color resolve({required int tenths}) => switch ((displayMode, palette)) {
    (.intensityClass, _) => switch (tenths) {
      < 45 => classColors.four,
      < 50 => classColors.fiveLower,
      < 55 => classColors.fiveUpper,
      < 60 => classColors.sixLower,
      < 65 => classColors.sixUpper,
      _ => classColors.seven,
    }.background,
    (.tenth, .intensityGradient) => EstimatedIntensityScaleColorResolver(
      colors: classColors,
    ).resolve(tenths: tenths),
    (.tenth, .kyoshinMonitor) =>
      minBy(
            kyoshinColorMap,
            (entry) => ((entry.intensity * 10).round() - tenths).abs(),
          )?.color ??
          EstimatedIntensityScaleColorResolver(
            colors: classColors,
          ).resolve(tenths: tenths),
  };

  List<Color> scaleColors() => [
    for (var tenths = minTenths; tenths <= maxTenths; tenths++)
      resolve(tenths: tenths),
  ];
}

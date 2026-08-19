import 'dart:typed_data';

import 'package:eqmonitor/core/component/intenisty/jma_intensity_icon.dart';
import 'package:eqmonitor/core/component/intenisty/jma_lpgm_intensity_icon.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/core/theme/build_theme.dart';
import 'package:eqmonitor/core/theme/model/theme_color_set.dart';
import 'package:eqmonitor/core/util/widget_to_image.dart';
import 'package:eqmonitor/feature/map/features/icon/data/model/intensity_icon.dart';
import 'package:material_ui/material_ui.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'intensity_icon_repository.g.dart';

@Riverpod(keepAlive: true)
IntensityIconRepository intensityIconRepository(Ref ref) =>
    const IntensityIconRepository();

final class IntensityIconRepository {
  const new();

  Future<Uint8List> renderJmaIntensityIcon({
    required JmaIntensity intensity,
    required IntensityIconType type,
    required ThemeColorSet colorSet,
    required Brightness brightness,
  }) async {
    final bytes = await WidgetImageRenderer.render(
      logicalSize: const Size(50, 50),
      widget: Theme(
        data: AppThemeDataBuilder.build(
          colorSet: colorSet,
          brightness: brightness,
        ),
        child: JmaIntensityIcon(intensity: intensity, type: type),
      ),
    );
    if (bytes == null) {
      throw Exception('Failed to render JmaIntensityIcon');
    }
    return bytes;
  }

  Future<Uint8List> renderJmaLpgmIntensityIcon({
    required JmaLpgmIntensity intensity,
    required IntensityIconType type,
    required ThemeColorSet colorSet,
    required Brightness brightness,
  }) async {
    final bytes = await WidgetImageRenderer.render(
      logicalSize: const Size(50, 50),
      widget: Theme(
        data: AppThemeDataBuilder.build(
          colorSet: colorSet,
          brightness: brightness,
        ),
        child: JmaLpgmIntensityIcon(intensity: intensity, type: type),
      ),
    );
    if (bytes == null) {
      throw Exception('Failed to render JmaLpgmIntensityIcon');
    }
    return bytes;
  }
}

import 'dart:typed_data';
import 'dart:ui';

import 'package:eqmonitor/core/component/intenisty/jma_intensity_icon.dart';
import 'package:eqmonitor/core/component/intenisty/jma_lpgm_intensity_icon.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:eqmonitor/core/util/widget_to_image.dart';
import 'package:eqmonitor/feature/map/features/icon/data/model/intensity_icon.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'intensity_icon_repository.g.dart';

@Riverpod(keepAlive: true)
IntensityIconRepository intensityIconRepository(Ref ref) =>
    const IntensityIconRepository();

final class IntensityIconRepository {
  const IntensityIconRepository();

  Future<Uint8List> renderJmaIntensityIcon({
    required JmaIntensity intensity,
    required IntensityIconType type,
    required IntensityColorModel intensityColorModel,
  }) async {
    final bytes = await renderWidgetToImageBytes(
      logicalSize: const Size(50, 50),
      widget: ProviderScope(
        overrides: [
          intensityColorProvider.overrideWithValue(intensityColorModel),
        ],
        child: JmaIntensityIcon(
          intensity: intensity,
          type: type,
        ),
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
    required IntensityColorModel intensityColorModel,
  }) async {
    final bytes = await renderWidgetToImageBytes(
      logicalSize: const Size(50, 50),
      widget: ProviderScope(
        overrides: [
          intensityColorProvider.overrideWithValue(intensityColorModel),
        ],
        child: JmaLpgmIntensityIcon(
          intensity: intensity,
          type: type,
        ),
      ),
    );
    if (bytes == null) {
      throw Exception('Failed to render JmaLpgmIntensityIcon');
    }
    return bytes;
  }
}

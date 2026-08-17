import 'dart:typed_data';

import 'package:eqmonitor/core/theme/build_theme.dart';
import 'package:eqmonitor/core/theme/provider/app_theme_notifier.dart';
import 'package:eqmonitor/core/theme/theme_provider.dart';
import 'package:eqmonitor/core/util/widget_to_image.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/shindo_db_intensity_class.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/shindo_db_intensity_class_icon.dart';
import 'package:material_ui/material_ui.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shindo_db_intensity_icon_provider.g.dart';

/// 震度データベース固有の震度階級 (旧階級 5/6・歴史的階級) の地図用アイコン
///
/// 現行の JMA 震度と一致する階級は intensityIconProvider の画像を流用するため、
/// ここでは [ShindoDbIntensityClass.exactJmaIntensity] を持たない階級のみ描画する。
@Riverpod(keepAlive: true)
Future<Map<ShindoDbIntensityClass, Uint8List>> shindoDbIntensityIcon(
  Ref ref,
) async {
  final colorSet = ref.watch(activeColorSetProvider);
  final brightness = ref.watch(brightnessProvider);

  final result = <ShindoDbIntensityClass, Uint8List>{};
  final futures = <Future<void>>[];
  for (final cls in ShindoDbIntensityClass.values.where(
    (cls) => cls.exactJmaIntensity == null,
  )) {
    futures.add(() async {
      final bytes = await WidgetImageRenderer.render(
        logicalSize: const Size(50, 50),
        widget: Theme(
          data: AppThemeDataBuilder.build(
            colorSet: colorSet,
            brightness: brightness,
          ),
          child: ShindoDbIntensityClassMapIcon(intensityClass: cls),
        ),
      );
      if (bytes == null) {
        throw Exception('Failed to render ShindoDbIntensityClassMapIcon');
      }
      result[cls] = bytes;
    }());
  }
  await futures.wait;
  return result;
}

extension ShindoDbIntensityIconEx on Map<ShindoDbIntensityClass, Uint8List> {
  Map<String, Uint8List> get toMapStyleImages => {
    for (final entry in entries) entry.key.mapIconId: entry.value,
  };
}

import 'dart:typed_data';

import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/core/theme/provider/app_theme_notifier.dart';
import 'package:eqmonitor/core/theme/theme_provider.dart';
import 'package:eqmonitor/core/util/nullable_value_requirement.dart';
import 'package:eqmonitor/feature/map/features/icon/data/model/intensity_icon.dart';
import 'package:eqmonitor/feature/map/features/icon/data/model/intensity_icon_data.dart';
import 'package:eqmonitor/feature/map/features/icon/data/model/intensity_icon_jma_intensity.dart';
import 'package:eqmonitor/feature/map/features/icon/data/model/intensity_icon_jma_lpgm_intensity.dart';
import 'package:eqmonitor/feature/map/features/icon/data/repository/intensity_icon_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'intensity_icon_provider.g.dart';

@Riverpod(keepAlive: true)
Future<IntensityIconData> intensityIcon(Ref ref) async {
  final repository = ref.watch(intensityIconRepositoryProvider);
  final colorSet = ref.watch(activeColorSetProvider);
  final brightness = ref.watch(brightnessProvider);

  final futures = <Future<void>>[];
  final jmaIntensityMap = <IntensityIconType, Map<JmaIntensity, Uint8List>>{};
  final jmaLpgmIntensityMap =
      <IntensityIconType, Map<JmaLpgmIntensity, Uint8List>>{};
  for (final intensity in JmaIntensity.values) {
    for (final type in IntensityIconType.values) {
      futures.add(() async {
        final bytes = await repository.renderJmaIntensityIcon(
          intensity: intensity,
          type: type,
          colorSet: colorSet,
          brightness: brightness,
        );
        jmaIntensityMap.putIfAbsent(type, () => {})[intensity] = bytes;
      }());
    }
  }
  for (final intensity in JmaLpgmIntensity.values) {
    for (final type in IntensityIconType.values) {
      futures.add(() async {
        final bytes = await repository.renderJmaLpgmIntensityIcon(
          intensity: intensity,
          type: type,
          colorSet: colorSet,
          brightness: brightness,
        );
        jmaLpgmIntensityMap.putIfAbsent(type, () => {})[intensity] = bytes;
      }());
    }
  }
  await futures.wait;
  assert(
    jmaIntensityMap.entries.every(
      (e) => e.value.length == JmaIntensity.values.length,
    ),
    'jmaIntensityMap values must be the same length as JmaIntensity values',
  );
  assert(
    jmaIntensityMap.entries.length == IntensityIconType.values.length,
    'jmaIntensityMap entries must be the same length as IntensityIconType values',
  );
  assert(
    jmaLpgmIntensityMap.entries.every(
      (e) => e.value.length == JmaLpgmIntensity.values.length,
    ),
    'jmaLpgmIntensityMap values must be the same length as JmaLpgmIntensity values',
  );
  assert(
    jmaLpgmIntensityMap.entries.length == IntensityIconType.values.length,
    'jmaLpgmIntensityMap entries must be the same length as IntensityIconType values',
  );
  const reason = '直前のループでIntensityIconType.valuesすべてに対して描画済み';
  return IntensityIconData(
    jmaIntensity: IntensityIconJmaIntensity(
      filled: jmaIntensityMap[IntensityIconType.filled].orFailBecause(reason),
      small: jmaIntensityMap[IntensityIconType.small].orFailBecause(reason),
      smallWithoutText: jmaIntensityMap[IntensityIconType.smallWithoutText]
          .orFailBecause(reason),
    ),
    lpgmIntensity: IntensityIconJmaLpgmIntensity(
      filled: jmaLpgmIntensityMap[IntensityIconType.filled].orFailBecause(
        reason,
      ),
      small: jmaLpgmIntensityMap[IntensityIconType.small].orFailBecause(reason),
      smallWithoutText: jmaLpgmIntensityMap[IntensityIconType.smallWithoutText]
          .orFailBecause(reason),
    ),
  );
}

extension IntensityIconProviderEx on IntensityIconData {
  Map<String, Uint8List> get toMapStyleImages => {
    for (final entry in jmaIntensity.filled.entries)
      'JmaIntensity.${IntensityIconType.filled.name}.${entry.key.name}':
          entry.value,
    for (final entry in jmaIntensity.small.entries)
      'JmaIntensity.${IntensityIconType.small.name}.${entry.key.name}':
          entry.value,
    for (final entry in jmaIntensity.smallWithoutText.entries)
      'JmaIntensity.${IntensityIconType.smallWithoutText.name}.${entry.key.name}':
          entry.value,
    for (final entry in lpgmIntensity.filled.entries)
      'JmaLpgmIntensity.${IntensityIconType.filled.name}.${entry.key.name}':
          entry.value,
    for (final entry in lpgmIntensity.small.entries)
      'JmaLpgmIntensity.${IntensityIconType.small.name}.${entry.key.name}':
          entry.value,
    for (final entry in lpgmIntensity.smallWithoutText.entries)
      'JmaLpgmIntensity.${IntensityIconType.smallWithoutText.name}.${entry.key.name}':
          entry.value,
  };
}

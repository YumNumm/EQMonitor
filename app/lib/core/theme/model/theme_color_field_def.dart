import 'package:eqmonitor/core/theme/model/theme_color_set.dart';
import 'package:flutter/material.dart';

enum ThemeColorFieldCategory {
  primary,
  secondary,
  tertiary,
  error,
  surface,
  status,
  map,
}

class ThemeColorFieldDef {
  const ThemeColorFieldDef({
    required this.label,
    required this.category,
    required this.getter,
    required this.setter,
  });

  final String label;
  final ThemeColorFieldCategory category;
  final Color Function(ThemeColorSet colorSet) getter;
  final ThemeColorSet Function(ThemeColorSet colorSet, Color color) setter;
}

final List<ThemeColorFieldDef> themeColorFieldDefs = [
  ThemeColorFieldDef(
    label: 'Primary',
    category: ThemeColorFieldCategory.primary,
    getter: (colorSet) => colorSet.primary,
    setter: (colorSet, color) => colorSet.copyWith(primary: color),
  ),
  ThemeColorFieldDef(
    label: 'On Primary',
    category: ThemeColorFieldCategory.primary,
    getter: (colorSet) => colorSet.onPrimary,
    setter: (colorSet, color) => colorSet.copyWith(onPrimary: color),
  ),
  ThemeColorFieldDef(
    label: 'Primary Container',
    category: ThemeColorFieldCategory.primary,
    getter: (colorSet) => colorSet.primaryContainer,
    setter: (colorSet, color) => colorSet.copyWith(primaryContainer: color),
  ),
  ThemeColorFieldDef(
    label: 'On Primary Container',
    category: ThemeColorFieldCategory.primary,
    getter: (colorSet) => colorSet.onPrimaryContainer,
    setter: (colorSet, color) => colorSet.copyWith(onPrimaryContainer: color),
  ),
  ThemeColorFieldDef(
    label: 'Secondary',
    category: ThemeColorFieldCategory.secondary,
    getter: (colorSet) => colorSet.secondary,
    setter: (colorSet, color) => colorSet.copyWith(secondary: color),
  ),
  ThemeColorFieldDef(
    label: 'On Secondary',
    category: ThemeColorFieldCategory.secondary,
    getter: (colorSet) => colorSet.onSecondary,
    setter: (colorSet, color) => colorSet.copyWith(onSecondary: color),
  ),
  ThemeColorFieldDef(
    label: 'Secondary Container',
    category: ThemeColorFieldCategory.secondary,
    getter: (colorSet) => colorSet.secondaryContainer,
    setter: (colorSet, color) => colorSet.copyWith(secondaryContainer: color),
  ),
  ThemeColorFieldDef(
    label: 'On Secondary Container',
    category: ThemeColorFieldCategory.secondary,
    getter: (colorSet) => colorSet.onSecondaryContainer,
    setter: (colorSet, color) =>
        colorSet.copyWith(onSecondaryContainer: color),
  ),
  ThemeColorFieldDef(
    label: 'Tertiary',
    category: ThemeColorFieldCategory.tertiary,
    getter: (colorSet) => colorSet.tertiary,
    setter: (colorSet, color) => colorSet.copyWith(tertiary: color),
  ),
  ThemeColorFieldDef(
    label: 'On Tertiary',
    category: ThemeColorFieldCategory.tertiary,
    getter: (colorSet) => colorSet.onTertiary,
    setter: (colorSet, color) => colorSet.copyWith(onTertiary: color),
  ),
  ThemeColorFieldDef(
    label: 'Tertiary Container',
    category: ThemeColorFieldCategory.tertiary,
    getter: (colorSet) => colorSet.tertiaryContainer,
    setter: (colorSet, color) => colorSet.copyWith(tertiaryContainer: color),
  ),
  ThemeColorFieldDef(
    label: 'On Tertiary Container',
    category: ThemeColorFieldCategory.tertiary,
    getter: (colorSet) => colorSet.onTertiaryContainer,
    setter: (colorSet, color) =>
        colorSet.copyWith(onTertiaryContainer: color),
  ),
  ThemeColorFieldDef(
    label: 'Error',
    category: ThemeColorFieldCategory.error,
    getter: (colorSet) => colorSet.error,
    setter: (colorSet, color) => colorSet.copyWith(error: color),
  ),
  ThemeColorFieldDef(
    label: 'On Error',
    category: ThemeColorFieldCategory.error,
    getter: (colorSet) => colorSet.onError,
    setter: (colorSet, color) => colorSet.copyWith(onError: color),
  ),
  ThemeColorFieldDef(
    label: 'Error Container',
    category: ThemeColorFieldCategory.error,
    getter: (colorSet) => colorSet.errorContainer,
    setter: (colorSet, color) => colorSet.copyWith(errorContainer: color),
  ),
  ThemeColorFieldDef(
    label: 'On Error Container',
    category: ThemeColorFieldCategory.error,
    getter: (colorSet) => colorSet.onErrorContainer,
    setter: (colorSet, color) => colorSet.copyWith(onErrorContainer: color),
  ),
  ThemeColorFieldDef(
    label: 'Surface',
    category: ThemeColorFieldCategory.surface,
    getter: (colorSet) => colorSet.surface,
    setter: (colorSet, color) => colorSet.copyWith(surface: color),
  ),
  ThemeColorFieldDef(
    label: 'On Surface',
    category: ThemeColorFieldCategory.surface,
    getter: (colorSet) => colorSet.onSurface,
    setter: (colorSet, color) => colorSet.copyWith(onSurface: color),
  ),
  ThemeColorFieldDef(
    label: 'On Surface Variant',
    category: ThemeColorFieldCategory.surface,
    getter: (colorSet) => colorSet.onSurfaceVariant,
    setter: (colorSet, color) => colorSet.copyWith(onSurfaceVariant: color),
  ),
  ThemeColorFieldDef(
    label: 'Surface Container Lowest',
    category: ThemeColorFieldCategory.surface,
    getter: (colorSet) => colorSet.surfaceContainerLowest,
    setter: (colorSet, color) =>
        colorSet.copyWith(surfaceContainerLowest: color),
  ),
  ThemeColorFieldDef(
    label: 'Surface Container Low',
    category: ThemeColorFieldCategory.surface,
    getter: (colorSet) => colorSet.surfaceContainerLow,
    setter: (colorSet, color) =>
        colorSet.copyWith(surfaceContainerLow: color),
  ),
  ThemeColorFieldDef(
    label: 'Surface Container',
    category: ThemeColorFieldCategory.surface,
    getter: (colorSet) => colorSet.surfaceContainer,
    setter: (colorSet, color) => colorSet.copyWith(surfaceContainer: color),
  ),
  ThemeColorFieldDef(
    label: 'Surface Container High',
    category: ThemeColorFieldCategory.surface,
    getter: (colorSet) => colorSet.surfaceContainerHigh,
    setter: (colorSet, color) =>
        colorSet.copyWith(surfaceContainerHigh: color),
  ),
  ThemeColorFieldDef(
    label: 'Surface Container Highest',
    category: ThemeColorFieldCategory.surface,
    getter: (colorSet) => colorSet.surfaceContainerHighest,
    setter: (colorSet, color) =>
        colorSet.copyWith(surfaceContainerHighest: color),
  ),
  ThemeColorFieldDef(
    label: 'Outline',
    category: ThemeColorFieldCategory.surface,
    getter: (colorSet) => colorSet.outline,
    setter: (colorSet, color) => colorSet.copyWith(outline: color),
  ),
  ThemeColorFieldDef(
    label: 'Outline Variant',
    category: ThemeColorFieldCategory.surface,
    getter: (colorSet) => colorSet.outlineVariant,
    setter: (colorSet, color) => colorSet.copyWith(outlineVariant: color),
  ),
  ThemeColorFieldDef(
    label: 'Inverse Surface',
    category: ThemeColorFieldCategory.surface,
    getter: (colorSet) => colorSet.inverseSurface,
    setter: (colorSet, color) => colorSet.copyWith(inverseSurface: color),
  ),
  ThemeColorFieldDef(
    label: 'On Inverse Surface',
    category: ThemeColorFieldCategory.surface,
    getter: (colorSet) => colorSet.onInverseSurface,
    setter: (colorSet, color) => colorSet.copyWith(onInverseSurface: color),
  ),
  ThemeColorFieldDef(
    label: 'Inverse Primary',
    category: ThemeColorFieldCategory.surface,
    getter: (colorSet) => colorSet.inversePrimary,
    setter: (colorSet, color) => colorSet.copyWith(inversePrimary: color),
  ),
  ThemeColorFieldDef(
    label: 'Shadow',
    category: ThemeColorFieldCategory.surface,
    getter: (colorSet) => colorSet.shadow,
    setter: (colorSet, color) => colorSet.copyWith(shadow: color),
  ),
  ThemeColorFieldDef(
    label: 'Scrim',
    category: ThemeColorFieldCategory.surface,
    getter: (colorSet) => colorSet.scrim,
    setter: (colorSet, color) => colorSet.copyWith(scrim: color),
  ),
  ThemeColorFieldDef(
    label: 'Success',
    category: ThemeColorFieldCategory.status,
    getter: (colorSet) => colorSet.status.success,
    setter: (colorSet, color) =>
        colorSet.copyWith(status: colorSet.status.copyWith(success: color)),
  ),
  ThemeColorFieldDef(
    label: 'Warning',
    category: ThemeColorFieldCategory.status,
    getter: (colorSet) => colorSet.status.warning,
    setter: (colorSet, color) =>
        colorSet.copyWith(status: colorSet.status.copyWith(warning: color)),
  ),
  ThemeColorFieldDef(
    label: 'Info',
    category: ThemeColorFieldCategory.status,
    getter: (colorSet) => colorSet.status.info,
    setter: (colorSet, color) =>
        colorSet.copyWith(status: colorSet.status.copyWith(info: color)),
  ),
  ThemeColorFieldDef(
    label: 'Map Background',
    category: ThemeColorFieldCategory.map,
    getter: (colorSet) => colorSet.mapColors.background,
    setter: (colorSet, color) => colorSet.copyWith(
      mapColors: colorSet.mapColors.copyWith(background: color),
    ),
  ),
  ThemeColorFieldDef(
    label: 'World Land',
    category: ThemeColorFieldCategory.map,
    getter: (colorSet) => colorSet.mapColors.worldLand,
    setter: (colorSet, color) => colorSet.copyWith(
      mapColors: colorSet.mapColors.copyWith(worldLand: color),
    ),
  ),
  ThemeColorFieldDef(
    label: 'World Line',
    category: ThemeColorFieldCategory.map,
    getter: (colorSet) => colorSet.mapColors.worldLine,
    setter: (colorSet, color) => colorSet.copyWith(
      mapColors: colorSet.mapColors.copyWith(worldLine: color),
    ),
  ),
  ThemeColorFieldDef(
    label: 'Japan Land',
    category: ThemeColorFieldCategory.map,
    getter: (colorSet) => colorSet.mapColors.japanLand,
    setter: (colorSet, color) => colorSet.copyWith(
      mapColors: colorSet.mapColors.copyWith(japanLand: color),
    ),
  ),
  ThemeColorFieldDef(
    label: 'Japan Line',
    category: ThemeColorFieldCategory.map,
    getter: (colorSet) => colorSet.mapColors.japanLine,
    setter: (colorSet, color) => colorSet.copyWith(
      mapColors: colorSet.mapColors.copyWith(japanLine: color),
    ),
  ),
];

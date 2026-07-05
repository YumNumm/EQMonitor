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

/// [ThemeColorFieldDef]の宣言的な一覧を保持するコンテナ。
///
/// `ThemeColorSet`の全編集可能カラーフィールドを網羅する。
/// エディタUI(Task 5/6)は[all]を描画するだけで完結する。
class ThemeColorFieldDefs {
  const ThemeColorFieldDefs._();

  static final List<ThemeColorFieldDef> all = [
    ThemeColorFieldDef(
      label: 'プライマリ',
      category: ThemeColorFieldCategory.primary,
      getter: (colorSet) => colorSet.primary,
      setter: (colorSet, color) => colorSet.copyWith(primary: color),
    ),
    ThemeColorFieldDef(
      label: 'オンプライマリ',
      category: ThemeColorFieldCategory.primary,
      getter: (colorSet) => colorSet.onPrimary,
      setter: (colorSet, color) => colorSet.copyWith(onPrimary: color),
    ),
    ThemeColorFieldDef(
      label: 'プライマリコンテナ',
      category: ThemeColorFieldCategory.primary,
      getter: (colorSet) => colorSet.primaryContainer,
      setter: (colorSet, color) => colorSet.copyWith(primaryContainer: color),
    ),
    ThemeColorFieldDef(
      label: 'オンプライマリコンテナ',
      category: ThemeColorFieldCategory.primary,
      getter: (colorSet) => colorSet.onPrimaryContainer,
      setter: (colorSet, color) => colorSet.copyWith(onPrimaryContainer: color),
    ),
    ThemeColorFieldDef(
      label: 'セカンダリ',
      category: ThemeColorFieldCategory.secondary,
      getter: (colorSet) => colorSet.secondary,
      setter: (colorSet, color) => colorSet.copyWith(secondary: color),
    ),
    ThemeColorFieldDef(
      label: 'オンセカンダリ',
      category: ThemeColorFieldCategory.secondary,
      getter: (colorSet) => colorSet.onSecondary,
      setter: (colorSet, color) => colorSet.copyWith(onSecondary: color),
    ),
    ThemeColorFieldDef(
      label: 'セカンダリコンテナ',
      category: ThemeColorFieldCategory.secondary,
      getter: (colorSet) => colorSet.secondaryContainer,
      setter: (colorSet, color) => colorSet.copyWith(secondaryContainer: color),
    ),
    ThemeColorFieldDef(
      label: 'オンセカンダリコンテナ',
      category: ThemeColorFieldCategory.secondary,
      getter: (colorSet) => colorSet.onSecondaryContainer,
      setter: (colorSet, color) =>
          colorSet.copyWith(onSecondaryContainer: color),
    ),
    ThemeColorFieldDef(
      label: 'ターシャリ',
      category: ThemeColorFieldCategory.tertiary,
      getter: (colorSet) => colorSet.tertiary,
      setter: (colorSet, color) => colorSet.copyWith(tertiary: color),
    ),
    ThemeColorFieldDef(
      label: 'オンターシャリ',
      category: ThemeColorFieldCategory.tertiary,
      getter: (colorSet) => colorSet.onTertiary,
      setter: (colorSet, color) => colorSet.copyWith(onTertiary: color),
    ),
    ThemeColorFieldDef(
      label: 'ターシャリコンテナ',
      category: ThemeColorFieldCategory.tertiary,
      getter: (colorSet) => colorSet.tertiaryContainer,
      setter: (colorSet, color) => colorSet.copyWith(tertiaryContainer: color),
    ),
    ThemeColorFieldDef(
      label: 'オンターシャリコンテナ',
      category: ThemeColorFieldCategory.tertiary,
      getter: (colorSet) => colorSet.onTertiaryContainer,
      setter: (colorSet, color) =>
          colorSet.copyWith(onTertiaryContainer: color),
    ),
    ThemeColorFieldDef(
      label: 'エラー',
      category: ThemeColorFieldCategory.error,
      getter: (colorSet) => colorSet.error,
      setter: (colorSet, color) => colorSet.copyWith(error: color),
    ),
    ThemeColorFieldDef(
      label: 'オンエラー',
      category: ThemeColorFieldCategory.error,
      getter: (colorSet) => colorSet.onError,
      setter: (colorSet, color) => colorSet.copyWith(onError: color),
    ),
    ThemeColorFieldDef(
      label: 'エラーコンテナ',
      category: ThemeColorFieldCategory.error,
      getter: (colorSet) => colorSet.errorContainer,
      setter: (colorSet, color) => colorSet.copyWith(errorContainer: color),
    ),
    ThemeColorFieldDef(
      label: 'オンエラーコンテナ',
      category: ThemeColorFieldCategory.error,
      getter: (colorSet) => colorSet.onErrorContainer,
      setter: (colorSet, color) => colorSet.copyWith(onErrorContainer: color),
    ),
    ThemeColorFieldDef(
      label: 'サーフェス',
      category: ThemeColorFieldCategory.surface,
      getter: (colorSet) => colorSet.surface,
      setter: (colorSet, color) => colorSet.copyWith(surface: color),
    ),
    ThemeColorFieldDef(
      label: 'オンサーフェス',
      category: ThemeColorFieldCategory.surface,
      getter: (colorSet) => colorSet.onSurface,
      setter: (colorSet, color) => colorSet.copyWith(onSurface: color),
    ),
    ThemeColorFieldDef(
      label: 'オンサーフェスバリアント',
      category: ThemeColorFieldCategory.surface,
      getter: (colorSet) => colorSet.onSurfaceVariant,
      setter: (colorSet, color) => colorSet.copyWith(onSurfaceVariant: color),
    ),
    ThemeColorFieldDef(
      label: 'サーフェスコンテナ(最低)',
      category: ThemeColorFieldCategory.surface,
      getter: (colorSet) => colorSet.surfaceContainerLowest,
      setter: (colorSet, color) =>
          colorSet.copyWith(surfaceContainerLowest: color),
    ),
    ThemeColorFieldDef(
      label: 'サーフェスコンテナ(低)',
      category: ThemeColorFieldCategory.surface,
      getter: (colorSet) => colorSet.surfaceContainerLow,
      setter: (colorSet, color) =>
          colorSet.copyWith(surfaceContainerLow: color),
    ),
    ThemeColorFieldDef(
      label: 'サーフェスコンテナ',
      category: ThemeColorFieldCategory.surface,
      getter: (colorSet) => colorSet.surfaceContainer,
      setter: (colorSet, color) => colorSet.copyWith(surfaceContainer: color),
    ),
    ThemeColorFieldDef(
      label: 'サーフェスコンテナ(高)',
      category: ThemeColorFieldCategory.surface,
      getter: (colorSet) => colorSet.surfaceContainerHigh,
      setter: (colorSet, color) =>
          colorSet.copyWith(surfaceContainerHigh: color),
    ),
    ThemeColorFieldDef(
      label: 'サーフェスコンテナ(最高)',
      category: ThemeColorFieldCategory.surface,
      getter: (colorSet) => colorSet.surfaceContainerHighest,
      setter: (colorSet, color) =>
          colorSet.copyWith(surfaceContainerHighest: color),
    ),
    ThemeColorFieldDef(
      label: 'アウトライン',
      category: ThemeColorFieldCategory.surface,
      getter: (colorSet) => colorSet.outline,
      setter: (colorSet, color) => colorSet.copyWith(outline: color),
    ),
    ThemeColorFieldDef(
      label: 'アウトラインバリアント',
      category: ThemeColorFieldCategory.surface,
      getter: (colorSet) => colorSet.outlineVariant,
      setter: (colorSet, color) => colorSet.copyWith(outlineVariant: color),
    ),
    ThemeColorFieldDef(
      label: 'インバースサーフェス',
      category: ThemeColorFieldCategory.surface,
      getter: (colorSet) => colorSet.inverseSurface,
      setter: (colorSet, color) => colorSet.copyWith(inverseSurface: color),
    ),
    ThemeColorFieldDef(
      label: 'オンインバースサーフェス',
      category: ThemeColorFieldCategory.surface,
      getter: (colorSet) => colorSet.onInverseSurface,
      setter: (colorSet, color) => colorSet.copyWith(onInverseSurface: color),
    ),
    ThemeColorFieldDef(
      label: 'インバースプライマリ',
      category: ThemeColorFieldCategory.surface,
      getter: (colorSet) => colorSet.inversePrimary,
      setter: (colorSet, color) => colorSet.copyWith(inversePrimary: color),
    ),
    ThemeColorFieldDef(
      label: 'シャドウ',
      category: ThemeColorFieldCategory.surface,
      getter: (colorSet) => colorSet.shadow,
      setter: (colorSet, color) => colorSet.copyWith(shadow: color),
    ),
    ThemeColorFieldDef(
      label: 'スクリム',
      category: ThemeColorFieldCategory.surface,
      getter: (colorSet) => colorSet.scrim,
      setter: (colorSet, color) => colorSet.copyWith(scrim: color),
    ),
    ThemeColorFieldDef(
      label: '成功',
      category: ThemeColorFieldCategory.status,
      getter: (colorSet) => colorSet.status.success,
      setter: (colorSet, color) =>
          colorSet.copyWith(status: colorSet.status.copyWith(success: color)),
    ),
    ThemeColorFieldDef(
      label: '警告',
      category: ThemeColorFieldCategory.status,
      getter: (colorSet) => colorSet.status.warning,
      setter: (colorSet, color) =>
          colorSet.copyWith(status: colorSet.status.copyWith(warning: color)),
    ),
    ThemeColorFieldDef(
      label: '情報',
      category: ThemeColorFieldCategory.status,
      getter: (colorSet) => colorSet.status.info,
      setter: (colorSet, color) =>
          colorSet.copyWith(status: colorSet.status.copyWith(info: color)),
    ),
    ThemeColorFieldDef(
      label: 'マップ背景',
      category: ThemeColorFieldCategory.map,
      getter: (colorSet) => colorSet.mapColors.background,
      setter: (colorSet, color) => colorSet.copyWith(
        mapColors: colorSet.mapColors.copyWith(background: color),
      ),
    ),
    ThemeColorFieldDef(
      label: '世界の陸地',
      category: ThemeColorFieldCategory.map,
      getter: (colorSet) => colorSet.mapColors.worldLand,
      setter: (colorSet, color) => colorSet.copyWith(
        mapColors: colorSet.mapColors.copyWith(worldLand: color),
      ),
    ),
    ThemeColorFieldDef(
      label: '世界の国境線',
      category: ThemeColorFieldCategory.map,
      getter: (colorSet) => colorSet.mapColors.worldLine,
      setter: (colorSet, color) => colorSet.copyWith(
        mapColors: colorSet.mapColors.copyWith(worldLine: color),
      ),
    ),
    ThemeColorFieldDef(
      label: '日本の陸地',
      category: ThemeColorFieldCategory.map,
      getter: (colorSet) => colorSet.mapColors.japanLand,
      setter: (colorSet, color) => colorSet.copyWith(
        mapColors: colorSet.mapColors.copyWith(japanLand: color),
      ),
    ),
    ThemeColorFieldDef(
      label: '日本の県境線',
      category: ThemeColorFieldCategory.map,
      getter: (colorSet) => colorSet.mapColors.japanLine,
      setter: (colorSet, color) => colorSet.copyWith(
        mapColors: colorSet.mapColors.copyWith(japanLine: color),
      ),
    ),
  ];
}

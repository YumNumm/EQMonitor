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
    required this.description,
    required this.getter,
    required this.setter,
  });

  final String label;
  final ThemeColorFieldCategory category;

  /// この色がアプリのどこで使われるかを説明する文。
  ///
  /// エディタUIのsubtitleに表示される。
  final String description;
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
      description: 'アプリの基調色。スイッチやチェックアイコンなど、主要な操作要素の色として使用されます。',
      getter: (colorSet) => colorSet.primary,
      setter: (colorSet, color) => colorSet.copyWith(primary: color),
    ),
    ThemeColorFieldDef(
      label: 'オンプライマリ',
      category: ThemeColorFieldCategory.primary,
      description: 'プライマリ色の上に重ねる文字・アイコンの色。ボタンのラベルなどに使用されます。',
      getter: (colorSet) => colorSet.onPrimary,
      setter: (colorSet, color) => colorSet.copyWith(onPrimary: color),
    ),
    ThemeColorFieldDef(
      label: 'プライマリコンテナ',
      category: ThemeColorFieldCategory.primary,
      description: 'プライマリ系の淡い背景色。選択状態の要素の背景などに使用されます。',
      getter: (colorSet) => colorSet.primaryContainer,
      setter: (colorSet, color) => colorSet.copyWith(primaryContainer: color),
    ),
    ThemeColorFieldDef(
      label: 'オンプライマリコンテナ',
      category: ThemeColorFieldCategory.primary,
      description: 'プライマリコンテナの上に重ねる文字・アイコンの色。',
      getter: (colorSet) => colorSet.onPrimaryContainer,
      setter: (colorSet, color) => colorSet.copyWith(onPrimaryContainer: color),
    ),
    ThemeColorFieldDef(
      label: 'セカンダリ',
      category: ThemeColorFieldCategory.secondary,
      description: '補助的なアクセント色。一部のスイッチやコントロールの強調に使用されます。',
      getter: (colorSet) => colorSet.secondary,
      setter: (colorSet, color) => colorSet.copyWith(secondary: color),
    ),
    ThemeColorFieldDef(
      label: 'セカンダリコンテナ',
      category: ThemeColorFieldCategory.secondary,
      description: '地震履歴のフィルタチップ（深さ・マグニチュードなど）の選択時の背景色として使用されます。',
      getter: (colorSet) => colorSet.secondaryContainer,
      setter: (colorSet, color) => colorSet.copyWith(secondaryContainer: color),
    ),
    ThemeColorFieldDef(
      label: 'オンセカンダリコンテナ',
      category: ThemeColorFieldCategory.secondary,
      description: 'セカンダリコンテナの上に重ねる文字・アイコンの色。選択中チップの文字色などに使用されます。',
      getter: (colorSet) => colorSet.onSecondaryContainer,
      setter: (colorSet, color) =>
          colorSet.copyWith(onSecondaryContainer: color),
    ),
    ThemeColorFieldDef(
      label: 'ターシャリ',
      category: ThemeColorFieldCategory.tertiary,
      description: '第3のアクセント色。バッジや一部のカードの強調に使用されます。',
      getter: (colorSet) => colorSet.tertiary,
      setter: (colorSet, color) => colorSet.copyWith(tertiary: color),
    ),
    ThemeColorFieldDef(
      label: 'ターシャリコンテナ',
      category: ThemeColorFieldCategory.tertiary,
      description: 'ターシャリ系の淡い背景色。一部のバッジやカードの背景に使用されます。',
      getter: (colorSet) => colorSet.tertiaryContainer,
      setter: (colorSet, color) => colorSet.copyWith(tertiaryContainer: color),
    ),
    ThemeColorFieldDef(
      label: 'オンターシャリコンテナ',
      category: ThemeColorFieldCategory.tertiary,
      description: 'ターシャリコンテナの上に重ねる文字・アイコンの色。',
      getter: (colorSet) => colorSet.onTertiaryContainer,
      setter: (colorSet, color) =>
          colorSet.copyWith(onTertiaryContainer: color),
    ),
    ThemeColorFieldDef(
      label: 'エラー',
      category: ThemeColorFieldCategory.error,
      description: 'エラーを示す色。エラー画面のアイコンや通信切断時のステータス表示などに使用されます。',
      getter: (colorSet) => colorSet.error,
      setter: (colorSet, color) => colorSet.copyWith(error: color),
    ),
    ThemeColorFieldDef(
      label: 'エラーコンテナ',
      category: ThemeColorFieldCategory.error,
      description: 'エラー通知（スナックバーなど）の背景色として使用されます。',
      getter: (colorSet) => colorSet.errorContainer,
      setter: (colorSet, color) => colorSet.copyWith(errorContainer: color),
    ),
    ThemeColorFieldDef(
      label: 'オンエラーコンテナ',
      category: ThemeColorFieldCategory.error,
      description: 'エラーコンテナの上に重ねる文字・アイコンの色。',
      getter: (colorSet) => colorSet.onErrorContainer,
      setter: (colorSet, color) => colorSet.copyWith(onErrorContainer: color),
    ),
    ThemeColorFieldDef(
      label: 'サーフェス',
      category: ThemeColorFieldCategory.surface,
      description: 'カードやダイアログの基本の背景色として使用されます。',
      getter: (colorSet) => colorSet.surface,
      setter: (colorSet, color) => colorSet.copyWith(surface: color),
    ),
    ThemeColorFieldDef(
      label: 'オンサーフェス',
      category: ThemeColorFieldCategory.surface,
      description: 'アプリ全体の標準の文字・アイコンの色。アプリバーの文字色にも使用されます。',
      getter: (colorSet) => colorSet.onSurface,
      setter: (colorSet, color) => colorSet.copyWith(onSurface: color),
    ),
    ThemeColorFieldDef(
      label: 'オンサーフェスバリアント',
      category: ThemeColorFieldCategory.surface,
      description: '補足説明やキャプションなど、控えめな文字・アイコンの色として広く使用されます。',
      getter: (colorSet) => colorSet.onSurfaceVariant,
      setter: (colorSet, color) => colorSet.copyWith(onSurfaceVariant: color),
    ),
    ThemeColorFieldDef(
      label: 'サーフェスコンテナ(低)',
      category: ThemeColorFieldCategory.surface,
      description: '画面全体の背景色とアプリバーの背景色として使用されます。',
      getter: (colorSet) => colorSet.surfaceContainerLow,
      setter: (colorSet, color) =>
          colorSet.copyWith(surfaceContainerLow: color),
    ),
    ThemeColorFieldDef(
      label: 'サーフェスコンテナ',
      category: ThemeColorFieldCategory.surface,
      description: '中間階層のコンテナ背景色。',
      getter: (colorSet) => colorSet.surfaceContainer,
      setter: (colorSet, color) => colorSet.copyWith(surfaceContainer: color),
    ),
    ThemeColorFieldDef(
      label: 'サーフェスコンテナ(高)',
      category: ThemeColorFieldCategory.surface,
      description: 'カードや接続状態表示などのコンテナ背景色として使用されます。',
      getter: (colorSet) => colorSet.surfaceContainerHigh,
      setter: (colorSet, color) =>
          colorSet.copyWith(surfaceContainerHigh: color),
    ),
    ThemeColorFieldDef(
      label: 'サーフェスコンテナ(最高)',
      category: ThemeColorFieldCategory.surface,
      description: '最も高い階層のコンテナ背景色。',
      getter: (colorSet) => colorSet.surfaceContainerHighest,
      setter: (colorSet, color) =>
          colorSet.copyWith(surfaceContainerHighest: color),
    ),
    ThemeColorFieldDef(
      label: 'アウトライン',
      category: ThemeColorFieldCategory.surface,
      description: '枠線の色。色見本の縁取りや入力欄の枠線などに使用されます。',
      getter: (colorSet) => colorSet.outline,
      setter: (colorSet, color) => colorSet.copyWith(outline: color),
    ),
    ThemeColorFieldDef(
      label: 'アウトラインバリアント',
      category: ThemeColorFieldCategory.surface,
      description: '控えめな枠線・区切り線の色。カードやモーダルシートの縁取りなどに使用されます。',
      getter: (colorSet) => colorSet.outlineVariant,
      setter: (colorSet, color) => colorSet.copyWith(outlineVariant: color),
    ),
    ThemeColorFieldDef(
      label: 'オンインバースサーフェス',
      category: ThemeColorFieldCategory.surface,
      description: '反転背景の上に重ねる文字・アイコンの色。',
      getter: (colorSet) => colorSet.onInverseSurface,
      setter: (colorSet, color) => colorSet.copyWith(onInverseSurface: color),
    ),
    ThemeColorFieldDef(
      label: '成功',
      category: ThemeColorFieldCategory.status,
      description: '成功・正常を示す色。強震モニタの接続状態や設定完了のチェックマークなどに使用されます。',
      getter: (colorSet) => colorSet.status.success,
      setter: (colorSet, color) =>
          colorSet.copyWith(status: colorSet.status.copyWith(success: color)),
    ),
    ThemeColorFieldDef(
      label: '警告',
      category: ThemeColorFieldCategory.status,
      description: '警告を示す色。ベータ版の注意喚起や接続が不安定なときの表示に使用されます。',
      getter: (colorSet) => colorSet.status.warning,
      setter: (colorSet, color) =>
          colorSet.copyWith(status: colorSet.status.copyWith(warning: color)),
    ),
    ThemeColorFieldDef(
      label: 'マップ背景',
      category: ThemeColorFieldCategory.map,
      description: '地図の背景色。海域など地物のない部分の色として使用されます。',
      getter: (colorSet) => colorSet.mapColors.background,
      setter: (colorSet, color) => colorSet.copyWith(
        mapColors: colorSet.mapColors.copyWith(background: color),
      ),
    ),
    ThemeColorFieldDef(
      label: '世界の陸地',
      category: ThemeColorFieldCategory.map,
      description: '日本以外の陸地の塗りつぶし色。',
      getter: (colorSet) => colorSet.mapColors.worldLand,
      setter: (colorSet, color) => colorSet.copyWith(
        mapColors: colorSet.mapColors.copyWith(worldLand: color),
      ),
    ),
    ThemeColorFieldDef(
      label: '世界の国境線',
      category: ThemeColorFieldCategory.map,
      description: '日本以外の国境・海岸線の線の色。',
      getter: (colorSet) => colorSet.mapColors.worldLine,
      setter: (colorSet, color) => colorSet.copyWith(
        mapColors: colorSet.mapColors.copyWith(worldLine: color),
      ),
    ),
    ThemeColorFieldDef(
      label: '日本の陸地',
      category: ThemeColorFieldCategory.map,
      description: '日本の陸地の塗りつぶし色。',
      getter: (colorSet) => colorSet.mapColors.japanLand,
      setter: (colorSet, color) => colorSet.copyWith(
        mapColors: colorSet.mapColors.copyWith(japanLand: color),
      ),
    ),
    ThemeColorFieldDef(
      label: '日本の県境線',
      category: ThemeColorFieldCategory.map,
      description: '日本国内の境界線の色。都道府県境・市区町村境・緊急地震速報の予想区域の境界線に使用されます。',
      getter: (colorSet) => colorSet.mapColors.japanLine,
      setter: (colorSet, color) => colorSet.copyWith(
        mapColors: colorSet.mapColors.copyWith(japanLine: color),
      ),
    ),
  ];
}

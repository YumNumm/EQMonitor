import 'package:eqmonitor/core/theme/model/estimated_intensity_colors.dart';
import 'package:eqmonitor/core/theme/model/intensity_color_entry.dart';
import 'package:eqmonitor/core/theme/model/intensity_colors.dart';
import 'package:eqmonitor/core/theme/model/intensity_text_color.dart';
import 'package:eqmonitor/core/theme/model/map_colors.dart';
import 'package:eqmonitor/core/theme/model/status_colors.dart';
import 'package:eqmonitor/core/theme/model/theme_color_set.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_theme.freezed.dart';
part 'app_theme.g.dart';

enum ThemeBrightnessMode { light, dark }

@freezed
abstract class AppTheme with _$AppTheme {
  const factory AppTheme({
    required String name,
    required int version,
    required String author,
    required List<ThemeBrightnessMode> modes,
    ThemeColorSet? light,
    ThemeColorSet? dark,
  }) = _AppTheme;

  factory AppTheme.fromJson(Map<String, dynamic> json) =>
      _$AppThemeFromJson(json);

  // 設計ドキュメントに記載のEQMonitor Defaultプリセット（全色値のコード）
  factory AppTheme.eqmonitorDefault() => const AppTheme(
    name: 'EQMonitor Default',
    version: 1,
    author: 'EQMonitor',
    modes: [ThemeBrightnessMode.light, ThemeBrightnessMode.dark],
    light: ThemeColorSet(
      primary: Color(0xFF2F6FE4),
      onPrimary: Color(0xFFFFFFFF),
      primaryContainer: Color(0xFFDCE8FF),
      onPrimaryContainer: Color(0xFF001A41),
      secondary: Color(0xFF5E86D6),
      onSecondary: Color(0xFFFFFFFF),
      secondaryContainer: Color(0xFFD6E3FF),
      onSecondaryContainer: Color(0xFF001B3E),
      tertiary: Color(0xFF2D8A78),
      onTertiary: Color(0xFFFFFFFF),
      tertiaryContainer: Color(0xFFA8F0DE),
      onTertiaryContainer: Color(0xFF002117),
      error: Color(0xFFC54C4C),
      onError: Color(0xFFFFFFFF),
      errorContainer: Color(0xFFFFDAD6),
      onErrorContainer: Color(0xFF410002),
      surface: Color(0xFFFFFFFF),
      onSurface: Color(0xFF10151C),
      onSurfaceVariant: Color(0xFF4A5A6D),
      surfaceContainerLowest: Color(0xFFFFFFFF),
      surfaceContainerLow: Color(0xFFF5F8FC),
      surfaceContainer: Color(0xFFEDF3F9),
      surfaceContainerHigh: Color(0xFFEAF0F7),
      surfaceContainerHighest: Color(0xFFD9E6F7),
      outline: Color(0xFF95A7BC),
      outlineVariant: Color(0xFFD3DDE8),
      inverseSurface: Color(0xFF0F141A),
      onInverseSurface: Color(0xFFF5F8FC),
      inversePrimary: Color(0xFF4D8DFF),
      shadow: Color(0xFF000000),
      scrim: Color(0xFF000000),
      status: StatusColors(
        success: Color(0xFF248A5A),
        warning: Color(0xFFB57900),
        info: Color(0xFF1D73D8),
      ),
      intensity: IntensityColors(
        unknown: IntensityColorEntry(
          background: Color(0xFF000000),
          foreground: IntensityTextColor.auto(),
        ),
        zero: IntensityColorEntry(
          background: Color(0xFFFFFFFF),
          foreground: IntensityTextColor.auto(),
        ),
        one: IntensityColorEntry(
          background: Color(0xFF03B5FF),
          foreground: IntensityTextColor.auto(),
        ),
        two: IntensityColorEntry(
          background: Color(0xFF76FF03),
          foreground: IntensityTextColor.auto(),
        ),
        three: IntensityColorEntry(
          background: Color(0xFF00C853),
          foreground: IntensityTextColor.auto(),
        ),
        four: IntensityColorEntry(
          background: Color(0xFFFFEB3B),
          foreground: IntensityTextColor.auto(),
        ),
        fiveLower: IntensityColorEntry(
          background: Color(0xFFFFC107),
          foreground: IntensityTextColor.auto(),
        ),
        fiveUpper: IntensityColorEntry(
          background: Color(0xFFFF6F00),
          foreground: IntensityTextColor.auto(),
        ),
        sixLower: IntensityColorEntry(
          background: Color(0xFFFF2800),
          foreground: IntensityTextColor.auto(),
        ),
        sixUpper: IntensityColorEntry(
          background: Color(0xFFA50021),
          foreground: IntensityTextColor.auto(),
        ),
        seven: IntensityColorEntry(
          background: Color(0xFFC800FF),
          foreground: IntensityTextColor.auto(),
        ),
      ),
      estimatedIntensity: EstimatedIntensityColors(
        four: IntensityColorEntry(
          background: Color(0xFFFAE6A0),
          foreground: IntensityTextColor.auto(),
        ),
        fiveLower: IntensityColorEntry(
          background: Color(0xFFFFE600),
          foreground: IntensityTextColor.auto(),
        ),
        fiveUpper: IntensityColorEntry(
          background: Color(0xFFFF9900),
          foreground: IntensityTextColor.auto(),
        ),
        sixLower: IntensityColorEntry(
          background: Color(0xFFFF2800),
          foreground: IntensityTextColor.auto(),
        ),
        sixUpper: IntensityColorEntry(
          background: Color(0xFFA50021),
          foreground: IntensityTextColor.auto(),
        ),
        seven: IntensityColorEntry(
          background: Color(0xFFB40068),
          foreground: IntensityTextColor.auto(),
        ),
      ),
      mapColors: MapColors(
        background: Color(0xFF0D1B4A),
        worldLand: Color(0xFFFFFFFF),
        worldLine: Color(0xFF6B7280),
        japanLand: Color(0xFFFFFFFF),
        japanLine: Color(0xFF6B7280),
      ),
    ),
    dark: ThemeColorSet(
      primary: Color(0xFF4D8DFF),
      onPrimary: Color(0xFF07121F),
      primaryContainer: Color(0xFF24344A),
      onPrimaryContainer: Color(0xFFDCE8FF),
      secondary: Color(0xFF8FB7FF),
      onSecondary: Color(0xFF07121F),
      secondaryContainer: Color(0xFF1A3A6B),
      onSecondaryContainer: Color(0xFFD6E3FF),
      tertiary: Color(0xFF91D4C8),
      onTertiary: Color(0xFF002117),
      tertiaryContainer: Color(0xFF1A5C4F),
      onTertiaryContainer: Color(0xFFA8F0DE),
      error: Color(0xFFFF7A7A),
      onError: Color(0xFF410002),
      errorContainer: Color(0xFF8C1D18),
      onErrorContainer: Color(0xFFFFDAD6),
      surface: Color(0xFF171E26),
      onSurface: Color(0xFFF3F6FA),
      onSurfaceVariant: Color(0xFFC4CCD7),
      surfaceContainerLowest: Color(0xFF0F141A),
      surfaceContainerLow: Color(0xFF131A21),
      surfaceContainer: Color(0xFF1D2630),
      surfaceContainerHigh: Color(0xFF232D38),
      surfaceContainerHighest: Color(0xFF2B3744),
      outline: Color(0xFF506073),
      outlineVariant: Color(0xFF3A4654),
      inverseSurface: Color(0xFFF5F8FC),
      onInverseSurface: Color(0xFF0F141A),
      inversePrimary: Color(0xFF2F6FE4),
      shadow: Color(0xFF000000),
      scrim: Color(0xFF000000),
      status: StatusColors(
        success: Color(0xFF63D39B),
        warning: Color(0xFFF4C75E),
        info: Color(0xFF78B8FF),
      ),
      intensity: IntensityColors(
        unknown: IntensityColorEntry(
          background: Color(0xFF000000),
          foreground: IntensityTextColor.auto(),
        ),
        zero: IntensityColorEntry(
          background: Color(0xFFFFFFFF),
          foreground: IntensityTextColor.auto(),
        ),
        one: IntensityColorEntry(
          background: Color(0xFF03B5FF),
          foreground: IntensityTextColor.auto(),
        ),
        two: IntensityColorEntry(
          background: Color(0xFF76FF03),
          foreground: IntensityTextColor.auto(),
        ),
        three: IntensityColorEntry(
          background: Color(0xFF00C853),
          foreground: IntensityTextColor.auto(),
        ),
        four: IntensityColorEntry(
          background: Color(0xFFFFEB3B),
          foreground: IntensityTextColor.auto(),
        ),
        fiveLower: IntensityColorEntry(
          background: Color(0xFFFFC107),
          foreground: IntensityTextColor.auto(),
        ),
        fiveUpper: IntensityColorEntry(
          background: Color(0xFFFF6F00),
          foreground: IntensityTextColor.auto(),
        ),
        sixLower: IntensityColorEntry(
          background: Color(0xFFFF2800),
          foreground: IntensityTextColor.auto(),
        ),
        sixUpper: IntensityColorEntry(
          background: Color(0xFFA50021),
          foreground: IntensityTextColor.auto(),
        ),
        seven: IntensityColorEntry(
          background: Color(0xFFC800FF),
          foreground: IntensityTextColor.auto(),
        ),
      ),
      estimatedIntensity: EstimatedIntensityColors(
        four: IntensityColorEntry(
          background: Color(0xFFFAE6A0),
          foreground: IntensityTextColor.auto(),
        ),
        fiveLower: IntensityColorEntry(
          background: Color(0xFFFFE600),
          foreground: IntensityTextColor.auto(),
        ),
        fiveUpper: IntensityColorEntry(
          background: Color(0xFFFF9900),
          foreground: IntensityTextColor.auto(),
        ),
        sixLower: IntensityColorEntry(
          background: Color(0xFFFF2800),
          foreground: IntensityTextColor.auto(),
        ),
        sixUpper: IntensityColorEntry(
          background: Color(0xFFA50021),
          foreground: IntensityTextColor.auto(),
        ),
        seven: IntensityColorEntry(
          background: Color(0xFFB40068),
          foreground: IntensityTextColor.auto(),
        ),
      ),
      mapColors: MapColors(
        background: Color(0xFF0A1540),
        worldLand: Color(0xFF2B3744),
        worldLine: Color(0xFF506073),
        japanLand: Color(0xFF2B3744),
        japanLine: Color(0xFFF3F6FA),
      ),
    ),
  );

  const AppTheme._();

  ThemeColorSet colorSetFor(Brightness brightness) {
    final colorSet = switch (brightness) {
      Brightness.light => light ?? dark,
      Brightness.dark => dark ?? light,
    };
    if (colorSet == null) {
      throw StateError('AppTheme has no color set for $brightness');
    }
    return colorSet;
  }

  bool supportsMode(ThemeBrightnessMode mode) => modes.contains(mode);

  // JMA標準カラー: eqmonitorDefaultベースで震度色のみ差し替え
  static AppTheme jmaStandard() {
    final base = AppTheme.eqmonitorDefault();
    const jmaIntensity = IntensityColors(
      unknown: IntensityColorEntry(
        background: Color(0xFF000000),
        foreground: IntensityTextColor.auto(),
      ),
      zero: IntensityColorEntry(
        background: Color(0xFFFFFFFF),
        foreground: IntensityTextColor.auto(),
      ),
      one: IntensityColorEntry(
        background: Color(0xFF80C0E0),
        foreground: IntensityTextColor.auto(),
      ),
      two: IntensityColorEntry(
        background: Color(0xFF0000FF),
        foreground: IntensityTextColor.auto(),
      ),
      three: IntensityColorEntry(
        background: Color(0xFF00AAFF),
        foreground: IntensityTextColor.auto(),
      ),
      four: IntensityColorEntry(
        background: Color(0xFFFFFF00),
        foreground: IntensityTextColor.auto(),
      ),
      fiveLower: IntensityColorEntry(
        background: Color(0xFFFFAA00),
        foreground: IntensityTextColor.auto(),
      ),
      fiveUpper: IntensityColorEntry(
        background: Color(0xFFFF5500),
        foreground: IntensityTextColor.auto(),
      ),
      sixLower: IntensityColorEntry(
        background: Color(0xFFFF0000),
        foreground: IntensityTextColor.auto(),
      ),
      sixUpper: IntensityColorEntry(
        background: Color(0xFFCC0000),
        foreground: IntensityTextColor.auto(),
      ),
      seven: IntensityColorEntry(
        background: Color(0xFFAA0088),
        foreground: IntensityTextColor.auto(),
      ),
    );
    return base.copyWith(
      name: 'JMA Standard',
      author: 'EQMonitor',
      light: base.light?.copyWith(intensity: jmaIntensity),
      dark: base.dark?.copyWith(intensity: jmaIntensity),
    );
  }
}

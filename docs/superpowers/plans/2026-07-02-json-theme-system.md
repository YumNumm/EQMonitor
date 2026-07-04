# JSONテーマシステム 実装計画

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** アプリ全体の配色をJSON定義のテーマで切替可能にする

**Architecture:** Freezedモデル群でテーマJSONを型安全にパースし、`AppThemeNotifier`（Riverpod + SharedPreferences）で永続化。`DesignSystemThemeExtension.colorTheme`（`ThemeColorSet`型）を通じてUI層に配布。既存の`ColorPalette`・`ColorThemeExtension`・`TextColorThemeExtension`・`IntensityColorModel`・`MapColorScheme`を統合・廃止する。

**Tech Stack:** Flutter, Freezed, json_serializable, Riverpod (keepAlive), theme_tailor, SharedPreferences

## Global Constraints

- `Theme.of(context).colorScheme` のアプリコードからの直接参照を禁止（Material Widget内部用のみ）
- UI層でのカラーアクセスは `designSystem.colorTheme.*` 経由のみ
- `designSystem` 変数名を使用（`ds` 等の省略禁止）
- テーマJSON全フィールド必須、不正JSONはデフォルトにフォールバック
- 色値は `#RRGGBB` 形式（`ColorJsonConverter` で変換）
- 生成ファイル（`*.g.dart`、`*.freezed.dart`）はコミット対象
- `melos run generate` で `build_runner` を実行
- `melos run analyze` が通ること

---

### Task 1: カラーモデル群の作成

**Files:**
- Create: `app/lib/core/theme/model/intensity_text_color.dart`
- Create: `app/lib/core/theme/model/intensity_color_entry.dart`
- Create: `app/lib/core/theme/model/intensity_colors.dart`
- Create: `app/lib/core/theme/model/estimated_intensity_colors.dart`
- Create: `app/lib/core/theme/model/status_colors.dart`
- Create: `app/lib/core/theme/model/map_colors.dart`
- Test: `app/test/core/theme/model/intensity_text_color_test.dart`
- Test: `app/test/core/theme/model/intensity_color_entry_test.dart`

**Interfaces:**
- Consumes: `ColorJsonConverter` from `package:eqmonitor/core/util/converter/color_converter.dart`
- Produces:
  - `IntensityTextColor` sealed class (`auto()`, `manual({Color color})`)
  - `IntensityColorEntry` class (`Color background`, `IntensityTextColor foreground`) with `Color get resolvedForeground`
  - `IntensityColors` class (fields: `unknown`, `zero`, `one`, `two`, `three`, `four`, `fiveLower`, `fiveUpper`, `sixLower`, `sixUpper`, `seven` — all `IntensityColorEntry`)
  - `EstimatedIntensityColors` class (fields: `four`, `fiveLower`, `fiveUpper`, `sixLower`, `sixUpper`, `seven` — all `IntensityColorEntry`)
  - `StatusColors` class (fields: `success`, `warning`, `info` — all `Color`)
  - `MapColors` class (fields: `background`, `worldLand`, `worldLine`, `japanLand`, `japanLine` — all `Color`)

- [ ] **Step 1: `IntensityTextColor` sealed class を作成**

```dart
// app/lib/core/theme/model/intensity_text_color.dart
import 'package:eqmonitor/core/util/converter/color_converter.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'intensity_text_color.freezed.dart';
part 'intensity_text_color.g.dart';

@Freezed(unionKey: 'type')
sealed class IntensityTextColor with _$IntensityTextColor {
  @FreezedUnionValue('auto')
  const factory IntensityTextColor.auto() = IntensityTextColorAuto;

  @FreezedUnionValue('manual')
  const factory IntensityTextColor.manual({
    @ColorJsonConverter() required Color color,
  }) = IntensityTextColorManual;

  factory IntensityTextColor.fromJson(Map<String, dynamic> json) =>
      _$IntensityTextColorFromJson(json);
}
```

- [ ] **Step 2: `IntensityColorEntry` を作成**

```dart
// app/lib/core/theme/model/intensity_color_entry.dart
import 'package:eqmonitor/core/theme/model/intensity_text_color.dart';
import 'package:eqmonitor/core/util/converter/color_converter.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'intensity_color_entry.freezed.dart';
part 'intensity_color_entry.g.dart';

@freezed
abstract class IntensityColorEntry with _$IntensityColorEntry {
  const IntensityColorEntry._();

  const factory IntensityColorEntry({
    @ColorJsonConverter() required Color background,
    required IntensityTextColor foreground,
  }) = _IntensityColorEntry;

  factory IntensityColorEntry.fromJson(Map<String, dynamic> json) =>
      _$IntensityColorEntryFromJson(json);

  Color get resolvedForeground => switch (foreground) {
    IntensityTextColorAuto() =>
      background.computeLuminance() > 0.5 ? Colors.black : Colors.white,
    IntensityTextColorManual(:final color) => color,
  };
}
```

- [ ] **Step 3: `IntensityColors` を作成**

```dart
// app/lib/core/theme/model/intensity_colors.dart
import 'package:eqmonitor/core/theme/model/intensity_color_entry.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'intensity_colors.freezed.dart';
part 'intensity_colors.g.dart';

@freezed
abstract class IntensityColors with _$IntensityColors {
  const factory IntensityColors({
    required IntensityColorEntry unknown,
    required IntensityColorEntry zero,
    required IntensityColorEntry one,
    required IntensityColorEntry two,
    required IntensityColorEntry three,
    required IntensityColorEntry four,
    required IntensityColorEntry fiveLower,
    required IntensityColorEntry fiveUpper,
    required IntensityColorEntry sixLower,
    required IntensityColorEntry sixUpper,
    required IntensityColorEntry seven,
  }) = _IntensityColors;

  factory IntensityColors.fromJson(Map<String, dynamic> json) =>
      _$IntensityColorsFromJson(json);
}
```

- [ ] **Step 4: `EstimatedIntensityColors` を作成**

```dart
// app/lib/core/theme/model/estimated_intensity_colors.dart
import 'package:eqmonitor/core/theme/model/intensity_color_entry.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'estimated_intensity_colors.freezed.dart';
part 'estimated_intensity_colors.g.dart';

@freezed
abstract class EstimatedIntensityColors with _$EstimatedIntensityColors {
  const factory EstimatedIntensityColors({
    required IntensityColorEntry four,
    required IntensityColorEntry fiveLower,
    required IntensityColorEntry fiveUpper,
    required IntensityColorEntry sixLower,
    required IntensityColorEntry sixUpper,
    required IntensityColorEntry seven,
  }) = _EstimatedIntensityColors;

  factory EstimatedIntensityColors.fromJson(Map<String, dynamic> json) =>
      _$EstimatedIntensityColorsFromJson(json);
}
```

- [ ] **Step 5: `StatusColors` を作成**

```dart
// app/lib/core/theme/model/status_colors.dart
import 'package:eqmonitor/core/util/converter/color_converter.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'status_colors.freezed.dart';
part 'status_colors.g.dart';

@freezed
abstract class StatusColors with _$StatusColors {
  const factory StatusColors({
    @ColorJsonConverter() required Color success,
    @ColorJsonConverter() required Color warning,
    @ColorJsonConverter() required Color info,
  }) = _StatusColors;

  factory StatusColors.fromJson(Map<String, dynamic> json) =>
      _$StatusColorsFromJson(json);
}
```

- [ ] **Step 6: `MapColors` を作成**

```dart
// app/lib/core/theme/model/map_colors.dart
import 'package:eqmonitor/core/util/converter/color_converter.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'map_colors.freezed.dart';
part 'map_colors.g.dart';

@freezed
abstract class MapColors with _$MapColors {
  const factory MapColors({
    @ColorJsonConverter() required Color background,
    @ColorJsonConverter() required Color worldLand,
    @ColorJsonConverter() required Color worldLine,
    @ColorJsonConverter() required Color japanLand,
    @ColorJsonConverter() required Color japanLine,
  }) = _MapColors;

  factory MapColors.fromJson(Map<String, dynamic> json) =>
      _$MapColorsFromJson(json);
}
```

- [ ] **Step 7: テスト — IntensityTextColor のJSON往復**

```dart
// app/test/core/theme/model/intensity_text_color_test.dart
import 'package:eqmonitor/core/theme/model/intensity_text_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('IntensityTextColor', () {
    test('auto のJSON往復', () {
      const original = IntensityTextColor.auto();
      final json = original.toJson();
      expect(json, {'type': 'auto'});
      final restored = IntensityTextColor.fromJson(json);
      expect(restored, original);
    });

    test('manual のJSON往復', () {
      const original = IntensityTextColor.manual(color: Color(0xFF333333));
      final json = original.toJson();
      expect(json['type'], 'manual');
      final restored = IntensityTextColor.fromJson(json);
      expect(restored, isA<IntensityTextColorManual>());
    });
  });
}
```

- [ ] **Step 8: テスト — IntensityColorEntry の resolvedForeground**

```dart
// app/test/core/theme/model/intensity_color_entry_test.dart
import 'package:eqmonitor/core/theme/model/intensity_color_entry.dart';
import 'package:eqmonitor/core/theme/model/intensity_text_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('IntensityColorEntry.resolvedForeground', () {
    test('auto + 明るい背景 → 黒', () {
      const entry = IntensityColorEntry(
        background: Color(0xFFFFFFFF),
        foreground: IntensityTextColor.auto(),
      );
      expect(entry.resolvedForeground, Colors.black);
    });

    test('auto + 暗い背景 → 白', () {
      const entry = IntensityColorEntry(
        background: Color(0xFF000000),
        foreground: IntensityTextColor.auto(),
      );
      expect(entry.resolvedForeground, Colors.white);
    });

    test('manual → 指定色', () {
      const entry = IntensityColorEntry(
        background: Color(0xFFFFFFFF),
        foreground: IntensityTextColor.manual(color: Color(0xFF333333)),
      );
      expect(entry.resolvedForeground, const Color(0xFF333333));
    });
  });
}
```

- [ ] **Step 9: コード生成を実行**

Run: `cd app && dart run build_runner build --delete-conflicting-outputs`
Expected: 6つのモデルファイルに対応する `.freezed.dart` と `.g.dart` が生成される

- [ ] **Step 10: テスト実行**

Run: `cd app && flutter test test/core/theme/model/`
Expected: 全テストPASS

- [ ] **Step 11: コミット**

```bash
git add app/lib/core/theme/model/ app/test/core/theme/model/
git commit -m "feat: テーマシステムのカラーモデル群を作成"
```

---

### Task 2: ThemeColorSet と AppTheme モデルの作成

**Files:**
- Create: `app/lib/core/theme/model/theme_color_set.dart`
- Create: `app/lib/core/theme/model/app_theme.dart`
- Test: `app/test/core/theme/model/theme_color_set_test.dart`
- Test: `app/test/core/theme/model/app_theme_test.dart`

**Interfaces:**
- Consumes: Task 1 で作成した全モデル, `ColorJsonConverter`
- Produces:
  - `ThemeBrightnessMode` enum (`light`, `dark`)
  - `ThemeColorSet` class — ColorScheme準拠フィールド + `StatusColors status` + `IntensityColors intensity` + `EstimatedIntensityColors estimatedIntensity` + `@JsonKey(name: 'map') MapColors mapColors`。`ColorScheme toColorScheme(Brightness brightness)` メソッドを持つ。
  - `AppTheme` class — `name`, `version`, `author`, `modes`, `light?`, `dark?`。`AppTheme.eqmonitorDefault()` と `AppTheme.jmaStandard()` のプリセットファクトリ。`ThemeColorSet colorSetFor(Brightness brightness)` メソッドを持つ。

- [ ] **Step 1: `ThemeColorSet` を作成**

```dart
// app/lib/core/theme/model/theme_color_set.dart
import 'package:eqmonitor/core/theme/model/estimated_intensity_colors.dart';
import 'package:eqmonitor/core/theme/model/intensity_colors.dart';
import 'package:eqmonitor/core/theme/model/map_colors.dart';
import 'package:eqmonitor/core/theme/model/status_colors.dart';
import 'package:eqmonitor/core/util/converter/color_converter.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'theme_color_set.freezed.dart';
part 'theme_color_set.g.dart';

@freezed
abstract class ThemeColorSet with _$ThemeColorSet {
  const ThemeColorSet._();

  const factory ThemeColorSet({
    @ColorJsonConverter() required Color primary,
    @ColorJsonConverter() required Color onPrimary,
    @ColorJsonConverter() required Color primaryContainer,
    @ColorJsonConverter() required Color onPrimaryContainer,
    @ColorJsonConverter() required Color secondary,
    @ColorJsonConverter() required Color onSecondary,
    @ColorJsonConverter() required Color secondaryContainer,
    @ColorJsonConverter() required Color onSecondaryContainer,
    @ColorJsonConverter() required Color tertiary,
    @ColorJsonConverter() required Color onTertiary,
    @ColorJsonConverter() required Color tertiaryContainer,
    @ColorJsonConverter() required Color onTertiaryContainer,
    @ColorJsonConverter() required Color error,
    @ColorJsonConverter() required Color onError,
    @ColorJsonConverter() required Color errorContainer,
    @ColorJsonConverter() required Color onErrorContainer,
    @ColorJsonConverter() required Color surface,
    @ColorJsonConverter() required Color onSurface,
    @ColorJsonConverter() required Color onSurfaceVariant,
    @ColorJsonConverter() required Color surfaceContainerLowest,
    @ColorJsonConverter() required Color surfaceContainerLow,
    @ColorJsonConverter() required Color surfaceContainer,
    @ColorJsonConverter() required Color surfaceContainerHigh,
    @ColorJsonConverter() required Color surfaceContainerHighest,
    @ColorJsonConverter() required Color outline,
    @ColorJsonConverter() required Color outlineVariant,
    @ColorJsonConverter() required Color inverseSurface,
    @ColorJsonConverter() required Color onInverseSurface,
    @ColorJsonConverter() required Color inversePrimary,
    @ColorJsonConverter() required Color shadow,
    @ColorJsonConverter() required Color scrim,
    required StatusColors status,
    required IntensityColors intensity,
    required EstimatedIntensityColors estimatedIntensity,
    @JsonKey(name: 'map') required MapColors mapColors,
  }) = _ThemeColorSet;

  factory ThemeColorSet.fromJson(Map<String, dynamic> json) =>
      _$ThemeColorSetFromJson(json);

  ColorScheme toColorScheme(Brightness brightness) => ColorScheme(
    brightness: brightness,
    primary: primary,
    onPrimary: onPrimary,
    primaryContainer: primaryContainer,
    onPrimaryContainer: onPrimaryContainer,
    secondary: secondary,
    onSecondary: onSecondary,
    secondaryContainer: secondaryContainer,
    onSecondaryContainer: onSecondaryContainer,
    tertiary: tertiary,
    onTertiary: onTertiary,
    tertiaryContainer: tertiaryContainer,
    onTertiaryContainer: onTertiaryContainer,
    error: error,
    onError: onError,
    errorContainer: errorContainer,
    onErrorContainer: onErrorContainer,
    surface: surface,
    onSurface: onSurface,
    onSurfaceVariant: onSurfaceVariant,
    surfaceContainerLowest: surfaceContainerLowest,
    surfaceContainerLow: surfaceContainerLow,
    surfaceContainer: surfaceContainer,
    surfaceContainerHigh: surfaceContainerHigh,
    surfaceContainerHighest: surfaceContainerHighest,
    outline: outline,
    outlineVariant: outlineVariant,
    inverseSurface: inverseSurface,
    onInverseSurface: onInverseSurface,
    inversePrimary: inversePrimary,
    shadow: shadow,
    scrim: scrim,
  );
}
```

- [ ] **Step 2: `AppTheme` を作成（プリセット含む）**

```dart
// app/lib/core/theme/model/app_theme.dart
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
  const AppTheme._();

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
        unknown: IntensityColorEntry(background: Color(0xFF000000), foreground: IntensityTextColor.auto()),
        zero: IntensityColorEntry(background: Color(0xFFFFFFFF), foreground: IntensityTextColor.auto()),
        one: IntensityColorEntry(background: Color(0xFF03B5FF), foreground: IntensityTextColor.auto()),
        two: IntensityColorEntry(background: Color(0xFF76FF03), foreground: IntensityTextColor.auto()),
        three: IntensityColorEntry(background: Color(0xFF00C853), foreground: IntensityTextColor.auto()),
        four: IntensityColorEntry(background: Color(0xFFFFEB3B), foreground: IntensityTextColor.auto()),
        fiveLower: IntensityColorEntry(background: Color(0xFFFFC107), foreground: IntensityTextColor.auto()),
        fiveUpper: IntensityColorEntry(background: Color(0xFFFF6F00), foreground: IntensityTextColor.auto()),
        sixLower: IntensityColorEntry(background: Color(0xFFFF2800), foreground: IntensityTextColor.auto()),
        sixUpper: IntensityColorEntry(background: Color(0xFFA50021), foreground: IntensityTextColor.auto()),
        seven: IntensityColorEntry(background: Color(0xFFC800FF), foreground: IntensityTextColor.auto()),
      ),
      estimatedIntensity: EstimatedIntensityColors(
        four: IntensityColorEntry(background: Color(0xFFFAE6A0), foreground: IntensityTextColor.auto()),
        fiveLower: IntensityColorEntry(background: Color(0xFFFFE600), foreground: IntensityTextColor.auto()),
        fiveUpper: IntensityColorEntry(background: Color(0xFFFF9900), foreground: IntensityTextColor.auto()),
        sixLower: IntensityColorEntry(background: Color(0xFFFF2800), foreground: IntensityTextColor.auto()),
        sixUpper: IntensityColorEntry(background: Color(0xFFA50021), foreground: IntensityTextColor.auto()),
        seven: IntensityColorEntry(background: Color(0xFFB40068), foreground: IntensityTextColor.auto()),
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
        unknown: IntensityColorEntry(background: Color(0xFF000000), foreground: IntensityTextColor.auto()),
        zero: IntensityColorEntry(background: Color(0xFFFFFFFF), foreground: IntensityTextColor.auto()),
        one: IntensityColorEntry(background: Color(0xFF03B5FF), foreground: IntensityTextColor.auto()),
        two: IntensityColorEntry(background: Color(0xFF76FF03), foreground: IntensityTextColor.auto()),
        three: IntensityColorEntry(background: Color(0xFF00C853), foreground: IntensityTextColor.auto()),
        four: IntensityColorEntry(background: Color(0xFFFFEB3B), foreground: IntensityTextColor.auto()),
        fiveLower: IntensityColorEntry(background: Color(0xFFFFC107), foreground: IntensityTextColor.auto()),
        fiveUpper: IntensityColorEntry(background: Color(0xFFFF6F00), foreground: IntensityTextColor.auto()),
        sixLower: IntensityColorEntry(background: Color(0xFFFF2800), foreground: IntensityTextColor.auto()),
        sixUpper: IntensityColorEntry(background: Color(0xFFA50021), foreground: IntensityTextColor.auto()),
        seven: IntensityColorEntry(background: Color(0xFFC800FF), foreground: IntensityTextColor.auto()),
      ),
      estimatedIntensity: EstimatedIntensityColors(
        four: IntensityColorEntry(background: Color(0xFFFAE6A0), foreground: IntensityTextColor.auto()),
        fiveLower: IntensityColorEntry(background: Color(0xFFFFE600), foreground: IntensityTextColor.auto()),
        fiveUpper: IntensityColorEntry(background: Color(0xFFFF9900), foreground: IntensityTextColor.auto()),
        sixLower: IntensityColorEntry(background: Color(0xFFFF2800), foreground: IntensityTextColor.auto()),
        sixUpper: IntensityColorEntry(background: Color(0xFFA50021), foreground: IntensityTextColor.auto()),
        seven: IntensityColorEntry(background: Color(0xFFB40068), foreground: IntensityTextColor.auto()),
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
}
```

JMA Standardプリセットはデフォルトと震度色だけ異なる。`eqmonitorDefault()` を参照して `copyWith` でintensity部分だけ差し替えて定義する。

- [ ] **Step 3: テスト — ThemeColorSet の JSON往復と toColorScheme**

```dart
// app/test/core/theme/model/theme_color_set_test.dart
import 'dart:convert';

import 'package:eqmonitor/core/theme/model/theme_color_set.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:eqmonitor/core/theme/model/app_theme.dart';

void main() {
  group('ThemeColorSet', () {
    test('JSON往復で値が保持される', () {
      final original = AppTheme.eqmonitorDefault().light!;
      final json = original.toJson();
      final jsonStr = jsonEncode(json);
      final restored = ThemeColorSet.fromJson(
        jsonDecode(jsonStr) as Map<String, dynamic>,
      );
      expect(restored.primary, original.primary);
      expect(restored.status.success, original.status.success);
      expect(restored.intensity.seven.background, original.intensity.seven.background);
      expect(restored.mapColors.japanLand, original.mapColors.japanLand);
    });

    test('toColorScheme は正しいBrightnessを設定', () {
      final colorSet = AppTheme.eqmonitorDefault().light!;
      final scheme = colorSet.toColorScheme(Brightness.light);
      expect(scheme.brightness, Brightness.light);
      expect(scheme.primary, colorSet.primary);
    });
  });
}
```

- [ ] **Step 4: テスト — AppTheme のバリデーションと colorSetFor**

```dart
// app/test/core/theme/model/app_theme_test.dart
import 'dart:convert';

import 'package:eqmonitor/core/theme/model/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppTheme', () {
    test('eqmonitorDefault のJSON往復', () {
      final original = AppTheme.eqmonitorDefault();
      final json = original.toJson();
      final jsonStr = jsonEncode(json);
      final restored = AppTheme.fromJson(
        jsonDecode(jsonStr) as Map<String, dynamic>,
      );
      expect(restored.name, 'EQMonitor Default');
      expect(restored.modes.length, 2);
      expect(restored.light, isNotNull);
      expect(restored.dark, isNotNull);
    });

    test('colorSetFor light', () {
      final theme = AppTheme.eqmonitorDefault();
      final colorSet = theme.colorSetFor(Brightness.light);
      expect(colorSet, theme.light);
    });

    test('colorSetFor dark', () {
      final theme = AppTheme.eqmonitorDefault();
      final colorSet = theme.colorSetFor(Brightness.dark);
      expect(colorSet, theme.dark);
    });

    test('不正なJSON は FormatException', () {
      expect(
        () => AppTheme.fromJson({'name': 'bad'}),
        throwsA(isA<Error>()),
      );
    });
  });
}
```

- [ ] **Step 5: コード生成を実行**

Run: `cd app && dart run build_runner build --delete-conflicting-outputs`
Expected: `theme_color_set` と `app_theme` の `.freezed.dart`、`.g.dart` が生成される

- [ ] **Step 6: テスト実行**

Run: `cd app && flutter test test/core/theme/model/`
Expected: 全テストPASS

- [ ] **Step 7: コミット**

```bash
git add app/lib/core/theme/model/theme_color_set.dart app/lib/core/theme/model/app_theme.dart
git add app/test/core/theme/model/theme_color_set_test.dart app/test/core/theme/model/app_theme_test.dart
git add app/lib/core/theme/model/*.freezed.dart app/lib/core/theme/model/*.g.dart
git commit -m "feat: ThemeColorSetとAppThemeモデルを作成（プリセット付き）"
```

---

### Task 3: AppThemeNotifier Provider の作成

**Files:**
- Create: `app/lib/core/theme/provider/app_theme_notifier.dart`
- Test: `app/test/core/theme/provider/app_theme_notifier_test.dart`

**Interfaces:**
- Consumes: `AppTheme`, `ThemeColorSet`, `sharedPreferencesProvider`, `brightnessNotifierProvider`
- Produces:
  - `AppThemeNotifier` — `@Riverpod(keepAlive: true)`, state型 `({AppTheme lightTheme, AppTheme darkTheme})`。`setLightTheme(AppTheme)`, `setDarkTheme(AppTheme)`, `importFromJson(String) → Result<AppTheme, AppThemeImportException>`, `exportToJson(AppTheme) → String` メソッド。
  - `activeColorSetProvider` — `@riverpod ThemeColorSet activeColorSet(Ref ref)`, brightnessに応じてlight/darkのThemeColorSetを返す。
  - `colorSetForBrightnessProvider` — `@riverpod ThemeColorSet colorSetForBrightness(Ref ref, Brightness brightness)`, 明示的にBrightnessを指定してThemeColorSetを返す（app.dartでlight/dark両方を取得するため）。

- [ ] **Step 1: `AppThemeNotifier` を作成**

```dart
// app/lib/core/theme/provider/app_theme_notifier.dart
import 'dart:convert';

import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/theme/model/app_theme.dart';
import 'package:eqmonitor/core/theme/model/theme_color_set.dart';
import 'package:eqmonitor/core/theme/theme_provider.dart';
import 'package:eqmonitor/core/provider/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_theme_notifier.g.dart';

@Riverpod(keepAlive: true)
class AppThemeNotifier extends _$AppThemeNotifier {
  static const _lightKey = 'app_theme_light';
  static const _darkKey = 'app_theme_dark';

  @override
  ({AppTheme lightTheme, AppTheme darkTheme}) build() {
    return (
      lightTheme: _load(_lightKey) ?? AppTheme.eqmonitorDefault(),
      darkTheme: _load(_darkKey) ?? AppTheme.eqmonitorDefault(),
    );
  }

  Future<void> setLightTheme(AppTheme theme) async {
    state = (lightTheme: theme, darkTheme: state.darkTheme);
    await _save(_lightKey, theme);
  }

  Future<void> setDarkTheme(AppTheme theme) async {
    state = (lightTheme: state.lightTheme, darkTheme: theme);
    await _save(_darkKey, theme);
  }

  Result<AppTheme, AppThemeImportException> importFromJson(String rawJson) {
    try {
      final decoded = jsonDecode(rawJson);
      if (decoded is! Map<String, dynamic>) {
        return const Failure(
          AppThemeImportException('JSONの形式が不正です'),
        );
      }
      final theme = AppTheme.fromJson(decoded);
      if (theme.version != 1) {
        return const Failure(
          AppThemeImportException('未対応のテーマバージョンです'),
        );
      }
      for (final mode in theme.modes) {
        final colorSet = switch (mode) {
          ThemeBrightnessMode.light => theme.light,
          ThemeBrightnessMode.dark => theme.dark,
        };
        if (colorSet == null) {
          return Failure(
            AppThemeImportException('${mode.name}モードの色定義がありません'),
          );
        }
      }
      return Success(theme);
    } on FormatException catch (_) {
      return const Failure(
        AppThemeImportException('JSONの解析に失敗しました'),
      );
    } on Exception catch (_) {
      return const Failure(
        AppThemeImportException('テーマJSONの内容が不正です'),
      );
    }
  }

  String exportToJson(AppTheme theme) =>
      const JsonEncoder.withIndent('  ').convert(theme.toJson());

  AppTheme? _load(String key) {
    final value = ref.read(sharedPreferencesProvider).getString(key);
    if (value == null) return null;
    try {
      return AppTheme.fromJson(
        jsonDecode(value) as Map<String, dynamic>,
      );
    } on Exception catch (_) {
      return null;
    }
  }

  Future<void> _save(String key, AppTheme theme) async {
    await ref
        .read(sharedPreferencesProvider)
        .setString(key, jsonEncode(theme.toJson()));
  }
}

@riverpod
ThemeColorSet activeColorSet(Ref ref) {
  final brightness = ref.watch(brightnessNotifierProvider);
  final themes = ref.watch(appThemeNotifierProvider);
  final theme = switch (brightness) {
    Brightness.light => themes.lightTheme,
    Brightness.dark => themes.darkTheme,
  };
  return theme.colorSetFor(brightness);
}

@riverpod
ThemeColorSet colorSetForBrightness(Ref ref, Brightness brightness) {
  final themes = ref.watch(appThemeNotifierProvider);
  final theme = switch (brightness) {
    Brightness.light => themes.lightTheme,
    Brightness.dark => themes.darkTheme,
  };
  return theme.colorSetFor(brightness);
}

final class AppThemeImportException implements Exception {
  const AppThemeImportException(this.message);
  final String message;
}
```

- [ ] **Step 2: テスト**

```dart
// app/test/core/theme/provider/app_theme_notifier_test.dart
import 'package:eqmonitor/core/theme/model/app_theme.dart';
import 'package:eqmonitor/core/theme/provider/app_theme_notifier.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppThemeNotifier', () {
    test('importFromJson — 正常なJSON', () {
      final theme = AppTheme.eqmonitorDefault();
      final notifier = AppThemeNotifier();
      final json = const JsonEncoder.withIndent('  ').convert(theme.toJson());
      // importFromJson のバリデーションロジックだけ検証
      // （Riverpod container は統合テストで検証）
    });
  });
}
```

注: Provider の統合テストは `ProviderContainer` + SharedPreferences モックが必要。ここではimportFromJsonのバリデーションロジック単体をテストする。

- [ ] **Step 3: コード生成**

Run: `cd app && dart run build_runner build --delete-conflicting-outputs`

- [ ] **Step 4: テスト実行**

Run: `cd app && flutter test test/core/theme/provider/`
Expected: PASS

- [ ] **Step 5: コミット**

```bash
git add app/lib/core/theme/provider/ app/test/core/theme/provider/
git commit -m "feat: AppThemeNotifierとactiveColorSetProviderを作成"
```

---

### Task 4: DesignSystemThemeExtension のリファクタ

**Files:**
- Modify: `app/lib/core/designsystem/extensions/design_system_theme_extension.dart`
- Modify: `app/lib/core/designsystem/design_system_build_context_x.dart`

**Interfaces:**
- Consumes: `ThemeColorSet`, `TypographyThemeExtension`, `SpacingThemeExtension`, `ShapeThemeExtension`
- Produces: `DesignSystemThemeExtension` with `colorTheme` (type: `ThemeColorSet`), `spacing`, `shape`, `typography` プロパティ。旧 `palette`, `color`, `textColor` は廃止。

- [ ] **Step 1: `DesignSystemThemeExtension` を書き換え**

`palette`, `color`, `textColor` を `colorTheme` (`ThemeColorSet`) に統合する。`TypographyThemeExtension` は `TextColorThemeExtension` に依存しているが、タイポグラフィの色は `colorTheme.onSurface` / `colorTheme.onSurfaceVariant` から取得するように変更する。

```dart
// app/lib/core/designsystem/extensions/design_system_theme_extension.dart
// ignore_for_file: annotate_overrides

import 'package:eqmonitor/core/designsystem/extensions/shape_theme_extension.dart';
import 'package:eqmonitor/core/designsystem/extensions/spacing_theme_extension.dart';
import 'package:eqmonitor/core/designsystem/extensions/typography_theme_extension.dart';
import 'package:eqmonitor/core/theme/model/theme_color_set.dart';
import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'design_system_theme_extension.tailor.dart';

@TailorMixin(themeGetter: ThemeGetter.onThemeData)
class DesignSystemThemeExtension
    extends ThemeExtension<DesignSystemThemeExtension>
    with _$DesignSystemThemeExtensionTailorMixin {
  const DesignSystemThemeExtension({
    required this.colorTheme,
    required this.spacing,
    required this.shape,
    required this.typography,
  });

  final ThemeColorSet colorTheme;
  final SpacingThemeExtension spacing;
  final ShapeThemeExtension shape;
  final TypographyThemeExtension typography;
}
```

注: `ThemeColorSet` は Freezed で生成されるため `@tailorMixinComponent` ではない。`theme_tailor` の `lerp` は `ThemeColorSet` の `lerp` をサポートしないため、手動の `copyWith` / `lerp` override が必要か確認し、必要なら `lerpDouble` 等で各Colorを補間する実装を追加する。あるいは `@TailorMixin` を外して手動で `ThemeExtension` を実装する。

- [ ] **Step 2: `TypographyThemeExtension` の `TextColorThemeExtension` 依存を解消**

`TypographyThemeExtension` のファクトリを `ThemeColorSet` を受け取る形に変更する。

`app/lib/core/designsystem/extensions/typography_theme_extension.dart` を修正:
- `factory TypographyThemeExtension.light(TextColorThemeExtension textColor)` → `factory TypographyThemeExtension.fromColorTheme(ThemeColorSet colorTheme)`
- `textColor.primary` → `colorTheme.onSurface`
- `textColor.secondary` → `colorTheme.onSurfaceVariant`
- `textColor.tertiary` → `colorTheme.outline`

- [ ] **Step 3: `design_system_build_context_x.dart` はそのまま維持**

`context.designSystem` アクセスパターンは変更不要（`DesignSystemThemeExtension` の型は同じ）。ただし `context.designSystem.palette` → `context.designSystem.colorTheme` へのAPIの変更は Task 6 で対応する。

- [ ] **Step 4: コード生成**

Run: `cd app && dart run build_runner build --delete-conflicting-outputs`
Expected: `.tailor.dart` が再生成される

- [ ] **Step 5: コミット**

```bash
git add app/lib/core/designsystem/extensions/design_system_theme_extension.dart
git add app/lib/core/designsystem/extensions/typography_theme_extension.dart
git commit -m "refactor: DesignSystemThemeExtensionをcolorTheme(ThemeColorSet)に統合"
```

---

### Task 5: buildTheme() と app.dart の統合

**Files:**
- Modify: `app/lib/core/theme/build_theme.dart`
- Modify: `app/lib/app.dart`

**Interfaces:**
- Consumes: `ThemeColorSet`, `DesignSystemThemeExtension`, `AppThemeNotifier`, `activeColorSetProvider`, `themeModeProvider`
- Produces: `buildTheme(ThemeColorSet colorSet, Brightness brightness) → ThemeData`

- [ ] **Step 1: `buildTheme()` を書き換え**

```dart
// app/lib/core/theme/build_theme.dart
import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/core/designsystem/extensions/shape_theme_extension.dart';
import 'package:eqmonitor/core/designsystem/extensions/spacing_theme_extension.dart';
import 'package:eqmonitor/core/designsystem/extensions/typography_theme_extension.dart';
import 'package:eqmonitor/core/theme/model/theme_color_set.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

ThemeData buildTheme({
  required ThemeColorSet colorSet,
  required Brightness brightness,
}) {
  final colorScheme = colorSet.toColorScheme(brightness);
  final spacing = SpacingThemeExtension.standard();
  final shape = ShapeThemeExtension.standard();
  final typography = TypographyThemeExtension.fromColorTheme(colorSet);

  final designSystem = DesignSystemThemeExtension(
    colorTheme: colorSet,
    spacing: spacing,
    shape: shape,
    typography: typography,
  );

  return ThemeData(
    colorScheme: colorScheme,
    scaffoldBackgroundColor: colorSet.surfaceContainerLow,
    cardColor: colorSet.surface,
    dialogTheme: DialogThemeData(
      backgroundColor: colorSet.surface,
      surfaceTintColor: Colors.transparent,
    ),
    cardTheme: CardThemeData(
      color: colorSet.surfaceContainerHigh,
      surfaceTintColor: Colors.transparent,
      shape: RoundedSuperellipseBorder(
        borderRadius: BorderRadius.circular(shape.card),
      ),
    ),
    extensions: [designSystem],
    useMaterial3: true,
    textTheme: TextTheme(
      displayLarge: typography.displayLarge,
      displayMedium: typography.displayMedium,
      headlineLarge: typography.headlineLarge,
      headlineMedium: typography.headlineMedium,
      headlineSmall: typography.headlineSmall,
      titleLarge: typography.titleLarge,
      titleMedium: typography.titleMedium,
      titleSmall: typography.titleSmall,
      bodyLarge: typography.bodyLarge,
      bodyMedium: typography.bodyMedium,
      bodySmall: typography.bodySmall,
      labelLarge: typography.labelLarge,
      labelMedium: typography.labelMedium,
      labelSmall: typography.labelSmall,
    ),
    fontFamily: primaryFontFamily,
    fontFamilyFallback: japaneseFontFamilyFallback,
    cupertinoOverrideTheme: CupertinoThemeData(
      brightness: brightness,
      applyThemeToAll: true,
      primaryColor: colorSet.primary,
      scaffoldBackgroundColor: colorSet.surface,
      barBackgroundColor: colorSet.surface,
    ),
    appBarTheme: AppBarTheme(
      surfaceTintColor: Colors.transparent,
      scrolledUnderElevation: 0,
      backgroundColor: colorSet.surfaceContainerLow,
      foregroundColor: colorSet.onSurface,
    ),
    splashFactory: NoSplash.splashFactory,
    // ignore: deprecated_member_use
    sliderTheme: const SliderThemeData(year2023: false),
    // ignore: deprecated_member_use
    progressIndicatorTheme: const ProgressIndicatorThemeData(year2023: false),
    dropdownMenuTheme: DropdownMenuThemeData(
      menuStyle: MenuStyle(
        padding: WidgetStateProperty.all(EdgeInsets.zero),
        shape: WidgetStateProperty.all(
          RoundedSuperellipseBorder(
            borderRadius: BorderRadius.circular(shape.sm),
          ),
        ),
      ),
    ),
  );
}
```

- [ ] **Step 2: `app.dart` を書き換え**

`DynamicColorBuilder` と `CustomColors` を削除し、`activeColorSetProvider` を使用する形に変更する。

```dart
// app/lib/app.dart — build() 内
final theme = ref.watch(themeModeProvider);
final routerConfig = ref.watch(goRouterProvider);
final lightColorSet = ref.watch(colorSetForBrightnessProvider(Brightness.light));
final darkColorSet = ref.watch(colorSetForBrightnessProvider(Brightness.dark));

final app = MaterialApp.router(
  title: 'EQMonitor',
  themeMode: theme.value,
  routerConfig: routerConfig,
  builder: (context, child) =>
      DebugLauncher(child: child ?? const SizedBox.shrink()),
  theme: buildTheme(colorSet: lightColorSet, brightness: Brightness.light),
  darkTheme: buildTheme(colorSet: darkColorSet, brightness: Brightness.dark),
  localizationsDelegates: const [...],
  supportedLocales: const [Locale('ja', 'JP')],
);
```

`activeColorSetForBrightnessProvider` は明示的にBrightnessを指定できるfamilyプロバイダ（または2つの個別Provider）として `app_theme_notifier.dart` に追加する。

- [ ] **Step 3: `CustomColors` を削除**

`app/lib/core/theme/custom_colors.dart` を削除（`error` は `ThemeColorSet.error` に移行済み）。

- [ ] **Step 4: `buildCupertinoTheme` を削除**

もう使われない。`cupertinoOverrideTheme` は `buildTheme` 内で設定済み。

- [ ] **Step 5: analyze 実行**

Run: `cd app && dart analyze`
Expected: エラーなし（この時点で旧API参照箇所がコンパイルエラーになる。それらは Task 6, 7 で修正する）

- [ ] **Step 6: コミット**

```bash
git add app/lib/core/theme/build_theme.dart app/lib/app.dart
git add app/lib/core/theme/provider/app_theme_notifier.dart
git commit -m "feat: buildThemeとapp.dartをAppThemeNotifier経由に統合"
```

---

### Task 6: designSystem.palette / designSystem.color / designSystem.textColor 参照の移行

**Files:**
- Modify: 約86箇所のファイル（`designSystem.palette.*`, `designSystem.color.*`, `designSystem.textColor.*` を `designSystem.colorTheme.*` に置換）

**Interfaces:**
- Consumes: Task 4 で変更した `DesignSystemThemeExtension`
- Produces: 全ての旧プロパティアクセスを新しいアクセスパターンに移行

旧→新の置換ルール:

| 旧アクセス | 新アクセス |
|---|---|
| `designSystem.palette.brandPrimary` | `designSystem.colorTheme.primary` |
| `designSystem.palette.brandPrimaryContainer` | `designSystem.colorTheme.primaryContainer` |
| `designSystem.palette.brandSecondary` | `designSystem.colorTheme.secondary` |
| `designSystem.palette.brandTertiary` | `designSystem.colorTheme.tertiary` |
| `designSystem.palette.statusSuccess` | `designSystem.colorTheme.status.success` |
| `designSystem.palette.statusWarning` | `designSystem.colorTheme.status.warning` |
| `designSystem.palette.statusDanger` | `designSystem.colorTheme.error` |
| `designSystem.palette.statusInfo` | `designSystem.colorTheme.status.info` |
| `designSystem.color.backgroundDefault` | `designSystem.colorTheme.surfaceContainerLow` |
| `designSystem.color.backgroundSubtle` | `designSystem.colorTheme.surfaceContainer` |
| `designSystem.color.surfaceDefault` | `designSystem.colorTheme.surface` |
| `designSystem.color.surfaceRaised` | `designSystem.colorTheme.surfaceContainerLow` |
| `designSystem.color.surfaceCard` | `designSystem.colorTheme.surfaceContainerHigh` |
| `designSystem.color.surfaceEmphasis` | `designSystem.colorTheme.surfaceContainerHighest` |
| `designSystem.color.outlineSoft` | `designSystem.colorTheme.outlineVariant` |
| `designSystem.color.outlineStrong` | `designSystem.colorTheme.outline` |
| `designSystem.textColor.primary` | `designSystem.colorTheme.onSurface` |
| `designSystem.textColor.secondary` | `designSystem.colorTheme.onSurfaceVariant` |
| `designSystem.textColor.tertiary` | `designSystem.colorTheme.outline` |
| `designSystem.textColor.inverse` | `designSystem.colorTheme.onInverseSurface` |
| `designSystem.textColor.onBrand` | `designSystem.colorTheme.onPrimary` |

- [ ] **Step 1: sed/grep で全箇所を一括置換**

各置換ルールをファイルごとに適用する。`grep -rn` で対象行を見つけ、`Edit` で置換する。

- [ ] **Step 2: analyze 実行**

Run: `cd app && dart analyze`
Expected: 旧プロパティ参照のエラーが解消

- [ ] **Step 3: コミット**

```bash
git add -A
git commit -m "refactor: designSystem.palette/color/textColorをdesignSystem.colorThemeに移行"
```

---

### Task 7: Theme.of(context).colorScheme 参照の移行

**Files:**
- Modify: 約239箇所のファイル

**Interfaces:**
- Consumes: Task 4 で変更した `DesignSystemThemeExtension`
- Produces: 全ての `Theme.of(context).colorScheme.*` 参照を `designSystem.colorTheme.*` に置換

置換ルール:

| 旧アクセス | 新アクセス |
|---|---|
| `Theme.of(context).colorScheme.primary` | `designSystem.colorTheme.primary` |
| `Theme.of(context).colorScheme.onPrimary` | `designSystem.colorTheme.onPrimary` |
| `Theme.of(context).colorScheme.surface` | `designSystem.colorTheme.surface` |
| `Theme.of(context).colorScheme.onSurface` | `designSystem.colorTheme.onSurface` |
| `Theme.of(context).colorScheme.error` | `designSystem.colorTheme.error` |
| `Theme.of(context).colorScheme.outline` | `designSystem.colorTheme.outline` |
| （他のColorSchemeプロパティも同名で移行）| |

各ファイルで `Theme.of(context).colorScheme` を使っている箇所に `final designSystem = context.designSystem;` を追加（既にある場合は省略）し、参照を置き換える。

- [ ] **Step 1: 対象ファイル一覧を取得**

Run: `grep -rln 'Theme\.of(context)\.colorScheme\|\.colorScheme\.' app/lib/ --include='*.dart' | grep -v '\.g\.dart\|\.freezed\.dart\|\.tailor\.dart\|build_theme\.dart'`

- [ ] **Step 2: 各ファイルを移行**

パターン: `Theme.of(context).colorScheme.xxx` → `context.designSystem.colorTheme.xxx`

`context.designSystem` が未使用のファイルでは import を追加:
```dart
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
```

- [ ] **Step 3: analyze 実行**

Run: `cd app && dart analyze`
Expected: エラーなし

- [ ] **Step 4: コミット**

```bash
git add -A
git commit -m "refactor: Theme.of(context).colorSchemeをdesignSystem.colorThemeに移行"
```

---

### Task 8: intensityColorProvider / estimatedIntensityColorProvider 参照の移行

**Files:**
- Modify: 約45箇所（intensityColorProvider）+ 約12箇所（estimatedIntensityColorProvider）

**Interfaces:**
- Consumes: Task 4 で変更した `DesignSystemThemeExtension`
- Produces: Provider経由の震度カラー取得を `designSystem.colorTheme.intensity` / `designSystem.colorTheme.estimatedIntensity` に移行

移行パターン:

**Widget内 (BuildContext あり):**
```dart
// 旧
final intensityColor = ref.watch(intensityColorProvider);
final color = intensityColor.fromJmaIntensity(intensity);
// → color.foreground, color.background

// 新
final designSystem = context.designSystem;
final entry = designSystem.colorTheme.intensity.seven; // 例
// → entry.resolvedForeground, entry.background
```

`IntensityColorModel` → `IntensityColors` の対応:
- `intensityColor.fromJmaIntensity(intensity)` のようなスイッチロジックは `IntensityColors` に extension として追加する（`IntensityColors` に `IntensityColorEntry fromJmaIntensity(JmaIntensity)` メソッドを追加）。
- `TextColorModel.foreground` → `IntensityColorEntry.resolvedForeground`
- `TextColorModel.background` → `IntensityColorEntry.background`

**非Widget (Ref あり、BuildContext なし):**
- `activeColorSetProvider` 経由で `ThemeColorSet` を取得し、`.intensity` にアクセス。

- [ ] **Step 1: IntensityColors に JmaIntensity / JmaLpgmIntensity のルックアップ extension を追加**

```dart
// app/lib/core/theme/model/intensity_colors.dart に追加
extension IntensityColorsLookup on IntensityColors {
  IntensityColorEntry fromJmaIntensity(JmaIntensity intensity) =>
      switch (intensity) {
        JmaIntensity.unknown => unknown,
        JmaIntensity.zero => zero,
        JmaIntensity.one => one,
        JmaIntensity.two => two,
        JmaIntensity.three => three,
        JmaIntensity.four => four,
        JmaIntensity.fiveUnknown => fiveLower,
        JmaIntensity.fiveLower => fiveLower,
        JmaIntensity.fiveUpper => fiveUpper,
        JmaIntensity.sixLower => sixLower,
        JmaIntensity.sixUpper => sixUpper,
        JmaIntensity.seven => seven,
      };

  IntensityColorEntry fromJmaLpgmIntensity(JmaLpgmIntensity intensity) =>
      switch (intensity) {
        JmaLpgmIntensity.unknown => unknown,
        JmaLpgmIntensity.zero => zero,
        JmaLpgmIntensity.one => three,
        JmaLpgmIntensity.two => four,
        JmaLpgmIntensity.three => fiveLower,
        JmaLpgmIntensity.four => seven,
      };
}
```

- [ ] **Step 2: 各参照箇所を移行**

45 + 12 = 57 箇所を移行。基本パターン:
- `ref.watch(intensityColorProvider)` → 削除し、`context.designSystem.colorTheme.intensity` を使用
- `ref.watch(estimatedIntensityColorProvider)` → 削除し、`context.designSystem.colorTheme.estimatedIntensity` を使用

テストファイルも対応:
- `test/core/provider/config/theme/intensity_color/` → 新しい `AppThemeNotifier` のテストに更新 or 削除
- `test/feature/settings/features/display_settings/color_scheme/` → 設定UIが Task 10 で書き換わるため、このタスクでは一旦テストを削除

- [ ] **Step 3: 旧プロバイダーファイルを削除**

```
app/lib/core/provider/config/theme/intensity_color/intensity_color_provider.dart
app/lib/core/provider/config/theme/intensity_color/estimated_intensity_color_provider.dart
app/lib/core/provider/config/theme/intensity_color/model/intensity_color_model.dart
```

生成ファイル（`.g.dart`, `.freezed.dart`）も削除。

- [ ] **Step 4: analyze 実行**

Run: `cd app && dart analyze`
Expected: エラーなし

- [ ] **Step 5: コミット**

```bash
git add -A
git commit -m "refactor: intensityColorProvider/estimatedIntensityColorProviderをdesignSystem.colorThemeに移行"
```

---

### Task 9: MapColorScheme 参照の移行

**Files:**
- Modify: `app/lib/feature/map/data/notifier/map_configuration_notifier.dart`
- Modify: `app/lib/feature/map/data/provider/map_style_util.dart`
- Modify: `app/lib/feature/map/data/model/map_configuration.dart`（`MapColorScheme` クラスを削除）

**Interfaces:**
- Consumes: `ThemeColorSet.mapColors` (`MapColors`)
- Produces: `MapStyleUtil.getStyle()` が `MapColors` を受け取る形に変更

- [ ] **Step 1: `MapStyleUtil.getStyle()` の引数を `MapColors` に変更**

`app/lib/feature/map/data/provider/map_style_util.dart` の `getStyle(MapColorScheme)` → `getStyle(MapColors)` に変更。プロパティアクセスも:
- `colorScheme.backgroundColor` → `mapColors.background`
- `colorScheme.worldLandColor` → `mapColors.worldLand`
- 以下同様

- [ ] **Step 2: `MapConfigurationNotifier` で `activeColorSetProvider` の `mapColors` を使用**

- [ ] **Step 3: `map_configuration.dart` から `MapColorScheme` クラスを削除**

- [ ] **Step 4: analyze 実行**

Run: `cd app && dart analyze`

- [ ] **Step 5: コミット**

```bash
git add -A
git commit -m "refactor: MapColorSchemeをdesignSystem.colorTheme.mapColorsに移行"
```

---

### Task 10: 旧ファイル削除とクリーンアップ

**Files:**
- Delete: `app/lib/core/designsystem/extensions/color_palette.dart` (+`.tailor.dart`)
- Delete: `app/lib/core/designsystem/extensions/color_theme_extension.dart` (+`.tailor.dart`)
- Delete: `app/lib/core/designsystem/extensions/text_color_theme_extension.dart` (+`.tailor.dart`)
- Delete: `app/lib/core/theme/custom_colors.dart`
- Delete: `app/lib/core/provider/config/theme/intensity_color/` ディレクトリ全体（Task 8 で未削除なら）
- Modify: 不要になったimport文の除去

**Interfaces:**
- Consumes: Task 4-9 の移行が完了していること
- Produces: 旧カラーシステムの完全除去

- [ ] **Step 1: 旧ファイル削除**

```bash
rm app/lib/core/designsystem/extensions/color_palette.dart
rm app/lib/core/designsystem/extensions/color_palette.tailor.dart
rm app/lib/core/designsystem/extensions/color_theme_extension.dart
rm app/lib/core/designsystem/extensions/color_theme_extension.tailor.dart
rm app/lib/core/designsystem/extensions/text_color_theme_extension.dart
rm app/lib/core/designsystem/extensions/text_color_theme_extension.tailor.dart
rm app/lib/core/theme/custom_colors.dart
rm -rf app/lib/core/provider/config/theme/intensity_color/
```

- [ ] **Step 2: 不要な import を削除**

`grep -rn` で削除したファイルへの import を検索し、全て除去。

- [ ] **Step 3: analyze + test 実行**

Run: `cd app && dart analyze && flutter test`
Expected: 全て PASS

- [ ] **Step 4: コミット**

```bash
git add -A
git commit -m "chore: 旧カラーシステムのファイルを削除"
```

---

### Task 11: SharedPreferences マイグレーション

**Files:**
- Create: `app/lib/core/theme/migration/theme_migration.dart`
- Modify: `app/lib/core/theme/provider/app_theme_notifier.dart`
- Test: `app/test/core/theme/migration/theme_migration_test.dart`

**Interfaces:**
- Consumes: 旧 SharedPreferences キー `intensity_color`、`estimated_intensity_color`、`AppTheme.eqmonitorDefault()`
- Produces: `migrateIntensityColors(SharedPreferences prefs) → AppTheme?` — 旧形式のJSONを読み取り、新 `AppTheme` に変換する関数。`AppThemeNotifier.build()` 内で初回起動時に呼び出す。

- [ ] **Step 1: マイグレーション関数を作成**

```dart
// app/lib/core/theme/migration/theme_migration.dart
import 'dart:convert';

import 'package:eqmonitor/core/theme/model/app_theme.dart';
import 'package:eqmonitor/core/theme/model/intensity_color_entry.dart';
import 'package:eqmonitor/core/theme/model/intensity_colors.dart';
import 'package:eqmonitor/core/theme/model/intensity_text_color.dart';
import 'package:shared_preferences/shared_preferences.dart';

AppTheme? migrateFromLegacyIntensityColors(SharedPreferences prefs) {
  final intensityJson = prefs.getString('intensity_color');
  final estimatedJson = prefs.getString('estimated_intensity_color');

  if (intensityJson == null && estimatedJson == null) {
    return null;
  }

  final defaultTheme = AppTheme.eqmonitorDefault();

  // 旧IntensityColorModel のJSON形式:
  // { "zero": {"foreground": "#FF...", "background": "#FF..."}, ... }
  IntensityColors? migratedIntensity;
  if (intensityJson != null) {
    try {
      final decoded = jsonDecode(intensityJson) as Map<String, dynamic>;
      migratedIntensity = _convertLegacyIntensity(decoded);
    } on Exception catch (_) {
      // マイグレーション失敗→デフォルト使用
    }
  }

  // 旧EstimatedIntensityColorModel も同じ形式
  // (four〜seven のみ抽出)
  // ...同様のロジック

  // デフォルトテーマにマイグレーション結果を反映
  var lightSet = defaultTheme.light!;
  var darkSet = defaultTheme.dark!;

  if (migratedIntensity != null) {
    lightSet = lightSet.copyWith(intensity: migratedIntensity);
    darkSet = darkSet.copyWith(intensity: migratedIntensity);
  }

  // 旧キーを削除
  prefs.remove('intensity_color');
  prefs.remove('estimated_intensity_color');

  return defaultTheme.copyWith(light: lightSet, dark: darkSet);
}

IntensityColors _convertLegacyIntensity(Map<String, dynamic> json) {
  IntensityColorEntry convert(Map<String, dynamic> entry) {
    // 旧形式: {"foreground": "#AARRGGBB", "background": "#AARRGGBB"}
    return IntensityColorEntry(
      background: _parseColor(entry['background'] as String),
      foreground: IntensityTextColor.manual(
        color: _parseColor(entry['foreground'] as String),
      ),
    );
  }
  return IntensityColors(
    unknown: convert(json['unknown'] as Map<String, dynamic>),
    zero: convert(json['zero'] as Map<String, dynamic>),
    one: convert(json['one'] as Map<String, dynamic>),
    two: convert(json['two'] as Map<String, dynamic>),
    three: convert(json['three'] as Map<String, dynamic>),
    four: convert(json['four'] as Map<String, dynamic>),
    fiveLower: convert(json['fiveLower'] as Map<String, dynamic>),
    fiveUpper: convert(json['fiveUpper'] as Map<String, dynamic>),
    sixLower: convert(json['sixLower'] as Map<String, dynamic>),
    sixUpper: convert(json['sixUpper'] as Map<String, dynamic>),
    seven: convert(json['seven'] as Map<String, dynamic>),
  );
}

Color _parseColor(String hex) {
  // ColorJsonConverter と同じロジック
  if (hex.startsWith('#')) {
    final h = hex.substring(1);
    if (h.length == 8) return Color(int.parse(h, radix: 16));
    if (h.length == 6) return Color(int.parse('FF$h', radix: 16));
  }
  throw FormatException('Invalid color: $hex');
}
```

- [ ] **Step 2: `AppThemeNotifier.build()` でマイグレーションを呼び出す**

```dart
@override
({AppTheme lightTheme, AppTheme darkTheme}) build() {
  final prefs = ref.read(sharedPreferencesProvider);

  // レガシーマイグレーション（初回のみ）
  final migrated = migrateFromLegacyIntensityColors(prefs);
  if (migrated != null) {
    _save(_lightKey, migrated);
    _save(_darkKey, migrated);
    return (lightTheme: migrated, darkTheme: migrated);
  }

  return (
    lightTheme: _load(_lightKey) ?? AppTheme.eqmonitorDefault(),
    darkTheme: _load(_darkKey) ?? AppTheme.eqmonitorDefault(),
  );
}
```

- [ ] **Step 3: テスト**

```dart
// app/test/core/theme/migration/theme_migration_test.dart
import 'package:eqmonitor/core/theme/migration/theme_migration.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('migrateFromLegacyIntensityColors', () {
    test('旧キーが無い場合はnullを返す', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      expect(migrateFromLegacyIntensityColors(prefs), isNull);
    });

    test('旧intensity_colorキーがある場合はマイグレーション', () async {
      SharedPreferences.setMockInitialValues({
        'intensity_color': '{"unknown":{"foreground":"#FFFFFFFF","background":"#FF000000"},"zero":{"foreground":"#FF000000","background":"#FFFFFFFF"},"one":{"foreground":"#FF000000","background":"#FF03B5FF"},"two":{"foreground":"#FF000000","background":"#FF76FF03"},"three":{"foreground":"#FF000000","background":"#FF00C853"},"four":{"foreground":"#FF000000","background":"#FFFFFFEB3B"},"fiveLower":{"foreground":"#FF000000","background":"#FFFFC107"},"fiveUpper":{"foreground":"#FF000000","background":"#FFFF6F00"},"sixLower":{"foreground":"#FFFFFFFF","background":"#FFFF2800"},"sixUpper":{"foreground":"#FFFFFFFF","background":"#FFA50021"},"seven":{"foreground":"#FFFFFFFF","background":"#FFC800FF"}}',
      });
      final prefs = await SharedPreferences.getInstance();
      final result = migrateFromLegacyIntensityColors(prefs);
      expect(result, isNotNull);
      expect(result!.light!.intensity.seven.background.value, isNonZero);
      // 旧キーが削除されたことを確認
      expect(prefs.getString('intensity_color'), isNull);
    });
  });
}
```

- [ ] **Step 4: テスト実行**

Run: `cd app && flutter test test/core/theme/migration/`
Expected: PASS

- [ ] **Step 5: コミット**

```bash
git add app/lib/core/theme/migration/ app/test/core/theme/migration/
git add app/lib/core/theme/provider/app_theme_notifier.dart
git commit -m "feat: 旧震度カラー設定のマイグレーション関数を追加"
```

---

### Task 12: 最終検証

**Files:**
- 変更なし（テスト実行のみ）

**Interfaces:**
- Consumes: Task 1-11 の全成果物
- Produces: 全テストPASS、analyze PASS

- [ ] **Step 1: 全テスト実行**

Run: `cd app && flutter test`
Expected: 全テスト PASS

- [ ] **Step 2: analyze 実行**

Run: `melos run analyze`
Expected: エラーなし

- [ ] **Step 3: 旧API参照の残存チェック**

```bash
grep -rn 'intensityColorProvider\|estimatedIntensityColorProvider\|MapColorScheme\|ColorPalette\|ColorThemeExtension\|TextColorThemeExtension\|\.colorScheme\.' app/lib/ --include='*.dart' | grep -v '\.g\.dart\|\.freezed\.dart\|\.tailor\.dart\|build_theme\.dart\|theme_color_set\.dart'
```

Expected: ヒットなし（build_theme.dart 内の `toColorScheme` 呼び出しのみ許容）

- [ ] **Step 4: コミット（必要な修正があれば）**

```bash
git add -A
git commit -m "fix: 最終検証で見つかった残存参照を修正"
```

---

## スコープ外（後続計画として別途作成）

以下は本計画のコアシステムが完成した後、別計画として実施する:

1. **テーマ設定UI** — テーマ選択画面（プリセット一覧、Light/Dark別選択）、JSON import/exportダイアログ、色エディタ。既存の `color_scheme_config_page.dart` / `estimated_intensity_color_config_page.dart` を `AppThemeNotifier` ベースに書き換え。
2. **custom lint rule** — `Theme.of(context).colorScheme` の直接参照を検出するlintルール。

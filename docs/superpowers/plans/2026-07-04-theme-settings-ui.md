# テーマ設定UI + custom lint rule Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** JSONテーマシステム(`AppTheme`/`ThemeColorSet`)に対するユーザー向け編集UI(プリセット選択・全トークン編集・JSONインポート/エクスポート)と、`Theme.of(context).colorScheme` の直接参照を防ぐ custom lint ルールを追加する。

**Architecture:** `AppThemeNotifier` に `setThemeForMode`/presets provider を追加し、宣言的な `ThemeColorFieldDef`/`IntensityFieldDef` リストでテーマの全カラートークンを1箇所に集約する。UIは `ThemeSettingsPage`(プリセット選択・プレビュー・JSON入出力の入口)と `ThemeEditorPage`(定義リストを描画するだけのフラット/震度セクション)の2画面構成。lintは新規スタンドアロンパッケージ `packages/eqmonitor_custom_lints`(custom_lint_builder)で `avoid_direct_color_scheme` ルールを実装し、`dart run custom_lint` で検証する(`dart analyze` はローカルでハングするため使わない)。

**Tech Stack:** Flutter/Dart, Riverpod (`@riverpod` / `hooks_riverpod`), Freezed, `flutter_colorpicker` (git fork), go_router_builder, custom_lint_builder + custom_lint_core + analyzer(lint package側)。

## Global Constraints

- コードスタイル: typedef禁止 / `Impl` 命名禁止 / 不要な `abstract interface class` 禁止 / freezedモデルは独立ファイル / `String` より enum / グローバル関数・変数禁止(class内定数か Provider 経由。ただし本コードベースの慣例である `@riverpod` トップレベル関数はグローバル関数禁止の例外として扱う——既存 `app_theme_notifier.dart` の `activeColorSet`/`colorSetForBrightness` がその前例)。
- 変数名は `designSystem`(`ds` 等の略称禁止)。
- UI層のカラーアクセスは `designSystem.colorTheme.*` のみ。`Theme.of(context).colorScheme` の直接参照は禁止(本計画のTask 7で機械的に検出する)。
- `dart analyze` はローカル環境でハングする既知の問題があるため、本計画の検証ステップには含めない。検証は `timeout` 付きの `flutter test` と `dart run custom_lint` で行う。すべての dart/flutter コマンドには `timeout <秒>` を前置する。
- 生成ファイル(`*.g.dart` / `*.freezed.dart`)はコミット対象。riverpod/freezed のコード生成は `dart run build_runner build --delete-conflicting-outputs --build-filter '<対象パス>'` で対象を絞って実行する。
- テスト判定基準: TDDで進める。develop の既存フルスイートには24件の既存失敗があるため、「全テストPASS」ではなく「新規失敗ゼロ(既存24件と一致)」を各タスクの合否基準とする。
- PRは常に `YumNumm/EQMonitor`(`gh pr create --repo YumNumm/EQMonitor`)、ベースブランチは `develop`。
- コミットメッセージの末尾には必ず以下のトレーラーを付与する:
  ```
  Claude-Session: https://claude.ai/code/session_01EapeTteTrPUodCTmDiTEWp
  ```

## File Structure

```
app/lib/core/theme/
  provider/app_theme_notifier.dart          # 変更: setThemeForMode 追加 (Task 1)
  provider/theme_presets_provider.dart       # 新規: themePresetsProvider (Task 1)
  model/theme_color_field_def.dart           # 新規: ThemeColorFieldDef 宣言リスト (Task 2)
  model/intensity_field_def.dart             # 新規: IntensityFieldDef 宣言リスト (Task 2)

app/lib/feature/settings/features/display_settings/
  ui/display_settings.dart                   # 変更: 「テーマ設定」タイル追加 (Task 3)
  ui/theme/theme_settings_page.dart          # 新規: プリセット選択+プレビュー (Task 3)
  ui/theme/theme_json_dialogs.dart           # 新規: import/exportダイアログ (Task 4)
  ui/theme/theme_editor_page.dart            # 新規: mode指定エディタ (Task 5, 6)
  data/notifier/theme_editor_controller.dart # 新規: 編集状態+即時保存 (Task 5)

app/lib/core/router/router.dart              # 変更: ThemeSettingsRoute/ThemeEditorRoute追加 (Task 3)

app/test/core/theme/provider/app_theme_notifier_test.dart          # 変更: setThemeForMode テスト追加 (Task 1)
app/test/core/theme/model/theme_color_field_def_test.dart          # 新規 (Task 2)
app/test/core/theme/model/intensity_field_def_test.dart            # 新規 (Task 2)
app/test/feature/settings/features/display_settings/theme_settings_page_test.dart  # 新規 (Task 3, 4)
app/test/feature/settings/features/display_settings/theme_editor_page_test.dart    # 新規 (Task 5, 6)

packages/eqmonitor_custom_lints/                    # 新規パッケージ (Task 7)
  pubspec.yaml
  lib/eqmonitor_custom_lints.dart                    # プラグインエントリポイント
  lib/rules/avoid_direct_color_scheme.dart
  test/rules/avoid_direct_color_scheme_test.dart
  test/fixtures/avoid_direct_color_scheme/violation.dart
  test/fixtures/avoid_direct_color_scheme/ok.dart

app/pubspec.yaml            # 変更: dev_dependency に eqmonitor_custom_lints 追加 (Task 8)
analysis_options.yaml       # 変更: analyzer.plugins に custom_lint 追加 (Task 8)
pubspec.yaml                # 変更: melos scripts に custom_lint 追加 (Task 8)
.github/workflows/wc-check-dart-analyze.yaml  # 変更: custom_lint 実行ステップ追加 (Task 8)
```

---
### Task 1: AppThemeNotifier に setThemeForMode + themePresetsProvider を追加

**Files:**
- Modify: `app/lib/core/theme/provider/app_theme_notifier.dart`
- Create: `app/lib/core/theme/provider/theme_presets_provider.dart`
- Modify: `app/test/core/theme/provider/app_theme_notifier_test.dart`
- Create: `app/test/core/theme/provider/theme_presets_provider_test.dart`

**Interfaces:**
- Consumes: 既存 `AppThemeNotifier.setLightTheme(AppTheme)` / `setDarkTheme(AppTheme)`(`app_theme_notifier.dart:57-65`)、`AppTheme.eqmonitorDefault()` / `AppTheme.jmaStandard()`(`app_theme.dart`)。
- Produces: `AppThemeNotifier.setThemeForMode(ThemeBrightnessMode mode, AppTheme theme)` — Task 3/4/5/6 の保存処理が使う唯一のAPI。`themePresetsProvider`(`Provider<List<AppTheme>>` 相当、`@riverpod List<AppTheme> themePresets(Ref ref)`)— Task 3 のプリセット選択UIが使う。

- [ ] **Step 1: 失敗するテストを書く(setThemeForMode)**

`app/test/core/theme/provider/app_theme_notifier_test.dart` の末尾、`main()` 内の最後の `group` の後に追加:

```dart
  group('AppThemeNotifier.setThemeForMode', () {
    test('mode=light で呼ぶと setLightTheme と同じ結果になる', () async {
      final container = await _container();
      addTearDown(container.dispose);

      final theme = AppTheme.eqmonitorDefault().copyWith(name: 'Custom Light');
      await _notifier(
        container,
      ).setThemeForMode(ThemeBrightnessMode.light, theme);

      final state = container.read(appThemeProvider);
      expect(state.lightTheme.name, 'Custom Light');
      expect(state.darkTheme.name, 'EQMonitor Default');
    });

    test('mode=dark で呼ぶと setDarkTheme と同じ結果になる', () async {
      final container = await _container();
      addTearDown(container.dispose);

      final theme = AppTheme.eqmonitorDefault().copyWith(name: 'Custom Dark');
      await _notifier(
        container,
      ).setThemeForMode(ThemeBrightnessMode.dark, theme);

      final state = container.read(appThemeProvider);
      expect(state.darkTheme.name, 'Custom Dark');
      expect(state.lightTheme.name, 'EQMonitor Default');
    });
  });
```

- [ ] **Step 2: テストが失敗することを確認する**

Run: `timeout 120 flutter test app/test/core/theme/provider/app_theme_notifier_test.dart -r expanded`
(作業ディレクトリ `app/` で実行)
Expected: FAIL — `The method 'setThemeForMode' isn't defined for the type 'AppThemeNotifier'`

- [ ] **Step 3: setThemeForMode を実装する**

`app/lib/core/theme/provider/app_theme_notifier.dart` の `setDarkTheme` メソッド(57-65行目)の直後に追加:

```dart
  Future<void> setThemeForMode(ThemeBrightnessMode mode, AppTheme theme) {
    return switch (mode) {
      ThemeBrightnessMode.light => setLightTheme(theme),
      ThemeBrightnessMode.dark => setDarkTheme(theme),
    };
  }
```

- [ ] **Step 4: テストがパスすることを確認する**

Run: `timeout 120 flutter test app/test/core/theme/provider/app_theme_notifier_test.dart -r expanded`
Expected: PASS (全件)

- [ ] **Step 5: 失敗するテストを書く(themePresetsProvider)**

新規作成 `app/test/core/theme/provider/theme_presets_provider_test.dart`:

```dart
import 'package:eqmonitor/core/provider/shared_preferences.dart' as app_prefs;
import 'package:eqmonitor/core/theme/model/app_theme.dart';
import 'package:eqmonitor/core/theme/provider/theme_presets_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('themePresetsProvider は EQMonitor Default と JMA Standard を含む', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final container = ProviderContainer(
      overrides: [
        app_prefs.sharedPreferencesProvider.overrideWithValue(
          app_prefs.SharedPreferencesAsync(prefs),
        ),
      ],
    );
    addTearDown(container.dispose);

    final presets = container.read(themePresetsProvider);
    expect(presets.length, 2);
    expect(presets.map((e) => e.name), [
      AppTheme.eqmonitorDefault().name,
      AppTheme.jmaStandard().name,
    ]);
  });
}
```

- [ ] **Step 6: テストが失敗することを確認する**

Run: `timeout 120 flutter test app/test/core/theme/provider/theme_presets_provider_test.dart -r expanded`
Expected: FAIL — `Target of URI doesn't exist: 'package:eqmonitor/core/theme/provider/theme_presets_provider.dart'`

- [ ] **Step 7: themePresetsProvider を実装する**

新規作成 `app/lib/core/theme/provider/theme_presets_provider.dart`:

```dart
import 'package:eqmonitor/core/theme/model/app_theme.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_presets_provider.g.dart';

@riverpod
List<AppTheme> themePresets(Ref ref) => [
  AppTheme.eqmonitorDefault(),
  AppTheme.jmaStandard(),
];
```

- [ ] **Step 8: コード生成を実行する**

Run: `cd app && timeout 300 dart run build_runner build --delete-conflicting-outputs --build-filter 'lib/core/theme/provider/theme_presets_provider.g.dart'`
Expected: `theme_presets_provider.g.dart` が生成される。生成後 `cd -` で戻る。

- [ ] **Step 9: テストがパスすることを確認する**

Run: `timeout 120 flutter test app/test/core/theme/provider/theme_presets_provider_test.dart -r expanded`
Expected: PASS

- [ ] **Step 10: Commit**

```bash
git add app/lib/core/theme/provider/app_theme_notifier.dart \
        app/lib/core/theme/provider/theme_presets_provider.dart \
        app/lib/core/theme/provider/theme_presets_provider.g.dart \
        app/test/core/theme/provider/app_theme_notifier_test.dart \
        app/test/core/theme/provider/theme_presets_provider_test.dart
git commit -m "$(cat <<'EOF'
feat(theme): AppThemeNotifierにsetThemeForMode/themePresetsProviderを追加

テーマ設定UIからプリセット適用・カスタム保存・JSONインポートを
単一APIで扱えるようにする。

Claude-Session: https://claude.ai/code/session_01EapeTteTrPUodCTmDiTEWp
EOF
)"
```

### Task 2: ThemeColorFieldDef / IntensityFieldDef 宣言リスト

**Files:**
- Create: `app/lib/core/theme/model/theme_color_field_def.dart`
- Create: `app/lib/core/theme/model/intensity_field_def.dart`
- Create: `app/test/core/theme/model/theme_color_field_def_test.dart`
- Create: `app/test/core/theme/model/intensity_field_def_test.dart`

**Interfaces:**
- Consumes: `ThemeColorSet`(全31フラットColor + `status`/`intensity`/`estimatedIntensity`/`mapColors`、`theme_color_set.dart`)、`StatusColors`(`status_colors.dart`)、`MapColors`(`map_colors.dart`)、`IntensityColors`(11エントリ、`intensity_colors.dart`)、`EstimatedIntensityColors`(6エントリ、`estimated_intensity_colors.dart`)、`IntensityColorEntry`(`background: Color`, `foreground: IntensityTextColor`、`intensity_color_entry.dart`)、`IntensityTextColor`(sealed `IntensityTextColor.auto()` / `IntensityTextColor.manual({required Color color})`、`intensity_text_color.dart`)。
- Produces: `ThemeColorFieldCategory` enum、`ThemeColorFieldDef`(`label: String`, `category: ThemeColorFieldCategory`, `Color Function(ThemeColorSet) getter`, `ThemeColorSet Function(ThemeColorSet, Color) setter`)、`themeColorFieldDefs: List<ThemeColorFieldDef>`(39件)。`IntensityFieldGroup` enum(`intensity`, `estimatedIntensity`)、`IntensityFieldDef`(`label: String`, `group: IntensityFieldGroup`, `IntensityColorEntry Function(ThemeColorSet) entryGetter`, `ThemeColorSet Function(ThemeColorSet, IntensityColorEntry) entrySetter`)、`intensityFieldDefs: List<IntensityFieldDef>`(17件: intensity 11 + estimatedIntensity 6)。Task 5/6 のエディタUIがこの2リストを描画するだけで完結する。

- [ ] **Step 1: 失敗するテストを書く(ThemeColorFieldDef の網羅性・getter/setter整合性)**

新規作成 `app/test/core/theme/model/theme_color_field_def_test.dart`:

```dart
import 'package:eqmonitor/core/theme/model/app_theme.dart';
import 'package:eqmonitor/core/theme/model/theme_color_field_def.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final base = AppTheme.eqmonitorDefault().light!;
  const probe = Color(0xFF123456);

  test('全39件のフィールド定義が存在する', () {
    expect(themeColorFieldDefs.length, 39);
  });

  test('各定義について setter(base, probe) 後に getter が probe を返す', () {
    for (final def in themeColorFieldDefs) {
      final updated = def.setter(base, probe);
      expect(
        def.getter(updated),
        probe,
        reason: '${def.label} の getter/setter が不整合です',
      );
    }
  });

  test('全定義をprobeで書き換えるとtoJsonの全Colorフィールドがprobeになる (ラウンドトリップ)', () {
    var mutated = base;
    for (final def in themeColorFieldDefs) {
      mutated = def.setter(mutated, probe);
    }
    final json = mutated.toJson();
    const flatColorKeys = [
      'primary', 'onPrimary', 'primaryContainer', 'onPrimaryContainer',
      'secondary', 'onSecondary', 'secondaryContainer', 'onSecondaryContainer',
      'tertiary', 'onTertiary', 'tertiaryContainer', 'onTertiaryContainer',
      'error', 'onError', 'errorContainer', 'onErrorContainer',
      'surface', 'onSurface', 'onSurfaceVariant',
      'surfaceContainerLowest', 'surfaceContainerLow', 'surfaceContainer',
      'surfaceContainerHigh', 'surfaceContainerHighest',
      'outline', 'outlineVariant', 'inverseSurface', 'onInverseSurface',
      'inversePrimary', 'shadow', 'scrim',
    ];
    for (final key in flatColorKeys) {
      expect(json[key], '#ff123456', reason: 'key=$key');
    }
    final status = json['status'] as Map<String, dynamic>;
    for (final key in ['success', 'warning', 'info']) {
      expect(status[key], '#ff123456', reason: 'status.$key');
    }
    final map = json['map'] as Map<String, dynamic>;
    for (final key in [
      'background', 'worldLand', 'worldLine', 'japanLand', 'japanLine',
    ]) {
      expect(map[key], '#ff123456', reason: 'map.$key');
    }
  });
}
```

- [ ] **Step 2: テストが失敗することを確認する**

Run: `timeout 120 flutter test app/test/core/theme/model/theme_color_field_def_test.dart -r expanded`
Expected: FAIL — `Target of URI doesn't exist: 'package:eqmonitor/core/theme/model/theme_color_field_def.dart'`

(注: `json[key]` の16進数フォーマットは `app/lib/core/util/converter/color_converter.dart` の `ColorJsonConverter` 実装に依存する。実装確認のため Step 3 着手前に一度 `cat app/lib/core/util/converter/color_converter.dart` でフォーマットを確認し、テストの期待値文字列をそれに合わせて修正すること。)

- [ ] **Step 3: ThemeColorFieldDef と39件の定義を実装する**

新規作成 `app/lib/core/theme/model/theme_color_field_def.dart`:

```dart
import 'package:eqmonitor/core/theme/model/theme_color_set.dart';
import 'package:flutter/material.dart';

enum ThemeColorFieldCategory { primary, secondary, tertiary, error, surface, status, map }

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
```

- [ ] **Step 4: テストがパスすることを確認する**

Run: `timeout 120 flutter test app/test/core/theme/model/theme_color_field_def_test.dart -r expanded`
Expected: PASS (39件チェック含め全件)

- [ ] **Step 5: 失敗するテストを書く(IntensityFieldDef)**

新規作成 `app/test/core/theme/model/intensity_field_def_test.dart`:

```dart
import 'package:eqmonitor/core/theme/model/app_theme.dart';
import 'package:eqmonitor/core/theme/model/intensity_color_entry.dart';
import 'package:eqmonitor/core/theme/model/intensity_field_def.dart';
import 'package:eqmonitor/core/theme/model/intensity_text_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final base = AppTheme.eqmonitorDefault().light!;
  const probeEntry = IntensityColorEntry(
    background: Color(0xFF123456),
    foreground: IntensityTextColor.manual(color: Color(0xFF654321)),
  );

  test('intensity 11件 + estimatedIntensity 6件 = 17件の定義が存在する', () {
    expect(intensityFieldDefs.length, 17);
    expect(
      intensityFieldDefs
          .where((e) => e.group == IntensityFieldGroup.intensity)
          .length,
      11,
    );
    expect(
      intensityFieldDefs
          .where((e) => e.group == IntensityFieldGroup.estimatedIntensity)
          .length,
      6,
    );
  });

  test('各定義について entrySetter(base, probeEntry) 後に entryGetter が probeEntry を返す', () {
    for (final def in intensityFieldDefs) {
      final updated = def.entrySetter(base, probeEntry);
      expect(
        def.entryGetter(updated),
        probeEntry,
        reason: '${def.label} の entryGetter/entrySetter が不整合です',
      );
    }
  });
}
```

- [ ] **Step 6: テストが失敗することを確認する**

Run: `timeout 120 flutter test app/test/core/theme/model/intensity_field_def_test.dart -r expanded`
Expected: FAIL — `Target of URI doesn't exist: 'package:eqmonitor/core/theme/model/intensity_field_def.dart'`

- [ ] **Step 7: IntensityFieldDef と17件の定義を実装する**

新規作成 `app/lib/core/theme/model/intensity_field_def.dart`:

```dart
import 'package:eqmonitor/core/theme/model/intensity_color_entry.dart';
import 'package:eqmonitor/core/theme/model/theme_color_set.dart';

enum IntensityFieldGroup { intensity, estimatedIntensity }

class IntensityFieldDef {
  const IntensityFieldDef({
    required this.label,
    required this.group,
    required this.entryGetter,
    required this.entrySetter,
  });

  final String label;
  final IntensityFieldGroup group;
  final IntensityColorEntry Function(ThemeColorSet colorSet) entryGetter;
  final ThemeColorSet Function(ThemeColorSet colorSet, IntensityColorEntry entry)
      entrySetter;
}

final List<IntensityFieldDef> intensityFieldDefs = [
  IntensityFieldDef(
    label: '震度不明',
    group: IntensityFieldGroup.intensity,
    entryGetter: (colorSet) => colorSet.intensity.unknown,
    entrySetter: (colorSet, entry) => colorSet.copyWith(
      intensity: colorSet.intensity.copyWith(unknown: entry),
    ),
  ),
  IntensityFieldDef(
    label: '震度0',
    group: IntensityFieldGroup.intensity,
    entryGetter: (colorSet) => colorSet.intensity.zero,
    entrySetter: (colorSet, entry) => colorSet.copyWith(
      intensity: colorSet.intensity.copyWith(zero: entry),
    ),
  ),
  IntensityFieldDef(
    label: '震度1',
    group: IntensityFieldGroup.intensity,
    entryGetter: (colorSet) => colorSet.intensity.one,
    entrySetter: (colorSet, entry) => colorSet.copyWith(
      intensity: colorSet.intensity.copyWith(one: entry),
    ),
  ),
  IntensityFieldDef(
    label: '震度2',
    group: IntensityFieldGroup.intensity,
    entryGetter: (colorSet) => colorSet.intensity.two,
    entrySetter: (colorSet, entry) => colorSet.copyWith(
      intensity: colorSet.intensity.copyWith(two: entry),
    ),
  ),
  IntensityFieldDef(
    label: '震度3',
    group: IntensityFieldGroup.intensity,
    entryGetter: (colorSet) => colorSet.intensity.three,
    entrySetter: (colorSet, entry) => colorSet.copyWith(
      intensity: colorSet.intensity.copyWith(three: entry),
    ),
  ),
  IntensityFieldDef(
    label: '震度4',
    group: IntensityFieldGroup.intensity,
    entryGetter: (colorSet) => colorSet.intensity.four,
    entrySetter: (colorSet, entry) => colorSet.copyWith(
      intensity: colorSet.intensity.copyWith(four: entry),
    ),
  ),
  IntensityFieldDef(
    label: '震度5弱',
    group: IntensityFieldGroup.intensity,
    entryGetter: (colorSet) => colorSet.intensity.fiveLower,
    entrySetter: (colorSet, entry) => colorSet.copyWith(
      intensity: colorSet.intensity.copyWith(fiveLower: entry),
    ),
  ),
  IntensityFieldDef(
    label: '震度5強',
    group: IntensityFieldGroup.intensity,
    entryGetter: (colorSet) => colorSet.intensity.fiveUpper,
    entrySetter: (colorSet, entry) => colorSet.copyWith(
      intensity: colorSet.intensity.copyWith(fiveUpper: entry),
    ),
  ),
  IntensityFieldDef(
    label: '震度6弱',
    group: IntensityFieldGroup.intensity,
    entryGetter: (colorSet) => colorSet.intensity.sixLower,
    entrySetter: (colorSet, entry) => colorSet.copyWith(
      intensity: colorSet.intensity.copyWith(sixLower: entry),
    ),
  ),
  IntensityFieldDef(
    label: '震度6強',
    group: IntensityFieldGroup.intensity,
    entryGetter: (colorSet) => colorSet.intensity.sixUpper,
    entrySetter: (colorSet, entry) => colorSet.copyWith(
      intensity: colorSet.intensity.copyWith(sixUpper: entry),
    ),
  ),
  IntensityFieldDef(
    label: '震度7',
    group: IntensityFieldGroup.intensity,
    entryGetter: (colorSet) => colorSet.intensity.seven,
    entrySetter: (colorSet, entry) => colorSet.copyWith(
      intensity: colorSet.intensity.copyWith(seven: entry),
    ),
  ),
  IntensityFieldDef(
    label: '推計震度4',
    group: IntensityFieldGroup.estimatedIntensity,
    entryGetter: (colorSet) => colorSet.estimatedIntensity.four,
    entrySetter: (colorSet, entry) => colorSet.copyWith(
      estimatedIntensity: colorSet.estimatedIntensity.copyWith(four: entry),
    ),
  ),
  IntensityFieldDef(
    label: '推計震度5弱',
    group: IntensityFieldGroup.estimatedIntensity,
    entryGetter: (colorSet) => colorSet.estimatedIntensity.fiveLower,
    entrySetter: (colorSet, entry) => colorSet.copyWith(
      estimatedIntensity: colorSet.estimatedIntensity.copyWith(
        fiveLower: entry,
      ),
    ),
  ),
  IntensityFieldDef(
    label: '推計震度5強',
    group: IntensityFieldGroup.estimatedIntensity,
    entryGetter: (colorSet) => colorSet.estimatedIntensity.fiveUpper,
    entrySetter: (colorSet, entry) => colorSet.copyWith(
      estimatedIntensity: colorSet.estimatedIntensity.copyWith(
        fiveUpper: entry,
      ),
    ),
  ),
  IntensityFieldDef(
    label: '推計震度6弱',
    group: IntensityFieldGroup.estimatedIntensity,
    entryGetter: (colorSet) => colorSet.estimatedIntensity.sixLower,
    entrySetter: (colorSet, entry) => colorSet.copyWith(
      estimatedIntensity: colorSet.estimatedIntensity.copyWith(
        sixLower: entry,
      ),
    ),
  ),
  IntensityFieldDef(
    label: '推計震度6強',
    group: IntensityFieldGroup.estimatedIntensity,
    entryGetter: (colorSet) => colorSet.estimatedIntensity.sixUpper,
    entrySetter: (colorSet, entry) => colorSet.copyWith(
      estimatedIntensity: colorSet.estimatedIntensity.copyWith(
        sixUpper: entry,
      ),
    ),
  ),
  IntensityFieldDef(
    label: '推計震度7',
    group: IntensityFieldGroup.estimatedIntensity,
    entryGetter: (colorSet) => colorSet.estimatedIntensity.seven,
    entrySetter: (colorSet, entry) => colorSet.copyWith(
      estimatedIntensity: colorSet.estimatedIntensity.copyWith(seven: entry),
    ),
  ),
];
```

- [ ] **Step 8: テストがパスすることを確認する**

Run: `timeout 120 flutter test app/test/core/theme/model/intensity_field_def_test.dart -r expanded`
Expected: PASS

- [ ] **Step 9: Commit**

```bash
git add app/lib/core/theme/model/theme_color_field_def.dart \
        app/lib/core/theme/model/intensity_field_def.dart \
        app/test/core/theme/model/theme_color_field_def_test.dart \
        app/test/core/theme/model/intensity_field_def_test.dart
git commit -m "$(cat <<'EOF'
feat(theme): テーマカラートークンの宣言的フィールド定義を追加

ThemeColorSet/IntensityColors/EstimatedIntensityColorsの全カラー
トークンをThemeColorFieldDef/IntensityFieldDefのリストに集約し、
エディタUI(後続タスク)からフィールド追加時の修正箇所を1箇所にする。

Claude-Session: https://claude.ai/code/session_01EapeTteTrPUodCTmDiTEWp
EOF
)"
```

### Task 3: ThemeSettingsPage(プリセット選択+プレビュー) + ルーティング + 表示設定への導線

**Files:**
- Create: `app/lib/feature/settings/features/display_settings/ui/theme/theme_settings_page.dart`
- Modify: `app/lib/feature/settings/features/display_settings/ui/display_settings.dart`
- Modify: `app/lib/core/router/router.dart`
- Create: `app/test/feature/settings/features/display_settings/theme_settings_page_test.dart`

**Interfaces:**
- Consumes: Task 1 の `themePresetsProvider`(`List<AppTheme>`)、`AppThemeNotifier.setThemeForMode`、`appThemeProvider`(既存、`({AppTheme lightTheme, AppTheme darkTheme})` を返す)、`ThemeColorSet.toColorScheme`は使わず `AppTheme.colorSetFor(Brightness)` でプレビュー用 `ThemeColorSet` を得る。`DesignSystemThemeExtension`(公開コンストラクタ、`colorTheme`/`spacing`/`shape`/`typography`)、`SpacingThemeExtension.standard()`、`ShapeThemeExtension.standard()`、`TypographyThemeExtension.fromColorTheme(ThemeColorSet)`(すべて `design_system_theme_extension.dart` と同ディレクトリの `extensions/`)。`JmaIntensityIcon`(`intensity`, `type: IntensityIconType.small`, `size`)。
- Produces: `ThemeSettingsPage`(引数なし)。`ThemeSettingsRoute`(`/settings/display/theme`)。`ThemeEditorRoute({required String mode})`(`/settings/display/theme/editor/:mode`)— 本タスクでは最小限の実体(Scaffoldのみ)を返し、Task 5 でボディを `ThemeEditorPage` に差し替える。この2ルートは Task 4/5/6 が消費する。

- [ ] **Step 1: 失敗するテストを書く(プリセット選択でnotifierに保存される)**

新規作成 `app/test/feature/settings/features/display_settings/theme_settings_page_test.dart`:

```dart
import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/core/provider/shared_preferences.dart' as app_prefs;
import 'package:eqmonitor/core/theme/model/app_theme.dart';
import 'package:eqmonitor/core/theme/provider/app_theme_notifier.dart';
import 'package:eqmonitor/feature/settings/features/display_settings/ui/theme/theme_settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _TestApp extends StatelessWidget {
  const _TestApp({required this.home});
  final Widget home;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData.light().copyWith(
      extensions: [DesignSystemThemeExtension.light()],
    );
    return MaterialApp(theme: theme, home: home);
  }
}

Future<ProviderContainer> _container() async {
  SharedPreferences.setMockInitialValues({});
  final prefs = await SharedPreferences.getInstance();
  return ProviderContainer(
    overrides: [
      app_prefs.sharedPreferencesProvider.overrideWithValue(
        app_prefs.SharedPreferencesAsync(prefs),
      ),
    ],
  );
}

void main() {
  testWidgets('JMA Standardプリセットをタップするとlightテーマに保存される', (tester) async {
    final container = await _container();
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const _TestApp(home: ThemeSettingsPage()),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text(AppTheme.jmaStandard().name).first);
    await tester.pumpAndSettle();

    final state = container.read(appThemeProvider);
    expect(state.lightTheme.name, AppTheme.jmaStandard().name);
  });

  testWidgets('編集ボタンをタップするとThemeEditorRouteへ遷移する', (tester) async {
    final container = await _container();
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const _TestApp(home: ThemeSettingsPage()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('編集'), findsWidgets);
  });
}
```

- [ ] **Step 2: テストが失敗することを確認する**

Run: `timeout 120 flutter test app/test/feature/settings/features/display_settings/theme_settings_page_test.dart -r expanded`
Expected: FAIL — `Target of URI doesn't exist: '.../ui/theme/theme_settings_page.dart'`

- [ ] **Step 3: ThemeSettingsPage を実装する**

新規作成 `app/lib/feature/settings/features/display_settings/ui/theme/theme_settings_page.dart`:

```dart
import 'package:eqmonitor/core/component/container/bordered_container.dart';
import 'package:eqmonitor/core/component/intenisty/jma_intensity_icon.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/core/designsystem/extensions/shape_theme_extension.dart';
import 'package:eqmonitor/core/designsystem/extensions/spacing_theme_extension.dart';
import 'package:eqmonitor/core/designsystem/extensions/typography_theme_extension.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/theme/model/app_theme.dart';
import 'package:eqmonitor/core/theme/model/theme_color_set.dart';
import 'package:eqmonitor/core/theme/provider/app_theme_notifier.dart';
import 'package:eqmonitor/core/theme/provider/theme_presets_provider.dart';
import 'package:eqmonitor/feature/settings/component/settings_section_header.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ThemeSettingsPage extends StatelessWidget {
  const ThemeSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('テーマ設定')),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SettingsSectionHeader(text: 'ライト用テーマ'),
            _ModeSection(mode: ThemeBrightnessMode.light),
            SettingsSectionHeader(text: 'ダーク用テーマ'),
            _ModeSection(mode: ThemeBrightnessMode.dark),
          ],
        ),
      ),
    );
  }
}

class _ModeSection extends ConsumerWidget {
  const _ModeSection({required this.mode});

  final ThemeBrightnessMode mode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themes = ref.watch(appThemeProvider);
    final currentTheme = switch (mode) {
      ThemeBrightnessMode.light => themes.lightTheme,
      ThemeBrightnessMode.dark => themes.darkTheme,
    };
    final presets = ref.watch(themePresetsProvider);
    final brightness = switch (mode) {
      ThemeBrightnessMode.light => Brightness.light,
      ThemeBrightnessMode.dark => Brightness.dark,
    };

    return BorderedContainer(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(currentTheme.name, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          _ThemePreview(colorSet: currentTheme.colorSetFor(brightness)),
          const SizedBox(height: 8),
          ...presets.map(
            (preset) => RadioListTile<String>.adaptive(
              contentPadding: EdgeInsets.zero,
              title: Text(preset.name),
              value: preset.name,
              // ignore: deprecated_member_use
              groupValue: currentTheme.name,
              onChanged: (_) async => ref
                  .read(appThemeProvider.notifier)
                  .setThemeForMode(mode, preset),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: FilledButton.tonal(
              onPressed: () =>
                  ThemeEditorRoute(mode: mode.name).go(context),
              child: const Text('編集'),
            ),
          ),
        ],
      ),
    );
  }
}

class _ThemePreview extends StatelessWidget {
  const _ThemePreview({required this.colorSet});

  final ThemeColorSet colorSet;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        extensions: [
          DesignSystemThemeExtension(
            colorTheme: colorSet,
            spacing: SpacingThemeExtension.standard(),
            shape: ShapeThemeExtension.standard(),
            typography: TypographyThemeExtension.fromColorTheme(colorSet),
          ),
        ],
      ),
      child: Row(
        children: [
          _Swatch(color: colorSet.primary, label: 'Primary'),
          const SizedBox(width: 8),
          _Swatch(color: colorSet.surface, label: 'Surface'),
          const SizedBox(width: 8),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: JmaIntensity.values
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: JmaIntensityIcon(
                          intensity: e,
                          type: IntensityIconType.small,
                          size: 24,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Swatch extends StatelessWidget {
  const _Swatch({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(
              color: context.designSystem.colorTheme.outline,
            ),
          ),
        ),
        Text(label, style: Theme.of(context).textTheme.labelSmall),
      ],
    );
  }
}
```

(注: `RadioListTile.adaptive` の deprecated 警告は既存コード `display_settings.dart` と同じ抑制コメントを踏襲する。実装時に `IntensityIconType` の実際のenum値名を `app/lib/feature/map/features/icon/data/model/intensity_icon.dart` で確認すること。)

- [ ] **Step 4: router.dart にルートを追加する**

`app/lib/core/router/router.dart` の import 群に以下を追加(63行目 `display_settings.dart` importの直後):

```dart
import 'package:eqmonitor/core/theme/model/app_theme.dart';
import 'package:eqmonitor/feature/settings/features/display_settings/ui/theme/theme_settings_page.dart';
```

`DisplayRoute` の定義(424-430行目)を以下に置き換える:

```dart
@TypedGoRoute<DisplayRoute>(
  path: 'display',
  routes: [
    TypedGoRoute<ThemeSettingsRoute>(
      path: 'theme',
      routes: [TypedGoRoute<ThemeEditorRoute>(path: 'editor/:mode')],
    ),
  ],
)
class DisplayRoute extends GoRouteData with $DisplayRoute {
  const DisplayRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const DisplaySettingsPage();
}

class ThemeSettingsRoute extends GoRouteData with $ThemeSettingsRoute {
  const ThemeSettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ThemeSettingsPage();
}

class ThemeEditorRoute extends GoRouteData with $ThemeEditorRoute {
  const ThemeEditorRoute({required this.mode});

  final String mode;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final brightnessMode = ThemeBrightnessMode.values.firstWhere(
      (e) => e.name == mode,
      orElse: () => ThemeBrightnessMode.light,
    );
    return Scaffold(
      appBar: AppBar(title: Text('テーマ編集 (${brightnessMode.name})')),
      body: const SizedBox.shrink(),
    );
  }
}
```

同様に、既存の `SettingsRoute` の `TypedGoRoute<DisplayRoute>(path: 'display')`(327行目)は上記の `routes:` 付き宣言に置き換わっているため二重定義しないよう確認する。

- [ ] **Step 5: コード生成を実行する**

Run: `cd app && timeout 300 dart run build_runner build --delete-conflicting-outputs --build-filter 'lib/core/router/router.g.dart'`
Expected: `router.g.dart` が更新され `$ThemeSettingsRoute` / `$ThemeEditorRoute` が生成される。`cd -` で戻る。

- [ ] **Step 6: 表示設定ページに「テーマ設定」タイルを追加する**

`app/lib/feature/settings/features/display_settings/ui/display_settings.dart` の import 群に追加:

```dart
import 'package:eqmonitor/core/router/router.dart';
```

`_Body` の `children`(30-35行目)を以下に置き換える:

```dart
          children: [
            const SettingsSectionHeader(text: '配色設定'),
            const _ThemeSelector(),
            ListTile(
              title: const Text('テーマ設定'),
              subtitle: const Text('配色プリセットの選択・カスタム編集・JSON入出力'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => const ThemeSettingsRoute().go(context),
            ),
          ],
```

- [ ] **Step 7: テストがパスすることを確認する**

Run: `timeout 180 flutter test app/test/feature/settings/features/display_settings/theme_settings_page_test.dart -r expanded`
Expected: PASS(2件)

- [ ] **Step 8: 回帰確認**

Run: `timeout 300 flutter test app/test/core/router -r expanded` (router関連の既存テストがあれば)。存在しない場合はスキップして次のコマンドのみ実行:
Run: `timeout 180 flutter test app/test/feature/settings/features/display_settings -r expanded`
Expected: 既存24件の失敗と一致し、新規失敗がないこと。

- [ ] **Step 9: Commit**

```bash
git add app/lib/feature/settings/features/display_settings/ui/theme/theme_settings_page.dart \
        app/lib/feature/settings/features/display_settings/ui/display_settings.dart \
        app/lib/core/router/router.dart \
        app/lib/core/router/router.g.dart \
        app/test/feature/settings/features/display_settings/theme_settings_page_test.dart
git commit -m "$(cat <<'EOF'
feat(theme): ThemeSettingsPageとルーティング、表示設定への導線を追加

プリセット選択・プレビュー表示・編集画面への遷移を提供する
テーマ設定画面を新設し、表示設定ページから到達可能にする。

Claude-Session: https://claude.ai/code/session_01EapeTteTrPUodCTmDiTEWp
EOF
)"
```

### Task 4: JSONインポート/エクスポート ダイアログ

**Files:**
- Create: `app/lib/feature/settings/features/display_settings/ui/theme/theme_json_dialogs.dart`
- Modify: `app/lib/feature/settings/features/display_settings/ui/theme/theme_settings_page.dart`
- Modify: `app/test/feature/settings/features/display_settings/theme_settings_page_test.dart`

**Interfaces:**
- Consumes: `AppThemeNotifier.importFromJson(String)`(`Result<AppTheme, AppThemeImportException>`)、`AppThemeNotifier.exportToJson(AppTheme)`(`String`)、`AppThemeNotifier.setThemeForMode`(Task 1)、`Result`/`Success`/`Failure`(`core/foundation/result.dart`)、`AppTheme.modes`/`AppTheme.supportsMode`。
- Produces: `ThemeImportExportSection`(引数なし `HookConsumerWidget`)。Task 3 の `ThemeSettingsPage` がこのウィジェットを body 末尾に配置する。

- [ ] **Step 1: 失敗するテストを書く(インポート成功・失敗・エクスポート)**

`app/test/feature/settings/features/display_settings/theme_settings_page_test.dart` の `import` 群に追加:

```dart
import 'dart:convert';

import 'package:eqmonitor/core/theme/model/theme_color_set.dart';
import 'package:flutter/services.dart';
```

同ファイルの `main()` 内、既存の2つの `testWidgets` の後に追加:

```dart
  testWidgets('不正なJSONをインポートするとエラーダイアログが表示される', (tester) async {
    final container = await _container();
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const _TestApp(home: ThemeSettingsPage()),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('JSONをインポート'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'not json at all');
    await tester.tap(find.text('インポート'));
    await tester.pumpAndSettle();

    expect(find.text('インポートに失敗しました'), findsOneWidget);
  });

  testWidgets('正常なJSONをインポートして適用するとlightテーマに反映される', (tester) async {
    final container = await _container();
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const _TestApp(home: ThemeSettingsPage()),
      ),
    );
    await tester.pumpAndSettle();

    final imported = AppTheme.eqmonitorDefault().copyWith(
      name: 'インポートテーマ',
      modes: const [ThemeBrightnessMode.light],
      dark: null,
    );
    final json = const JsonEncoder().convert(imported.toJson());

    await tester.tap(find.text('JSONをインポート'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), json);
    await tester.tap(find.text('インポート'));
    await tester.pumpAndSettle();

    expect(find.text('適用'), findsOneWidget);
    await tester.tap(find.text('適用'));
    await tester.pumpAndSettle();

    final state = container.read(appThemeProvider);
    expect(state.lightTheme.name, 'インポートテーマ');
  });

  testWidgets('エクスポートするとクリップボードにJSONがコピーされる', (tester) async {
    final container = await _container();
    addTearDown(container.dispose);

    final copied = <String>[];
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
      SystemChannels.platform,
      (call) async {
        if (call.method == 'Clipboard.setData') {
          final args = call.arguments as Map<dynamic, dynamic>;
          copied.add(args['text'] as String);
        }
        return null;
      },
    );
    addTearDown(
      () => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        null,
      ),
    );

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const _TestApp(home: ThemeSettingsPage()),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('ライトをエクスポート'));
    await tester.pumpAndSettle();

    expect(copied, hasLength(1));
    expect(() => jsonDecode(copied.single), returnsNormally);
  });
```

- [ ] **Step 2: テストが失敗することを確認する**

Run: `timeout 180 flutter test app/test/feature/settings/features/display_settings/theme_settings_page_test.dart -r expanded`
Expected: FAIL — `Bad state: No element` または `finder found 0 widgets`(「JSONをインポート」「ライトをエクスポート」ボタンが未実装のため)

- [ ] **Step 3: ThemeImportExportSection を実装する**

新規作成 `app/lib/feature/settings/features/display_settings/ui/theme/theme_json_dialogs.dart`:

```dart
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/theme/model/app_theme.dart';
import 'package:eqmonitor/core/theme/provider/app_theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ThemeImportExportSection extends HookConsumerWidget {
  const ThemeImportExportSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messenger = ScaffoldMessenger.of(context);
    final themes = ref.watch(appThemeProvider);

    Future<void> exportMode(ThemeBrightnessMode mode) async {
      final theme = switch (mode) {
        ThemeBrightnessMode.light => themes.lightTheme,
        ThemeBrightnessMode.dark => themes.darkTheme,
      };
      final json = ref.read(appThemeProvider.notifier).exportToJson(theme);
      await Clipboard.setData(ClipboardData(text: json));
      messenger.showSnackBar(
        const SnackBar(content: Text('JSONをクリップボードにコピーしました')),
      );
    }

    Future<void> showImportErrorDialog(String message) {
      return showAdaptiveDialog<void>(
        context: context,
        builder: (dialogContext) => AlertDialog.adaptive(
          title: const Text('インポートに失敗しました'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('閉じる'),
            ),
          ],
        ),
      );
    }

    Future<void> showApplyModeDialog(AppTheme theme) async {
      final result = await showAdaptiveDialog<Set<ThemeBrightnessMode>>(
        context: context,
        builder: (dialogContext) => HookBuilder(
          builder: (context) {
            final state = useState<Set<ThemeBrightnessMode>>({
              ...theme.modes,
            });
            return AlertDialog.adaptive(
              title: const Text('適用先を選択'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: ThemeBrightnessMode.values
                    .where(theme.supportsMode)
                    .map(
                      (mode) => CheckboxListTile.adaptive(
                        value: state.value.contains(mode),
                        title: Text(mode.name),
                        onChanged: (checked) {
                          final next = {...state.value};
                          if (checked ?? false) {
                            next.add(mode);
                          } else {
                            next.remove(mode);
                          }
                          state.value = next;
                        },
                      ),
                    )
                    .toList(),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  child: const Text('キャンセル'),
                ),
                FilledButton(
                  onPressed: () =>
                      Navigator.of(dialogContext).pop(state.value),
                  child: const Text('適用'),
                ),
              ],
            );
          },
        ),
      );
      if (result == null || result.isEmpty) {
        return;
      }
      for (final mode in result) {
        await ref
            .read(appThemeProvider.notifier)
            .setThemeForMode(mode, theme);
      }
      messenger.showSnackBar(const SnackBar(content: Text('テーマを適用しました')));
    }

    Future<void> showImportDialog() async {
      final controller = TextEditingController();
      final text = await showAdaptiveDialog<String>(
        context: context,
        builder: (dialogContext) => AlertDialog.adaptive(
          title: const Text('JSONをインポート'),
          content: TextField(
            controller: controller,
            maxLines: 8,
            decoration: const InputDecoration(hintText: 'テーマJSONを貼り付け'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('キャンセル'),
            ),
            FilledButton(
              onPressed: () =>
                  Navigator.of(dialogContext).pop(controller.text),
              child: const Text('インポート'),
            ),
          ],
        ),
      );
      if (text == null || text.isEmpty) {
        return;
      }
      final result = ref.read(appThemeProvider.notifier).importFromJson(text);
      switch (result) {
        case Success<AppTheme, AppThemeImportException>():
          await showApplyModeDialog(result.value);
        case Failure<AppTheme, AppThemeImportException>():
          await showImportErrorDialog(result.exception.message);
      }
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          FilledButton.tonal(
            onPressed: () => exportMode(ThemeBrightnessMode.light),
            child: const Text('ライトをエクスポート'),
          ),
          FilledButton.tonal(
            onPressed: () => exportMode(ThemeBrightnessMode.dark),
            child: const Text('ダークをエクスポート'),
          ),
          FilledButton.tonal(
            onPressed: showImportDialog,
            child: const Text('JSONをインポート'),
          ),
        ],
      ),
    );
  }
}
```

- [ ] **Step 4: ThemeSettingsPage の body に組み込む**

`theme_settings_page.dart` の import 群に追加:

```dart
import 'package:eqmonitor/feature/settings/features/display_settings/ui/theme/theme_json_dialogs.dart';
```

`ThemeSettingsPage.build` の `Column.children` を以下に変更:

```dart
          children: [
            SettingsSectionHeader(text: 'ライト用テーマ'),
            _ModeSection(mode: ThemeBrightnessMode.light),
            SettingsSectionHeader(text: 'ダーク用テーマ'),
            _ModeSection(mode: ThemeBrightnessMode.dark),
            SettingsSectionHeader(text: 'JSON入出力'),
            ThemeImportExportSection(),
          ],
```

(`Column` の `children` は既に `const` 修飾のため `const` を外す必要がある。`body:` の `SingleChildScrollView(child: Column(...))` から `const` を除去すること。)

- [ ] **Step 5: テストがパスすることを確認する**

Run: `timeout 180 flutter test app/test/feature/settings/features/display_settings/theme_settings_page_test.dart -r expanded`
Expected: PASS(5件)

- [ ] **Step 6: Commit**

```bash
git add app/lib/feature/settings/features/display_settings/ui/theme/theme_json_dialogs.dart \
        app/lib/feature/settings/features/display_settings/ui/theme/theme_settings_page.dart \
        app/test/feature/settings/features/display_settings/theme_settings_page_test.dart
git commit -m "$(cat <<'EOF'
feat(theme): テーマJSONのインポート/エクスポートダイアログを追加

クリップボード経由でテーマJSONを入出力できるようにし、
インポート失敗時はエラーダイアログ、成功時は適用先モード選択
ダイアログを表示する。

Claude-Session: https://claude.ai/code/session_01EapeTteTrPUodCTmDiTEWp
EOF
)"
```

### Task 5: ThemeEditorController + ThemeEditorPage(フラットトークンセクション)

**Files:**
- Create: `app/lib/feature/settings/features/display_settings/data/notifier/theme_editor_controller.dart`
- Create: `app/lib/feature/settings/features/display_settings/ui/theme/theme_editor_page.dart`
- Modify: `app/lib/core/router/router.dart`
- Create: `app/test/feature/settings/features/display_settings/theme_editor_page_test.dart`

**Interfaces:**
- Consumes: Task 2 の `themeColorFieldDefs`(`ThemeColorFieldDef` の `label`/`category`/`getter`/`setter`)、`ThemeColorFieldCategory` enum、Task 1 の `AppThemeNotifier.setThemeForMode`、`appThemeProvider`、`AppTheme`/`ThemeColorSet`/`ThemeBrightnessMode`。
- Produces: `themeEditorControllerProvider(ThemeBrightnessMode mode)`(family、`ThemeColorSet` を返す riverpod generator 生成 provider)、`ThemeEditorController.updateField(ThemeColorFieldDef def, Color color)`(Task 6 も同じ `updateIntensityEntry` を追加してこのクラスを拡張する)。`ThemeEditorPage({required ThemeBrightnessMode mode})` — Task 3 の router 内 `ThemeEditorRoute.build` が呼び出す。

- [ ] **Step 1: 失敗するテストを書く(ThemeEditorController がカスタムテーマとして保存する)**

新規作成 `app/test/feature/settings/features/display_settings/theme_editor_page_test.dart`:

```dart
import 'package:eqmonitor/core/provider/shared_preferences.dart' as app_prefs;
import 'package:eqmonitor/core/theme/model/app_theme.dart';
import 'package:eqmonitor/core/theme/provider/app_theme_notifier.dart';
import 'package:eqmonitor/feature/settings/features/display_settings/data/notifier/theme_editor_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<ProviderContainer> _container() async {
  SharedPreferences.setMockInitialValues({});
  final prefs = await SharedPreferences.getInstance();
  return ProviderContainer(
    overrides: [
      app_prefs.sharedPreferencesProvider.overrideWithValue(
        app_prefs.SharedPreferencesAsync(prefs),
      ),
    ],
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('updateField は現在の色を反映しカスタムテーマとして保存する', () async {
    final container = await _container();
    addTearDown(container.dispose);

    const probe = Color(0xFF112233);
    await container
        .read(
          themeEditorControllerProvider(ThemeBrightnessMode.light).notifier,
        )
        .updateField(
          themeColorFieldDefFor('Primary'),
          probe,
        );

    final colorSet = container.read(
      themeEditorControllerProvider(ThemeBrightnessMode.light),
    );
    expect(colorSet.primary, probe);

    final themes = container.read(appThemeProvider);
    expect(themes.lightTheme.name, 'カスタム');
    expect(themes.lightTheme.light!.primary, probe);
  });
}
```

(注: `themeColorFieldDefFor` はテスト補助のためだけの関数ではなく、Task 2 で定義した `themeColorFieldDefs.firstWhere((e) => e.label == 'Primary')` をテスト内で直接呼び出す形に置き換えること。上記コードの `themeColorFieldDefFor('Primary')` は擬似コードであり、実装時は次のように書き換える: `themeColorFieldDefs.firstWhere((e) => e.label == 'Primary')`。このとき `import 'package:eqmonitor/core/theme/model/theme_color_field_def.dart';` を追加する。)

- [ ] **Step 2: テストが失敗することを確認する**

Run: `timeout 120 flutter test app/test/feature/settings/features/display_settings/theme_editor_page_test.dart -r expanded`
Expected: FAIL — `Target of URI doesn't exist: '.../theme_editor_controller.dart'`

- [ ] **Step 3: ThemeEditorController を実装する**

新規作成 `app/lib/feature/settings/features/display_settings/data/notifier/theme_editor_controller.dart`:

```dart
import 'package:eqmonitor/core/theme/model/app_theme.dart';
import 'package:eqmonitor/core/theme/model/intensity_color_entry.dart';
import 'package:eqmonitor/core/theme/model/intensity_field_def.dart';
import 'package:eqmonitor/core/theme/model/theme_color_field_def.dart';
import 'package:eqmonitor/core/theme/model/theme_color_set.dart';
import 'package:eqmonitor/core/theme/provider/app_theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_editor_controller.g.dart';

@riverpod
class ThemeEditorController extends _$ThemeEditorController {
  @override
  ThemeColorSet build(ThemeBrightnessMode mode) {
    final themes = ref.watch(appThemeProvider);
    final theme = switch (mode) {
      ThemeBrightnessMode.light => themes.lightTheme,
      ThemeBrightnessMode.dark => themes.darkTheme,
    };
    return theme.colorSetFor(_brightnessFor(mode));
  }

  Future<void> updateField(ThemeColorFieldDef def, Color color) async {
    final updated = def.setter(state, color);
    state = updated;
    await _save(updated);
  }

  Future<void> updateIntensityEntry(
    IntensityFieldDef def,
    IntensityColorEntry entry,
  ) async {
    final updated = def.entrySetter(state, entry);
    state = updated;
    await _save(updated);
  }

  Future<void> _save(ThemeColorSet colorSet) async {
    final theme = AppTheme(
      name: 'カスタム',
      version: 1,
      author: 'EQMonitor',
      modes: [mode],
      light: mode == ThemeBrightnessMode.light ? colorSet : null,
      dark: mode == ThemeBrightnessMode.dark ? colorSet : null,
    );
    await ref.read(appThemeProvider.notifier).setThemeForMode(mode, theme);
  }

  Brightness _brightnessFor(ThemeBrightnessMode mode) => switch (mode) {
    ThemeBrightnessMode.light => Brightness.light,
    ThemeBrightnessMode.dark => Brightness.dark,
  };
}
```

(`updateIntensityEntry` は本タスクではまだ呼び出し元がないが、型は `IntensityColorEntry` で確定させておき、Task 6 の `ThemeEditorPage` 震度セクションから呼び出す。)

- [ ] **Step 4: コード生成を実行する**

Run: `cd app && timeout 300 dart run build_runner build --delete-conflicting-outputs --build-filter 'lib/feature/settings/features/display_settings/data/notifier/theme_editor_controller.g.dart'`
Expected: `theme_editor_controller.g.dart` が生成され `themeEditorControllerProvider` が使えるようになる。`cd -` で戻る。

- [ ] **Step 5: テストがパスすることを確認する**

Run: `timeout 120 flutter test app/test/feature/settings/features/display_settings/theme_editor_page_test.dart -r expanded`
Expected: PASS

- [ ] **Step 6: ThemeEditorPage(フラットセクション)を実装する**

新規作成 `app/lib/feature/settings/features/display_settings/ui/theme/theme_editor_page.dart`:

```dart
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/theme/model/app_theme.dart';
import 'package:eqmonitor/core/theme/model/theme_color_field_def.dart';
import 'package:eqmonitor/feature/settings/features/display_settings/data/notifier/theme_editor_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ThemeEditorPage extends ConsumerWidget {
  const ThemeEditorPage({required this.mode, super.key});

  final ThemeBrightnessMode mode;

  static const _flatCategories = [
    ThemeColorFieldCategory.primary,
    ThemeColorFieldCategory.secondary,
    ThemeColorFieldCategory.tertiary,
    ThemeColorFieldCategory.error,
    ThemeColorFieldCategory.surface,
    ThemeColorFieldCategory.status,
  ];

  static String _categoryLabel(ThemeColorFieldCategory category) =>
      switch (category) {
        ThemeColorFieldCategory.primary => 'Primary',
        ThemeColorFieldCategory.secondary => 'Secondary',
        ThemeColorFieldCategory.tertiary => 'Tertiary',
        ThemeColorFieldCategory.error => 'Error',
        ThemeColorFieldCategory.surface => 'Surface',
        ThemeColorFieldCategory.status => 'Status',
        ThemeColorFieldCategory.map => 'Map',
      };

  static Future<Color?> _pickColor(BuildContext context, Color initial) {
    return showAdaptiveDialog<Color>(
      context: context,
      builder: (dialogContext) => _ColorPickerDialog(initial: initial),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorSet = ref.watch(themeEditorControllerProvider(mode));
    final controller = ref.read(themeEditorControllerProvider(mode).notifier);

    return Scaffold(
      appBar: AppBar(title: Text('テーマ編集 (${mode.name})')),
      body: ListView(
        children: _flatCategories.map((category) {
          final defs = themeColorFieldDefs
              .where((def) => def.category == category)
              .toList();
          return ExpansionTile(
            title: Text(_categoryLabel(category)),
            children: defs
                .map(
                  (def) => ListTile(
                    title: Text(def.label),
                    trailing: GestureDetector(
                      onTap: () async {
                        final picked = await _pickColor(
                          context,
                          def.getter(colorSet),
                        );
                        if (picked == null) {
                          return;
                        }
                        await controller.updateField(def, picked);
                      },
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: def.getter(colorSet),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: context.designSystem.colorTheme.outline,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          );
        }).toList(),
      ),
    );
  }
}

class _ColorPickerDialog extends StatefulWidget {
  const _ColorPickerDialog({required this.initial});

  final Color initial;

  @override
  State<_ColorPickerDialog> createState() => _ColorPickerDialogState();
}

class _ColorPickerDialogState extends State<_ColorPickerDialog> {
  late Color _current = widget.initial;

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: const Text('色を選択'),
      content: SingleChildScrollView(
        child: ColorPicker(
          pickerColor: _current,
          onColorChanged: (color) => setState(() => _current = color),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('キャンセル'),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(_current),
          child: const Text('適用'),
        ),
      ],
    );
  }
}
```

- [ ] **Step 7: router.dart の ThemeEditorRoute.build を差し替える**

`app/lib/core/router/router.dart` の import 群に追加:

```dart
import 'package:eqmonitor/feature/settings/features/display_settings/ui/theme/theme_editor_page.dart';
```

Task 3 で追加した `ThemeEditorRoute` の `build` メソッドを以下に置き換える:

```dart
  @override
  Widget build(BuildContext context, GoRouterState state) {
    final brightnessMode = ThemeBrightnessMode.values.firstWhere(
      (e) => e.name == mode,
      orElse: () => ThemeBrightnessMode.light,
    );
    return ThemeEditorPage(mode: brightnessMode);
  }
```

- [ ] **Step 8: 失敗するテストを書く(色編集でカスタム化される・widget経由)**

`app/test/feature/settings/features/display_settings/theme_editor_page_test.dart` に以下を追記(import に `package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart` と `package:eqmonitor/feature/settings/features/display_settings/ui/theme/theme_editor_page.dart` と `package:flutter_colorpicker/flutter_colorpicker.dart` を追加):

```dart
class _TestApp extends StatelessWidget {
  const _TestApp({required this.home});
  final Widget home;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData.light().copyWith(
      extensions: [DesignSystemThemeExtension.light()],
    );
    return MaterialApp(theme: theme, home: home);
  }
}

void main() {
  // ...(既存のtestに続けて追加)

  testWidgets('Primaryスウォッチをタップして色を変更するとカスタム化される', (tester) async {
    final container = await _container();
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: _TestApp(
          home: const ThemeEditorPage(mode: ThemeBrightnessMode.light),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Primary'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Primary').first);
    await tester.pumpAndSettle();

    final picker = tester.widget<ColorPicker>(find.byType(ColorPicker));
    picker.onColorChanged(const Color(0xFF445566));
    await tester.pumpAndSettle();
    await tester.tap(find.text('適用'));
    await tester.pumpAndSettle();

    final themes = container.read(appThemeProvider);
    expect(themes.lightTheme.name, 'カスタム');
    expect(themes.lightTheme.light!.primary, const Color(0xFF445566));
  });
}
```

(注: `ExpansionTile` を開くため最初の `find.text('Primary')` タップはカテゴリタイトル("Primary" カテゴリ見出し)を開く操作、2回目はフィールド行の "Primary" ラベルをタップしてスウォッチの `GestureDetector` を経由する想定。実際のウィジェットツリーで `GestureDetector` をタップする必要がある場合は `find.byType(GestureDetector).first` に置き換えること。)

- [ ] **Step 9: コード生成 + テスト実行**

Run: `cd app && timeout 300 dart run build_runner build --delete-conflicting-outputs --build-filter 'lib/core/router/router.g.dart'` (router再生成、`cd -` で戻る)
Run: `timeout 180 flutter test app/test/feature/settings/features/display_settings/theme_editor_page_test.dart -r expanded`
Expected: PASS(2件)

- [ ] **Step 10: Commit**

```bash
git add app/lib/feature/settings/features/display_settings/data/notifier/theme_editor_controller.dart \
        app/lib/feature/settings/features/display_settings/data/notifier/theme_editor_controller.g.dart \
        app/lib/feature/settings/features/display_settings/ui/theme/theme_editor_page.dart \
        app/lib/core/router/router.dart \
        app/lib/core/router/router.g.dart \
        app/test/feature/settings/features/display_settings/theme_editor_page_test.dart
git commit -m "$(cat <<'EOF'
feat(theme): ThemeEditorControllerとThemeEditorPageのフラット
トークンセクションを追加

Primary/Secondary/Tertiary/Error/Surface/Statusの各カラーを
flutter_colorpickerで編集し、変更のたび即時にカスタムテーマとして
保存する。

Claude-Session: https://claude.ai/code/session_01EapeTteTrPUodCTmDiTEWp
EOF
)"
```

### Task 6: ThemeEditorPage の震度/推計震度/マップ セクション

**Files:**
- Modify: `app/lib/feature/settings/features/display_settings/ui/theme/theme_editor_page.dart`
- Modify: `app/test/feature/settings/features/display_settings/theme_editor_page_test.dart`

**Interfaces:**
- Consumes: Task 2 の `intensityFieldDefs`(`IntensityFieldDef`、`entryGetter`/`entrySetter`)、`IntensityFieldGroup` enum、`IntensityColorEntry`(`background`/`foreground`)、`IntensityTextColor`(sealed、`IntensityTextColorAuto()` / `IntensityTextColorManual(color: Color)`、`intensity_text_color.dart`)、Task 5 の `ThemeEditorController.updateIntensityEntry(IntensityFieldDef, IntensityColorEntry)`、`themeColorFieldDefs` の `ThemeColorFieldCategory.map` エントリ(Task 2)。
- Produces: `ThemeEditorPage` に Map / 震度配色 / 推計震度配色セクションが追加された完全版。以降のタスクはこれを消費しない(最終UIタスク)。

- [ ] **Step 1: 失敗するテストを書く(震度配色の背景色編集・自動/手動切替)**

`app/test/feature/settings/features/display_settings/theme_editor_page_test.dart` の `main()` 内、既存の `testWidgets` の後に追加(import に `package:eqmonitor/core/theme/model/intensity_text_color.dart` を追加):

```dart
  testWidgets('震度7の背景色を変更するとカスタム化される', (tester) async {
    final container = await _container();
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: _TestApp(
          home: const ThemeEditorPage(mode: ThemeBrightnessMode.light),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('震度配色'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('intensity-bg-seven')));
    await tester.pumpAndSettle();

    final picker = tester.widget<ColorPicker>(find.byType(ColorPicker));
    picker.onColorChanged(const Color(0xFF998877));
    await tester.pumpAndSettle();
    await tester.tap(find.text('適用'));
    await tester.pumpAndSettle();

    final themes = container.read(appThemeProvider);
    expect(
      themes.lightTheme.light!.intensity.seven.background,
      const Color(0xFF998877),
    );
  });

  testWidgets('震度7の文字色を手動に切り替えて色を選ぶとmanualになる', (tester) async {
    final container = await _container();
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: _TestApp(
          home: const ThemeEditorPage(mode: ThemeBrightnessMode.light),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('震度配色'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('intensity-fg-mode-seven')));
    await tester.pumpAndSettle();
    // ToggleButtons/SegmentedButton等で「手動」を選択
    await tester.tap(find.text('手動').last);
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('intensity-fg-manual-seven')));
    await tester.pumpAndSettle();

    final picker = tester.widget<ColorPicker>(find.byType(ColorPicker));
    picker.onColorChanged(const Color(0xFF001122));
    await tester.pumpAndSettle();
    await tester.tap(find.text('適用'));
    await tester.pumpAndSettle();

    final themes = container.read(appThemeProvider);
    final foreground = themes.lightTheme.light!.intensity.seven.foreground;
    expect(foreground, isA<IntensityTextColorManual>());
    expect(
      (foreground as IntensityTextColorManual).color,
      const Color(0xFF001122),
    );
  });
```

- [ ] **Step 2: テストが失敗することを確認する**

Run: `timeout 180 flutter test app/test/feature/settings/features/display_settings/theme_editor_page_test.dart -r expanded`
Expected: FAIL — `震度配色` のテキスト/`intensity-bg-seven` キーが見つからない

- [ ] **Step 3: ThemeEditorPage に Map / 震度 / 推計震度 セクションを追加する**

`theme_editor_page.dart` の import 群に追加:

```dart
import 'package:eqmonitor/core/theme/model/intensity_color_entry.dart';
import 'package:eqmonitor/core/theme/model/intensity_field_def.dart';
import 'package:eqmonitor/core/theme/model/intensity_text_color.dart';
```

`_flatCategories` の直後に定数を追加:

```dart
  static const _mapCategory = ThemeColorFieldCategory.map;
```

`build` メソッドの `ListView` の `children:` を以下に置き換える(既存の `_flatCategories.map(...)` に加えて Map/震度/推計震度セクションを連結する):

```dart
      body: ListView(
        children: [
          ..._flatCategories.map(
            (category) => ExpansionTile(
              title: Text(_categoryLabel(category)),
              children: themeColorFieldDefs
                  .where((def) => def.category == category)
                  .map(
                    (def) => _ColorFieldTile(
                      def: def,
                      colorSet: colorSet,
                      onChanged: (color) => controller.updateField(def, color),
                    ),
                  )
                  .toList(),
            ),
          ),
          ExpansionTile(
            title: Text(_categoryLabel(_mapCategory)),
            children: themeColorFieldDefs
                .where((def) => def.category == _mapCategory)
                .map(
                  (def) => _ColorFieldTile(
                    def: def,
                    colorSet: colorSet,
                    onChanged: (color) => controller.updateField(def, color),
                  ),
                )
                .toList(),
          ),
          ExpansionTile(
            title: const Text('震度配色'),
            children: intensityFieldDefs
                .where((def) => def.group == IntensityFieldGroup.intensity)
                .map(
                  (def) => _IntensityFieldTile(
                    def: def,
                    colorSet: colorSet,
                    onChanged: (entry) =>
                        controller.updateIntensityEntry(def, entry),
                  ),
                )
                .toList(),
          ),
          ExpansionTile(
            title: const Text('推計震度配色'),
            children: intensityFieldDefs
                .where(
                  (def) =>
                      def.group == IntensityFieldGroup.estimatedIntensity,
                )
                .map(
                  (def) => _IntensityFieldTile(
                    def: def,
                    colorSet: colorSet,
                    onChanged: (entry) =>
                        controller.updateIntensityEntry(def, entry),
                  ),
                )
                .toList(),
          ),
        ],
      ),
```

`ThemeEditorPage` の `build` メソッド末尾(既存の `ExpansionTile` を作っていた `_flatCategories.map((category) { ... })` の実装)は上記の書き換えにより不要になるため削除する。同ファイル内の元の `ListTile` インライン実装を切り出し、クラス外(ファイル下部)に以下の2つの新規ウィジェットを追加する:

```dart
class _ColorFieldTile extends StatelessWidget {
  const _ColorFieldTile({
    required this.def,
    required this.colorSet,
    required this.onChanged,
  });

  final ThemeColorFieldDef def;
  final ThemeColorSet colorSet;
  final void Function(Color color) onChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(def.label),
      trailing: GestureDetector(
        onTap: () async {
          final picked = await ThemeEditorPage._pickColor(
            context,
            def.getter(colorSet),
          );
          if (picked == null) {
            return;
          }
          onChanged(picked);
        },
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: def.getter(colorSet),
            shape: BoxShape.circle,
            border: Border.all(
              color: context.designSystem.colorTheme.outline,
            ),
          ),
        ),
      ),
    );
  }
}

class _IntensityFieldTile extends StatelessWidget {
  const _IntensityFieldTile({
    required this.def,
    required this.colorSet,
    required this.onChanged,
  });

  final IntensityFieldDef def;
  final ThemeColorSet colorSet;
  final void Function(IntensityColorEntry entry) onChanged;

  @override
  Widget build(BuildContext context) {
    final entry = def.entryGetter(colorSet);
    final keySuffix = def.label;

    return ListTile(
      title: Text(def.label),
      subtitle: Row(
        children: [
          const Text('文字色: '),
          SegmentedButton<bool>(
            key: ValueKey('intensity-fg-mode-$keySuffix'),
            segments: const [
              ButtonSegment(value: true, label: Text('自動')),
              ButtonSegment(value: false, label: Text('手動')),
            ],
            selected: {entry.foreground is IntensityTextColorAuto},
            onSelectionChanged: (selection) {
              final isAuto = selection.first;
              onChanged(
                entry.copyWith(
                  foreground: isAuto
                      ? const IntensityTextColor.auto()
                      : IntensityTextColor.manual(
                          color: entry.resolvedForeground,
                        ),
                ),
              );
            },
          ),
          if (entry.foreground is IntensityTextColorManual)
            GestureDetector(
              key: ValueKey('intensity-fg-manual-$keySuffix'),
              onTap: () async {
                final current = entry.foreground as IntensityTextColorManual;
                final picked = await ThemeEditorPage._pickColor(
                  context,
                  current.color,
                );
                if (picked == null) {
                  return;
                }
                onChanged(
                  entry.copyWith(
                    foreground: IntensityTextColor.manual(color: picked),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.only(left: 8),
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: current.color,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: context.designSystem.colorTheme.outline,
                  ),
                ),
              ),
            ),
        ],
      ),
      trailing: GestureDetector(
        key: ValueKey('intensity-bg-$keySuffix'),
        onTap: () async {
          final picked = await ThemeEditorPage._pickColor(
            context,
            entry.background,
          );
          if (picked == null) {
            return;
          }
          onChanged(entry.copyWith(background: picked));
        },
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: entry.background,
            shape: BoxShape.circle,
            border: Border.all(
              color: context.designSystem.colorTheme.outline,
            ),
          ),
        ),
      ),
    );
  }
}
```

`ThemeEditorPage._pickColor` は Task 5 で `static` 定義済みのため `private` メンバーへの外部クラスからのアクセスは同一ライブラリ(同ファイル)内であれば可能。`_ColorFieldTile`/`_IntensityFieldTile` は同ファイル内に定義するためアクセス可能である。

(注: 上記テストの `find.byKey(ValueKey('intensity-bg-seven'))` はテスト側キー文字列と `def.label`(震度7)の日本語ラベルの一致を前提にしている。実装時に `intensityFieldDefs` の `label` 値(`震度7` 等)とテストの `ValueKey` 文字列を突き合わせ、キーは `'intensity-bg-${def.label}'` のように **ラベルそのもの**を用いるため、テストコードの `ValueKey('intensity-bg-seven')` は `ValueKey('intensity-bg-震度7')` に、`ValueKey('intensity-fg-mode-seven')` は `ValueKey('intensity-fg-mode-震度7')` に、`ValueKey('intensity-fg-manual-seven')` は `ValueKey('intensity-fg-manual-震度7')` に読み替えて実装・テスト双方を修正すること。)

- [ ] **Step 4: テストがパスすることを確認する**

Run: `timeout 180 flutter test app/test/feature/settings/features/display_settings/theme_editor_page_test.dart -r expanded`
Expected: PASS(4件)

- [ ] **Step 5: 回帰確認**

Run: `timeout 300 flutter test app/test/feature/settings/features/display_settings -r expanded`
Run: `timeout 300 flutter test app/test/core/theme -r expanded`
Expected: 新規失敗ゼロ(develop既存の24件と一致)。

- [ ] **Step 6: Commit**

```bash
git add app/lib/feature/settings/features/display_settings/ui/theme/theme_editor_page.dart \
        app/test/feature/settings/features/display_settings/theme_editor_page_test.dart
git commit -m "$(cat <<'EOF'
feat(theme): ThemeEditorPageに震度/推計震度/マップ配色セクションを追加

震度・推計震度エントリごとに背景色と文字色(自動/手動)を編集できる
ようにし、テーマ編集UIを全カラートークンについて完成させる。

Claude-Session: https://claude.ai/code/session_01EapeTteTrPUodCTmDiTEWp
EOF
)"
```

### Task 7: eqmonitor_custom_lints パッケージ + avoid_direct_color_scheme ルール

**Files:**
- Create: `packages/eqmonitor_custom_lints/pubspec.yaml`
- Create: `packages/eqmonitor_custom_lints/analysis_options.yaml`
- Create: `packages/eqmonitor_custom_lints/lib/eqmonitor_custom_lints.dart`
- Create: `packages/eqmonitor_custom_lints/lib/rules/avoid_direct_color_scheme.dart`
- Create: `packages/eqmonitor_custom_lints/test/fixtures/avoid_direct_color_scheme/violation.dart`
- Create: `packages/eqmonitor_custom_lints/test/fixtures/avoid_direct_color_scheme/ok.dart`
- Create: `packages/eqmonitor_custom_lints/test/rules/avoid_direct_color_scheme_test.dart`

**バージョン選定(pub.dev を WebFetch で確認、2026-07-04時点):** `custom_lint_builder: ^0.8.1`(`analyzer: ^8.0.0` を要求)、`custom_lint: ^0.8.1`(実行ランナー、dev_dependency)。この analyzer 制約は `app/pubspec.yaml` の `dependency_overrides.analyzer: ^12.0.0` と両立しない。したがって本パッケージは **ルート `pubspec.yaml` のワークスペース共有解決に参加させない**(`packages/eqmonitor_lints` や `packages/extensions` と異なり `resolution: workspace` フィールドを持たせない)。これは `tools/eqmonitor_lints_plugin`(analyzer 13 系、独立 pub 解決)と同じ理由による分離であり、Step 2 で `dart pub get` が単独resolutionで成功することを検証する。

**Interfaces:**
- Consumes: なし(既存コードに依存しない新規独立パッケージ)。
- Produces: `packages/eqmonitor_custom_lints` パッケージ、その `createPlugin()` エントリポイント、`avoid_direct_color_scheme` という名前の `LintCode`。Task 8 が `app/pubspec.yaml` の `dev_dependencies` に `path: ../packages/eqmonitor_custom_lints` として追加し、`analysis_options.yaml` の `analyzer.plugins` に `custom_lint` を追加して結線する。

- [ ] **Step 1: パッケージ雛形とフィクスチャを作成する**

新規作成 `packages/eqmonitor_custom_lints/pubspec.yaml`:

```yaml
name: eqmonitor_custom_lints
description: Custom lint rules for EQMonitor (custom_lint plugin package).
publish_to: none
version: 0.1.0

environment:
  sdk: ^3.0.0

dependencies:
  analyzer: ^8.0.0
  custom_lint_builder: ^0.8.1

dev_dependencies:
  custom_lint: ^0.8.1
  test: ^1.29.0
```

新規作成 `packages/eqmonitor_custom_lints/analysis_options.yaml`(このパッケージ自身の fixture を自己ホスト的に解析させ、フィクスチャテストで使う):

```yaml
analyzer:
  plugins:
    - custom_lint
  exclude:
    - "test/fixtures/**"
```

新規作成 `packages/eqmonitor_custom_lints/lib/eqmonitor_custom_lints.dart`:

```dart
import 'package:custom_lint_builder/custom_lint_builder.dart';

PluginBase createPlugin() => _EqmonitorCustomLintsPlugin();

class _EqmonitorCustomLintsPlugin extends PluginBase {
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) => const [];
}
```

(この時点では `getLintRules` は空リストを返す最小実装。ルールは Step 5 で追加する。)

新規作成 `packages/eqmonitor_custom_lints/test/fixtures/avoid_direct_color_scheme/violation.dart`(意図的にルール違反を含む):

```dart
import 'package:flutter/material.dart';

class ViolationWidget extends StatelessWidget {
  const ViolationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return ColoredBox(color: color, child: const SizedBox());
  }
}
```

新規作成 `packages/eqmonitor_custom_lints/test/fixtures/avoid_direct_color_scheme/ok.dart`(ルールに違反しない):

```dart
class FakeDesignSystem {
  const FakeDesignSystem();
  Object get colorTheme => const Object();
}

class OkWidget {
  const OkWidget(this.designSystem);

  final FakeDesignSystem designSystem;

  Object get resolvedColor => designSystem.colorTheme;
}
```

- [ ] **Step 2: 依存解決が単独で成功することを確認する**

Run: `cd packages/eqmonitor_custom_lints && timeout 120 dart pub get`
Expected: `Got dependencies!`(このディレクトリ単独で `analyzer ^8.0.0` / `custom_lint_builder ^0.8.1` / `custom_lint ^0.8.1` が解決される。もしワークスペース側の解決に巻き込まれてエラーになる場合は、`packages/eqmonitor_lints/pubspec.yaml` 等が持つ `resolution: workspace` フィールドを本パッケージには**追加しない**という前提を再確認し、ルート `pubspec.yaml` の `workspace:` リストが `packages/*` glob で本ディレクトリを暗黙に含めてしまっていないか `dart pub get`(ワークスペースルートで実行)のエラーメッセージで確認する。含まれてしまう場合は本ディレクトリを `tools/eqmonitor_custom_lints` に変更し、`packages/eqmonitor_custom_lints` へのパスは全て `tools/eqmonitor_custom_lints` に読み替える。)
`cd -` で戻る。

- [ ] **Step 3: 失敗するルールテストを書く**

新規作成 `packages/eqmonitor_custom_lints/test/rules/avoid_direct_color_scheme_test.dart`:

```dart
import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';

void main() {
  test('violation.dart は avoid_direct_color_scheme を検出する', () async {
    final result = await Process.run('dart', [
      'run',
      'custom_lint',
      '--format=json',
    ], workingDirectory: Directory.current.path);

    final lines = const LineSplitter().convert(result.stdout as String);
    final jsonLine = lines.firstWhere(
      (line) => line.trim().startsWith('{'),
      orElse: () => '{}',
    );
    final decoded = jsonDecode(jsonLine) as Map<String, dynamic>;
    final diagnostics = (decoded['diagnostics'] as List<dynamic>? ?? [])
        .cast<Map<String, dynamic>>();

    final violationDiagnostics = diagnostics.where(
      (d) =>
          (d['location']?['file'] as String? ?? '').contains(
            'violation.dart',
          ) &&
          (d['code'] as String? ?? '') == 'avoid_direct_color_scheme',
    );
    final okDiagnostics = diagnostics.where(
      (d) =>
          (d['location']?['file'] as String? ?? '').contains('ok.dart') &&
          (d['code'] as String? ?? '') == 'avoid_direct_color_scheme',
    );

    expect(
      violationDiagnostics,
      isNotEmpty,
      reason: 'violation.dart で avoid_direct_color_scheme が検出されていません',
    );
    expect(
      okDiagnostics,
      isEmpty,
      reason: 'ok.dart で誤検出が発生しています',
    );
  }, timeout: const Timeout(Duration(minutes: 2)));
}
```

- [ ] **Step 4: テストが失敗することを確認する**

Run: `cd packages/eqmonitor_custom_lints && timeout 150 dart test test/rules/avoid_direct_color_scheme_test.dart`
Expected: FAIL — `violationDiagnostics` が空(ルール未実装のため)。`cd -` で戻る。

- [ ] **Step 5: avoid_direct_color_scheme ルールを実装する**

新規作成 `packages/eqmonitor_custom_lints/lib/rules/avoid_direct_color_scheme.dart`:

```dart
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AvoidDirectColorScheme extends DartLintRule {
  const AvoidDirectColorScheme() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_direct_color_scheme',
    problemMessage:
        'Theme.of(context).colorScheme を直接参照せず、'
        'designSystem.colorTheme を使用してください。',
    errorSeverity: ErrorSeverity.WARNING,
  );

  static const _allowedPathSegments = [
    '/core/theme/build_theme.dart',
    '.g.dart',
    '.freezed.dart',
  ];

  bool _isAllowed(String path) {
    final normalized = path.replaceAll(r'\', '/');
    return _allowedPathSegments.any(normalized.endsWith) ||
        normalized.contains('/test/fixtures/');
  }

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    if (_isAllowed(resolver.path)) {
      return;
    }

    context.registry.addPropertyAccess((node) {
      _reportIfColorSchemeOnThemeData(node.propertyName, node.target, reporter);
    });
    context.registry.addPrefixedIdentifier((node) {
      _reportIfColorSchemeOnThemeData(node.identifier, node.prefix, reporter);
    });
  }

  void _reportIfColorSchemeOnThemeData(
    SimpleIdentifier propertyName,
    Expression? target,
    ErrorReporter reporter,
  ) {
    if (propertyName.name != 'colorScheme') {
      return;
    }
    final targetType = target?.staticType;
    if (targetType == null) {
      return;
    }
    final displayName = targetType.getDisplayString();
    if (displayName == 'ThemeData') {
      reporter.atNode(propertyName, code);
    }
  }
}
```

新規作成/更新 `packages/eqmonitor_custom_lints/lib/eqmonitor_custom_lints.dart`(Step 1 の空リストを実ルールに置き換える):

```dart
import 'package:custom_lint_builder/custom_lint_builder.dart';

import 'rules/avoid_direct_color_scheme.dart';

PluginBase createPlugin() => _EqmonitorCustomLintsPlugin();

class _EqmonitorCustomLintsPlugin extends PluginBase {
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) => const [
    AvoidDirectColorScheme(),
  ];
}
```

`packages/eqmonitor_custom_lints/test/fixtures/avoid_direct_color_scheme/violation.dart` は `package:flutter/material.dart` に依存するため、`pubspec.yaml` の `dependencies` に `flutter` を追加する必要がある。`pubspec.yaml` を以下に更新する:

```yaml
name: eqmonitor_custom_lints
description: Custom lint rules for EQMonitor (custom_lint plugin package).
publish_to: none
version: 0.1.0

environment:
  sdk: ^3.0.0
  flutter: ">=3.0.0"

dependencies:
  analyzer: ^8.0.0
  custom_lint_builder: ^0.8.1
  flutter:
    sdk: flutter

dev_dependencies:
  custom_lint: ^0.8.1
  test: ^1.29.0
```

- [ ] **Step 6: 依存を再解決してテストがパスすることを確認する**

Run: `cd packages/eqmonitor_custom_lints && timeout 120 dart pub get`
Run: `timeout 150 dart test test/rules/avoid_direct_color_scheme_test.dart`
Expected: PASS — `violation.dart` で1件以上検出、`ok.dart` で0件。`cd -` で戻る。

- [ ] **Step 7: Commit**

```bash
git add packages/eqmonitor_custom_lints/
git commit -m "$(cat <<'EOF'
feat(lints): avoid_direct_color_schemeルールを持つcustom_lintプラグイン
パッケージを追加

Theme.of(context).colorSchemeの直接参照を検出し、
designSystem.colorThemeへの移行を強制するeqmonitor_custom_lints
パッケージを新設する。analyzerバージョン制約の衝突を避けるため
ワークスペース共有解決には参加させない。

Claude-Session: https://claude.ai/code/session_01EapeTteTrPUodCTmDiTEWp
EOF
)"
```

### Task 8: app への custom_lint 結線 + melos/CI 追加 + 最終検証

**Files:**
- Modify: `app/pubspec.yaml`
- Modify: `analysis_options.yaml`(ワークスペースルート)
- Modify: `pubspec.yaml`(ワークスペースルート、melos scripts)
- Modify: `.github/workflows/wc-check-dart-analyze.yaml`

**Interfaces:**
- Consumes: Task 7 の `packages/eqmonitor_custom_lints`(`avoid_direct_color_scheme` ルール)。
- Produces: `melos run custom_lint` コマンド、CI での custom_lint 実行ステップ。これが本計画の最終タスクであり、後続タスクはない。

- [ ] **Step 1: app に eqmonitor_custom_lints を dev_dependency として追加する**

`app/pubspec.yaml` の `dev_dependencies:` セクション(185-198行目)に1行追加する:

```yaml
dev_dependencies:
  build_runner: ^2.11.1
  eqmonitor_custom_lints:
    path: ../packages/eqmonitor_custom_lints
  eqmonitor_lints:
    path: ../packages/eqmonitor_lints
  fake_async: ^1.3.1
  flutter_gen_runner: ^5.8.0
  freezed: ^4.0.0-dev.3
  go_router_builder: ^4.3.0
  json_serializable: ^6.14.0
  riverpod_generator: ^4.0.4
  riverpod_lint: ^3.1.4
  shared_preferences_platform_interface: ^2.4.0
  test: ^1.29.0
  theme_tailor: ^3.1.3
```

- [ ] **Step 2: 依存解決を確認する(既知リスクの検証)**

Run: `cd app && timeout 180 dart pub get --enforce-lockfile` が失敗する場合(app の `dependency_overrides.analyzer: ^12.0.0` と `custom_lint_builder` の `analyzer: ^8.0.0` 制約が競合し得るため)、まず `--enforce-lockfile` を外して解決可能か確認する:

Run: `cd app && timeout 180 dart pub get`

- **成功する場合**: そのまま Step 3 へ進む。生成された `app/pubspec.lock` の差分をコミット対象に含める。
- **失敗する場合(バージョン競合)**: 以下の代替手順を実行する。
  1. ワークスペースルートの `pubspec.yaml` に `dependency_overrides:` セクションを追加できない制約(pub workspaceのルート以外でのoverride不可)を踏まえ、`app/pubspec.yaml` の `dependency_overrides` に `custom_lint_builder` / `custom_lint` 自体は追加しない(これらは `eqmonitor_custom_lints` 側の制約であり app 側から緩めることはできない)。
  2. 代わりに `packages/eqmonitor_custom_lints/pubspec.yaml` の `custom_lint_builder` バージョンを、app の `analyzer: ^12.0.0` と両立する範囲に緩めることを試みる: `custom_lint_builder: ">=0.7.0 <1.0.0"` のように制約を緩め、`cd packages/eqmonitor_custom_lints && timeout 120 dart pub get` で単独解決が壊れないことを確認してから、再度 Step 2 の `dart pub get`(app側)を試す。
  3. それでも解決しない場合は、`packages/eqmonitor_custom_lints` を `tools/eqmonitor_custom_lints` へ移動し(`tools/eqmonitor_lints_plugin` と同様にワークスペース外に置く)、app からの `dev_dependencies` path参照ではなく **`analysis_options.yaml` の `plugins:`(トップレベル、native analyzer plugin 用のキー)に `eqmonitor_custom_lints_plugin` として登録する代替設計に切り替える**。この場合 Task 7 のルール実装を `custom_lint_builder` API から `analysis_server_plugin`(`tools/eqmonitor_lints_plugin/lib/rules/avoid_eqmonitor_api_in_ui.dart` と同じ `AnalysisRule`/`RuleVisitorRegistry` API)に書き換える必要がある。この代替設計を採用した場合は Task 7 の該当ファイルをこのAPIに合わせて修正し、本Stepの残りをスキップして Step 6(CIステップ、`dart analyze` は既にこの仕組みを実行しているため追加のCIステップは不要)に進む。

`cd -` で戻る。

- [ ] **Step 3: root analysis_options.yaml に custom_lint プラグインを登録する**

`analysis_options.yaml`(ワークスペースルート)を以下に変更する(既存の `analyzer:` セクションに `plugins:` を追加し、既存のトップレベル `plugins:` キー(native analyzer plugin用)とは別に共存させる):

```yaml
include: package:eqmonitor_lints/analysis_options.yaml
analyzer:
  errors:
    avoid_implementing_value_types: ignore
    avoid_print: ignore
    document_ignores: ignore
    lines_longer_than_80_chars: ignore
    unnecessary_async: ignore
    unnecessary_cast: ignore
  exclude:
    - "**/DerivedData/**"
    - "**/build/**"
    - "build/**"
  plugins:
    - custom_lint

plugins:
  eqmonitor_lints_plugin:
    path: tools/eqmonitor_lints_plugin
    diagnostics:
      avoid_stateful_widget: true
      avoid_null_assertion_operator: true
      avoid_top_level_functions: true
      avoid_print: true
      avoid_eqmonitor_api_in_ui: true
      avoid_mixed_declaration_categories: true
```

- [ ] **Step 4: melos に custom_lint スクリプトを追加する**

ワークスペースルート `pubspec.yaml` の `melos.scripts` セクション、`analyze:` スクリプト(26-31行目)の直後に追加する:

```yaml
    custom_lint:
      run: |
        cd app && dart run custom_lint
      description: |
        custom_lint ルール(avoid_direct_color_scheme 等)を app に対して実行します。
        dart analyze はローカル環境でハングする既知の問題があるため、
        こちらを日常的な検証コマンドとして使用してください。
```

- [ ] **Step 5: melos custom_lint スクリプトの動作を確認する**

Run: `timeout 180 dart pub global run melos run custom_lint`
Expected: `avoid_direct_color_scheme` の違反が0件(既存コードは `designSystem.colorTheme` 経由のためこの時点で違反なし)。もし既存コードに `Theme.of(context).colorScheme` の直接参照が残っている場合は、その箇所を `context.designSystem.colorTheme` に置き換える(本タスクのスコープ内でのクリーンアップとして許容する)。

- [ ] **Step 6: CI に custom_lint 実行ステップを追加する**

`.github/workflows/wc-check-dart-analyze.yaml` の `Report analyze` ステップ(32-37行目)の後に追加する:

```yaml
      - name: Install melos
        run: |
          echo "$HOME/.pub-cache/bin" >> "$GITHUB_PATH"
          dart pub global activate melos

      - name: Run custom_lint
        run: melos run custom_lint
```

- [ ] **Step 7: 最終回帰確認(新規失敗ゼロの判定)**

Run: `timeout 300 flutter test app/test/core/theme -r expanded`
Run: `timeout 300 flutter test app/test/feature/settings/features/display_settings -r expanded`
Run: `timeout 600 flutter test app -r expanded`
Expected: develop の既存フルスイートに存在する24件の既存失敗と一致し、本計画で追加した新規テストがすべてPASSしていること(新規失敗ゼロ)。差異があれば `git diff develop -- app/test` と照らし合わせて原因を切り分ける。

Run: `cd packages/eqmonitor_custom_lints && timeout 150 dart test`
Expected: PASS

- [ ] **Step 8: Commit**

```bash
git add app/pubspec.yaml app/pubspec.lock analysis_options.yaml pubspec.yaml \
        .github/workflows/wc-check-dart-analyze.yaml
git commit -m "$(cat <<'EOF'
chore(lints): custom_lintをappに結線し、melosスクリプトとCIステップを追加

eqmonitor_custom_lintsをappのdev_dependencyとして登録し、
analysis_options.yamlでcustom_lintプラグインを有効化。
`melos run custom_lint`とCIのdart-analyzeワークフローに
avoid_direct_color_schemeルールの実行を組み込む。

Claude-Session: https://claude.ai/code/session_01EapeTteTrPUodCTmDiTEWp
EOF
)"
```

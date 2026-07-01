# JSONテーマシステム設計

## 概要

アプリケーション全体の配色を「テーマ」という単位で管理し、JSONファイルで定義・共有できる仕組みを導入する。震度カラー、テキスト色、サーフェス色、地図色など、すべての色をテーマで制御する。

## 要件

- テーマはJSONファイルで構築される
- プリセットテーマの内蔵 + JSON import/exportによるカスタムテーマの両対応
- 制御範囲は配色のみ（タイポグラフィ、スペーシング、シェイプは対象外）
- 震度カラー・推計震度カラー・地図カラーもテーマに統合
- 1テーマがLight/Dark両方、Lightのみ、Darkのみのいずれかを定義できる
- ユーザーはLightモードとDarkモードでそれぞれ別テーマを選択するか、Light+Dark両対応テーマを1つ選択することもできる
- 全フィールド必須の厳密バリデーション。不正なテーマはロードを拒否しデフォルトにフォールバック
- UI層への配布は `Theme.of(context).extension<DesignSystemThemeExtension>()` 経由
- `Theme.of(context).colorScheme` の直接参照を禁止

## テーマJSON構造

```json
{
  "name": "EQMonitor Default",
  "version": 1,
  "author": "EQMonitor",
  "modes": ["light", "dark"],
  "light": {
    "primary": "#2F6FE4",
    "onPrimary": "#FFFFFF",
    "primaryContainer": "#DCE8FF",
    "onPrimaryContainer": "#001A41",
    "secondary": "#5E86D6",
    "onSecondary": "#FFFFFF",
    "secondaryContainer": "#D6E3FF",
    "onSecondaryContainer": "#001B3E",
    "tertiary": "#2D8A78",
    "onTertiary": "#FFFFFF",
    "tertiaryContainer": "#A8F0DE",
    "onTertiaryContainer": "#002117",
    "error": "#C54C4C",
    "onError": "#FFFFFF",
    "errorContainer": "#FFDAD6",
    "onErrorContainer": "#410002",
    "surface": "#FFFFFF",
    "onSurface": "#10151C",
    "onSurfaceVariant": "#4A5A6D",
    "surfaceContainerLowest": "#FFFFFF",
    "surfaceContainerLow": "#F5F8FC",
    "surfaceContainer": "#EDF3F9",
    "surfaceContainerHigh": "#EAF0F7",
    "surfaceContainerHighest": "#D9E6F7",
    "outline": "#95A7BC",
    "outlineVariant": "#D3DDE8",
    "inverseSurface": "#0F141A",
    "onInverseSurface": "#F5F8FC",
    "inversePrimary": "#4D8DFF",
    "shadow": "#000000",
    "scrim": "#000000",
    "status": {
      "success": "#248A5A",
      "warning": "#B57900",
      "info": "#1D73D8"
    },
    "intensity": {
      "unknown": { "background": "#000000", "foreground": { "type": "auto" } },
      "zero": { "background": "#FFFFFF", "foreground": { "type": "auto" } },
      "one": { "background": "#03B5FF", "foreground": { "type": "auto" } },
      "two": { "background": "#76FF03", "foreground": { "type": "auto" } },
      "three": { "background": "#00C853", "foreground": { "type": "auto" } },
      "four": { "background": "#FFEB3B", "foreground": { "type": "auto" } },
      "fiveLower": { "background": "#FFC107", "foreground": { "type": "auto" } },
      "fiveUpper": { "background": "#FF6F00", "foreground": { "type": "auto" } },
      "sixLower": { "background": "#FF2800", "foreground": { "type": "auto" } },
      "sixUpper": { "background": "#A50021", "foreground": { "type": "auto" } },
      "seven": { "background": "#C800FF", "foreground": { "type": "auto" } }
    },
    "estimatedIntensity": {
      "four": { "background": "#FAE6A0", "foreground": { "type": "auto" } },
      "fiveLower": { "background": "#FFE600", "foreground": { "type": "auto" } },
      "fiveUpper": { "background": "#FF9900", "foreground": { "type": "auto" } },
      "sixLower": { "background": "#FF2800", "foreground": { "type": "auto" } },
      "sixUpper": { "background": "#A50021", "foreground": { "type": "auto" } },
      "seven": { "background": "#B40068", "foreground": { "type": "auto" } }
    },
    "map": {
      "background": "#0D1B4A",
      "worldLand": "#FFFFFF",
      "worldLine": "#6B7280",
      "japanLand": "#FFFFFF",
      "japanLine": "#6B7280"
    }
  },
  "dark": {
    "primary": "#4D8DFF",
    "onPrimary": "#07121F",
    "primaryContainer": "#24344A",
    "onPrimaryContainer": "#DCE8FF",
    "secondary": "#8FB7FF",
    "onSecondary": "#07121F",
    "secondaryContainer": "#1A3A6B",
    "onSecondaryContainer": "#D6E3FF",
    "tertiary": "#91D4C8",
    "onTertiary": "#002117",
    "tertiaryContainer": "#1A5C4F",
    "onTertiaryContainer": "#A8F0DE",
    "error": "#FF7A7A",
    "onError": "#410002",
    "errorContainer": "#8C1D18",
    "onErrorContainer": "#FFDAD6",
    "surface": "#171E26",
    "onSurface": "#F3F6FA",
    "onSurfaceVariant": "#C4CCD7",
    "surfaceContainerLowest": "#0F141A",
    "surfaceContainerLow": "#131A21",
    "surfaceContainer": "#1D2630",
    "surfaceContainerHigh": "#232D38",
    "surfaceContainerHighest": "#2B3744",
    "outline": "#506073",
    "outlineVariant": "#3A4654",
    "inverseSurface": "#F5F8FC",
    "onInverseSurface": "#0F141A",
    "inversePrimary": "#2F6FE4",
    "shadow": "#000000",
    "scrim": "#000000",
    "status": {
      "success": "#63D39B",
      "warning": "#F4C75E",
      "info": "#78B8FF"
    },
    "intensity": {
      "unknown": { "background": "#000000", "foreground": { "type": "auto" } },
      "zero": { "background": "#FFFFFF", "foreground": { "type": "auto" } },
      "one": { "background": "#03B5FF", "foreground": { "type": "auto" } },
      "two": { "background": "#76FF03", "foreground": { "type": "auto" } },
      "three": { "background": "#00C853", "foreground": { "type": "auto" } },
      "four": { "background": "#FFEB3B", "foreground": { "type": "auto" } },
      "fiveLower": { "background": "#FFC107", "foreground": { "type": "auto" } },
      "fiveUpper": { "background": "#FF6F00", "foreground": { "type": "auto" } },
      "sixLower": { "background": "#FF2800", "foreground": { "type": "auto" } },
      "sixUpper": { "background": "#A50021", "foreground": { "type": "auto" } },
      "seven": { "background": "#C800FF", "foreground": { "type": "auto" } }
    },
    "estimatedIntensity": {
      "four": { "background": "#FAE6A0", "foreground": { "type": "auto" } },
      "fiveLower": { "background": "#FFE600", "foreground": { "type": "auto" } },
      "fiveUpper": { "background": "#FF9900", "foreground": { "type": "auto" } },
      "sixLower": { "background": "#FF2800", "foreground": { "type": "auto" } },
      "sixUpper": { "background": "#A50021", "foreground": { "type": "auto" } },
      "seven": { "background": "#B40068", "foreground": { "type": "auto" } }
    },
    "map": {
      "background": "#0A1540",
      "worldLand": "#2B3744",
      "worldLine": "#506073",
      "japanLand": "#2B3744",
      "japanLine": "#F3F6FA"
    }
  }
}
```

## データモデル

### AppTheme

テーマ全体を表すトップレベルモデル。

```dart
enum ThemeBrightnessMode { light, dark }

@freezed
class AppTheme with _$AppTheme {
  const factory AppTheme({
    required String name,
    required int version,
    required String author,
    required List<ThemeBrightnessMode> modes, // [light], [dark], [light, dark]
    ThemeColorSet? light,
    ThemeColorSet? dark,
  }) = _AppTheme;

  factory AppTheme.fromJson(Map<String, dynamic> json) => _$AppThemeFromJson(json);

  factory AppTheme.eqmonitorDefault() => /* プリセット */;
}
```

`modes` に含まれるモードに対応する `light` / `dark` が必須。含まれないモードのフィールドは `null`。

テーマ選択UIでは、ユーザーが選択中のBrightnessに対応する `modes` を持つテーマのみを選択肢として表示する。例えばDarkモードで使用するテーマ選択時には、`modes` に `dark` を含むテーマだけが表示される。

### ThemeColorSet

1つのモード（LightまたはDark）の全色定義。ColorScheme命名に準拠。

```dart
@freezed
class ThemeColorSet with _$ThemeColorSet {
  const factory ThemeColorSet({
    // ColorScheme準拠
    required Color primary,
    required Color onPrimary,
    required Color primaryContainer,
    required Color onPrimaryContainer,
    required Color secondary,
    required Color onSecondary,
    required Color secondaryContainer,
    required Color onSecondaryContainer,
    required Color tertiary,
    required Color onTertiary,
    required Color tertiaryContainer,
    required Color onTertiaryContainer,
    required Color error,
    required Color onError,
    required Color errorContainer,
    required Color onErrorContainer,
    required Color surface,
    required Color onSurface,
    required Color onSurfaceVariant,
    required Color surfaceContainerLowest,
    required Color surfaceContainerLow,
    required Color surfaceContainer,
    required Color surfaceContainerHigh,
    required Color surfaceContainerHighest,
    required Color outline,
    required Color outlineVariant,
    required Color inverseSurface,
    required Color onInverseSurface,
    required Color inversePrimary,
    required Color shadow,
    required Color scrim,
    // EQMonitor固有
    required StatusColors status,
    required IntensityColors intensity,
    required EstimatedIntensityColors estimatedIntensity,
    @JsonKey(name: 'map') required MapColors mapColors,
  }) = _ThemeColorSet;

  factory ThemeColorSet.fromJson(Map<String, dynamic> json) => _$ThemeColorSetFromJson(json);
}
```

全 `Color` フィールドには既存の `ColorJsonConverter` を適用する（`@ColorJsonConverter()` アノテーション、またはクラスレベルの `@JsonSerializable(converters: [ColorJsonConverter()])` で一括指定）。これにより `#RRGGBB` 文字列と `Color` の相互変換が行われる。

### StatusColors

```dart
@freezed
class StatusColors with _$StatusColors {
  const factory StatusColors({
    required Color success,
    required Color warning,
    required Color info,
  }) = _StatusColors;
}
```

### IntensityColorEntry / IntensityTextColor

```dart
@Freezed(unionKey: 'type')
sealed class IntensityTextColor with _$IntensityTextColor {
  @FreezedUnionValue('auto')
  const factory IntensityTextColor.auto() = IntensityTextColorAuto;
  @FreezedUnionValue('manual')
  const factory IntensityTextColor.manual({@ColorJsonConverter() required Color color}) = IntensityTextColorManual;
}

@freezed
class IntensityColorEntry with _$IntensityColorEntry {
  const factory IntensityColorEntry({
    required Color background,
    required IntensityTextColor foreground,
  }) = _IntensityColorEntry;
}
```

`foreground` が `auto` の場合、`background.computeLuminance() > 0.5` で黒、それ以外で白を返す。

### IntensityColors（観測震度: unknown〜seven）

```dart
@freezed
class IntensityColors with _$IntensityColors {
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
}
```

### EstimatedIntensityColors（推計震度: four〜seven）

```dart
@freezed
class EstimatedIntensityColors with _$EstimatedIntensityColors {
  const factory EstimatedIntensityColors({
    required IntensityColorEntry four,
    required IntensityColorEntry fiveLower,
    required IntensityColorEntry fiveUpper,
    required IntensityColorEntry sixLower,
    required IntensityColorEntry sixUpper,
    required IntensityColorEntry seven,
  }) = _EstimatedIntensityColors;
}
```

### MapColors

```dart
@freezed
class MapColors with _$MapColors {
  const factory MapColors({
    required Color background,
    required Color worldLand,
    required Color worldLine,
    required Color japanLand,
    required Color japanLine,
  }) = _MapColors;
}
```

## DesignSystemThemeExtension の変更

`ColorTheme` を `ThemeColorSet` として統合。既存の `ColorPalette`、`ColorThemeExtension`、`TextColorThemeExtension` を廃止。

```dart
class DesignSystemThemeExtension extends ThemeExtension<DesignSystemThemeExtension> {
  final ThemeColorSet colorTheme;        // 全カラートークンを集約（旧 ColorPalette + ColorThemeExtension + TextColorThemeExtension）
  final TypographyTheme typographyTheme; // 固定（テーマ対象外）
  final SpacingTheme spacingTheme;       // 固定（テーマ対象外）
  final ShapeTheme shapeTheme;           // 固定（テーマ対象外）
}
```

### UI層での利用

```dart
final designSystem = Theme.of(context).extension<DesignSystemThemeExtension>()!;

// ColorSchemeと同じ感覚
designSystem.colorTheme.primary
designSystem.colorTheme.onSurface
designSystem.colorTheme.surfaceContainer
designSystem.colorTheme.outline

// EQMonitor固有
designSystem.colorTheme.status.success
designSystem.colorTheme.intensity.seven.background
designSystem.colorTheme.intensity.seven.foreground // → auto判定 or 手動指定色
designSystem.colorTheme.estimatedIntensity.sixLower.background
designSystem.colorTheme.mapColors.japanLand
```

### 禁止パターン

```dart
// NG: 禁止
Theme.of(context).colorScheme.primary
Theme.of(context).colorScheme.surface
```

`analysis_options.yaml` で custom lint rule を追加し、`colorScheme` の直接参照を検出する。

## Provider設計

### AppThemeNotifier

```dart
@Riverpod(keepAlive: true)
class AppThemeNotifier extends _$AppThemeNotifier {
  // SharedPreferencesで永続化
  // キー: 'app_theme_light', 'app_theme_dark'
  // ライトモード用テーマとダークモード用テーマをそれぞれ保存

  Future<void> setLightTheme(AppTheme theme);
  Future<void> setDarkTheme(AppTheme theme);
  Future<AppTheme> importFromJson(String json); // バリデーション付き
  String exportToJson(AppTheme theme);
}
```

### activeColorSetProvider

```dart
@riverpod
ThemeColorSet activeColorSet(Ref ref) {
  final brightness = ref.watch(brightnessNotifierProvider);
  final notifier = ref.watch(appThemeNotifierProvider);
  // brightnessに応じてlight/darkテーマのThemeColorSetを返す
}
```

### buildTheme() の変更

```dart
ThemeData buildTheme(ThemeColorSet colorSet, Brightness brightness) {
  final colorScheme = colorSet.toColorScheme(brightness);

  return ThemeData(
    useMaterial3: true,
    brightness: brightness,
    colorScheme: colorScheme, // Material Widget内部用（アプリコードからは参照禁止）
    extensions: [
      DesignSystemThemeExtension(
        colorTheme: colorSet,
        typographyTheme: TypographyTheme.standard(),
        spacingTheme: SpacingTheme.standard(),
        shapeTheme: ShapeTheme.standard(),
      ),
    ],
  );
}
```

`ThemeColorSet.toColorScheme()` でFlutter内部が必要とする `ColorScheme` を生成する。

## 既存コードの移行

| 既存 | 移行先 | 対応 |
|---|---|---|
| `intensityColorProvider` | `designSystem.colorTheme.intensity` | 廃止 |
| `estimatedIntensityColorProvider` | `designSystem.colorTheme.estimatedIntensity` | 廃止 |
| `MapColorScheme` | `designSystem.colorTheme.mapColors` | 廃止 |
| `ColorPalette` | `ThemeColorSet` のColorScheme準拠フィールド + `status` | 廃止 |
| `ColorThemeExtension` | `ThemeColorSet` の `surface*` / `outline*` フィールド | 廃止 |
| `TextColorThemeExtension` | `ThemeColorSet` の `onSurface` / `onSurfaceVariant` 等 | 廃止 |
| `IntensityColorModel` | `IntensityColors` + `IntensityColorEntry` | 廃止 |
| `themeModeProvider` | そのまま維持 | 変更なし |
| `brightnessNotifierProvider` | そのまま維持 | 変更なし |

### SharedPreferences マイグレーション

旧 `intensity_color` キーおよび `estimated_intensity_color` キーのJSONデータを新 `AppTheme` フォーマットに変換するマイグレーション関数を提供し、初回起動時に自動変換する。両方のキーのカスタム設定を保持する。

## バリデーション

`AppTheme.fromJson()` で以下を検証:

1. `version` が対応バージョンであること
2. `modes` に含まれるモードに対応する `light` / `dark` が存在すること
3. 全色値が `#RRGGBB` 形式であること
4. 全フィールドが存在すること（部分テーマは不許可）

不正なJSONの場合は `FormatException` をスローし、呼び出し側でデフォルトテーマにフォールバックする。

## プリセットテーマ

初期実装として以下のプリセットを提供:

1. **EQMonitor Default** — 現行のデザインシステム色をそのまま移植（Light + Dark）
2. **JMA Standard** — JMA公式配色の震度カラーを使用（Light + Dark）

プリセットはDartコード内の `AppTheme` ファクトリコンストラクタとして定義する。

## ファイル構成

```
app/lib/core/theme/
├── model/
│   ├── app_theme.dart
│   ├── theme_color_set.dart
│   ├── status_colors.dart
│   ├── intensity_color_entry.dart
│   ├── intensity_text_color.dart
│   ├── intensity_colors.dart
│   ├── estimated_intensity_colors.dart
│   └── map_colors.dart
├── provider/
│   └── app_theme_notifier.dart
├── build_theme.dart          # 変更
└── theme_provider.dart       # 維持
```

廃止するファイル:
- `core/designsystem/extensions/color_palette.dart`
- `core/designsystem/extensions/color_theme_extension.dart`
- `core/designsystem/extensions/text_color_theme_extension.dart`
- `core/provider/config/theme/intensity_color/` ディレクトリ全体
- `feature/map/data/model/map_configuration.dart` の `MapColorScheme`

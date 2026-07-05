# テーマ設定UI + custom lint rule 設計

日付: 2026-07-04
前提: [2026-07-02-json-theme-system-design.md](2026-07-02-json-theme-system-design.md)(マージ済み PR #1440)の後続計画。旧計画の「スコープ外」2項目を実装する。

## 目的

1. **テーマ設定UI** — JSONテーマシステム(AppTheme / ThemeColorSet / AppThemeNotifier)に対するユーザー向けUI。プリセット選択、JSONインポート/エクスポート、全カラートークンの編集。
2. **custom lint rule** — `Theme.of(context).colorScheme` の直接参照を検出し、`designSystem.colorTheme` への移行を強制する。

## 1. テーマ設定UI

### 画面構成

```
表示設定ページ(既存)
└─ 配色設定セクション
   ├─ (既存) ThemeMode選択(Light/Dark/System)
   └─ (新規) 「テーマ設定」タイル → ThemeSettingsPage

ThemeSettingsPage(新規)
├─ Light用テーマ / Dark用テーマ の2セクション。各セクションに:
│  ├─ 現在のテーマ名+プレビュー(震度色チップ列 + primary/surface色)
│  ├─ プリセット選択(EQMonitor Default / JMA標準 / カスタム(存在時))
│  └─ 「編集」ボタン → ThemeEditorPage(mode指定)
├─ JSONインポート(ペーストダイアログ → import先モード選択)
└─ JSONエクスポート(現在のLight/Darkをクリップボードへ)

ThemeEditorPage(新規、mode = light | dark)
├─ カテゴリ別セクション(ExpansionTile等):
│  ├─ Primary / Secondary / Tertiary / Error(on系・Container系含む)
│  ├─ Surface(surfaceContainer 5段階、inverse系、outline、shadow、scrim)
│  ├─ Status(StatusColors 全フィールド)
│  ├─ 震度配色(0〜7: 背景色 + 文字色(auto/manual切替))
│  ├─ 推計震度配色(4〜7: 同上)
│  └─ マップ(MapColors 全フィールド)
├─ 各行: ラベル + 現在色スウォッチ → タップで flutter_colorpicker ダイアログ
└─ 編集で「カスタム」テーマ(name: 'カスタム')として当該モードに保存
```

### アーキテクチャ

- **フィールド定義の宣言化**: `ThemeColorSet` の31個のフラットColor + ネストモデル(Status/Intensity/EstimatedIntensity/Map)を、`ThemeColorFieldDef`(label、category、`Color Function(ThemeColorSet)` getter、`ThemeColorSet Function(ThemeColorSet, Color)` setter)のリストとして1ファイルに定義する(`theme_color_field_defs.dart`)。エディタUIはこのリストを描画するだけにし、フィールド追加時の修正箇所を1箇所にする。
  - 震度/推計震度のエントリ(背景+IntensityTextColor)は構造が異なるため、別定義(`IntensityFieldDef`)で扱う。
  - typedefは使わない(コードスタイル制約)。Function型はフィールド型として直接記述。
- **編集フロー**: `AppThemeNotifier` の現行テーマ(当該モード)を初期値に、ページローカルの編集状態(`ThemeEditorController` 的なNotifier provider、家族引数 mode)で `ThemeColorSet` を保持。保存時に `AppTheme(name: 'カスタム', ...)` を構築して `AppThemeNotifier` に保存。
  - 保存タイミング: 色変更のたび即時反映・即時保存(プレビュー性重視、既存アプリの設定と同じ挙動)。「保存」ボタンは置かない。
  - プリセットは不変。プリセット選択中に編集を開始した時点でカスタム化する。
- **AppThemeNotifierへの追加API**: `setThemeForMode(ThemeBrightnessMode mode, AppTheme theme)`(現状のsave系APIを確認し、なければ追加)。プリセット適用・カスタム保存・インポート適用はすべてこれを通す。
- **JSONインポート**: 既存 `importFromJson`(Result型、バージョン+必須フィールド検証)を使用。失敗時は例外メッセージをダイアログ表示。成功時に適用先(Light/Dark/両方)を選ばせる。
- **JSONエクスポート**: 既存 `exportToJson` → `Clipboard.setData` + SnackBar。

### エラー処理

- インポート失敗: `AppThemeImportException` の内容をそのままユーザーに表示(既存の検証メッセージを利用)。
- カラーピッカーはColor値しか返さないため色値の不正はない。

### テスト

- ThemeSettingsPage: プリセット選択でnotifierに保存される / インポート成功・失敗のダイアログ挙動 / エクスポートでクリップボードに書かれる(widget test)。
- ThemeEditorPage: フィールド定義リストの網羅性(ThemeColorSetの全Color系フィールドが定義に含まれることをリフレクション不使用で検証 — JSON round-tripで「定義リスト経由で全フィールドを書き換えたときtoJsonが全て変化する」テスト) / 色変更が保存されカスタム化することのwidget test。
- 定義リストのgetter/setter対応の正しさ: 各defで `setter(set, X)` 後に `getter` がXを返すことの全件ループテスト。

## 2. custom lint rule

### 構成

- 新パッケージ **`packages/eqmonitor_custom_lints`**(custom_lint_builder ベース、Dart only)。
- ルール `avoid_direct_color_scheme`: `Theme.of(context).colorScheme` へのプロパティアクセス(および `ThemeData.colorScheme` getterへのアクセス全般)を検出し、`designSystem.colorTheme を使用してください` を報告。
  - 許可リスト: `app/lib/core/theme/build_theme.dart`(ColorScheme構築側)、生成ファイル(`*.g.dart` / `*.freezed.dart`)。
- appの `dev_dependencies` に追加し、`app/analysis_options.yaml` に `plugins: [custom_lint]` を設定。
- melosに `custom_lint` スクリプトを追加(`melos exec --scope=eqmonitor -- dart run custom_lint`)。CIへの組み込みは flutter.yaml に1ステップ追加。
- テスト: ルールパッケージ内に違反コード/非違反コードのfixtureを置き、`custom_lint --watch=false` 相当のテストAPI(`custom_lint_core` のtesting)またはfixture実行で検証。

### 注意

- `dart analyze` はcustom_lintルールを実行しない(custom_lintは別プロセス)。CIステップ追加が実効性の要。
- ローカル環境で `dart analyze` がハングする既知問題があるため、検証は `dart run custom_lint` 単体とテストで行う。

## スコープ外

- テーマの複数保存・命名管理(カスタムは各モード1つ)
- テーマ共有機能(ファイル/URL)
- lint quick fix(自動修正)

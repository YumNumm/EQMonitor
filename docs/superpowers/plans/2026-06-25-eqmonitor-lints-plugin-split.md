# eqmonitor_lints プラグイン分離・正常化 実装計画 (案A)

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Dart 3.12.2 で動作しないカスタム lint プラグインを正常化し、新ルール `avoid_mixed_declaration_categories` を含む全ルールを実際に発火させる。

**Architecture:** `packages/eqmonitor_lints` は2役(① 共有 lint 設定の `include` 提供 / ② カスタム lint プラグイン)を兼ねているが、① は workspace 内・analyzer 9、② は analyzer 13 を要求し両立不可。そこで **② のプラグインコードを workspace 外の独立パッケージ `tools/eqmonitor_lints_plugin`(独自 lockfile・analyzer 13)へ分離**し、ルートの `analysis_options.yaml` から `plugins: { path: }` で参照する。workspace 本体(analyzer 9 / freezed / riverpod codegen)には一切触れない。

**Tech Stack:** analysis_server_plugin ^0.3.8 (→ 0.3.18) / analyzer ^13 / Dart 3.12.2 (Flutter 3.44.3)

## Global Constraints

- workspace 本体の analyzer(9.0.0)・freezed・riverpod_generator・codegen は**変更しない**。
- 新プラグインパッケージ `tools/eqmonitor_lints_plugin` は **workspace メンバーにしない**(`resolution: workspace` を付けない / `packages/*` glob 外の `tools/` に置く)。
- 設定パッケージ `packages/eqmonitor_lints` は**パッケージ名・配置・`lib/analysis_options.yaml` の include 利用を維持**する(18 件の `include:` / 19 件の path dev_dependency は変更しない)。
- lint ルールはデフォルト無効。ルートの `analysis_options.yaml` の `diagnostics:` で**明示的に有効化必須**。
- 抑制コメントはプラグイン名プレフィックス付き: `// ignore: eqmonitor_lints_plugin/<rule_name>`。
- `prefer_shorthands` は Dart 3.12 非対応(analyzer_plugin ^0.13.10 固定)のため `plugins:` から除外する。
- 実環境 SDK は Dart 3.12.2。検証は必ず Flutter 同梱 dart (`/Users/ryotaro.onoue/.local/share/mise/installs/flutter/3.44.3-stable/bin/dart`) で行う。

---

## File Structure

- 新規 `tools/eqmonitor_lints_plugin/pubspec.yaml` — 独立パッケージ定義(analyzer 13)
- 新規 `tools/eqmonitor_lints_plugin/analysis_options.yaml` — 自己 lint 用の最小設定
- 新規 `tools/eqmonitor_lints_plugin/lib/main.dart` — プラグインエントリポイント(`packages/eqmonitor_lints/lib/main.dart` から移設・rename)
- 新規 `tools/eqmonitor_lints_plugin/lib/src/rules/*.dart` — 6 ルール(`packages/eqmonitor_lints/lib/src/rules/` から移設)
- 変更 `packages/eqmonitor_lints/pubspec.yaml` — プラグイン用 deps を削除し設定提供のみに
- 削除 `packages/eqmonitor_lints/lib/main.dart`, `packages/eqmonitor_lints/lib/src/rules/`
- 変更 `packages/eqmonitor_lints/lib/analysis_options.yaml` — `plugins: prefer_shorthands` ブロック削除
- 変更 `analysis_options.yaml`(リポジトリルート) — `plugins: eqmonitor_lints_plugin: { path:, diagnostics: }` 追加

---

## Task 1: 独立プラグインパッケージの作成とルール移設

**Files:**
- Create: `tools/eqmonitor_lints_plugin/pubspec.yaml`
- Create: `tools/eqmonitor_lints_plugin/analysis_options.yaml`
- Create: `tools/eqmonitor_lints_plugin/lib/main.dart`
- Create: `tools/eqmonitor_lints_plugin/lib/src/rules/avoid_stateful_widget.dart` ほか 6 ルール
- Delete (移設後): `packages/eqmonitor_lints/lib/main.dart`, `packages/eqmonitor_lints/lib/src/rules/`

**Interfaces:**
- Produces: パッケージ名 `eqmonitor_lints_plugin`、`plugin` エントリポイント、6 ルールクラス。

- [ ] **Step 1: ディレクトリとルールファイルの移設**

```bash
cd /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor
mkdir -p tools/eqmonitor_lints_plugin/lib/src
git mv packages/eqmonitor_lints/lib/src/rules tools/eqmonitor_lints_plugin/lib/src/rules
git mv packages/eqmonitor_lints/lib/main.dart tools/eqmonitor_lints_plugin/lib/main.dart
```

- [ ] **Step 2: 新パッケージの pubspec を作成**

`tools/eqmonitor_lints_plugin/pubspec.yaml`:
```yaml
name: eqmonitor_lints_plugin
description: Custom analyzer plugin (lint rules) for EQMonitor. Standalone (not in pub workspace) to use analyzer 13 independently of the app workspace.
publish_to: none

environment:
  sdk: ^3.12.0

dependencies:
  analysis_server_plugin: ^0.3.8
  analyzer: ^13.0.0
```
（注: `resolution: workspace` は**付けない**。`flutter` / `altive_lints` / `yumemi_lints` / `prefer_shorthands` / `analyzer_plugin` の明示依存は不要なので付けない。）

- [ ] **Step 3: 自己 lint 用の最小 analysis_options を作成**

`tools/eqmonitor_lints_plugin/analysis_options.yaml`:
```yaml
analyzer:
  errors:
    lines_longer_than_80_chars: ignore
    deprecated_member_use: ignore
```
（`deprecated_member_use` 無視は `LintCode.name`→`lowerCaseName` の deprecation info を抑止するため。）

- [ ] **Step 4: main.dart のプラグイン名を更新**

`tools/eqmonitor_lints_plugin/lib/main.dart` の `name` getter を変更:
```dart
  @override
  String get name => 'eqmonitor_lints_plugin';
```
（import パスは `package:eqmonitor_lints/...` のままでは解決不可。`git mv` 後にルールの import を新パッケージ名へ置換する — Step 5。）

- [ ] **Step 5: import パスを新パッケージ名へ置換**

`tools/eqmonitor_lints_plugin/lib/main.dart` の `import 'package:eqmonitor_lints/src/rules/...'` を `package:eqmonitor_lints_plugin/src/rules/...` に置換:
```bash
cd /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor
sed -i '' 's|package:eqmonitor_lints/src/|package:eqmonitor_lints_plugin/src/|g' tools/eqmonitor_lints_plugin/lib/main.dart
```

- [ ] **Step 6: 依存解決**

```bash
DART=/Users/ryotaro.onoue/.local/share/mise/installs/flutter/3.44.3-stable/bin/dart
cd /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor/tools/eqmonitor_lints_plugin
$DART pub get
```
Expected: 解決成功。`analyzer = 13.x` / `analysis_server_plugin = 0.3.18` が lockfile に入る。

- [ ] **Step 7: コミット**

```bash
git add tools/eqmonitor_lints_plugin packages/eqmonitor_lints/lib
git commit -m "refactor(lints): カスタム lint プラグインを tools/eqmonitor_lints_plugin へ分離"
```

---

## Task 2: ルールコードを analyzer 13 API へ移行

**Files:**
- Modify: `tools/eqmonitor_lints_plugin/lib/src/rules/avoid_mixed_declaration_categories.dart`

**Interfaces:**
- Consumes: Task 1 の新パッケージ構成。
- Produces: analyzer 13 でコンパイル可能なルール群。

analyzer 13 では `ClassDeclaration.name` ゲッターが廃止された(クラス名が `namePart` 配下へ移動)。`avoid_mixed_declaration_categories` のみこれを使用しているため、**`@freezed` アノテーションノードへ報告**する形に変更する(他 5 ルールは analyzer 13 で変更不要)。

- [ ] **Step 1: 違反報告を Token から Annotation ノードへ変更**

`avoid_mixed_declaration_categories.dart` の `_Visitor` を以下に修正。`freezedClasses`(ClassDeclaration 蓄積)を `freezedAnnotations`(Annotation 蓄積)に置き換え、`reportAtToken(freezed.name)` を `reportAtNode(annotation)` に変更する:

```dart
  @override
  void visitCompilationUnit(CompilationUnit node) {
    final freezedAnnotations = <Annotation>[];
    final categories = <_Category>{};

    for (final declaration in node.declarations) {
      final category = _categoryOf(declaration);
      if (category == null) {
        continue;
      }
      categories.add(category);
      if (category == _Category.freezed && declaration is ClassDeclaration) {
        final annotation = _annotationOf(declaration.metadata, _freezedNames);
        if (annotation != null) {
          freezedAnnotations.add(annotation);
        }
      }
    }

    // 「1ファイル1カテゴリ」 + Riverpod DI 例外 ({riverpod, plain} は許可)。
    // freezed が他カテゴリと混在している場合のみ違反とする。
    if (categories.contains(_Category.freezed) && categories.length > 1) {
      for (final annotation in freezedAnnotations) {
        rule.reportAtNode(annotation);
      }
    }
  }
```

そして `_hasAnnotation` を、Annotation ノードを返す `_annotationOf` に置き換える(`_categoryOf` 内の `_hasAnnotation(...)` 呼び出しは `_annotationOf(...) != null` に変更):

```dart
  Annotation? _annotationOf(NodeList<Annotation> metadata, Set<String> names) {
    for (final annotation in metadata) {
      if (names.contains(annotation.name.name)) {
        return annotation;
      }
    }
    return null;
  }
```

- [ ] **Step 2: コンパイル検証**

```bash
DART=/Users/ryotaro.onoue/.local/share/mise/installs/flutter/3.44.3-stable/bin/dart
cd /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor/tools/eqmonitor_lints_plugin
$DART analyze lib/
```
Expected: `No issues found!`（`ClassDeclaration.name` エラーが消え、deprecation info も analysis_options で抑止済み）

- [ ] **Step 3: コミット**

```bash
git add tools/eqmonitor_lints_plugin/lib/src/rules/avoid_mixed_declaration_categories.dart
git commit -m "fix(lints): analyzer 13 対応 (ClassDeclaration.name 廃止 → アノテーションノードへ報告)"
```

---

## Task 3: 設定パッケージ packages/eqmonitor_lints のスリム化

**Files:**
- Modify: `packages/eqmonitor_lints/pubspec.yaml`
- Modify: `packages/eqmonitor_lints/lib/analysis_options.yaml`

**Interfaces:**
- Consumes: Task 1 でプラグインコードが移設済み。
- Produces: 設定提供のみのパッケージ(workspace 内・analyzer 非依存)。

- [ ] **Step 1: pubspec からプラグイン用 deps を削除**

`packages/eqmonitor_lints/pubspec.yaml` を以下に変更(`analysis_server_plugin` / `analyzer` / `analyzer_plugin` / `altive_lints` / `prefer_shorthands` を削除。`yumemi_lints` と flutter のみ残す):
```yaml
name: eqmonitor_lints

environment:
  sdk: ^3.11.0
  flutter: ^3.44.0

resolution: workspace

dependencies:
  flutter:
    sdk: flutter
  yumemi_lints: ^4.4.0
```

- [ ] **Step 2: 共有設定から prefer_shorthands プラグインブロックを削除**

`packages/eqmonitor_lints/lib/analysis_options.yaml` 末尾の以下を削除:
```yaml
plugins:
  prefer_shorthands: ^0.4.7
```
（included ファイルでの `plugins:` は元々無効。Dart 3.12 非対応でもあるため除去。）

- [ ] **Step 3: workspace 再解決**

```bash
DART=/Users/ryotaro.onoue/.local/share/mise/installs/flutter/3.44.3-stable/bin/dart
cd /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor
$DART pub get
```
Expected: 解決成功。analyzer は **9.0.0 のまま**(変化なし)。

- [ ] **Step 4: include が依然有効か確認**

```bash
$DART analyze packages/eqmonitor_lints/ 2>&1 | tail -5
```
Expected: include 解決エラーなし(プラグインホストの警告は出るが、解決自体は成功)。

- [ ] **Step 5: コミット**

```bash
git add packages/eqmonitor_lints/pubspec.yaml packages/eqmonitor_lints/lib/analysis_options.yaml pubspec.lock
git commit -m "refactor(lints): eqmonitor_lints を設定提供専用にスリム化"
```

---

## Task 4: ルート analysis_options へプラグイン登録

**Files:**
- Modify: `analysis_options.yaml`(リポジトリルート)

**Interfaces:**
- Consumes: Task 1〜3。
- Produces: 全ルールが `diagnostics:` で有効化された状態。

- [ ] **Step 1: 各ルールの登録名を確認**

```bash
cd /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor
rg -n "LintCode\(" -A1 tools/eqmonitor_lints_plugin/lib/src/rules/*.dart
```
Expected: 各ファイルの第1引数が登録名(`avoid_stateful_widget` / `avoid_null_assertion_operator` / `avoid_top_level_functions` / `avoid_print`(要確認) / `avoid_eqmonitor_api_in_ui` / `avoid_mixed_declaration_categories`)。

- [ ] **Step 2: ルート analysis_options.yaml に plugins ブロックを追記**

`analysis_options.yaml` の末尾(top-level)に追加(ルール名は Step 1 の実値に合わせる):
```yaml
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

- [ ] **Step 3: コミット**

```bash
git add analysis_options.yaml
git commit -m "feat(lints): eqmonitor_lints_plugin をルートに登録し全ルールを有効化"
```

---

## Task 5: end-to-end でルール発火を検証

**Files:**
- 一時フィクスチャ(検証後削除)

**Interfaces:**
- Consumes: Task 1〜4。

- [ ] **Step 1: 分析サーバのプラグインキャッシュをクリア**

```bash
rm -rf ~/.dartServer/.plugin_manager
```

- [ ] **Step 2: 違反フィクスチャを作成**

`app/lib/__lint_fixture__.dart`:
```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '__lint_fixture__.freezed.dart';

@freezed
abstract class FooModel with _$FooModel {
  const factory FooModel({required int a}) = _FooModel;
}

class Helper {
  int x = 0;
}

int plainTopLevel() => 2;
```

- [ ] **Step 3: 分析を実行しルール発火を確認**

```bash
DART=/Users/ryotaro.onoue/.local/share/mise/installs/flutter/3.44.3-stable/bin/dart
cd /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor
$DART analyze app/lib/__lint_fixture__.dart 2>&1 | rg "avoid_mixed_declaration_categories|avoid_top_level_functions"
```
Expected: `avoid_mixed_declaration_categories`(FooModel が Helper / plainTopLevel と混在)と `avoid_top_level_functions`(plainTopLevel)が報告される。
※ プラグインホストが `analysis_server_plugin 0.3.18` を Dart 3.12.2 でロードできることをここで実証する。報告が出なければ 案A の前提(ロード可否)が崩れるため STOP し報告する。

- [ ] **Step 4: フィクスチャ削除**

```bash
rm -f app/lib/__lint_fixture__.dart app/lib/__lint_fixture__.freezed.dart
```

- [ ] **Step 5: 既存コードへの影響確認(任意)**

```bash
$DART analyze app/lib packages 2>&1 | rg -c "avoid_mixed_declaration_categories" || true
```
Expected: freezed と他カテゴリが同居する既存ファイル(例 `estimated_intensity_provider.dart`)で警告。件数を確認し、必要なら `// ignore:` 方針をユーザーへ相談。

---

## Self-Review

- **Spec coverage:** ① freezed/riverpod/その他 class 同一ファイル禁止ルール = `avoid_mixed_declaration_categories`(Task 1 で移設・Task 2 で 13 対応・Task 4 で有効化)。② グローバル関数禁止 = 既存 `avoid_top_level_functions`(@riverpod 除外済み・Task 4 で有効化)。プラグイン正常化 = Task 1〜5。網羅。
- **Placeholder scan:** 各 Step に実コード・実コマンド・期待値を記載。Task 4 Step 1 のみルール名を実値確認する手順を明示(プレースホルダではなく検証ステップ)。
- **Type consistency:** `_annotationOf` は `Annotation?` を返し `reportAtNode(Annotation)` に渡す。`reportAtNode` は `AstNode` を受ける(`Annotation` は `AstNode`)。整合。

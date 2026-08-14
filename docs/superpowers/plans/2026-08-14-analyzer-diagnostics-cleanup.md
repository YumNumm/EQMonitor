# Analyzer 診断ゼロ化 実装計画

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** `melos run analyze`（`dart analyze . --fatal-infos`）の診断 1,512 件を 0 件にする。

**Architecture:** 前半で自作 analyzer plugin の誤検出を正し（`main()` / `@pragma('vm:entry-point')` / テストコード除外）、後半で残る実コードの違反を feature 単位で修正する。plugin 側の変更にはテストを追加し、CI で回帰を防ぐ。

**Tech Stack:** Dart 3.14.0 / Flutter 3.48.0-0.1.pre / analyzer 13 / analysis_server_plugin 0.3.x / melos 7

設計書: `docs/superpowers/specs/2026-08-14-analyzer-diagnostics-cleanup-design.md`

## Global Constraints

- Dart / Flutter コマンドは必ず `mise exec -- ` 経由で実行する。
- 依存追加は `dart pub add` / `flutter pub add` を使う。`pubspec.yaml` の依存部分を直接編集しない。
- `*.g.dart` / `*.freezed.dart` などの生成ファイルを手で編集しない。必要なら `dart run build_runner build --delete-conflicting-outputs` で再生成する。
- 生命に関わる情報（震度・マグニチュード・深さ・座標・警報種別・時刻）に、その場しのぎの固定値フォールバックを入れてはならない。
- `!`（null アサーション演算子）を新規に導入しない。
- トップレベル関数（プライベート含む）を新規に定義しない。`main()` と `@pragma('vm:entry-point')` 付きのみ例外。
- `StatefulWidget` / `ConsumerStatefulWidget` を新規に導入しない。`HookWidget` / `HookConsumerWidget` を使う。
- Widget にメソッドやゲッターを定義しない。再利用しない Widget は private class として切り出す。
- 変数宣言と代入を分離しない。`final` による即時代入と switch 式を使う。
- 2 つ以上の引数を持つ関数・クラスは名前付き引数にする。
- ログは talker または `dart:developer` の `log()` を使う。`print()` は禁止。
- コミットメッセージは英語 1 単語の prefix + 日本語 1 行。1 コミット 30〜100 行程度の粒度。
- `dart format` に準拠する（CI 強制）。
- `git --no-pager` を使って差分を確認する。

### 検証コマンド

全体検証（最終確認用、約 2〜3 分）:

```bash
cd /workspace && mise exec -- dart run melos exec -c 1 -- dart analyze . --fatal-infos
```

パッケージ単位の検証（タスク中に使う）:

```bash
cd /workspace/app && mise exec -- dart analyze lib/feature/<name> --fatal-infos
```

テスト実行:

```bash
cd /workspace/app && mise exec -- flutter test test/feature/<name>
```

---

## File Structure

### 新規作成

- `tools/eqmonitor_lints_plugin/lib/src/lint_target_scope.dart` — 解析対象パス判定（テストコード除外）
- `tools/eqmonitor_lints_plugin/lib/src/top_level_function_exemption.dart` — トップレベル関数の許可判定
- `tools/eqmonitor_lints_plugin/test/lint_target_scope_test.dart`
- `tools/eqmonitor_lints_plugin/test/top_level_function_exemption_test.dart`
- `tools/eqmonitor_custom_lints/lib/src/lint_target_scope.dart` — 同上（別パッケージのため複製）
- `tools/eqmonitor_custom_lints/test/lint_target_scope_test.dart`
- `app/lib/core/util/nullable_value_requirement.dart` — `orFailBecause` extension
- `app/test/core/util/nullable_value_requirement_test.dart`

### 変更

- `tools/eqmonitor_lints_plugin/lib/rules/*.dart` — 6 ルール全てにスコープ判定を適用
- `tools/eqmonitor_custom_lints/lib/rules/avoid_direct_color_scheme.dart` — 同上
- `tools/eqmonitor_lints_plugin/pubspec.yaml` — `test` を dev_dependencies に追加
- `app/analysis_options.yaml` — 無効な `plugins:` ブロックを削除
- `.github/workflows/wc-check-dart-analyze.yaml` — plugin のテストジョブを追加
- `app/lib/**` — feature 単位の違反修正（Task 8 以降）
- `packages/seismicity_pmtiles/**` — 標準 lint の修正（Task 6, 7）

---

## Task 1: plugin のテスト基盤とスコープ判定を作る

**Files:**
- Create: `tools/eqmonitor_lints_plugin/lib/src/lint_target_scope.dart`
- Create: `tools/eqmonitor_lints_plugin/test/lint_target_scope_test.dart`
- Modify: `tools/eqmonitor_lints_plugin/pubspec.yaml`

**Interfaces:**
- Produces: `LintTargetScope.isExcluded({required String path}) -> bool`
  テストコードのパスなら `true` を返す。`tools/eqmonitor_custom_lints` からも同名で複製利用する。

- [ ] **Step 1: `test` パッケージを dev_dependency に追加**

```bash
cd /workspace/tools/eqmonitor_lints_plugin
mise exec -- dart pub add dev:test
```

Expected: `pubspec.yaml` に `dev_dependencies: test:` が入り、`pub get` が成功する。

- [ ] **Step 2: 失敗するテストを書く**

`tools/eqmonitor_lints_plugin/test/lint_target_scope_test.dart`:

```dart
import 'package:eqmonitor_lints_plugin/src/lint_target_scope.dart';
import 'package:test/test.dart';

void main() {
  group('LintTargetScope.isExcluded', () {
    test('test ディレクトリ配下は除外する', () {
      expect(
        LintTargetScope.isExcluded(path: '/repo/app/test/feature/eew/a_test.dart'),
        isTrue,
      );
    });

    test('integration_test 配下は除外する', () {
      expect(
        LintTargetScope.isExcluded(path: '/repo/app/integration_test/app_test.dart'),
        isTrue,
      );
    });

    test('test_driver 配下は除外する', () {
      expect(
        LintTargetScope.isExcluded(path: '/repo/app/test_driver/driver.dart'),
        isTrue,
      );
    });

    test('lib 配下は除外しない', () {
      expect(
        LintTargetScope.isExcluded(path: '/repo/app/lib/feature/eew/eew_page.dart'),
        isFalse,
      );
    });

    test('ファイル名やディレクトリ名の部分一致では除外しない', () {
      expect(
        LintTargetScope.isExcluded(path: '/repo/app/lib/core/util/latest_test_helper.dart'),
        isFalse,
      );
      expect(
        LintTargetScope.isExcluded(path: '/repo/app/lib/feature/contest/page.dart'),
        isFalse,
      );
    });

    test('Windows 形式の区切り文字でも除外する', () {
      expect(
        LintTargetScope.isExcluded(path: r'C:\repo\app\test\feature\a_test.dart'),
        isTrue,
      );
    });
  });
}
```

- [ ] **Step 3: テストが失敗することを確認**

```bash
cd /workspace/tools/eqmonitor_lints_plugin
mise exec -- dart test
```

Expected: FAIL。`lint_target_scope.dart` が存在しないため import エラー。

- [ ] **Step 4: 実装を書く**

`tools/eqmonitor_lints_plugin/lib/src/lint_target_scope.dart`:

```dart
/// 自作 lint ルールの適用対象を判定する。
///
/// テストコードは本番コードと設計上の要求が異なるため、
/// 自作ルールの適用対象外とする（標準 lint は従来どおり適用される）。
class LintTargetScope {
  const LintTargetScope._();

  static const _excludedDirectories = {
    'test',
    'integration_test',
    'test_driver',
  };

  static bool isExcluded({required String path}) {
    final segments = path.replaceAll(r'\', '/').split('/');
    return segments.any(_excludedDirectories.contains);
  }
}
```

- [ ] **Step 5: テストが通ることを確認**

```bash
cd /workspace/tools/eqmonitor_lints_plugin
mise exec -- dart test
```

Expected: PASS（6 テスト全て）。出力に警告が出ないこと。

- [ ] **Step 6: 自パッケージの解析を確認**

```bash
cd /workspace/tools/eqmonitor_lints_plugin
mise exec -- dart analyze . --fatal-infos
```

Expected: `No issues found!`

- [ ] **Step 7: コミット**

```bash
cd /workspace
git add tools/eqmonitor_lints_plugin
git commit -m "Feat: lint 適用対象からテストコードを除く判定を追加"
```

---

## Task 2: 全ルールにスコープ判定を適用する

**Files:**
- Modify: `tools/eqmonitor_lints_plugin/lib/rules/avoid_top_level_functions.dart`
- Modify: `tools/eqmonitor_lints_plugin/lib/rules/avoid_null_assertion_operator.dart`
- Modify: `tools/eqmonitor_lints_plugin/lib/rules/avoid_stateful_widget.dart`
- Modify: `tools/eqmonitor_lints_plugin/lib/rules/avoid_print_call.dart`
- Modify: `tools/eqmonitor_lints_plugin/lib/rules/avoid_eqmonitor_api_in_ui.dart`
- Modify: `tools/eqmonitor_lints_plugin/lib/rules/avoid_mixed_declaration_categories.dart`

**Interfaces:**
- Consumes: Task 1 の `LintTargetScope.isExcluded({required String path})`

各ルールの `registerNodeProcessors` は現在このような形をしている。

```dart
  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) => registry.addFunctionDeclaration(this, _Visitor(this));
```

`avoid_eqmonitor_api_in_ui.dart` だけは既にパス判定を持っており、こちらが取得方法の参考になる。

```dart
    final path = context.definingUnit.unit.declaredFragment?.source.fullName;
```

- [ ] **Step 1: `avoid_top_level_functions.dart` にスコープ判定を入れる**

```dart
  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    final path = context.definingUnit.unit.declaredFragment?.source.fullName;
    if (path != null && LintTargetScope.isExcluded(path: path)) {
      return;
    }
    registry.addFunctionDeclaration(this, _Visitor(this));
  }
```

`import 'package:eqmonitor_lints_plugin/src/lint_target_scope.dart';` を追加する。
既存の import は相対パス（`import 'rules/...'`）ではなく、ルールファイル間では
`package:` import を使う。`main.dart` の既存 import 形式に合わせること。

- [ ] **Step 2: 残り 5 ルールに同じ判定を入れる**

`avoid_null_assertion_operator.dart` / `avoid_stateful_widget.dart` /
`avoid_print_call.dart` / `avoid_mixed_declaration_categories.dart` に、
Step 1 と同じ早期 return を追加する。登録するビジターの種類だけが異なる。

`avoid_eqmonitor_api_in_ui.dart` は既存のパス判定に条件を足す。

```dart
    final path = context.definingUnit.unit.declaredFragment?.source.fullName;
    if (path == null ||
        LintTargetScope.isExcluded(path: path) ||
        !_isInUiLayer(path)) {
      return;
    }
    registry.addImportDirective(this, _Visitor(this));
```

- [ ] **Step 3: 解析とテストを実行**

```bash
cd /workspace/tools/eqmonitor_lints_plugin
mise exec -- dart analyze . --fatal-infos && mise exec -- dart test
```

Expected: `No issues found!` かつ全テスト PASS。

- [ ] **Step 4: app のテストコードで診断が消えたことを確認**

```bash
cd /workspace/app
mise exec -- dart analyze test --fatal-infos 2>&1 | tail -5
```

Expected: `avoid_top_level_functions` / `avoid_null_assertion_operator` /
`avoid_eqmonitor_api_in_ui` が 1 件も出ない。

**注意:** この時点で `app/analysis_options.yaml` の `plugins:` は
`plugins_in_inner_options` 警告により無視されており、実際に効いているのは
リポジトリルートの `analysis_options.yaml` である。効果が出ない場合は
リポジトリルートから `mise exec -- dart analyze app/test --fatal-infos` を試すこと。

- [ ] **Step 5: コミット**

```bash
cd /workspace
git add tools/eqmonitor_lints_plugin
git commit -m "Fix: 自作 lint ルールをテストコードに適用しないよう修正"
```

---

## Task 3: `main()` と `@pragma('vm:entry-point')` を許可する

**Files:**
- Create: `tools/eqmonitor_lints_plugin/lib/src/top_level_function_exemption.dart`
- Create: `tools/eqmonitor_lints_plugin/test/top_level_function_exemption_test.dart`
- Modify: `tools/eqmonitor_lints_plugin/lib/rules/avoid_top_level_functions.dart`

**Interfaces:**
- Consumes: Task 2 完了後の `avoid_top_level_functions.dart`
- Produces: `TopLevelFunctionExemption.isExempt({required FunctionDeclaration node}) -> bool`

現在 `avoid_top_level_functions.dart` の `_Visitor` は `@riverpod` / `@Riverpod` のみ
除外している。この判定を専用クラスへ移し、許可条件を 3 つに増やす。

1. 関数名が `main`
2. `@riverpod` / `@Riverpod` アノテーションが付いている
3. `@pragma('vm:entry-point')` が付いている（第 1 引数が文字列リテラル `'vm:entry-point'`）

`@pragma` 全般を許可してはいけない。`vm:prefer-inline` など無関係な pragma で
ルールを回避できてしまうため、第 1 引数の文字列リテラル値まで検査する。

- [ ] **Step 1: 失敗するテストを書く**

`tools/eqmonitor_lints_plugin/test/top_level_function_exemption_test.dart`:

```dart
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:eqmonitor_lints_plugin/src/top_level_function_exemption.dart';
import 'package:test/test.dart';

List<FunctionDeclaration> _declarationsOf(String source) {
  final unit = parseString(content: source, throwIfDiagnostics: false).unit;
  return unit.declarations.whereType<FunctionDeclaration>().toList();
}

void main() {
  group('TopLevelFunctionExemption.isExempt', () {
    test('main は許可する', () {
      final declarations = _declarationsOf('void main() {}');
      expect(
        TopLevelFunctionExemption.isExempt(node: declarations.single),
        isTrue,
      );
    });

    test('@riverpod は許可する', () {
      final declarations = _declarationsOf('@riverpod\nint foo(Ref ref) => 0;');
      expect(
        TopLevelFunctionExemption.isExempt(node: declarations.single),
        isTrue,
      );
    });

    test('@Riverpod(keepAlive: true) は許可する', () {
      final declarations = _declarationsOf(
        '@Riverpod(keepAlive: true)\nint foo(Ref ref) => 0;',
      );
      expect(
        TopLevelFunctionExemption.isExempt(node: declarations.single),
        isTrue,
      );
    });

    test("@pragma('vm:entry-point') は許可する", () {
      final declarations = _declarationsOf(
        "@pragma('vm:entry-point')\nvoid worker(SendPort port) {}",
      );
      expect(
        TopLevelFunctionExemption.isExempt(node: declarations.single),
        isTrue,
      );
    });

    test("@pragma('vm:prefer-inline') は許可しない", () {
      final declarations = _declarationsOf(
        "@pragma('vm:prefer-inline')\nvoid helper() {}",
      );
      expect(
        TopLevelFunctionExemption.isExempt(node: declarations.single),
        isFalse,
      );
    });

    test('引数のない @pragma は許可しない', () {
      final declarations = _declarationsOf('@pragma\nvoid helper() {}');
      expect(
        TopLevelFunctionExemption.isExempt(node: declarations.single),
        isFalse,
      );
    });

    test('素のトップレベル関数は許可しない', () {
      final declarations = _declarationsOf('void helper() {}');
      expect(
        TopLevelFunctionExemption.isExempt(node: declarations.single),
        isFalse,
      );
    });

    test('main という名前でもクラスのメソッドは対象外（トップレベルのみ判定）', () {
      final declarations = _declarationsOf('void mainHandler() {}');
      expect(
        TopLevelFunctionExemption.isExempt(node: declarations.single),
        isFalse,
      );
    });
  });
}
```

- [ ] **Step 2: テストが失敗することを確認**

```bash
cd /workspace/tools/eqmonitor_lints_plugin
mise exec -- dart test test/top_level_function_exemption_test.dart
```

Expected: FAIL。`top_level_function_exemption.dart` が存在しない。

- [ ] **Step 3: 実装を書く**

`tools/eqmonitor_lints_plugin/lib/src/top_level_function_exemption.dart`:

```dart
import 'package:analyzer/dart/ast/ast.dart';

/// トップレベル関数のうち、言語仕様・フレームワーク上その形でしか
/// 書けないものを [AvoidTopLevelFunctions] の対象外と判定する。
class TopLevelFunctionExemption {
  const TopLevelFunctionExemption._();

  static const _entryPointFunctionName = 'main';
  static const _riverpodAnnotationNames = {'riverpod', 'Riverpod'};
  static const _pragmaAnnotationName = 'pragma';
  static const _vmEntryPointPragma = 'vm:entry-point';

  static bool isExempt({required FunctionDeclaration node}) {
    if (node.name.lexeme == _entryPointFunctionName) {
      return true;
    }
    return node.metadata.any(_isExemptAnnotation);
  }

  static bool _isExemptAnnotation(Annotation annotation) {
    final name = annotation.name.name;
    if (_riverpodAnnotationNames.contains(name)) {
      return true;
    }
    if (name != _pragmaAnnotationName) {
      return false;
    }
    final firstArgument = annotation.arguments?.arguments.firstOrNull;
    return firstArgument is SimpleStringLiteral &&
        firstArgument.value == _vmEntryPointPragma;
  }
}
```

`firstOrNull` は `dart:collection` ではなく `package:collection` 由来ではないかを確認すること。
Dart 3 の `Iterable.firstOrNull` は `package:collection` の拡張である。
依存を増やしたくない場合は `annotation.arguments?.arguments` が空かどうかを
明示的に判定してから `first` を取る形にしてよい。

- [ ] **Step 4: ルール本体を書き換える**

`avoid_top_level_functions.dart` の `_Visitor` から `_hasRiverpodAnnotation` と
`_riverpodNames` を削除し、`TopLevelFunctionExemption` を使う。

```dart
  @override
  void visitFunctionDeclaration(FunctionDeclaration node) {
    if (node.parent is! CompilationUnit) {
      return;
    }
    if (TopLevelFunctionExemption.isExempt(node: node)) {
      return;
    }
    rule.reportAtToken(node.name);
  }
```

- [ ] **Step 5: テストと解析を実行**

```bash
cd /workspace/tools/eqmonitor_lints_plugin
mise exec -- dart test && mise exec -- dart analyze . --fatal-infos
```

Expected: 全テスト PASS、`No issues found!`

- [ ] **Step 6: app 側で `main()` の診断が消えたことを確認**

```bash
cd /workspace
mise exec -- dart analyze app/lib/main.dart --fatal-infos
```

Expected: `main` に対する `avoid_top_level_functions` が消え、
`_main` と `_registerNotificationChannelIfNeeded` の 2 件だけが残る。

```bash
mise exec -- dart analyze app/lib/feature/location/data/jma_map_isolate.dart --fatal-infos
```

Expected: `jmaMapWorkerEntryPoint` の診断が消える。

- [ ] **Step 7: コミット**

```bash
cd /workspace
git add tools/eqmonitor_lints_plugin
git commit -m "Fix: main と vm:entry-point をトップレベル関数禁止の対象外にする"
```

---

## Task 4: eqmonitor_custom_lints にもスコープ判定を適用する

**Files:**
- Create: `tools/eqmonitor_custom_lints/lib/src/lint_target_scope.dart`
- Create: `tools/eqmonitor_custom_lints/test/lint_target_scope_test.dart`
- Modify: `tools/eqmonitor_custom_lints/lib/rules/avoid_direct_color_scheme.dart`

**Interfaces:**
- Consumes: Task 1 で作った `LintTargetScope` と同一の仕様（別パッケージのため実装を複製する）

`tools/eqmonitor_custom_lints` は `tools/eqmonitor_lints_plugin` とは独立した
pub パッケージであり、相互に依存していない。共有パッケージを新設するのは
2 パッケージ・1 クラスに対して過剰なので、実装を複製する。

`avoid_direct_color_scheme.dart` は既に `_isAllowed(path)` によるパス判定を持つ。
そこに `LintTargetScope.isExcluded` を足す。

- [ ] **Step 1: テストを書く**

`tools/eqmonitor_custom_lints/test/lint_target_scope_test.dart` に、
Task 1 Step 2 と同じ 6 ケースを `package:eqmonitor_custom_lints/src/lint_target_scope.dart`
に対して書く。テスト本文は Task 1 Step 2 のコードをそのまま使い、import 先だけ変える。

- [ ] **Step 2: テストが失敗することを確認**

```bash
cd /workspace/tools/eqmonitor_custom_lints
mise exec -- dart pub get && mise exec -- dart test test/lint_target_scope_test.dart
```

Expected: FAIL（import 解決不可）。

- [ ] **Step 3: 実装をコピーする**

`tools/eqmonitor_custom_lints/lib/src/lint_target_scope.dart` に
Task 1 Step 4 と同一の `LintTargetScope` を作る。

- [ ] **Step 4: ルールに適用する**

`avoid_direct_color_scheme.dart` の `registerNodeProcessors` を次のようにする。

```dart
    final path = context.definingUnit.unit.declaredFragment?.source.fullName;
    if (path != null &&
        (LintTargetScope.isExcluded(path: path) || _isAllowed(path))) {
      return;
    }
```

既存の `_isAllowed` の意味と条件の順序を変えないこと。

- [ ] **Step 5: テストと解析を実行**

```bash
cd /workspace/tools/eqmonitor_custom_lints
mise exec -- dart test && mise exec -- dart analyze . --fatal-infos
```

Expected: 既存の `avoid_direct_color_scheme_test.dart` も含め全 PASS、`No issues found!`

- [ ] **Step 6: コミット**

```bash
cd /workspace
git add tools/eqmonitor_custom_lints
git commit -m "Fix: avoid_direct_color_scheme をテストコードに適用しないよう修正"
```

---

## Task 5: Analyzer 設定の重複を解消し CI にテストを追加する

**Files:**
- Modify: `app/analysis_options.yaml`
- Modify: `.github/workflows/wc-check-dart-analyze.yaml`

**Interfaces:**
- Consumes: Task 2〜4 で変更した plugin

`app/analysis_options.yaml` の `plugins:` ブロックは
`WARNING|STATIC_WARNING|PLUGINS_IN_INNER_OPTIONS|/workspace/app/analysis_options.yaml|23|3|428`
を出している。pub workspace のメンバーパッケージでは `plugins:` を宣言できず、
この 14 行は無視されている。実際に効いているのはリポジトリルートの
`analysis_options.yaml` の同名ブロックである。

- [ ] **Step 1: 削除前に plugin ルールが効いていることを記録する**

```bash
cd /workspace
mise exec -- dart analyze app/lib/core/component/chip --fatal-infos 2>&1 | tail -20
```

Expected: `avoid_null_assertion_operator` が複数件出る。この件数を控える。

- [ ] **Step 2: `app/analysis_options.yaml` から `plugins:` ブロックを削除**

22 行目の空行以降、`plugins:` からファイル末尾までを削除する。
`analyzer:` セクション（`errors:` と `exclude:`）は残す。

削除後の `app/analysis_options.yaml` は次のようになる。

```yaml
include: package:eqmonitor_lints/analysis_options.yaml
analyzer:
  errors:
    avoid_implementing_value_types: ignore
    avoid_print: ignore
    document_ignores: ignore
    invalid_annotation_target: ignore
    lines_longer_than_80_chars: ignore
    unnecessary_async: ignore
    unnecessary_cast: ignore
  exclude:
    - "**/DerivedData/**"
    - "**/build/**"
    - "build/**"
    - android/**
    - ios/**
    - web/**
    - windows/**
    - macos/**
    - linux/**
```

- [ ] **Step 3: plugin ルールが引き続き効くことを確認**

```bash
cd /workspace
mise exec -- dart analyze app/lib/core/component/chip --fatal-infos 2>&1 | tail -20
```

Expected: Step 1 と同じ `avoid_null_assertion_operator` の件数が出る。
`plugins_in_inner_options` の警告は消えている。

**もし plugin ルールが効かなくなった場合**は削除を取り消し、
代わりにルート `analysis_options.yaml` 側の重複を検討する。
この場合は BLOCKED として報告すること。どちらの設定が正なのかは
実測で決める必要があり、勝手にどちらかを消してはいけない。

- [ ] **Step 4: CI に plugin のテストジョブを追加**

`.github/workflows/wc-check-dart-analyze.yaml` の
`Test eqmonitor_custom_lints` ステップの直後に、同形のステップを追加する。

```yaml
      # tools/ は melos workspace 外のため `melos run test` の対象にならない。
      # ルール実装の回帰防止としてここで実行する。
      - name: Test eqmonitor_lints_plugin
        working-directory: tools/eqmonitor_lints_plugin
        run: |
          mise exec -- dart pub get
          mise exec -- dart test
```

- [ ] **Step 5: workflow の構文を検証**

```bash
cd /workspace
mise exec -- actionlint .github/workflows/wc-check-dart-analyze.yaml
```

Expected: 出力なし（エラーなし）。

- [ ] **Step 6: 全体の診断件数を計測して記録する**

```bash
cd /workspace
mise exec -- dart run melos exec -c 1 -- dart analyze . --format machine --fatal-infos > /tmp/analyze-after-phase-a.txt 2>&1
grep -c '^\(ERROR\|WARNING\|INFO\)|' /tmp/analyze-after-phase-a.txt
```

Expected: 716 件。1,512 件から 796 件（誤検出 4 + テスト 792）減り、
さらに設定重複 1 件が消えた計算になる。
件数が 716 から大きくずれる場合は、ずれた理由を報告に書くこと。

- [ ] **Step 7: コミット**

```bash
cd /workspace
git add app/analysis_options.yaml .github/workflows/wc-check-dart-analyze.yaml
git commit -m "Fix: app の無効な plugins 設定を削除し plugin テストを CI に追加"
```

---

## Task 6: seismicity_pmtiles の lib 配下の lint を解消する

**Files:**
- Modify: `packages/seismicity_pmtiles/lib/src/decoder/seismicity_chunk_builder.dart`（`prefer_initializing_formals` 2 件）
- Modify: `packages/seismicity_pmtiles/lib/src/decoder/seismicity_dataset_accumulator.dart`（`prefer_initializing_formals` 2 件）
- Modify: `packages/seismicity_pmtiles/lib/src/decoder/seismicity_decoder_worker_entry.dart`（`type_annotate_public_apis` 2 件）
- Modify: `packages/seismicity_pmtiles/lib/src/decoder/seismicity_pmtiles_decode_operation.dart`（`prefer_initializing_formals` 1 件）
- Modify: `packages/seismicity_pmtiles/lib/src/decoder/seismicity_pmtiles_decoder_runner.dart`（`library_private_types_in_public_api` 3 件、`type_init_formals` 1 件）
- Modify: `packages/seismicity_pmtiles/lib/src/reader/seismicity_pmtiles_network_random_access_reader.dart`（`prefer_initializing_formals` 3 件）

合計 14 件。

**Interfaces:**
- Produces: このパッケージの公開 API に変更を入れる場合、利用側（`app`）のビルドを壊さないこと。
  `library_private_types_in_public_api` の解消でプライベート型を公開する場合、
  型名の変更が `app/lib/feature/seismicity` に波及しないか確認する。

- [ ] **Step 1: 現状の診断を確認**

```bash
cd /workspace/packages/seismicity_pmtiles
mise exec -- dart analyze lib --fatal-infos
```

Expected: 14 件の INFO。ファイルと行番号を控える。

- [ ] **Step 2: 既存テストが通ることを確認（ベースライン）**

```bash
cd /workspace/packages/seismicity_pmtiles
mise exec -- dart test
```

Expected: 全 PASS。以降の修正でこの結果が変わらないこと。

- [ ] **Step 3: `prefer_initializing_formals` を修正（8 件）**

コンストラクタ本体での代入を初期化仮引数に置き換える。

```dart
// 修正前
class Foo {
  Foo({required int value}) : _value = value;
  final int _value;
}

// 修正後（フィールド名が引数名と同じにできる場合）
class Foo {
  Foo({required this.value});
  final int value;
}
```

プライベートフィールドのままにしたい場合は初期化仮引数にできないため、
その箇所は `// ignore: prefer_initializing_formals` ではなく、
フィールドを公開して `final` にするか、現状維持が妥当かを判断する。
判断に迷う場合は報告に書くこと。

- [ ] **Step 4: `type_annotate_public_apis` を修正（2 件）**

公開 API の引数・戻り値に明示的な型注釈を付ける。推論されている型を
`mise exec -- dart analyze` の出力と実装から確認して正確に書く。
`dynamic` を書いてはいけない。

- [ ] **Step 5: `library_private_types_in_public_api` と `type_init_formals` を修正（4 件）**

`seismicity_pmtiles_decoder_runner.dart` の公開 API がプライベート型を露出している。
プライベート型を公開型に格上げするか、公開 API のシグネチャを公開型に変える。
公開型に格上げする場合は `lib/seismicity_pmtiles.dart`（バレルファイル）の
export に追加が必要かを確認する。

- [ ] **Step 6: 解析とテストを実行**

```bash
cd /workspace/packages/seismicity_pmtiles
mise exec -- dart analyze lib --fatal-infos && mise exec -- dart test
```

Expected: `No issues found!` かつ Step 2 と同じテスト結果。

- [ ] **Step 7: 利用側のビルドが壊れていないことを確認**

```bash
cd /workspace/app
mise exec -- dart analyze lib/feature/seismicity --fatal-infos 2>&1 | grep -c 'error' || true
```

Expected: `error` が 0 件（plugin の warning は Task 8 以降で扱うため残ってよい）。

- [ ] **Step 8: コミット**

```bash
cd /workspace
git add packages/seismicity_pmtiles/lib
git commit -m "Fix: seismicity_pmtiles の lib 配下の lint を解消"
```

---

## Task 7: seismicity_pmtiles の test / benchmark 配下の lint を解消する

**Files:**
- Modify: `packages/seismicity_pmtiles/benchmark/**`（12 件）
- Modify: `packages/seismicity_pmtiles/test/**`（47 件）

内訳は次のとおり。

| コード | 件数 |
| --- | ---: |
| `avoid_types_on_closure_parameters` | 12 |
| `prefer_const_declarations` | 12 |
| `type_annotate_public_apis` | 9 |
| `unnecessary_import` | 4 |
| `prefer_const_constructors` | 4 |
| `lines_longer_than_80_chars` | 4 |
| `omit_local_variable_types` | 3 |
| `specify_nonobvious_property_types` | 3 |
| `avoid_redundant_argument_values` | 4 |
| `comment_references` | 1 |
| `avoid_catches_without_on_clauses` | 1 |
| `unnecessary_async` | 1 |
| `unnecessary_const` | 1 |

**Interfaces:**
- Consumes: Task 6 で変更した `lib` の公開 API

- [ ] **Step 1: 現状の診断一覧を取得**

```bash
cd /workspace/packages/seismicity_pmtiles
mise exec -- dart analyze test benchmark --fatal-infos
```

Expected: 59 件の INFO。

- [ ] **Step 2: ベースラインのテスト結果を記録**

```bash
cd /workspace/packages/seismicity_pmtiles
mise exec -- dart test
```

Expected: 全 PASS。

- [ ] **Step 3: 自動修正できるものを `dart fix` で処理する**

```bash
cd /workspace/packages/seismicity_pmtiles
mise exec -- dart fix --dry-run
```

出力を確認し、意図しない変更が含まれないことを確かめてから適用する。

```bash
mise exec -- dart fix --apply
```

`dart fix` は `prefer_const_declarations` / `prefer_const_constructors` /
`unnecessary_import` / `unnecessary_const` / `omit_local_variable_types` などを
自動修正できる。適用後に必ず差分を確認する。

```bash
cd /workspace && git --no-pager diff packages/seismicity_pmtiles
```

- [ ] **Step 4: 残りを手で修正する**

`avoid_catches_without_on_clauses`（`seismicity_pmtiles_decode_benchmark.dart`）は
catch する例外型を特定して `on` 句を付ける。何が飛んでくるか不明な場合、
握りつぶさずに `on Object catch (e, st)` として再送出するか、
ベンチマーク用途として妥当な扱いを選ぶ。

`lines_longer_than_80_chars` は改行位置を調整する。文字列リテラルの場合は
隣接文字列リテラルの連結で分割する。

`avoid_types_on_closure_parameters` はクロージャ引数の型注釈を外す。
外すと型推論が効かなくなる箇所では、外側の型を明示する。

- [ ] **Step 5: 解析・テスト・フォーマットを実行**

```bash
cd /workspace/packages/seismicity_pmtiles
mise exec -- dart format . && mise exec -- dart analyze . --fatal-infos && mise exec -- dart test
```

Expected: `No issues found!` かつ Step 2 と同じテスト結果。

- [ ] **Step 6: コミット**

```bash
cd /workspace
git add packages/seismicity_pmtiles
git commit -m "Fix: seismicity_pmtiles の test / benchmark の lint を解消"
```

---

## Task 8: `orFailBecause` extension を追加する

**Files:**
- Create: `app/lib/core/util/nullable_value_requirement.dart`
- Create: `app/test/core/util/nullable_value_requirement_test.dart`

**Interfaces:**
- Produces: `extension NullableValueRequirement<T extends Object> on T?` の
  `T orFailBecause(String because)`。Task 9 以降の `!` 除去で使う。

このタスクは Task 9 以降で使う道具を用意する。
**この extension は最後の手段**であり、Task 9 以降では次の順に検討する。

1. `?.` による null 伝播（受け手が null を許容する場合）
2. `if (x != null)` / パターンマッチによるフロー解析
3. 型を非 null にする構造変更
4. ドメイン上正しい既定値がある場合のみ `??`
5. 上記が全て不可能で、不変条件により非 null が保証される場合のみ `orFailBecause`

- [ ] **Step 1: 失敗するテストを書く**

`app/test/core/util/nullable_value_requirement_test.dart`:

```dart
import 'package:eqmonitor/core/util/nullable_value_requirement.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('orFailBecause', () {
    test('非 null の値はそのまま返す', () {
      const int? value = 42;
      expect(value.orFailBecause('テスト'), 42);
    });

    test('null の場合は理由を含む StateError を投げる', () {
      const String? value = null;
      expect(
        () => value.orFailBecause('直前に containsKey で存在を確認済み'),
        throwsA(
          isA<StateError>().having(
            (e) => e.message,
            'message',
            contains('直前に containsKey で存在を確認済み'),
          ),
        ),
      );
    });

    test('false や 0 は null ではないのでそのまま返す', () {
      const bool? falseValue = false;
      const int? zero = 0;
      expect(falseValue.orFailBecause('テスト'), isFalse);
      expect(zero.orFailBecause('テスト'), 0);
    });
  });
}
```

- [ ] **Step 2: テストが失敗することを確認**

```bash
cd /workspace/app
mise exec -- flutter test test/core/util/nullable_value_requirement_test.dart
```

Expected: FAIL（import 解決不可）。

- [ ] **Step 3: 実装を書く**

`app/lib/core/util/nullable_value_requirement.dart`:

```dart
/// 不変条件により非 null が保証される値を、理由付きで取り出す。
extension NullableValueRequirement<T extends Object> on T? {
  /// [because] には「なぜ非 null と言えるのか」を書く。
  ///
  /// 想定が破れた場合は理由付きの [StateError] となる。`!` の
  /// `Null check operator used on a null value` と違い、
  /// クラッシュログから前提条件を特定できる。
  ///
  /// `?.` によるnull 伝播・フロー解析・型の見直しで解決できる箇所では
  /// これを使わないこと。
  T orFailBecause(String because) {
    final value = this;
    if (value == null) {
      throw StateError('必ず非 null のはずの値が null でした: $because');
    }
    return value;
  }
}
```

- [ ] **Step 4: テストが通ることを確認**

```bash
cd /workspace/app
mise exec -- flutter test test/core/util/nullable_value_requirement_test.dart
```

Expected: 3 テスト PASS。

- [ ] **Step 5: 解析を確認**

```bash
cd /workspace/app
mise exec -- dart analyze lib/core/util/nullable_value_requirement.dart --fatal-infos
```

Expected: `No issues found!`

- [ ] **Step 6: コミット**

```bash
cd /workspace
git add app/lib/core/util/nullable_value_requirement.dart app/test/core/util/nullable_value_requirement_test.dart
git commit -m "Feat: 不変条件を明示して非 null 値を取り出す extension を追加"
```

---

## Task 9: UI 層の eqmonitor_api 直接参照を解消する

**Files:**
- Modify: `app/lib/feature/tsunami/**/ui/**`（10 件）
- Modify: `app/lib/feature/telegram_list/**/ui/**`（3 件）
- Modify: `app/lib/feature/home/**/ui/**`（2 件）
- Modify: `app/lib/feature/shake_detection/ui/**`（2 件）
- Modify: `app/lib/feature/changelog/ui/**`（1 件）
- Modify: `app/lib/feature/settings/**/ui/**`（1 件）
- Modify: `app/lib/feature/start/ui/**`（1 件）
- 対応する `data/model/` にドメイン型と変換 extension を追加

合計 20 件。

**Interfaces:**
- Consumes: Task 8 の `orFailBecause`（必要な場合のみ）
- Produces: 各 feature の `data/model/` に追加したドメイン型。
  Task 10 以降で同じ feature を触るタスクがこれらを参照する。

現在の違反ファイル一覧を取得する。

```bash
cd /workspace
mise exec -- dart analyze app/lib --fatal-infos 2>&1 | grep avoid_eqmonitor_api_in_ui
```

- [ ] **Step 1: 違反箇所を分類する**

各 import について、UI が API 型の何を使っているかを調べる。

- API 型をそのまま画面に表示している → `data/model/` にドメイン型を作り変換する
- API の enum だけ使っている → ドメイン側の enum に変換する
- 実は使われていない未使用 import → 削除する

分類結果を報告に書くこと。

- [ ] **Step 2: 未使用 import を削除する**

```bash
cd /workspace/app
mise exec -- dart fix --dry-run
```

`unused_import` として検出されるものがあれば適用する。

- [ ] **Step 3: ドメイン型への変換を実装する**

プロジェクト規約に従い、`data/model/` に型を置き、API 型は `as api` で
エイリアス import して変換 extension を書く。

```dart
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;

extension TsunamiWarningModelConverter on api.TsunamiWarning {
  TsunamiWarningModel toModel() => TsunamiWarningModel(...);
}
```

**新しい型を作る前に、既存の型に同じものがないか必ず検索すること。**
同じフィールド構成の型が別 feature にあれば、それを再利用する。

Freezed を使う場合は生成が必要である。

```bash
cd /workspace/app
mise exec -- dart run build_runner build --delete-conflicting-outputs
```

- [ ] **Step 4: 該当 feature のテストを実行**

```bash
cd /workspace/app
mise exec -- flutter test test/feature/tsunami test/feature/telegram_list test/feature/home test/feature/shake_detection
```

Expected: 全 PASS。

- [ ] **Step 5: 診断が消えたことを確認**

```bash
cd /workspace
mise exec -- dart analyze app/lib --fatal-infos 2>&1 | grep -c avoid_eqmonitor_api_in_ui || echo 0
```

Expected: `0`

- [ ] **Step 6: コミット**

feature 単位で分割してコミットする（1 コミット 30〜100 行）。

```bash
cd /workspace
git add app/lib/feature/tsunami
git commit -m "Refactor: 津波 UI から API 型への直接依存を除去"
```

---

## Task 10: freezed モデルの同居を解消する

**Files:**
- Modify: `app/lib/feature/tsunami/data/model/timeline/tsunami_timeline.dart`（6 件のうち複数）
- Modify: `app/lib/feature/map/features/icon/data/model/intensity_icon.dart`（3 件）
- Modify: `app/lib/core/provider/estimated_intensity/provider/estimated_intensity_provider.dart`（1 件）
- Modify: `app/lib/feature/notification/data/model/test_notification_delivery.dart`（1 件）
- Modify: `app/lib/feature/seismicity/data/logic/seismicity_depth_projection.dart`（1 件）
- Create: 分離先の新規ファイル（各 freezed モデルにつき 1 ファイル）

合計 12 件。

**Interfaces:**
- Produces: 分離した freezed モデルの新ファイル。import 元の修正が必要。

`avoid_mixed_declaration_categories` は「freezed モデルは他の class /
Riverpod プロバイダと同一ファイルに定義できない」というルールである。

- [ ] **Step 1: 違反箇所の一覧を取得**

```bash
cd /workspace
mise exec -- dart analyze app/lib --fatal-infos 2>&1 | grep avoid_mixed_declaration_categories
```

- [ ] **Step 2: freezed モデルを専用ファイルへ移す**

1 ファイル 1 モデルとし、ファイル名はモデル名の snake_case にする。
`part 'xxx.freezed.dart';` と `part 'xxx.g.dart';` の宣言も移す。

- [ ] **Step 3: コード生成をやり直す**

```bash
cd /workspace/app
mise exec -- dart run build_runner build --delete-conflicting-outputs
```

移動前のファイルに対応する `*.freezed.dart` / `*.g.dart` が
残っていないことを確認する（`--delete-conflicting-outputs` で削除される）。

- [ ] **Step 4: import を修正する**

```bash
cd /workspace/app
mise exec -- dart analyze lib --fatal-infos 2>&1 | grep -E 'undefined|uri_does_not_exist' || echo "import OK"
```

- [ ] **Step 5: テストを実行**

```bash
cd /workspace/app
mise exec -- flutter test test/feature/tsunami test/feature/map test/feature/seismicity test/core
```

Expected: 全 PASS。

- [ ] **Step 6: 診断が消えたことを確認**

```bash
cd /workspace
mise exec -- dart analyze app/lib --fatal-infos 2>&1 | grep -c avoid_mixed_declaration_categories || echo 0
```

Expected: `0`

- [ ] **Step 7: コミット**

```bash
cd /workspace
git add app/lib
git commit -m "Refactor: freezed モデルを専用ファイルへ分離"
```

---

## Task 11: StatefulWidget と ColorScheme 直接参照を解消する

**Files:**
- Modify: `app/lib/feature/home/ui/component/map/home_map_view.dart:160`
- Modify: `app/lib/feature/map/ui/map_operation_queue_scope.dart:37`
- Modify: `app/lib/feature/settings/features/display_settings/ui/theme/theme_editor_page.dart:260`
- Modify: `app/lib/feature/settings/features/notification_settings/ui/page/override_edit_page.dart:392`
- Modify: `app/lib/feature/start/ui/component/forced_update_dialog.dart:16`
- Modify: `app/lib/feature/tsunami/ui/components/tsunami_region_list.dart:200`
- Modify: `app/lib/feature/tsunami/ui/components/tsunami_warning_history_overlay.dart:8`
- Modify: `app/lib/feature/live_monitor/**`（`avoid_direct_color_scheme` 4 件）

合計 11 件（StatefulWidget 7 件 + ColorScheme 4 件）。

**Interfaces:**
- Consumes: `flutter_hooks` の `useState` / `useEffect` / `useAnimationController` など

- [ ] **Step 1: 各 StatefulWidget の State が何を持っているか調べる**

`initState` / `dispose` / `setState` の使われ方を確認し、
対応する hook に置き換える計画を立てる。

| State の要素 | 置き換え先 |
| --- | --- |
| `AnimationController` | `useAnimationController` |
| `TextEditingController` | `useTextEditingController` |
| `ScrollController` | `useScrollController` |
| ローカルな可変値 + `setState` | `useState` |
| `initState` / `dispose` | `useEffect`（cleanup を返す） |
| `TickerProviderStateMixin` | `useSingleTickerProvider` |

**`AnimationController` を含むものは慎重に扱うこと。** `vsync` の扱いを誤ると
アニメーションが動かなくなる。変換後に実際の描画で確認できない環境のため、
Widget テストで振る舞いを固定してから変換する。

- [ ] **Step 2: 変換前に振る舞いを固定する Widget テストを書く**

テストが無い Widget については、変換前の振る舞いを検証するテストを先に書く。
既にテストがある場合はそれを使う。

```bash
cd /workspace/app
mise exec -- flutter test test/feature/tsunami test/feature/home test/feature/settings test/feature/map
```

Expected: 変換前に全 PASS すること。

- [ ] **Step 3: `HookWidget` / `HookConsumerWidget` へ変換する**

- [ ] **Step 4: `avoid_direct_color_scheme` 4 件を修正する**

`Theme.of(context).colorScheme` を `context.designSystem.colorTheme` に置き換える。
対応する色が `colorTheme` に無い場合は、勝手に近い色で代用せず報告すること。

- [ ] **Step 5: テストと解析を実行**

```bash
cd /workspace/app
mise exec -- flutter test test/feature/tsunami test/feature/home test/feature/settings test/feature/map test/feature/live_monitor
cd /workspace
mise exec -- dart analyze app/lib --fatal-infos 2>&1 | grep -cE 'avoid_stateful_widget|avoid_direct_color_scheme' || echo 0
```

Expected: テスト全 PASS、診断 `0`。

- [ ] **Step 6: コミット**

```bash
cd /workspace
git add app/lib app/test
git commit -m "Refactor: StatefulWidget を Hook 化し ColorScheme 直接参照を除去"
```

---

## Task 12: core 配下のトップレベル関数と `!` を解消する

**Files:**
- Modify: `app/lib/core/provider/**`（33 件: top_level 17 / null_assertion 15 / mixed 1）
- Modify: `app/lib/core/component/**`（17 件: null_assertion 12 / top_level 5）
- Modify: `app/lib/core/theme/**`（12 件: top_level 6 / null_assertion 6）
- Modify: `app/lib/core/util/**`（11 件: top_level 11）
- Modify: `app/lib/core/designsystem/**`（3 件: null_assertion 3）
- Modify: `app/lib/core/hook/**`（2 件: top_level 2）
- Modify: `app/lib/main.dart`（2 件: `_main` と `_registerNotificationChannelIfNeeded`）

合計 80 件。

**Interfaces:**
- Consumes: Task 8 の `orFailBecause`
- Produces: 切り出した専用クラスと Riverpod プロバイダ。
  Task 13 以降が `core` のこれらを参照する可能性がある。

**注意:** `app/lib/core/provider/estimated_intensity/worker/estimated_intensity_isolate.dart` の
`_workerEntryPoint` は `@pragma('vm:entry-point')` 付きのため Task 3 で除外済みである。
この関数を移動してはならない。

**注意:** `app/lib/core/hook/use_*.dart` の `useXxx()` は flutter_hooks の
規約でトップレベル関数である必要がある。クラス化すると hooks が機能しない。

これらは **ルールの除外条件に足さず、抑制コメントで対応する**。
「`use` で始まる関数」を一律に許可すると、hooks と無関係な関数名でも
ルールを回避できてしまうため、除外条件には入れない。

- [ ] **Step 1: `core/hook` に抑制コメントを置く**

`app/lib/core/hook/use_map_operation_queue.dart:54` と
`app/lib/core/hook/use_sheet_controller.dart:5` の 2 件に、
理由コメント付きで抑制コメントを置く。

```dart
// flutter_hooks の Hook はトップレベル関数として定義する規約であり、
// クラスのメソッドにすると Hook の登録順序が壊れて動作しない。
// ignore: eqmonitor_lints_plugin/avoid_top_level_functions
MapOperationScheduler useMapOperationQueue() {
```

抑制コメントを置いた後、診断が消えることを確認する。

```bash
cd /workspace
mise exec -- dart analyze app/lib/core/hook --fatal-infos
```

Expected: `No issues found!`

抑制コメントが効かない場合は、ルール名の指定形式が違う可能性がある。
`// ignore: avoid_top_level_functions`（プラグイン名なし）も試し、
どちらが効くかを報告に書くこと。

- [ ] **Step 2: `core/util` のトップレベル関数をクラス化する（11 件）**

プロジェクト規約に従い、処理を行う専用クラスを別ファイルに切り出す。
Riverpod の DI が必要かどうかは、その関数が状態や他の依存を必要とするかで決める。
純粋な計算（`log10` など）は `static` を持つユーティリティクラスで十分である。

```dart
// 修正前（app/lib/core/util/xxx.dart）
double log10(double x) => math.log(x) / math.ln10;

// 修正後
class MathUtil {
  const MathUtil._();
  static double log10(double x) => math.log(x) / math.ln10;
}
```

- [ ] **Step 3: `core/provider` `core/theme` `core/component` のトップレベル関数を処理する**

`showXxxDialog` / `showXxxSheet` のような UI 操作を伴うものは、
プロジェクト規約の `data/flow/` または `ui/action/` の考え方に沿って
`XxxAction` クラスへ切り出し、Riverpod で DI する。
`ref` / `context` はコンストラクタではなくメソッド引数で受け取る。

- [ ] **Step 4: `!` を除去する（36 件）**

設計書の優先順位に従う。

1. `?.` で足りるか
2. `if (x != null)` で確定できるか
3. 型を非 null にできるか
4. ドメイン上正しい既定値があるか
5. 上記が全て不可なら `orFailBecause('理由')`

`orFailBecause` を使った箇所は、ファイル・行・理由を報告に列挙すること。

`app/lib/core/theme/migration/theme_migration.dart` の 6 件は
テーマ移行処理であり、`app/test/core/theme/migration/theme_migration_test.dart` に
15 件のテストがある。変換前後でこのテストが通ることを必ず確認する。

- [ ] **Step 5: `main.dart` の `_main` と `_registerNotificationChannelIfNeeded` を処理する**

`_main` は `main()` から呼ばれる初期化処理である。
`main()` 内にインライン展開するか、`AppBootstrap` のようなクラスに切り出す。
アプリの起動シーケンスであり壊すと全機能が動かなくなるため、
処理順序を一切変えないこと。

- [ ] **Step 6: テストと解析を実行**

```bash
cd /workspace/app
mise exec -- flutter test test/core
cd /workspace
mise exec -- dart analyze app/lib/core app/lib/main.dart --fatal-infos
```

Expected: テスト全 PASS、`No issues found!`

- [ ] **Step 7: コミット**

ディレクトリ単位で分割してコミットする。

```bash
cd /workspace
git add app/lib/core/util
git commit -m "Refactor: core/util のトップレベル関数をクラス化"
```

---

## Task 13: earthquake_history の data 層を解消する

**Files:**
- Modify: `app/lib/feature/earthquake_history/data/**`

`feature/earthquake_history` は 160 件（null_assertion 83 / top_level 77）と最大である。
このタスクでは `data/` 配下のみを扱う。

現状の内訳（実測）:

| ファイル | 件数 |
| --- | ---: |
| `data/model/debug/earthquake_vxse_debug_reducer.dart` | 32 |
| `data/notifier/earthquake_vxse_debug_editor_controller.dart` | 25 |
| その他 `data/` 配下 | 残り |

**Interfaces:**
- Consumes: Task 8 の `orFailBecause`
- Produces: 切り出したクラス。Task 14（ui 層）が参照する可能性がある。

- [ ] **Step 1: 対象一覧を取得**

```bash
cd /workspace
mise exec -- dart analyze app/lib/feature/earthquake_history/data --fatal-infos
```

- [ ] **Step 2: 既存テストのベースラインを取る**

```bash
cd /workspace/app
mise exec -- flutter test test/feature/earthquake_history
```

Expected: 全 PASS。件数を控える。

- [ ] **Step 3: トップレベル関数をクラス化する**

`earthquake_vxse_debug_reducer.dart` は reducer であり、
状態遷移ロジックがトップレベル関数に分かれている可能性が高い。
`EarthquakeVxseDebugReducer` クラスのメソッドとしてまとめる。

規約により**クラス内のプライベートメソッドも原則禁止**である。
ただし本タスクの主目的はトップレベル関数の解消であり、
プライベートメソッド化は診断を消すには十分である。
過剰な分割を避け、まずはトップレベル関数の解消に集中すること。

- [ ] **Step 4: `!` を除去する**

震源・震度・マグニチュードを扱うコードである。
**固定値フォールバックを絶対に入れないこと。** 値が無い場合は
`null` のまま扱うか、呼び出し元まで `null` を伝播させる。

- [ ] **Step 5: テストと解析を実行**

```bash
cd /workspace/app
mise exec -- flutter test test/feature/earthquake_history
cd /workspace
mise exec -- dart analyze app/lib/feature/earthquake_history/data --fatal-infos
```

Expected: Step 2 と同じテスト結果、`No issues found!`

- [ ] **Step 6: コミット**

```bash
cd /workspace
git add app/lib/feature/earthquake_history/data
git commit -m "Refactor: 地震履歴 data 層のトップレベル関数と null アサーションを解消"
```

---

## Task 14: earthquake_history の ui 層を解消する

**Files:**
- Modify: `app/lib/feature/earthquake_history/ui/**`

**Interfaces:**
- Consumes: Task 13 で切り出したクラス、Task 8 の `orFailBecause`

主な対象（実測）:

| ファイル | 件数 |
| --- | ---: |
| `ui/components/shindo_db_hypocenter_information_card.dart` | 16 |
| `ui/components/region_picker_map_page.dart` | 10 |
| `ui/components/earthquake_history_map_popup.dart` | 9 |
| `ui/components/modal/earthquake_vxse_debug_editor.dart` | 9 |

`theme.textTheme.titleSmall!` 系の `!` が多い。これらは
`style:` パラメータが `TextStyle?` を受け取るため `?.` で解決できる。

```dart
// 修正前
style: theme.textTheme.titleSmall!.copyWith(color: foo)

// 修正後
style: theme.textTheme.titleSmall?.copyWith(color: foo)
```

- [ ] **Step 1: 対象一覧を取得**

```bash
cd /workspace
mise exec -- dart analyze app/lib/feature/earthquake_history/ui --fatal-infos
```

- [ ] **Step 2: `?.` で解決できるものを先に処理する**

`style:` `child:` など null を受け付けるパラメータへの `!` を `?.` に変える。
1 件ずつ、受け手の型が nullable であることを確認してから変える。

- [ ] **Step 3: 残りの `!` を処理する**

`region_picker_map_page.dart:48` の `city!.property!.code` のような
連鎖は、フロー解析で解決する。

```dart
// 修正前
resolvedCode.value = city!.property!.code;

// 修正後
final property = city?.property;
if (property != null) {
  resolvedCode.value = property.code;
}
```

`null` の場合に何もしないのが正しいか、それとも別の扱いが必要かを
その場のロジックから判断すること。判断できない場合は報告する。

- [ ] **Step 4: トップレベル関数を処理する**

- [ ] **Step 5: テストと解析を実行**

```bash
cd /workspace/app
mise exec -- flutter test test/feature/earthquake_history
cd /workspace
mise exec -- dart analyze app/lib/feature/earthquake_history --fatal-infos
```

Expected: テスト全 PASS、`No issues found!`

- [ ] **Step 6: コミット**

```bash
cd /workspace
git add app/lib/feature/earthquake_history/ui
git commit -m "Refactor: 地震履歴 UI の null アサーションを解消"
```

---

## Task 15: settings feature を解消する

**Files:**
- Modify: `app/lib/feature/settings/**`（91 件: null_assertion 63 / top_level 25、StatefulWidget と API import は Task 9・11 で処理済み）

主な対象（実測）:

| ファイル | 件数 |
| --- | ---: |
| `children/config/debug/tsunami/tsunami_telegram_timeline_debug_page.dart` | 21 |
| `children/config/debug/jma_map/debug_jma_map_page.dart` | 16 |
| `children/config/debug/shared_preferences/debug_shared_preferences_page.dart` | 12 |

デバッグ画面が中心である。これらは開発者向け機能であり、
本番ユーザーには見えないが、コード品質基準は同じく適用する。

**Interfaces:**
- Consumes: Task 8 の `orFailBecause`

- [ ] **Step 1: 対象一覧を取得**

```bash
cd /workspace
mise exec -- dart analyze app/lib/feature/settings --fatal-infos
```

- [ ] **Step 2: ベースラインのテストを実行**

```bash
cd /workspace/app
mise exec -- flutter test test/feature/settings
```

- [ ] **Step 3: `!` を除去する（63 件）**

- [ ] **Step 4: トップレベル関数を処理する（25 件）**

- [ ] **Step 5: テストと解析を実行**

```bash
cd /workspace/app
mise exec -- flutter test test/feature/settings
cd /workspace
mise exec -- dart analyze app/lib/feature/settings --fatal-infos
```

Expected: テスト全 PASS、`No issues found!`

- [ ] **Step 6: コミット**

サブディレクトリ単位で分割してコミットする。

---

## Task 16: tsunami / eew feature を解消する

**Files:**
- Modify: `app/lib/feature/tsunami/**`（残り: null_assertion 44）
- Modify: `app/lib/feature/eew/**`（42 件: null_assertion 33 / top_level 9）

主な対象（実測）:

| ファイル | 件数 |
| --- | ---: |
| `tsunami/data/model/tracking/tracked_tsunami_timeline.dart` | 35 |
| `eew/ui/components/eew_table.dart` | 8 |

**津波警報と緊急地震速報を扱う、本アプリで最も生命に関わる領域である。**
振る舞いを 1 ミリも変えてはならない。

**Interfaces:**
- Consumes: Task 8 の `orFailBecause`、Task 9 で作った津波のドメイン型、Task 10 で分離したモデル

- [ ] **Step 1: ベースラインのテストを実行して件数を控える**

```bash
cd /workspace/app
mise exec -- flutter test test/feature/tsunami test/feature/eew
```

Expected: 全 PASS。テスト数を報告に記録する。

- [ ] **Step 2: `tracked_tsunami_timeline.dart` の 35 件を処理する**

このファイルは津波電文の時系列追跡であり、
`app/test/feature/tsunami/tracked_tsunami_timeline_test.dart` にテストがある。
1 箇所直すごとにテストを回すこと。

```bash
cd /workspace/app
mise exec -- flutter test test/feature/tsunami/tracked_tsunami_timeline_test.dart
```

- [ ] **Step 3: 残りの tsunami / eew の違反を処理する**

- [ ] **Step 4: テストと解析を実行**

```bash
cd /workspace/app
mise exec -- flutter test test/feature/tsunami test/feature/eew
cd /workspace
mise exec -- dart analyze app/lib/feature/tsunami app/lib/feature/eew --fatal-infos
```

Expected: Step 1 と同じテスト結果、`No issues found!`

- [ ] **Step 5: コミット**

```bash
cd /workspace
git add app/lib/feature/tsunami
git commit -m "Refactor: 津波電文追跡の null アサーションを解消"
```

---

## Task 17: home / map / live_monitor feature を解消する

**Files:**
- Modify: `app/lib/feature/home/**`（残り: null_assertion 23 / top_level 8）
- Modify: `app/lib/feature/map/**`（残り: top_level 12 / null_assertion 9）
- Modify: `app/lib/feature/live_monitor/**`（残り: top_level 25）

合計 77 件（Task 9〜11 で処理済みの分を除く）。

**Interfaces:**
- Consumes: Task 8 の `orFailBecause`、Task 10 で分離した `intensity_icon` のモデル

- [ ] **Step 1: 対象一覧を取得**

```bash
cd /workspace
mise exec -- dart analyze app/lib/feature/home app/lib/feature/map app/lib/feature/live_monitor --fatal-infos
```

- [ ] **Step 2: ベースラインのテストを実行**

```bash
cd /workspace/app
mise exec -- flutter test test/feature/home test/feature/map test/feature/live_monitor
```

- [ ] **Step 3: 違反を処理する**

`home/ui/component/map/layer/**` は MapLibre のレイヤー操作であり、
`_updateGeoJsonIfChanged` のような差分更新処理がトップレベル関数になっている。
レイヤーごとの専用クラスへ切り出す。地図描画は自動テストで検証しにくいため、
処理の順序と条件分岐を変えないこと。

- [ ] **Step 4: テストと解析を実行**

```bash
cd /workspace/app
mise exec -- flutter test test/feature/home test/feature/map test/feature/live_monitor
cd /workspace
mise exec -- dart analyze app/lib/feature/home app/lib/feature/map app/lib/feature/live_monitor --fatal-infos
```

Expected: テスト全 PASS、`No issues found!`

- [ ] **Step 5: コミット**

---

## Task 18: 残る feature をすべて解消する

**Files:**
- Modify: `app/lib/feature/nied/**`（14 件）
- Modify: `app/lib/feature/location/**`（12 件）
- Modify: `app/lib/feature/knet_waveform/**`（11 件）
- Modify: `app/lib/feature/devices/**`（9 件）
- Modify: `app/lib/feature/telegram_list/**`（残り 6 件）
- Modify: `app/lib/feature/onboarding/**`（8 件）
- Modify: `app/lib/feature/feed/**`（7 件）
- Modify: `app/lib/feature/intensity_history/**`（7 件）
- Modify: `app/lib/feature/seismicity/**`（残り 6 件）
- Modify: `app/lib/feature/kyoshin_monitor/**`（6 件）
- Modify: `app/lib/feature/parameter/**`（6 件）
- Modify: `app/lib/feature/qzss_dcr/**`（6 件）
- Modify: `app/lib/feature/asset_pack/**`（4 件）
- Modify: `app/lib/feature/eew_history/**`（3 件）
- Modify: `app/lib/feature/fnet_catalog/**`（2 件）
- Modify: `app/lib/feature/telemetry/**`（2 件）
- Modify: `app/lib/feature/ads/**`（1 件）
- Modify: `app/lib/feature/debug/**`（1 件）
- Modify: `app/lib/feature/shake_detection/**`（残り 1 件）

合計 112 件程度（先行タスクの結果により前後する）。

**注意:** `app/lib/feature/location/data/jma_map_isolate.dart` の
`jmaMapWorkerEntryPoint` は `@pragma('vm:entry-point')` 付きのため
Task 3 で除外済みである。移動してはならない。

**Interfaces:**
- Consumes: Task 8 の `orFailBecause`

- [ ] **Step 1: 残っている診断の全一覧を取得する**

```bash
cd /workspace
mise exec -- dart analyze app/lib --fatal-infos 2>&1 | tee /tmp/remaining.txt | tail -3
```

Task 9〜17 の結果次第で残件が変わるため、ここで実測する。

- [ ] **Step 2: ベースラインのテストを実行**

```bash
cd /workspace/app
mise exec -- flutter test
```

Expected: 全 PASS。テスト数を報告に記録する。

- [ ] **Step 3: feature ごとに処理する**

件数の多い順に処理し、feature 単位でコミットする。

- [ ] **Step 4: app 全体の解析が通ることを確認**

```bash
cd /workspace/app
mise exec -- dart analyze . --fatal-infos
```

Expected: `No issues found!`

- [ ] **Step 5: app の全テストを実行**

```bash
cd /workspace/app
mise exec -- flutter test
```

Expected: Step 2 と同じ結果。

- [ ] **Step 6: コミット**

---

## Task 19: 全体検証と知見の記録

**Files:**
- Create: `docs/knowledge/20260814_analyzer-plugin-scope-and-exemptions.md`

**Interfaces:**
- Consumes: Task 1〜18 の全変更

- [ ] **Step 1: 全パッケージの解析を実行**

```bash
cd /workspace
mise exec -- dart run melos exec -c 1 -- dart analyze . --fatal-infos
```

Expected: 全 28 パッケージが `SUCCESS`。

- [ ] **Step 2: 全パッケージのテストを実行**

```bash
cd /workspace
mise exec -- dart run melos run test
```

Expected: 全 PASS。

- [ ] **Step 3: plugin のテストを実行**

```bash
cd /workspace/tools/eqmonitor_lints_plugin && mise exec -- dart test
cd /workspace/tools/eqmonitor_custom_lints && mise exec -- dart test
```

Expected: 全 PASS。

- [ ] **Step 4: フォーマットを確認**

```bash
cd /workspace
mise exec -- dart format --output=none --set-exit-if-changed app packages tools
```

Expected: 差分なし。

- [ ] **Step 5: 知見を記録する**

`docs/knowledge/20260814_analyzer-plugin-scope-and-exemptions.md` に次を書く。

- 自作 analyzer plugin の適用範囲（テストコード除外）と、その判定を `LintTargetScope` で一元管理していること
- `avoid_top_level_functions` の許可条件 3 つ（`main` / `@riverpod` / `@pragma('vm:entry-point')`）と、`@pragma` を第 1 引数まで検査する理由
- `plugins:` は pub workspace のルートでのみ有効であること（`app/analysis_options.yaml` に置いても無視される）
- `tools/` 配下は melos workspace 外のため `melos run test` の対象外であり、CI に個別ジョブが必要なこと
- `orFailBecause` の使いどころと使ってはいけない場面
- Linux 環境で `mise install` する際、`swift` と `gcloud` の導入に失敗する場合は
  `MISE_DISABLE_TOOLS="swift,gcloud"` で回避できること

- [ ] **Step 6: コミット**

```bash
cd /workspace
git add docs/knowledge/20260814_analyzer-plugin-scope-and-exemptions.md
git commit -m "Docs: Analyzer plugin の適用範囲と除外条件の知見を記録"
```

---

## Self-Review

**1. Spec coverage**

| 設計書の要件 | 対応タスク |
| --- | --- |
| テストコードを plugin 対象外にする | Task 1, 2, 4 |
| `main()` を許可する | Task 3 |
| `@pragma('vm:entry-point')` を許可する | Task 3 |
| `@pragma` 全般は許可しない | Task 3 Step 1 のテストで担保 |
| plugin にテストを追加する | Task 1, 3, 4 |
| plugin を CI のテスト対象にする | Task 5 |
| Analyzer 設定の重複を解消する | Task 5 |
| `orFailBecause` を追加する | Task 8 |
| `!` 除去の優先順位を守る | Task 8 の記述 + Task 12〜18 |
| `seismicity_pmtiles` の 73 件 | Task 6, 7 |
| `app/lib` の 643 件 | Task 9〜18 |
| 全 28 パッケージ SUCCESS の確認 | Task 19 |
| 知見の記録 | Task 19 |

**2. Placeholder scan**

Task 18 の件数「112 件程度」は先行タスクの結果に依存するため、
Step 1 で実測する手順を置いた。これは placeholder ではなく計測手順である。

Task 12 の `core/hook` の扱いは 2 案を提示し、実装者に判断させず
NEEDS_CONTEXT で報告させる形にした。

**3. Type consistency**

- `LintTargetScope.isExcluded({required String path}) -> bool` は Task 1 で定義し、Task 2・4 で同じ名前・同じシグネチャで使う。
- `TopLevelFunctionExemption.isExempt({required FunctionDeclaration node}) -> bool` は Task 3 で定義し、同 Task 内で使う。
- `orFailBecause(String because) -> T` は Task 8 で定義し、Task 12〜18 で使う。

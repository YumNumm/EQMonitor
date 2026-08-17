# 自作 Analyzer plugin の適用範囲・除外条件と運用知見

Analyzer 診断 1,512 件をゼロ化した作業 (2026-08-14) で判明した知見。

## 自作 analyzer plugin は 2 つある

| パッケージ | ルール | 配置 |
| --- | --- | --- |
| `tools/eqmonitor_lints_plugin` | `avoid_top_level_functions` / `avoid_null_assertion_operator` / `avoid_stateful_widget` / `avoid_print` / `avoid_eqmonitor_api_in_ui` / `avoid_mixed_declaration_categories` | melos workspace 外 |
| `tools/eqmonitor_custom_lints` | `avoid_direct_color_scheme` | melos workspace 外 |

どちらも `analysis_server_plugin` を使う native analyzer plugin で、analyzer 13 を
独立して使うため melos workspace の外に置いている。

## plugin はパッケージルート指定時のみ動く（最重要）

`dart analyze` に**サブディレクトリやファイルを指定すると、自作 plugin のルールは
1 件も発火しない**。

```bash
# ダメ: plugin が動かず No issues found! と誤表示される
mise exec -- dart analyze app/lib/feature/settings --fatal-infos

# 正しい: パッケージルートを指定する
cd /workspace && mise exec -- dart analyze app --fatal-infos
```

実測で `dart analyze app` = 643 件、`dart analyze app/lib` = 0 件だった。
CI (`invertase/github-action-dart-analyzer`) は `working-directory: app` で
パッケージルートを解析するため正しく動く。ローカル検証で feature を絞りたいときは、
全体を解析してから `grep` で絞ること。

```bash
mise exec -- dart analyze app --format machine --fatal-infos > /tmp/a.txt 2>&1
grep 'lib/feature/settings' /tmp/a.txt
```

## `plugins:` は pub workspace のルートでのみ有効

メンバーパッケージ (`app/analysis_options.yaml` など) に `plugins:` を直接書くと
`plugins_in_inner_options` 警告が出て**無視される**。ただし警告が出ていても
plugin 自体は（ルート宣言があれば）動作している点に注意。

`app` に plugin を効かせるには、`app/analysis_options.yaml` で
`include: ../analysis_options.yaml` としてルートの宣言を引き継ぐ。
`exclude` は宣言元ファイルからの相対で解決されるため、app 配下の
ネイティブディレクトリ除外は app 側に残す必要がある。

`packages/*` には現状 plugin が適用されていない
（`docs/todo/400_analyzer-plugin-coverage-for-packages.md` 参照）。

## テストコードは自作ルールの対象外

テストは本番と設計要求が異なるため、自作ルールの対象外にした。判定は
`LintTargetScope.isExcluded({required String path})` に集約し、各ルールの
`registerNodeProcessors` 冒頭で早期 return する。除外対象は
`test` / `integration_test` / `test_driver` ディレクトリ（セグメント完全一致）。

`analysis_options.yaml` の `exclude` は使わない。標準 lint まで止まってしまうため。

## `avoid_top_level_functions` の許可条件

`TopLevelFunctionExemption.isExempt` が判定する。許可は次の 3 つのみ。

1. 関数名が `main`（Dart のエントリポイントは言語仕様上トップレベル関数のみ）
2. `@riverpod` / `@Riverpod` 付き（関数プロバイダは Riverpod の規定形式）
3. `@pragma('vm:entry-point')` 付き（VM が名前解決するため移動不可）

`@pragma` は**第 1 引数の文字列リテラルが厳密に `'vm:entry-point'` の場合のみ**許可する。
`@pragma` 全般を許可すると `vm:prefer-inline` などで回避できてしまう。

flutter_hooks の `useXxx()` はトップレベル関数である必要がある（クラス化すると
Hook の登録順序が壊れる）。これは除外条件に足さず、理由コメント付きの
`// ignore: eqmonitor_lints_plugin/avoid_top_level_functions` で対応する。
「`use` で始まる関数」を一律許可すると無関係な関数名で回避できるため。

## `!`（null アサーション）除去の優先順位

機械的置換は禁止。次の順で判断する。

1. `?.` による null 伝播（`style:` `child:` など受け手が null を許容する場合）
2. `if (x != null)` / パターンマッチ / `switch` 式によるフロー解析
3. 型を非 null にする構造変更
4. `??` フォールバック（**ドメイン上正しい既定値**の場合のみ。震度・マグニチュード・
   深さ・座標・警報種別・時刻・波形には既定値を入れない）
5. `orFailBecause('理由')`（不変条件により非 null が保証される場合の最終手段）

`orFailBecause` は `app/lib/core/util/nullable_value_requirement.dart` の extension。
`!` と失敗時の挙動（例外送出）は同じで、クラッシュログから前提条件を特定できる点だけが違う。
今回 643 件の `!` 除去で使用したのは 10 件程度で、大半は 1〜3 で解消できた。

## plugin のテストと CI

`tools/` は melos workspace 外のため `melos run test` の対象外。
回帰防止として `.github/workflows/wc-check-dart-analyze.yaml` に
`tools/eqmonitor_lints_plugin` と `tools/eqmonitor_custom_lints` の
`dart test` ジョブを個別に追加してある。

## Linux (Cloud Agent) での mise セットアップ

`mise install` は `swift` と `gcloud` の導入に失敗することがある
（`libncurses.so.6` 不足や asdf プラグインの不具合）。解析・テストには
どちらも不要なので、次で回避する。

```bash
export MISE_DISABLE_TOOLS="swift,gcloud"
mise exec -- dart --version
```

`flutter pub get`（`dart pub get` ではなく）で workspace 依存を解決する。
`app` 全体の `dart analyze` は約 60〜90 秒、`flutter test` は約 3 分かかる。

---
alwaysApply: true
---

# 自作 analyzer plugin (`eqmonitor_lints_plugin`) 利用時の注意点

Task 12（`app/lib/core` 配下のトップレベル関数と `!` を解消する）で判明した知見。

## 解析はパッケージのルートを指定して実行する

自作の analyzer plugin はパッケージルート（`app`）を解析対象に指定したときしか
正しく動かない。サブディレクトリやファイル単位で `dart analyze` を実行すると、
カスタムルールの診断が 0 件になり誤った成功判定になる。

```bash
cd /workspace
mise exec -- dart analyze app --format machine --fatal-infos > /tmp/check.txt
grep -c '^\(ERROR\|WARNING\|INFO\)|' /tmp/check.txt
```

## `avoid_top_level_functions` の抑制コメント形式

`// ignore: eqmonitor_lints_plugin/avoid_top_level_functions`
（プラグイン名を含むフルネーム）で抑制できる。flutter_hooks の `useXxx()` の
ような、規約上トップレベル関数である必要がある箇所（Hook 定義）でのみ、
理由コメントとセットで使用すること。「`use` で始まる関数を一律許可する」等の
ルール緩和は行わず、個別の `// ignore:` で対応する。

## `avoid_mixed_declaration_categories`（freezed モデルと他クラスの同居禁止）

`@freezed` なクラスと、それ以外の `class`（ユーティリティクラス・Riverpod
プロバイダなど）を同一ファイルに置くと `AVOID_MIXED_DECLARATION_CATEGORIES`
が発生する。freezed モデルのファイルにヘルパー関数をトップレベル関数として
書いていた既存コードをクラス化する際は、**同じファイルに置かず専用ファイルに
分離する**こと（例: `theme_color_set.dart` の `onColorForBackground` は
`theme/util/contrast_color_util.dart` の `ContrastColorUtil` へ分離した）。

## `avoid_null_assertion_operator` を解消する際の優先順位

1. `?.`（null 伝播）
2. `if (x != null)` によるフロー解析・パターンマッチ
3. ローカル変数への束縛や `required` 引数化などの構造変更
4. `??` によるドメイン上正しい既定値へのフォールバック
   （震度・マグニチュード・深さ・座標・警報種別・時刻には使わない）
5. `orFailBecause('理由')`（`core/util/nullable_value_requirement.dart`）
   — 不変条件で非 null が保証される場合のみ、機械的な置換にしない

`hypocenter?.magnitude != null` のように一部フィールドだけ null チェックして
残りは `!` で強制アクセスする既存コードは、チェック漏れによる潜在的な
ランタイムクラッシュを埋め込んでいることがある。`!` を除去する際は
「本当にそのフィールドも null チェック済みか」を必ず確認すること。

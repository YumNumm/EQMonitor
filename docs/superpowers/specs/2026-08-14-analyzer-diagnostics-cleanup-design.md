# Analyzer 診断ゼロ化 設計書

## 背景

`melos run analyze`（`dart analyze . --fatal-infos`）で **1,512 件** の診断が出ている。
Flutter 3.48.0-0.1.pre / Dart 3.14.0 (build 3.14.0-29.0.dev) で計測した実測値である。

重要な事実として **Analyzer の `ERROR` は 0 件**であり、内訳は次のとおり。

| 種別 | 件数 |
| --- | ---: |
| `WARNING`（自作 analyzer plugin 由来 + 設定不備） | 1,439 |
| `INFO`（標準 lint / hint） | 73 |

`--fatal-infos` を付けている以上、`INFO` も CI を落とすため修正対象に含める。

### 診断コード別の内訳（実測）

| コード | 提供元 | 件数 |
| --- | --- | ---: |
| `avoid_top_level_functions` | eqmonitor_lints_plugin | 814 |
| `avoid_null_assertion_operator` | eqmonitor_lints_plugin | 578 |
| `avoid_eqmonitor_api_in_ui` | eqmonitor_lints_plugin | 23 |
| `avoid_mixed_declaration_categories` | eqmonitor_lints_plugin | 12 |
| `avoid_stateful_widget` | eqmonitor_lints_plugin | 7 |
| `avoid_direct_color_scheme` | eqmonitor_custom_lints | 4 |
| 標準 lint / hint（15 種） | Dart SDK / yumemi_lints | 73 |
| `plugins_in_inner_options` | Dart SDK | 1 |

### パッケージ別の内訳（実測）

| パッケージ | 件数 |
| --- | ---: |
| `app` | 1,439 |
| `packages/seismicity_pmtiles` | 73 |
| その他 26 パッケージ | 0 |

生成ファイル（`*.g.dart` / `*.freezed.dart` / `*.mocks.dart`）由来の診断は **0 件**であり、
コード生成のやり直しでは 1 件も減らない。

## 問題の分析

### 1. plugin ルールの誤検出が全体の 52% を占める

`avoid_top_level_functions` の 814 件のうち **296 件が `main()`** である。
Dart のエントリポイントは言語仕様上トップレベル関数以外にあり得ず、
「専用クラスに切り出して Riverpod で DI する」という是正指示は適用不可能である。

同様に `@pragma('vm:entry-point')` を付けた Isolate ワーカーのエントリポイント（`app/lib` に 2 件）も、
VM がトップレベル関数として解決するため移動できない。

`avoid_eqmonitor_api_in_ui` はパスに `/ui/` を含むかだけで判定しており、
`app/test/**/ui/**` のテストコードにも 3 件発火している。

### 2. テストコードが plugin ルールの 55% を占める

plugin ルール 1,438 件のうち **792 件がテストコード**である。
テストのローカルヘルパー（`_earthquake({...})` のようなフィクスチャ生成関数）や、
「この値は必ず存在するはずで、なければテストを失敗させたい」箇所での `!` は、
本番コードとは要求が異なる。

### 3. Analyzer 設定の重複

`app/analysis_options.yaml` の `plugins:` ブロックが
`plugins_in_inner_options` 警告を出している。pub workspace のメンバーパッケージでは
`plugins:` を宣言できず、この設定は無視されている。
実際に発火しているのはリポジトリルートの `analysis_options.yaml` の宣言である。

## 方針

### 方針 1: plugin の適用範囲を正す（設定変更）

以下を **ルールの誤検出の修正**として扱い、抑制ではないことを明確にする。

| 除外対象 | 理由 |
| --- | --- |
| `main()` | Dart 言語仕様上、エントリポイントはトップレベル関数のみ |
| `@pragma('vm:entry-point')` 付き関数 | Dart VM が名前解決するため移動不可 |
| `@riverpod` / `@Riverpod` 付き関数（実装済み） | 関数プロバイダは Riverpod の規定形式 |
| テストコード全体 | 本番コードとテストで設計要求が異なる（利用者判断） |

テストコードの判定は `test/` `integration_test/` `test_driver/` ディレクトリ配下とする。
これは **自作 plugin のルールのみ**に適用し、標準 lint はテストにも従来どおり適用する。
`analysis_options.yaml` の `exclude` は使わない（標準解析まで止まってしまうため）。

`@pragma` は `vm:entry-point` に限定する。`@pragma` 全般を許可すると
`vm:prefer-inline` のような無関係な pragma でもルールを回避できてしまう。

この方針で **796 件**が解消する（誤検出 4 件 + テスト 792 件）。設定重複の修正で 1 件。

### 方針 2: 残る 716 件を実コードの修正で解消する

| 対象 | 件数 |
| --- | ---: |
| `app/lib` の plugin ルール違反 | 643 |
| `packages/seismicity_pmtiles` の標準 lint | 73 |

`app/lib` の 643 件は feature 単位で修正する。ルール単位ではなく feature 単位にするのは、
同一ファイルを複数タスクで繰り返し編集して衝突するのを避けるためである。

## `!` の除去方針（最重要）

578 件中 356 件が `app/lib` にある。機械的置換は禁止とし、次の優先順位で判断する。

1. **null 伝播で足りる場合は `?.` を使う**
   Flutter の `style:` `child:` などは `null` を受け付ける。
   `style: theme.textTheme.titleSmall!.copyWith(...)` は
   `style: theme.textTheme.titleSmall?.copyWith(...)` で等価かつ安全になる。

2. **フロー解析で非 null を確定させる**
   `if (x != null) { ... }` / パターンマッチ / `switch` 式で、
   コンパイラに非 null を証明させる。

3. **そもそも null になり得ない型に変える**
   ローカル変数への束縛、`required` 引数化、Freezed のモデル分割などで
   構造的に null を排除する。

4. **`??` によるフォールバックは、その値がドメイン上の正しい既定値である場合に限る**
   「とりあえず」の固定値フォールバックはプロジェクト規約で禁止されている。
   震度・マグニチュード・座標など、生命に関わる情報に既定値を入れてはならない。

5. **不変条件により非 null が保証される箇所は、その不変条件を明示して失敗させる**
   `map[key]!` のように「直前に `containsKey` を確認済み」といった箇所が該当する。
   この場合のみ後述の `orFailBecause` を使う。

### `orFailBecause` 拡張

上記 5 のために、`app/lib/core/util/` に extension を追加する。

```dart
extension NullableValueRequirement<T extends Object> on T? {
  /// 不変条件により非 null が保証される値を取り出す。
  ///
  /// [because] には「なぜ非 null と言えるのか」を書く。
  /// 想定が破れた場合は理由付きの [StateError] となり、`!` の
  /// `Null check operator used on a null value` より原因を特定しやすい。
  T orFailBecause(String because) {
    final value = this;
    if (value == null) {
      throw StateError('必ず非 null のはずの値が null でした: $because');
    }
    return value;
  }
}
```

`!` と失敗時の挙動（例外送出）は同じで、診断可能性のみが向上する。
そのため「`!` を `orFailBecause` に置換して回る」ことは目的ではない。
各タスクの実装者は使用箇所と理由を報告し、レビュアーが機械的置換になっていないか検査する。

## テスト方針

自作 analyzer plugin には現状テストが 1 件もない（`tools/eqmonitor_custom_lints` のみ 1 ルール分あり）。
plugin のルールは全パッケージの解析結果を左右するため、回帰防止のテストを入れる。

- ルールの判定ロジック（パス判定・アノテーション判定）は純粋な関数として切り出し、単体テストする
- `tools/eqmonitor_lints_plugin` を CI（`wc-check-dart-analyze.yaml`）のテスト対象に追加する
  （`tools/` は melos workspace 外のため `melos run test` では実行されない）

`app` 側のコード修正では、既存テストを回帰検知に使う。
`!` 除去やトップレベル関数のクラス化で振る舞いが変わっていないことを、
該当 feature のテストで確認する。テストが無い箇所を触る場合は、
振る舞いを固定するテストを先に書く。

## 検証方法

```bash
mise exec -- dart run melos exec -c 1 -- dart analyze . --fatal-infos
```

最終的に全 28 パッケージが `SUCCESS` になることをもって完了とする。

タスクごとの部分検証は対象パッケージのみで行う。

```bash
cd app && mise exec -- dart analyze lib/feature/<name> --fatal-infos
```

## 適用範囲外

- 生成ファイルの再生成（診断 0 件のため不要）
- `backend/`（TypeScript、本件の対象外）
- `packages/eqmonitor_lints` が include する `yumemi_lints` のルール選定変更
  （ルールを緩めて件数を減らすことはしない）

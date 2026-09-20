# 開発環境・worktree・静的解析

## 正本と初期化

- Flutter と同梱 Dart は `mise.toml` / `mise.lock`、依存解決は `pubspec.lock` を正本とする。
  過去の stable SDK や文書中の revision に切り替えて検証しない。
- Dart workspace は root `pubspec.yaml` の `app`、`packages/*`、map example、`tools/*`。
  root `package.json` は Markdown tooling 用で、private `backend` は別 submodule。
- Flutter Scene と `scene` は同じ `third_party/flutter_scene` 内の path 依存。
  revision の正本は submodule commit。hosted 版や別 revision に置き換えない。

リポジトリルートで次を実行する。新規 worktree でも submodule 初期化を先に行う。

```sh
mise install
git submodule update --init third_party/flutter_scene
mise exec -- dart pub get --enforce-lockfile
mise exec -- dart run melos bootstrap
mise exec -- flutter --version --machine
```

Scene 更新時は `git submodule status third_party/flutter_scene` と
`pubspec.lock` の `flutter_scene` / `scene` がともに submodule の path を指すことを確認する。
`scene` override の削除は必要 API が揃った revision で別途検証する。

## Linux・CI・Apple プラグインの準備

- Linux で mise 未導入なら公式インストーラで導入し、`$HOME/.local/bin` を PATH に追加する。
  リポジトリルートで `mise trust ./mise.toml`、`mise install flutter` を実行する。
  Flutter plugin は `mise.toml` の `YumNumm/mise-flutter` を使う。
- `mise exec` が不要なツールの解決で止まる場合は、対象を `MISE_DISABLE_TOOLS` で除外する。
  現行 `mise.toml` に Swift の pin はない。過去の Swift 導入失敗を現行の必須手順にしない。
  Flutter/Dart コマンドは引き続き `mise exec --` 経由で実行する。
- Flutter 不要の CI は使用ツールだけを指定する（例: `mise exec python -- python3 script.py`）。
  slim runner では不足ライブラリによるツール導入失敗とコマンド本体の失敗を分ける。
- Native Assets を含む Flutter test にはホストの C コンパイラも必要。
  Linux の `No compiler configured on host 'linux_x64'` は Clang の有無を確認する。
  Ubuntu/Debian では `sudo apt-get install -y clang` で導入できる。
- 未取得の platform artifact は `mise exec -- flutter precache --linux` など対象だけ取得する。
- iOS は `mise exec -- flutter config --enable-swift-package-manager` を有効にする。
  worktree の `rsync ... SourcePackages ... No such file or directory` は、実行する package 内で
  `mkdir -p build/ios/SourcePackages build/macos/SourcePackages` を実行して再試行する。

CI の Flutter ジョブで使う初期化 action は `.github/actions/init-flutter-scene-submodule`。
現行 workflow の `uses: $/.github/...` は正しい相対指定 `./.github/...` と異なるため、修正対象として TODO で追跡する。
checkout の `submodules: true` も `recursive` も private backend を取得するため、
通常の Flutter 解析・テストには指定しない。backend が必要な作業はその指示を別途読む。
再帰取得が本当に必要なら、GitHub App のインストール先とトークンの `repositories` に
全 private repository を含める。`Repository not found` はトークン範囲も確認する。

## 解析の実行単位と CI 注釈

```sh
# root から package 全体を解析する
mise exec -- dart analyze app --fatal-infos --format machine
mise exec -- dart run melos run analyze
# 自作ルールを変更した場合は tools/eqmonitor_lints_plugin 内で実行
mise exec -- dart test
```

- ファイル・サブディレクトリ指定では自作 plugin の診断が抜けることがある。
  package 全体の結果を保存してから必要箇所を絞り込み、終了コードも確認する。
- `plugins:` は workspace ルートの `analysis_options.yaml` に宣言する。
  `app/analysis_options.yaml` はそれを include する。内側の `plugins:` は無視される。
  `exclude` は宣言元からの相対パスなので、app の native 除外は app 側に置く。
- 現行の自作 plugin は `tools/eqmonitor_lints_plugin` で、workspace に含まれる。
  analysis server は全 plugin を合成 package で解決するため、workspace の analyzer override
  だけでなく `flutter_hooks_lint_plugin` と両立する plugin 側の依存制約も必要。
- `packages/eqmonitor_lints/lib/analysis_options.yaml` は空の共通 baseline、
  `lib/recommended.yaml` は明示採用する strict 設定。include 先を統合すると適用範囲が変わる。
  他 package の plugin 適用範囲はその `analysis_options.yaml` も確認する。
- CI は固定 SDK の `dart analyze` と `.github/problem-matchers/dart-analyzer.json` を使う。
  machine 出力は `SEVERITY|TYPE|CODE|FILE|LINE|COLUMN|LENGTH|MESSAGE`、FILE は絶対パス。
  SDK 更新時は実出力を確認し、`--fatal-infos` を維持する。注釈用の別 SDK や `checks: write` は不要。
- analysis server の送信失敗が原因なら `DASH__SUPPRESS_ANALYTICS=true` を指定する。
  plugin の setup error / `RangeError` は解析完了ではない。部分解析の成功だけで全体を合格にしない。

## 自作ルールの解消・移行

- テストの `test` / `integration_test` / `test_driver` 除外は `LintTargetScope` が担当する。
  標準 lint まで止まる `analysis_options.yaml` の全体除外で代用しない。
- トップレベル関数の自動許可は `main`、`@riverpod` / `@Riverpod`、
  第1引数が文字列リテラル `'vm:entry-point'` の `@pragma` のみ。
- カスタム Hook は理由付き `// ignore: eqmonitor_lints_plugin/avoid_top_level_functions`、
  または static メソッドにできる。Hook の動作条件は build 中の呼び出し順序・回数の維持であり、
  トップレベルであることではない。`use` 接頭辞だけの一律免除は追加しない。
- `@freezed` モデルと helper class / Provider は専用ファイルへ分離する。
  Provider は `@riverpod` から生成する。新しい Provider 型の検出は `ManualProviderDetection` も確認する。
- `!` は null 伝播、フロー解析、非 null 型への構造変更の順で除去する。
  地震の震度・規模・深さ・座標・種別・時刻・波形を架空の既定値で埋めない。
  `orFailBecause('理由')` は不変条件が保証される場合の最終手段で、機械的に置換しない。
- lint 移行は `mise exec -- dart fix --dry-run app` で確認し、
  `mise exec -- dart fix --apply --code=<diagnostic> app` で対象を限定する。
  変更ファイルだけ `mise exec -- dart format <paths>` で整形し、SDK 差による周辺差分も確認する。
- Primary Constructor の `final` はフィールド宣言になる。通常引数には付けず、
  private な名前付き引数を作らない。型・パターン・コメントを保ち、正規表現で一括移行しない。
  自動提案の条件は `PrimaryConstructorConvertibility` が正本（親クラスなし、唯一の const 無名
  コンストラクタ、初期化子・本体なし、引数は初期化子や late のない final field の `this.x`）。
  構文移行では解析に加え、app 内の `mise exec -- flutter build bundle --debug --no-pub`
  で CFE も通し、関連テストを実行する。

生成手順は [code_generation.md](code_generation.md)、テスト環境は [testing.md](testing.md) を参照。

# build_runner 生成差分の扱い

## ルール

`build_runner` 実行で生成された差分は、直接の実装タスク対象ファイル外であってもコミットに含めてよい。

## 背景

Riverpod / Freezed / go_router_builder などの生成は、対象の変更に加えて既存の未生成差分や生成器バージョン差分をまとめて反映することがある。
このプロジェクトでは、生成ファイルを手編集せず `build_runner` の結果として出た差分であれば、関連する生成結果として扱う。

## 注意

- `.g.dart` / `.freezed.dart` は直接編集しない。
- 生成差分が出た場合は、ソースとの整合を確認したうえで残す。
- Flutter / Dart コマンドは `mise exec --` 経由で実行する。

```bash
cd app
mise exec -- dart run build_runner build --delete-conflicting-outputs
```

## seismicity_pmtiles の末尾空白 workaround（2026-08-09）

現在 `pubspec.lock` で固定されている Freezed `3.2.6-dev.1` と build_runner
`2.16.0` の組み合わせでは、`seismicity_pmtiles_exception.freezed.dart` の
Network例外5型に、末尾空白だけを持つ行が10行生成される。build_runnerを再実行すると
この空白を再導入し、`dart format` は除去しないため、branch全体の
`git diff --check` が失敗する。

`.freezed.dart` の手動編集禁止は引き続き適用する。次の処理だけを例外として認める。
これは生成コードの意味を変更する編集ではなく、対象ファイルとNetwork例外5型の
生成区間を固定し、その区間の行末ASCII space / tabだけを自動除去する再現可能な
formatting workaroundである。glob、ファイル全体、repository全体へ拡張しては
ならない。

repository rootで、必ず「再生成 → 正規化 → 検証」の順に実行する。

```bash
(
  set -eu

  seismicity_generated_file='packages/seismicity_pmtiles/lib/src/model/seismicity_pmtiles_exception.freezed.dart'
  seismicity_normalization_dir=$(mktemp -d)

  (
    cd packages/seismicity_pmtiles
    mise exec -- dart run build_runner build --delete-conflicting-outputs
  )

  cp -- "$seismicity_generated_file" "$seismicity_normalization_dir/before.dart"
  perl -0pi -e 's{(class SeismicityPmTilesNetworkRequestFailedException\b.*?)(?=\nclass SeismicityPmTilesTileNotFoundException\b)}{my $block = $1; $block =~ s/[ \t]+$//mg; $block}gse' \
    "$seismicity_generated_file"

  git diff --no-index --exit-code --ignore-space-at-eol \
    "$seismicity_normalization_dir/before.dart" \
    "$seismicity_generated_file"
  rm -r -- "$seismicity_normalization_dir"

  git diff --check
  git --no-pager diff -- "$seismicity_generated_file"
  mise exec -- dart analyze packages/seismicity_pmtiles
  mise exec -- flutter test --no-pub packages/seismicity_pmtiles/test
)
```

`git diff --no-index --ignore-space-at-eol` が非0なら、正規化で末尾空白以外が
変化しているため停止する。続く通常のdiffでは、生成元変更に対応するsemantic diffと
末尾空白除去だけであることを確認する。`git diff --check`、analyze、testsが通るまで
生成物をcommitしない。生成元を変更していない再現確認では、正規化後に
`git diff --exit-code -- "$seismicity_generated_file"` も実行し、HEADとの差分が
完全に消えることを確認する。

Freezedまたはbuild_runnerを更新した場合は再現性を確認し、生成器が末尾空白を出さなく
なった時点でこのworkaroundを廃止する。

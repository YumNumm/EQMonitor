# Dart PMTiles の random access 公開API境界

## 結論

EQMonitor の `seismicity_pmtiles` は `pmtiles 2.2.0` の `src/` を import
せず、PMTiles v3 の必要最小限の strict reader を package 内で所有する。

必要な境界は次の3点である。

1. Network / File / Asset を同じ `SeismicityRandomAccessReader.readAt` へ
   統一する。
2. 指定 data zoom の非空 TileID を directory / leaf entry から列挙し、
   全 Hilbert 座標を総当たりしない。
3. archive の破損と caller の入力誤りを型付き例外で分離し、曖昧な
   fallback を行わない。

## `pmtiles 2.2.0` で利用できない境界

pub.dev で配布される `pmtiles 2.2.0` の `lib/pmtiles.dart` は
`archive.dart`、`exceptions.dart`、`header.dart`、`terrarium.dart`、
`tile.dart`、`types.dart`、`zxy.dart` を export する。一方、次の型や処理は
公開 barrel から export されない。

- `ReadAt`、`MemoryAt`、File / HTTP 実装: `lib/src/io.dart`
- `Directory` と `Entry`: `lib/src/directory.dart`
- root / leaf directory 全体を走査する非空 tile 列挙API

`PmTilesArchive.fromReadAt` 自体は `archive.dart` 内にあるが、引数型の
`ReadAt` は `src/io.dart` にあり、メソッドも `@visibleForTesting` である。
そのため独自の Dio Range reader を安定した公開APIだけで注入できない。
`root` から見える directory だけでは private な leaf load を含む全 tile
列挙も構成できない。

この変更は upstream の `2.1.0` changelog に「`src/io.dart` を public API
から削除」と明記されている。`2.0.0` の古い dartdoc には `ReadAt` が残るため、
検索結果や古いAPIページを根拠にしてはいけない。必ず対象versionの
[2.2.0 API reference](https://pub.dev/documentation/pmtiles/2.2.0/pmtiles/)
と [2.2.0 archive](https://pub.dev/api/archives/pmtiles-2.2.0.tar.gz) を確認する。

関連 source:

- [pmtiles-dart public barrel](https://github.com/bramp/pmtiles-dart/blob/main/packages/pmtiles/lib/pmtiles.dart)
- [pmtiles-dart changelog](https://github.com/bramp/pmtiles-dart/blob/main/packages/pmtiles/CHANGELOG.md)
- [PMTiles v3 specification](https://github.com/protomaps/PMTiles/blob/main/spec/v3/spec.md)

## `src/` import を採用しない理由

EQMonitor の package は `eqmonitor_lints/recommended.yaml` を使う。この規約が
有効にする `implementation_imports` は、別packageの `lib/src` を非公開実装と
して扱い、importを禁止する。Dart公式も `src` はpackage自身だけが使う領域で、
外部利用者は破壊的変更を受け得るとしている。

- [Dart `implementation_imports` rule](https://dart.dev/tools/linter-rules/implementation_imports)

lintを ignore して `package:pmtiles/src/io.dart` や
`package:pmtiles/src/directory.dart` に依存すると、まさに `2.1.0` のような
公開境界変更で壊れる。生命に関わる震源データ経路では採用しない。

## package 内 reader の責務

`seismicity_pmtiles` が所有する実装は汎用PMTiles libraryの再実装ではなく、
震源 archive に必要な範囲へ限定する。

- PMTiles v3 / MVT archive の127-byte headerを検証する
- root / leaf directory と TileID run を official spec どおり decodeする
- section bounds、zoom bounds、directory depth / ordering、clustered orderingを
  open時に厳密検証する
- `none` / `gzip` compressionだけを受理する
- Fileは必要rangeだけ、Assetは注入loaderで全体を1回、Networkは後続layerで
  Dioのstrict HTTP Rangeだけを使う
- tileは展開済みMVT bytesまでを返し、feature decodeは後続layerへ分離する

公開 barrel は Freezed 契約、immutable header / directory entry、reader、
factory、archive interfaceだけに限定する。decoder、validator、traversal、
TileID helper、File / Assetの具象readerはpackage内部に留める。

## 検証コマンド

repository root から、Flutter / Dart command は必ず `mise exec --` 経由で
実行する。

```sh
mise exec -- dart format packages/seismicity_pmtiles
mise exec -- dart analyze packages/seismicity_pmtiles --fatal-infos
mise exec -- dart test packages/seismicity_pmtiles/test
```

公開境界を変更する場合は `test/public_api_compile_test.dart` も更新し、利用側が
`package:seismicity_pmtiles/seismicity_pmtiles.dart` だけで必要な契約へ到達できる
ことを維持する。

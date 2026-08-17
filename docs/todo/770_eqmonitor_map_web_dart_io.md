# eqmonitor_map: web ターゲットで dart:io を排除する

## 背景

`BaseMapView` を含む `package:eqmonitor_map/eqmonitor_map.dart` を import すると、
`dart:io` が import chain に入り web コンパイルが失敗する。ただしこれは **本 PR
（#1591 remote reader）以前からの状態**である:

- `BaseMapTileRepository` は local source でも `PmTilesV3FileRandomAccessReader`
  （`packages/pmtiles_v3`、`dart:io` の `File`/`RandomAccessFile`）を使う。
- pmtiles_v3 の barrel はこの file reader を無条件 export しており、
  `BaseMapView → BaseMapTileRepository → pmtiles_v3` の chain で既に `dart:io` が入る。

本 PR で追加した `MapRemotePmTilesRandomAccessReader`（`dart:io HttpClient`）も
`dart:io` を足すが、**上記のとおり local 経路の file reader で既に web は壊れて
いる**ため、remote reader だけを条件付き import しても web が通るようにはならない
（false safety）。CI に web ビルドは無い。

## やること（web を正式サポートするなら）

1. `pmtiles_v3` の random-access reader を web 対応にする:
   - file reader を条件付き import（`dart.library.io`）にし、web では
     `dart:html`/`package:web` or `package:http` ベースの reader を使う。
2. `eqmonitor_map` 側:
   - `BaseMapTileRepository` が local/remote reader を条件付き import 経由で
     生成し、web では `MapRemotePmTilesRandomAccessReader`（dart:io）を stub に
     差し替える。
3. web ビルドを CI に追加して回帰を防ぐ。

## 判断

現状 web は shipping target ではない（CLAUDE.md は iOS/Android を明記、CI に web
ビルド無し）。web 対応は pmtiles_v3 の reader 設計を含む横断的な作業なので、
remote reader PR（#1591）の scope 外として本 todo に切り出す。

## 参照

- PR #1627 review（P1: "Isolate the dart:io reader from web imports"）
- `packages/pmtiles_v3/lib/src/reader/pmtiles_v3_file_random_access_reader.dart`
- `packages/eqmonitor_map/lib/src/tile/base_map_tile_repository.dart`

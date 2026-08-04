# Seismicity PMTiles Core Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use `superpowers:subagent-driven-development` to implement this plan task-by-task. Strict RED/GREEN TDD is not required, but every public contract and parser boundary below requires focused unit coverage before task review.

**Goal:** 純Dartの`seismicity_pmtiles` packageを作り、Freezed公開契約、File/Asset random access、PMTiles v3 header/directory/leafの厳密な読み込みと指定zoomの非空tile列挙を提供する。

**Architecture:** 全sourceを`SeismicityRandomAccessReader`へ統一し、PMTiles parserはそのreaderだけに依存する。公開データ契約はFreezed、内部parserはimmutableな小さな値だけを扱う。Network実装とMVT feature decodeは後続stackへ分離する。

**Tech Stack:** Dart 3.11+ / Freezed / json_serializable / crypto / test / eqmonitor_lints

---

### Task 1: Package scaffold and Freezed public contracts

**Files:**
- Create: `packages/seismicity_pmtiles/pubspec.yaml`
- Create: `packages/seismicity_pmtiles/analysis_options.yaml`
- Create: `packages/seismicity_pmtiles/lib/seismicity_pmtiles.dart`
- Create: `packages/seismicity_pmtiles/lib/src/model/seismicity_pmtiles_source.dart`
- Create: `packages/seismicity_pmtiles/lib/src/model/seismicity_pmtiles_archive_descriptor.dart`
- Create: `packages/seismicity_pmtiles/lib/src/model/seismicity_pmtiles_bounds.dart`
- Create: `packages/seismicity_pmtiles/lib/src/model/seismicity_pmtiles_load_state.dart`
- Create: `packages/seismicity_pmtiles/lib/src/model/seismicity_pmtiles_exception.dart`
- Create: `packages/seismicity_pmtiles/lib/src/model/seismicity_pmtiles_result.dart`
- Create generated `*.freezed.dart` and `*.g.dart` beside each JSON model
- Test: `packages/seismicity_pmtiles/test/model/public_contracts_test.dart`

**Public contracts:**

```dart
@freezed
sealed class SeismicityPmTilesSource with _$SeismicityPmTilesSource {
  const factory SeismicityPmTilesSource.network({required Uri archiveUri}) =
      SeismicityPmTilesNetworkSource;
  const factory SeismicityPmTilesSource.file({required String path}) =
      SeismicityPmTilesFileSource;
  const factory SeismicityPmTilesSource.asset({required String assetKey}) =
      SeismicityPmTilesAssetSource;
}

@freezed
abstract class SeismicityPmTilesArchiveDescriptor
    with _$SeismicityPmTilesArchiveDescriptor {
  const factory SeismicityPmTilesArchiveDescriptor({
    required SeismicityPmTilesSource source,
    required int schemaVersion,
    required int dataZoom,
    required int expectedSizeBytes,
    required int expectedFeatureCount,
    required String archiveRevision,
    required DateTime periodFrom,
    required DateTime periodTo,
  }) = _SeismicityPmTilesArchiveDescriptor;
}
```

`SeismicityPmTilesException`は`Exception`を実装するFreezed unionで、少なくとも`invalidDescriptor`、`invalidRange`、`corruptArchive`、`unsupportedCompression`、`unsupportedSource`、`sourceReadFailed`を持つ。`SeismicityPmTilesResult<T>`は`success`/`failure`、load stateは`idle`、`openingSource`、`readingDirectory`、`completed`、`failed`、`cancelled`を持つ。

- [ ] Minimal pubspecを作り、依存はpackageディレクトリで`mise exec -- flutter pub add ...`を使って追加する。
- [ ] JSON round-trip、3 source union、generic result、exception/load-state分岐をtestする。
- [ ] `mise exec -- dart run build_runner build --delete-conflicting-outputs`で生成する。
- [ ] `mise exec -- dart test test/model/public_contracts_test.dart`を通す。

### Task 2: Common reader, File, and Asset implementations

**Files:**
- Create: `packages/seismicity_pmtiles/lib/src/reader/seismicity_random_access_reader.dart`
- Create: `packages/seismicity_pmtiles/lib/src/reader/seismicity_range_validator.dart`
- Create: `packages/seismicity_pmtiles/lib/src/reader/file_random_access_reader.dart`
- Create: `packages/seismicity_pmtiles/lib/src/reader/asset_random_access_reader.dart`
- Create: `packages/seismicity_pmtiles/lib/src/reader/seismicity_pmtiles_asset_loader.dart`
- Create: `packages/seismicity_pmtiles/lib/src/reader/seismicity_random_access_reader_factory.dart`
- Test: `packages/seismicity_pmtiles/test/reader/file_random_access_reader_test.dart`
- Test: `packages/seismicity_pmtiles/test/reader/asset_random_access_reader_test.dart`
- Test: `packages/seismicity_pmtiles/test/reader/seismicity_random_access_reader_factory_test.dart`

**Reader boundary:**

```dart
typedef SeismicityPmTilesAssetLoader =
    Future<Uint8List> Function({required String assetKey});

abstract interface class SeismicityRandomAccessReader {
  int get sizeBytes;

  Future<Uint8List> readAt({required int offset, required int length});

  Future<void> close();
}
```

- [ ] 共通validatorで負offset、非正length、overflow、EOF超過を読み込み前に拒否する。
- [ ] Fileは1つの`RandomAccessFile`を所有し、並行readのposition競合を直列化する。exact length以外を失敗にする。
- [ ] Assetは注入loaderを1回だけ呼び、archive全体を保持してsliceする。Flutterをimportしない。
- [ ] factoryはNetwork sourceを後続PRまで`unsupportedSource`として明示的に返し、File/Assetへfallbackしない。
- [ ] temp file、並行read、範囲外、close後、loader一回、source分岐をtestする。

### Task 3: Strict PMTiles v3 header and directory traversal

**Files:**
- Create: `packages/seismicity_pmtiles/lib/src/archive/pmtiles_v3_header.dart`
- Create: `packages/seismicity_pmtiles/lib/src/archive/pmtiles_v3_header_decoder.dart`
- Create: `packages/seismicity_pmtiles/lib/src/archive/pmtiles_v3_compression_decoder.dart`
- Create: `packages/seismicity_pmtiles/lib/src/archive/pmtiles_v3_directory_entry.dart`
- Create: `packages/seismicity_pmtiles/lib/src/archive/pmtiles_v3_directory_decoder.dart`
- Create: `packages/seismicity_pmtiles/lib/src/archive/pmtiles_v3_tile_id.dart`
- Create: `packages/seismicity_pmtiles/lib/src/archive/seismicity_pmtiles_archive.dart`
- Test: `packages/seismicity_pmtiles/test/archive/pmtiles_v3_header_decoder_test.dart`
- Test: `packages/seismicity_pmtiles/test/archive/pmtiles_v3_directory_decoder_test.dart`
- Test: `packages/seismicity_pmtiles/test/archive/seismicity_pmtiles_archive_test.dart`
- Create: `packages/seismicity_pmtiles/test/support/pmtiles_v3_fixture_builder.dart`

**Archive boundary:**

`PmTilesV3Header`と`PmTilesV3DirectoryEntry`もFreezedで生成し、巨大listを持たないimmutable valueとして扱う。

```dart
abstract interface class SeismicityPmTilesArchive {
  PmTilesV3Header get header;

  Stream<int> occupiedTileIdsAtZoom({required int zoom});

  Future<Uint8List> readTile({required int tileId});

  Future<void> close();
}
```

- [ ] 127-byte headerをlittle-endianで解析し、magic/version、section bounds、tile type MVT、zoom range、descriptor size/dataZoomを検証する。
- [ ] PMTiles v3のunsigned varint、delta tile ID、run length、length、offset+1を仕様どおりdecodeする。
- [ ] rootとleafをreaderから必要範囲だけ取得し、section外参照、空directory、zero length、順序逆転、3段超過を拒否する。
- [ ] internal/tile compressionは`none`と`gzip`を実装し、brotli/zstd/unknownを明示的なunsupported errorにする。
- [ ] 指定zoomのtile ID範囲とentry runの交差だけを展開し、bbox全総当たりをしない。
- [ ] `readTile`はdirectory entryを解決し、tile data sectionからexact rangeを読む。同じcontentを指すrunを正しく扱う。
- [ ] fixture builderでroot-only、leaf、gzip、run length、corrupt boundsを生成してtestする。外部ネットワークfixtureへ依存しない。

### Task 4: Core verification and documentation

**Files:**
- Create: `packages/seismicity_pmtiles/README.md`
- Modify: `docs/knowledge/20260802_flutter_scene_large_static_instances.md` only if a cross-component invariant changed

- [ ] `mise exec -- dart format packages/seismicity_pmtiles`を実行する。
- [ ] `mise exec -- dart analyze packages/seismicity_pmtiles --fatal-infos`を通す。
- [ ] `mise exec -- dart test packages/seismicity_pmtiles/test`を通す。
- [ ] public barrelがpackage利用者に必要なFreezed契約、reader、archiveだけをexportし、内部decoder helperをexportしないことを確認する。
- [ ] READMEにNetworkは次stackであり、File/AssetのみがこのPRの完成範囲であることを明記する。

# seismicity_pmtiles

EQMonitor の震源カタログ向けに、PMTiles v3 archive を random access で読む
純 Dart package です。

この stack layer で完成している範囲は次のとおりです。

- File source を `RandomAccessFile` から必要な byte range だけ読む
- Asset source を注入された loader で一度読み込み、同じ random-access 契約で読む
- PMTiles v3 の header、root directory、leaf directory を厳密に検証する
- 指定 zoom の非空 TileID を列挙し、tile data を必要な range だけ読む
- internal compression と tile compression の `none` / `gzip` を展開する
- source、descriptor、状態、結果、例外を Freezed の公開契約として扱う

Network source の型は先に公開していますが、reader factory は現時点では
`unsupportedSource` を返します。Dio による HTTP Range Request、`206` /
`Content-Range` / strong ETag の検証、`If-Match`、LRU cache、cancel は次の
stack layer で実装します。Network archive 全体を download する fallback は
追加しません。

また、この package が返す tile は展開済みの MVT byte列です。MVT feature を
震源の列形式 buffer に decode する処理は後続 stack layer の責務であり、この
layer には含みません。

## 公開 API

利用側は `package:seismicity_pmtiles/seismicity_pmtiles.dart` だけを import
します。公開 barrel は Freezed 契約、header / directory entry の immutable
value、random-access reader 境界、reader factory、archive 境界だけを公開し、
File / Asset の具象 reader、header decoder、directory traversal などの実装
helper は公開しません。

```dart
import 'package:seismicity_pmtiles/seismicity_pmtiles.dart';

Future<SeismicityPmTilesArchive> openSeismicityArchive({
  required SeismicityPmTilesArchiveDescriptor descriptor,
  required SeismicityPmTilesAssetLoader assetLoader,
}) async {
  final factory = SeismicityRandomAccessReaderFactory(
    assetLoader: assetLoader,
  );
  final result = await factory.create(source: descriptor.source);
  final reader = switch (result) {
    SeismicityPmTilesSuccess(:final value) => value,
    SeismicityPmTilesFailure(:final exception) => throw exception,
  };
  return SeismicityPmTilesArchive.open(
    reader: reader,
    descriptor: descriptor,
  );
}
```

File source には `SeismicityPmTilesSource.file(path: ...)`、Asset source には
`SeismicityPmTilesSource.asset(assetKey: ...)` を descriptor に設定します。
`expectedSizeBytes` と `dataZoom` は manifest 由来の値を渡してください。
値が archive と一致しない場合は、固定値へ fallback せず型付き例外で失敗します。

`SeismicityPmTilesArchive` は渡された reader の所有権を引き継ぎます。利用後は
必ず `close()` してください。open 中に失敗した場合も reader は閉じられます。

## Source ごとの読み込み特性

| Source | この layer | 読み込み方式 |
|---|---|---|
| File | 対応済み | 必要 range のみ。並行 read は単一 file handle 上で直列化 |
| Asset | 対応済み | loader を1回呼び、archive 全体を memory に保持して slice |
| Network | 未実装 | 次の stack layer で Dio の strict Range Request を実装 |

Flutter Asset API は asset 内の byte range 読み込みを提供しないため、Asset
source に限って全体を memory に保持します。この挙動を Network source へ
流用してはいけません。

## Archive の制約

- PMTiles version 3、tile type MVT の archive のみを受理する
- header と各 section の範囲、root の先頭16 KiB制約、directory の順序と
  TileID range、最大3段の directory、clustered ordering を検証する
- compression は `none` と `gzip` のみ対応する
- `occupiedTileIdsAtZoom` は存在する entry / run だけを走査し、全座標を
  総当たりしない
- `readTile` は該当 tile data range の展開済み byte列を返す

形式上の根拠は
[PMTiles Version 3 Specification](https://github.com/protomaps/PMTiles/blob/main/spec/v3/spec.md)
です。

## 検証

repository root から実行します。

```sh
mise exec -- dart format packages/seismicity_pmtiles
mise exec -- dart analyze packages/seismicity_pmtiles --fatal-infos
mise exec -- dart test packages/seismicity_pmtiles/test
```

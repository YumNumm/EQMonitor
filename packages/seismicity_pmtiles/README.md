# seismicity_pmtiles

EQMonitor の震源カタログ向けに、PMTiles v3 archive を random access で読む
純 Dart package です。

この stack layer で完成している範囲は次のとおりです。

- File source を `RandomAccessFile` から必要な byte range だけ読む
- Asset source を注入された loader で一度読み込み、同じ random-access 契約で読む
- Network source を Dio の HTTP byte-range request だけで読む
- Network response の `206`、`Content-Range`、body length、strong ETag を
  厳密に検証する
- Network range を容量上限付き LRU で保持し、同一 range の未完了通信を共有する
- Network request の cancel と reader の close を型付き失敗として管理する
- PMTiles v3 の header、root directory、leaf directory を厳密に検証する
- 指定 zoom の非空 TileID を列挙し、tile data を必要な range だけ読む
- internal compression と tile compression の `none` / `gzip` を展開する
- source、descriptor、状態、結果、例外を Freezed の公開契約として扱う

Network source は最初に完全検証できた `206` response の strong ETag を固定し、
後続 request へ `If-Match` として渡します。Network archive 全体の download や
Asset loader への fallback は行いません。通信・protocol・世代変更・cancel・close
は固定値へ置き換えず、公開された型付き例外で失敗します。

また、この package が返す tile は展開済みの MVT byte列です。MVT feature を
震源の列形式 buffer に decode する処理は後続 stack layer の責務であり、この
layer には含みません。

## 公開 API

seismicity package の API は
`package:seismicity_pmtiles/seismicity_pmtiles.dart` の公開 barrel 経由で利用します。
HTTP client 型の `Dio` / `CancelToken` は `package:dio/dio.dart` から別途 import
します。公開 barrel は Freezed 契約、header / directory entry の immutable value、
random-access reader 境界、reader factory、archive 境界だけを公開し、File / Asset
の具象 reader、header decoder、directory traversal などの実装 helper は公開しません。

```dart
import 'package:dio/dio.dart';
import 'package:seismicity_pmtiles/seismicity_pmtiles.dart';

Future<SeismicityPmTilesArchive> openSeismicityArchive({
  required SeismicityPmTilesArchiveDescriptor descriptor,
  required SeismicityPmTilesAssetLoader assetLoader,
  required Dio dio,
  required int networkMaxCacheBytes,
  required CancelToken cancelToken,
}) async {
  final factory = SeismicityRandomAccessReaderFactory(
    assetLoader: assetLoader,
    dio: dio,
    networkMaxCacheBytes: networkMaxCacheBytes,
  );
  final result = await factory.create(
    descriptor: descriptor,
    cancelToken: cancelToken,
  );
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
`SeismicityPmTilesSource.asset(assetKey: ...)`、Network source には
`SeismicityPmTilesSource.network(archiveUri: ...)` を descriptor に設定します。
`expectedSizeBytes` と `dataZoom` は検証済み manifest 由来の値を渡してください。
値が archive と一致しない場合は、固定値へ fallback せず型付き例外で失敗します。

`dio` には利用側で timeout などを設定した instance を注入します。
`networkMaxCacheBytes` は正の aggregate byte budget、`cancelToken` はその時点で
未完了の Network request を止める caller signal です。Factory は descriptor が
選んだ source だけを生成し、Network failure 時に Asset loader を呼びません。

`SeismicityPmTilesArchive` は渡された reader の所有権を引き継ぎます。利用後は
必ず `close()` してください。open 中に失敗した場合も reader は閉じられます。

## Source ごとの読み込み特性

| Source | この layer | 読み込み方式 |
|---|---|---|
| File | 対応済み | 必要 range のみ。並行 read は単一 file handle 上で直列化 |
| Asset | 対応済み | loader を1回呼び、archive 全体を memory に保持して slice |
| Network | 対応済み | Dio の strict byte-range request。全体 download なし |

Flutter Asset API は asset 内の byte range 読み込みを提供しないため、Asset
source に限って全体を memory に保持します。この挙動を Network source へ
流用してはいけません。

## Network reader の契約

- request は `Range: bytes=start-end` を送り、世代固定後は同じ strong ETag を
  `If-Match` に設定する
- response は HTTP `206`、要求と一致する `Content-Range`、正確な body length、
  値がちょうど1個の strong ETag をすべて満たす場合だけ受理する
- 最初の ETag を archive identity として固定し、同じ archive URI・ETag・offset・
  length の byte列を aggregate budget 以下の LRU に保持する。budget より大きい
  response は返すが cache しない
- 同じ range の未完了 read は1つの通信を共有する。identity 確立前の異なる range
  は最初の request 完了後に固定済み ETag を利用する
- caller cancel はその時点の未完了通信だけを止め、cache と固定済み ETag は保持する。
  `close()` は未完了 read の終了を待ち、以後の read を終端失敗にする
- `412`、ETag の欠落・不正・0個・複数・変更は世代変更として reader を終端状態にし、
  LRU を消去して peer request を止める。その後は最初の同じ型付き失敗を再送出する
- transport failure、protocol failure、世代変更、cancel、close はそれぞれ
  `networkRequestFailed`、`invalidNetworkResponse`、`archiveChanged`、`cancelled`、
  `closed` の公開例外として返す

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

## Decoder（MVT → typed chunks）

Caller は adapter で `schemaVersion` / `dataZoom` / `archiveRevision` を含む
descriptor を完成させ、Factory / reader / `SeismicityPmTilesArchive.open` までを
所有してから decoder を起動します。opened archive は受け入れた
`archive.descriptor` を唯一の正とし、decoder は archive と `chunkCapacity` だけを
受け取ります。schema / data zoom の `1` / `14` や URL からの推測は行いません。

```dart
final operation = SeismicityPmTilesDecoder().start(
  archive: archive,
  chunkCapacity: chunkCapacity,
);
await for (final state in operation.states) {
  // openingSource / readingDirectory / decoding / completed / failed / cancelled
}
final result = await operation.result;
await operation.cancel(); // 任意。archive は decoder が閉じる
```

- schema v1 は 8 プロパティすべてを canonical 比較し、衝突は `duplicateConflict`
- 数値は finite Float32 スロット、NaN+validity は欠落、明示 0 は valid
- 同一境界コピーは geometry と全プロパティ一致時のみ dedupe
- worker は長寿命 isolate で `TransferableTypedData` を受け渡し、公開 facade は
  実 factory を既定利用する
- 公開結果は完全 dataset のみ。部分 dataset は返さない

2M 行 correctness harness:

```sh
mise exec -- dart run packages/seismicity_pmtiles/benchmark/seismicity_pmtiles_decode_benchmark.dart \
  --features 2000000 --features-per-tile 1000 --chunk-capacity 65536 \
  --informational-time-threshold-ms 60000
```

詳細は [`docs/knowledge/20260809_seismicity_pmtiles_decoder.md`](../../docs/knowledge/20260809_seismicity_pmtiles_decoder.md)。

## 検証

repository root から実行します。

```sh
mise exec -- dart format packages/seismicity_pmtiles
mise exec -- dart analyze packages/seismicity_pmtiles --fatal-infos
mise exec -- dart test packages/seismicity_pmtiles/test
```

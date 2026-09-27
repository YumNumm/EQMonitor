# PMTiles の取得・検証・デコード

確認日: 2026-09-21。対象は `packages/pmtiles_v3`、`packages/seismicity_pmtiles`、`packages/eqmonitor_map/lib/src/tile/`。
以下の契約と、将来の暗号学的検証・合計メモリ制御の課題は区別する。

## 入力と archive identity

- File / Network / Asset は random-access reader 境界で統一する。File は必要 range、Asset は注入 loader で全体を一度読み込む。
- 他パッケージの `lib/src` や `@visibleForTesting` API に依存しない。PMTiles v3 strict reader を所有し、127-byte header、section bounds、zoom、directory 深さ・順序、TileID run を検証する。
- 非空 tile は root/leaf directory から列挙し、全 Hilbert 座標を総当たりしない。対応 compression は所有する reader の契約で明示する。
- descriptor は caller が schema、data zoom、revision、件数、期間、source をすべて渡す。開いた archive の descriptor を唯一の identity とし、decoder で差し替えたり URL から推定したりしない。
- 推計震度の event-ID-only URL と content-addressed URL は別 bytes のことがある。API の immutable descriptor にある URL・size・SHA-256 を検証し、旧 URL へ fallback しない。
- MapLibre は maxzoom 超過の overzoom は行うが minzoom 未満の underzoom は行わない。ヘッダと実 tile を確認する。過去の legacy archive の minzoom 5 を現行配信すべての制約とみなさない。
- 推計震度のテーマ色は焼き込まれた `fill` でなく `name` の震度階級を使う。

## HTTP の境界

- MapLibre の source エラーは Flutter 側へ確実に戻らないため、追加前に `Range: bytes=0-127` の preflight を行う。206・Content-Range・PMTiles v3 magic を確認し、必要な先頭 bytes を読んだら stream を閉じる。200 への全体取得 fallback はしない。
- `eqmonitor_map` の remote reader は redirect を拒否し、`Accept-Encoding: identity`、206、範囲・実 body 長・total length の一致、strong ETag 等の一貫した validator を検証する。412 や snapshot drift は混在 bytes を破棄する。
- これをすべての reader の実装済み保証とみなさない。`seismicity_pmtiles` の request/identity validator は Range・If-Match・status・ETag を扱うが、同じ encoding 検証を実装したものではない。取得経路を変更するときは差を確認する。
- ヘッダ preflight、ETag による一貫性、whole-file SHA-256 は異なる保証。部分 range を whole-file digest へ暗号学的に結び付けたと説明しない。
- `MapRemotePmTilesRandomAccessReader` の per-chunk digest/attestation 対応は未完了。validator なしの代替を入れる場合も、上限付き full-stream と全件検証の契約を別途満たす必要がある。手動の archive identity 確認でも redirect を追わず、API descriptor の取得先を検証する。
- manifest の `query_revision` は矩形検索の全ページへ `expected_revision` として渡す。途中変更時は部分結果を出さず、manifest を一度更新して論理 archive ID を対応付け直し、先頭から再取得する。

## リソース上限と壊れた入力

- gzip は一括展開せず、encoded bytes は read/展開前、decoded bytes は chunk 蓄積前に制限する。directory entry 数は配列確保前に制限する。
- leaf cache は件数上限付き LRU。`PmTilesV3Limits` の上限は source owner が明示する。
- `resourceLimitExceeded` は `corruptArchive` と区別し、byte/entry の単位を残す。エラーへ URL・payload・codec の生ログを含めない。
- per-tile 上限だけで並列 decode・CPU/GPU cache の合計保持量を制御したことにしない。in-flight 数と aggregate byte budget の対応は改善課題。
- `dart_earcut` の成功は geometry の妥当性を保証しない。`FillMeshBuilder` が自己交差・穴の包含・外形の包含を検証する。hole 内の独立した島は許可する。
- 交差候補を X 範囲で絞り、同 ring の隣接辺を除外する。orientation と面積は安全な整数範囲を超える場合だけ BigInt を用いる。
- `maxIntersectionChecks` は tile 内の全 build で共有し、境界候補と包含検査の合計を制限する。limit、self-intersection、invalid topology を型付き例外で区別する。

## 震源データの publication

- schema v1 は `hypocenters` Point を layer extent に従い変換する。geometry と全 8 property を重複判定へ含め、競合を拒否する。
- depth/magnitude の欠測は NaN + validity clear、明示された 0 は valid として保持する。数値出力は有限 Float32 へ検証する。
- 空 `earthquake_event_id` は拒否する。空 `max_intensity`・`determination_flag` と欠落を区別する。震度辞書は型付き UTF-8 offsets/indexes/validity を使う。
- 全 chunk、件数合計、descriptor identity を検証してから complete dataset を公開する。間引き・部分 dataset・推定 schema/zoom は使わない。
- 常駐 worker と `TransferableTypedData` を使用する。成功・失敗・cancel で archive を閉じ、cancel は受信 port close と worker 終了を待つ。
- ベンチマークの時間・RSS・threshold は観測値。correctness-only の exit code を性能目標達成と混同しない。

## 確認

各パッケージのディレクトリで `mise exec -- dart test`（Flutter package は `mise exec -- flutter test --dart-define=CI=true`）を実行する。
公開境界を変えた場合は `public_api_compile_test.dart`、geometry は自己交差・fill・推計震度 decoder の既存テストも確認する。

関連: [MapLibre](maplibre.md) / [新レンダラ](map_renderer.md)

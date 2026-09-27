# 地図データ契約・メモリ・非同期処理

見出しの数値は統合前の優先度。実機性能・配信物の検証は未完了。

## 950: Seismicity manifest の descriptor 契約

- producer → OpenAPI → `packages/eqmonitor_api` 再生成 → app adapter の順で、`schema_version` / `data_zoom` / `archive_revision` を公開する。
- 対象: `backend/api/api/src/features/hypocenter/datasource/manifest-datasource.ts`、`packages/eqmonitor_api/lib/src/models/seismicity_manifest_layer.dart`、`app/lib/feature/seismicity/data/`、`packages/seismicity_pmtiles/`。backend の現行実装は別途照合する。
- 完了条件: 公開 manifest から完全な `SeismicityPmTilesArchiveDescriptor` を構築し、`archive.descriptor` を decoder へそのまま渡す契約テストが通る。schema/zoom の固定値や URL からの推測を入れず、identity/count 不一致では部分データを公開しない（#1591 / #1592 / #1601 / #1611）。

## 900: PMTiles 展開予算の実測・合計制限

- 対象: `packages/pmtiles_v3/`、`packages/eqmonitor_map/lib/src/tile/` と app の source 構築箇所。
- release 対象の base map / seismicity / estimated-intensity ごとに、root/leaf/tile の encoded/decoded bytes と directory entry 数の p50/p95/p99/max を計測する。
- 暫定値（directory 1/8 MiB、tile 4/16 MiB、directory 65536 entries、leaf cache 4件）を実測最大値＋安全率へ変更する。estimated source は独立した descriptor/header 契約の上限を持つ。
- 同時展開 byte の weighted permit を repository/scheduler 境界に追加し、cancel・世代更新・close でも返却する。
- 完了条件: production archive の fixture/CI 検証、上限超過で部分 tile を公開しないテスト、iOS 実機6並列 decode の peak RSS/memory pressure が端末予算内である記録。

## 845 / 840: 永続 decode worker・転送形式は計測後に判断

- 対象: `packages/eqmonitor_map/lib/src/tile/base_map_tile_decoder.dart`、`lib/src/renderer/base_map_packed_mesh.dart`（同 package）。
- 845: 低性能端末を含む pan/pinch・cover 総入れ替えの frame timing、decode throughput、isolate 起動時間を測る。問題がある場合だけ長命 worker を導入し、retire 時の待機呼び出し終了と generation token による stale 結果破棄をテストする。
- 840: 現行 decoder の実測コメントでは約112KB/tile の転送に packed payload / `TransferableTypedData` は不要。MB級 payload または永続 worker の実測でコピーが frame 予算を侵食した場合だけ再評価する。
- 導入時の完了条件: payload 全体と各 section/table の件数・byte を確保/転送前に検証し、超過は typed exception。不要なら計測結果を残して閉じる。

## 830: cover 変更時の in-flight cancel

- `packages/eqmonitor_map/lib/src/widget/base_map_view.dart` は scheduler の backpressure/priority/coalesce を配線済みだが、cover 外 decode の結果破棄を残す。
- `lib/src/tile/scheduler/map_tile_scheduler.dart` の `tilesToCancel` と `base_map_tile_cache.dart` の受入判定を接続する。世代全体を cancel するなら新 cover を再発行し、有効な decode まで無限に捨て直さない。tile 単位 cancel でもよい。
- 完了条件: production view のテストで並列上限、中心優先、world copy の重複排除、cover 外結果による現 cover の LRU eviction 防止を確認する。`Isolate.run` の実行途中停止と結果破棄は区別する。

## 815: remote Range の per-chunk attestation

- 対象: `packages/eqmonitor_map/lib/src/tile/remote/map_remote_pm_tiles_reader.dart` と #1592 の signed sidecar。
- whole-file SHA-256 は全件取得しない Range reader では照合しない。ETag 安定性だけでは内容の正当性を保証できないため、署名対象へ chunk digest または Merkle root/proof を追加し、検証済み source から reader に渡す。
- 完了条件: ETag 据え置き・内容差し替えを controlled server で拒否し、typed exception で fail closed。既存の「source.sha256 に束縛しない」negative test を新契約に置き換える。

## 810: retained CPU/GPU byte の合計上限

- 対象: `MapTilePipelineBudget`、`BaseMapTileGeometry`、`BaseMapTileCache`（`packages/eqmonitor_map/lib/src/`）。件数・転送量上限だけでは保持メモリを制限できない。
- 正値検証付きの明示的な retained byte budget と geometry byte 集計を追加し、件数と byte の両方で eviction を駆動する。pin 合計も上限内に収める。
- 完了条件: 大きい geometry の byte 超過による eviction、pin 保護と pin 予算超過の挙動を自動テストする。

## 750: 推計震度 PMTiles の低 zoom

- API descriptor が指す content-addressed archive を対象に、地震履歴・Live Monitor の低 zoom 表示を確認する。legacy URL の minzoom 5 と別 archive の minzoom 0 が観測されており、配信全体の生成不具合と断定しない。
- 完了条件: 現行配信の header・実 tile・両画面の結果を記録する。必要な範囲で欠ける場合だけ producer の minzoom を修正して対象イベントを再生成する。MapLibre は minzoom 未満を underzoom しない。

# 地図データ契約・メモリ・非同期処理

見出しの数値は統合前の優先度。実機性能・配信物の検証は未完了。

## 950: Seismicity manifest の descriptor 契約

- producer → OpenAPI → `packages/eqmonitor_api` 再生成 → app adapter の順で、`schema_version` / `data_zoom` / `archive_revision` を公開する。
- 対象: `backend/api/api/src/features/hypocenter/datasource/manifest-datasource.ts`、`packages/eqmonitor_api/lib/src/models/seismicity_manifest_layer.dart`、`app/lib/feature/seismicity/data/`、`packages/seismicity_pmtiles/`。backend の現行実装は別途照合する。
- 完了条件: 公開 manifest から完全な `SeismicityPmTilesArchiveDescriptor` を構築し、`archive.descriptor` を decoder へそのまま渡す契約テストが通る。schema/zoom の固定値や URL からの推測を入れず、identity/count 不一致では部分データを公開しない（#1591 / #1592 / #1601 / #1611）。

## 900: PMTiles 展開予算の実測・合計制限

- 対象: `packages/pmtiles_v3/`、`packages/seismicity_pmtiles/` と app の source 構築箇所。
- release 対象の base map / seismicity / estimated-intensity ごとに、root/leaf/tile の encoded/decoded bytes と directory entry 数の p50/p95/p99/max を計測する。
- 暫定値（directory 1/8 MiB、tile 4/16 MiB、directory 65536 entries、leaf cache 4件）を実測最大値＋安全率へ変更する。estimated source は独立した descriptor/header 契約の上限を持つ。
- 同時展開 byte の weighted permit を repository/scheduler 境界に追加し、cancel・世代更新・close でも返却する。
- 完了条件: production archive の fixture/CI 検証、上限超過で部分 tile を公開しないテスト、iOS 実機6並列 decode の peak RSS/memory pressure が端末予算内である記録。

## 750: 推計震度 PMTiles の低 zoom

- API descriptor が指す content-addressed archive を対象に、地震履歴・Live Monitor の低 zoom 表示を確認する。legacy URL の minzoom 5 と別 archive の minzoom 0 が観測されており、配信全体の生成不具合と断定しない。
- 完了条件: 現行配信の header・実 tile・両画面の結果を記録する。必要な範囲で欠ける場合だけ producer の minzoom を修正して対象イベントを再生成する。MapLibre は minzoom 未満を underzoom しない。

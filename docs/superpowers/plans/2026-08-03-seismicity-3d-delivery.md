# Seismicity 3D Stacked Delivery Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use `superpowers:subagent-driven-development` to implement each plan in order. Do not start a dependent stack layer until the previous layer has task review and focused verification.

**Goal:** 既存の全震源カタログとFlutter Scene基盤を再利用し、Network/File/Asset PMTilesから全震源を読み込んで深さ付き3D表示するStacked PR群を公開する。

**Architecture:** PMTiles v3のrandom accessとdecodeは純Dartの`seismicity_pmtiles`へ隔離する。描画は`eqmonitor_map`を3Dへ拡張し、Flutter Scene forkの永続instance buffer APIだけに依存する。アプリは既存manifest/archive選択をpackage descriptorへ変換し、既存2D画面を残したまま3Dページを追加する。

**Baseline:** Flutter master、`eqmonitor_map` Scene spike、`/v2/hypocenters/manifest`のアプリ型と2D表示は`develop`に導入済みであり、再実装しない。

## Resolved Decisions

- `pmtiles 2.2.0`の非公開`ReadAt`/directoryへ依存せず、必要最小限のPMTiles v3 readerを`seismicity_pmtiles`内に実装する。
- `depth_km`欠損はvalidity bitを保持し、実深度とは別の「深さ不明」専用平面へ専用styleで表示する。
- Network manifestは既存アプリrepositoryで取得し、独立packageはEQMonitor API型へ依存しない。
- 新規Widget testは作らず、package、camera、projector、buffer、stateのunit testをgateにする。

## Stack

| Order | Branch | Deliverable | Gate |
|---:|---|---|---|
| 1 | `codex/seismicity-flutter-scene-design` | 最新developに整合した設計と実装計画 | docs review |
| 2 | `codex/seismicity-backend-contract-pin` | Backend gitlinkを震源catalog契約を含む`0e520aa1`へ復旧 | OpenAPI/model parity |
| 3 | `codex/seismicity-pmtiles-core` | Freezed契約、File/Asset reader、PMTiles v3 header/directory | focused Dart tests |
| 4 | `codex/seismicity-pmtiles-network` | Dio Range、206/Content-Range、strong ETag、If-Match、LRU、cancel | mocked network tests |
| 5 | `codex/seismicity-pmtiles-decoder` | zoom 14非空tile列挙、MVT point列形式decode、Isolate転送 | archive/decoder tests |
| 6 | Flutter Scene fork PR | 永続packed billboard bufferとresource lifecycle API | fork tests/API review |
| 7 | `codex/seismicity-scene-foundation` | perspective/orbit camera、地上・地下phase、pin/provenance同期 | pure unit tests + compile |
| 8 | `codex/seismicity-static-renderer` | 点/球impostor、半透明地表、200万件benchmark harness | physical profile/release evidence |
| 9 | `codex/seismicity-3d-integration` | archive adapter、3D page、route、日本地図、loading/error/retry | focused app tests + analyze |

各EQMonitor branchは`gh stack add`で直前branchを親に登録する。各taskはimplementer、task reviewer、必要なfix loopを完了してからcommit/pushする。

## Blocking Gates

- `packages/eqmonitor_map/pubspec.yaml`はFlutter Scene `7f71993...`、README/evidence定数は`695c954...`で不一致。Scene foundationで依存APIを再監査し、同一SHAへ一括同期する。
- 200万件30fps、5分間memory安定、GPU resource retirementは物理iOS/Android profile/releaseでのみ合格判定する。Linuxの合成testだけで完了扱いにしない。
- Backend gitlink復旧後、現行PMTiles metadataと生成OpenAPIがアプリ側契約に一致することを確認する。
- 日本地図meshは既存`app/assets/jma_map.pb`から生成可能かをScene integration前に確認し、区域境界では不足する場合だけ海岸線assetを追加する。

## Component Plans

- [`2026-08-03-seismicity-backend-contract-pin.md`](2026-08-03-seismicity-backend-contract-pin.md)
- [`2026-08-03-seismicity-pmtiles-core.md`](2026-08-03-seismicity-pmtiles-core.md)
- Network、decoder、Flutter Scene fork、scene/integrationは各stack layer着手前に個別planを追加する。

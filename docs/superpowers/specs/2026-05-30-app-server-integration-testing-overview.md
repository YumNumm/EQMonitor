# アプリ⇔サーバ結合テスト基盤 — 全体設計（分割 overview）

- 日付: 2026-05-30
- ステータス: 分割合意済み（①→②→③→④ の順で個別 spec 化）
- 関連: 各層の詳細 spec を本ファイルからリンクする

## 背景・目的

EQMonitor は Flutter アプリ（`app/`・共有 `packages/`）と Cloudflare Workers バックエンド
（`backend/` submodule: Hono + Valibot + Durable Objects）で構成される。両者の結合品質を
継続的に担保したいが、現状は次の状態:

- backend 側には api-stub（本家と同型の全エンドポイント mock サーバ）と契約テスト
  （`contract.test.ts`）が存在する。
- アプリ側には `integration_test/` が無く、API 結合を検証するテストが存在しない。
- 既存テスト（38本）は `test` + `fake_async` のみ。mocktail / http_mock_adapter /
  integration_test / patrol は不使用。手書き Fake + `ProviderContainer.overrideWith` が流儀。

ユーザーが結合テストで担保したいのは次の4点（すべて対象）:

1. スキーマの drift 検出（backend の API 変更にアプリが追従できているか）
2. アプリの挙動検証（real なレスポンス/エラー/シナリオで正しくパース・表示・遷移するか）
3. リアルタイム経路（EEW 等の WS/DO 経由 push をアプリが受信・表示できるか）
4. 回帰の安全網（デプロイ前に壊れていないことを CI で担保）

## 確定済みの制約・事実（裏取り済み）

- **CI が2世界に分断**:
  - app: GitHub-hosted `ubuntu-24.04` で `melos exec -- flutter test`（ユニット/widget のみ）。
    Node/pnpm なし・エミュレータ起動なし・integration_test 土壌なし。
  - backend: self-hosted `eqmonitor-backend-runner` で `pnpm test`（vitest）。Node/pnpm あり。
- **baseUrl 注入が綺麗**:
  `env(.env.dev REST_API_URL) → buildConfigProvider → telegramUrlProvider(restApiUrl/wsApiUrl)
  → dioProvider → apiClientProvider` の一本道。テストでは `dioProvider.overrideWith` で stub に
  向けられる。`telegramUrlProvider` は REST と WS の両 URL を握る。
- **api-stub は REST のみ**: `ticket` / `ingest` / WS は未実装（`backend/api/api-stub/src/`）。
  リアルタイム結合には WS stub の新規実装が必要。
- **realtime-do は WS 完全実装**: connect/auth(ticket,HMAC)/ingest/broadcast 済み。ただし
  WS フローの結合テストは未実装（Miniflare / vitest-pool-workers が必要）。
- **openapi.json に example payload は実質無い**（443 schema, examples は7個のみ）。
  drift テストの共有フィクスチャ源は stub の `DEFAULT_MOCKS`（Valibot 検証済み）が適切。
- **api-stub に Dockerfile あり** → Layer 2 で stub を CI service container として起動でき、
  app CI に Node/pnpm を入れずに済む選択肢がある。

## テストピラミッドと分割

```
        ┌─────────────────────────────────┐
 Spec④  │ Realtime  WS/DO push → アプリ表示 │  最重・WS stub 新規実装が前提
        ├─────────────────────────────────┤
 Spec③  │ アプリ↔stub  UI×シナリオ(widget)  │  中〜大・エミュレータ不要の widget test
        ├─────────────────────────────────┤
 Spec②  │ Dartクライアント↔stub            │  中・stub を CI で起動（Docker service）
        ├─────────────────────────────────┤
 Spec①  │ 契約/drift  DEFAULT_MOCKS↔Freezed │  最小・純Dart・既存CIで完結  ★1本目
        └─────────────────────────────────┘
```

### ビルド順とその理由

合意順 **①→②→③→④**。最大の制約である CI 分断を踏まえ、新規インフラ0で毎PRに効く
ドリフト網（①）を先に確立し、その後「stub を CI でどう起動するか（②）」という難所、
UI シナリオ（③）、最後に最もインフラの重いリアルタイム（④）へ進む。

> リアルタイム（④）は価値が最も高い一方、api-stub への WS stub 新規実装が前提で
> 最もインフラが重いため最後に置く。優先度を上げたい場合は順序を再調整する。

## 各 Spec の責務（サマリ）

| Spec | 層 | 検証対象 | 実行環境 | 新規インフラ | 詳細設計 |
|------|----|----------|----------|--------------|----------|
| ① | L1 契約/drift | stub `DEFAULT_MOCKS`(JSON) を Dart Freezed でパース | 既存 app CI（純Dart） | なし | [spec1](./2026-05-30-spec1-contract-drift-test-design.md) |
| ② | L2 client↔stub | Retrofit クライアント → 起動中 api-stub。デシリアライズ・error preset・fixture | 新CIジョブ（Docker service で stub） | stub 起動 | （①完了後に作成） |
| ③ | L3 app↔stub | `overrideWith` で stub に向け widget test。Admin API でシナリオ切替 | app CI（widget test） | なし | （②完了後に作成） |
| ④ | L4 realtime | (4a) realtime-do WS フロー（Miniflare）/ (4b) api-stub WS stub + app WS 受信 | backend CI + app CI | WS stub 新規実装 | （③完了後に作成） |

## 進め方

各 spec は **spec → 実装計画(writing-plans) → 実装 → レビュー** のサイクルを個別に回す。
本 overview は分割の地図であり、各層の詳細は個別 spec に委ねる。

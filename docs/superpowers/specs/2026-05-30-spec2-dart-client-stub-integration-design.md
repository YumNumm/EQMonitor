# Spec ② Dartクライアント↔stub 結合テスト — 詳細設計

- 日付: 2026-05-30
- 層: L2
- 親: [app-server-integration-testing-overview](./2026-05-30-app-server-integration-testing-overview.md)
- ステータス: 設計（ユーザーレビュー待ち）
- 前提: Spec ①（契約/drift）完了。fixtures エクスポータ・api-stub を流用。

## 目的

`packages/eqmonitor_api` の Dio + Retrofit クライアントを**起動中の api-stub に実際に HTTP で当て**、
次を検証する（Spec ① の「JSON→モデル」より一段リアル）:

1. **実 HTTP 経由のデシリアライズ**: Dio → Retrofit → Freezed の往復が成立する。
2. **エラー処理**: stub を error モードにすると、クライアントが期待どおり `DioException`（適切な
   status）を投げる。
3. **クエリ/パスパラメータ**: ページング・statuses・パスパラメータが正しく組み立てられる。

Spec ① が「形の drift」を見るのに対し、Spec ② は「**通信レイヤを含む実挙動**」を見る。

## アプローチ（採用: C. 専用ジョブで node 起動）

CI に **Flutter + node 両対応の専用ジョブ**を新設し、api-stub を node で起動して
Dart 結合テストを localhost:8790 に当てる。app の通常 PR テスト（`wc-check-dart-test.yaml`、
node なし）は汚さない。

### CI ジョブの流れ（新ワークフロー `wc-check-integration.yaml` 想定）

1. `actions/checkout`（**`submodules: recursive`** で backend を取得。通常 dart-test ジョブは
   submodule を取らないので本ジョブ専用）。
2. `jdx/mise-action` で **flutter + node + pnpm** を install。
3. backend: `pnpm install --frozen-lockfile` → api-stub を起動
   （`cd backend/api/api-stub && (pnpm build && node dist/index.mjs &)` もしくは `pnpm dev &`）。
4. `/health` を 200 になるまでポーリングして readiness 待ち。
5. `cd packages/eqmonitor_api && dart pub get && dart test --tags integration`。
6. teardown（プロセス kill は CI ジョブ終了で自然に消える）。

### テスト配置とタグ分離（重要）

- 配置: `packages/eqmonitor_api/test/integration/*_integration_test.dart`。
- **`@Tags(['integration'])`** を付け、**`packages/eqmonitor_api/dart_test.yaml` で
  `integration` タグをデフォルト除外**する。
  → 既存の `melos run test:dart`（`dart test` 全実行）が **stub 無しで誤って実行して落ちる**のを防ぐ。
  通常ユニットと Spec ① drift テストはタグ無しで従来どおり走る。
- 専用ジョブだけが `dart test --tags integration` で実行する。

```yaml
# packages/eqmonitor_api/dart_test.yaml
tags:
  integration:
    # 既定では skip（stub が必要なため）。CI 専用ジョブが --tags integration で明示実行。
```
（`dart test` はデフォルトで全タグ実行するため、除外は CI の通常ジョブ側を
`dart test -x integration` にする / もしくは `dart_test.yaml` の `presets` で制御する。
実装計画で最も確実な除外方法を確定する。）

## stub のプログラム制御（Admin API）

`/__stub__/api/*`（`backend/api/api-stub/src/admin-app.ts`）でモードを切り替える:

- `PUT /__stub__/api/mocks` — 指定 endpoint key を `error` / `fixture` / `override` に設定。
- `DELETE /__stub__/api/mocks/all` — 全モードを default に戻す（各テストの teardown で実行）。

テスト本体は Dart から Dio で Admin API を叩いてモードを切り替える（小さなヘルパ
`StubAdmin` を test/integration/ に用意）。

## テスト内容（初期スコープ）

`dioProvider` 相当の Dio を `BaseOptions(baseUrl: 'http://localhost:8790')` で生成し、
`ApiClient(dio)` 経由で各クライアントを叩く。

1. **default モード往復**（代表エンドポイント数件）:
   - `EarthquakeApiClient.getV2Earthquake()` → `EarthquakeListResponse` が返り、items がパースされる。
   - `EewApiClient.getV2EewLatest()`、`TsunamiApiClient.getV2Tsunami()` 等、主要 GET を網羅。
2. **error モード**:
   - Admin API で `GET /v2/earthquake` を error(500) に設定 → `getV2Earthquake()` が
     `DioException`（`response?.statusCode == 500`）を投げる。teardown で reset。
3. **クエリパラメータ**:
   - `getV2Earthquake(limit: ..., offset: ...)` が stub に正しく届く（stub 側で受領を確認、
     または返却内容で検証）。`statuses`（telegram）の List 直列化も検証。

> Spec ① の quarantine（未検証 named fixtures の乖離）はここでは対象外。default モード中心に組む。

## エラーハンドリング / エッジケース

- **stub 起動失敗**: `/health` ポーリングにタイムアウト（例 60s）を設け、超過でジョブを fail。
- **ポート競合**: CI ジョブは専有なので 8790 固定で可。ローカル実行手順も README/spec に明記。
- **flaky 対策**: 各テストは `setUp`/`tearDown` で stub モードを reset し独立させる。

## スコープ外

- 実 UI / widget（→ Spec ③）
- WebSocket / リアルタイム（→ Spec ④）
- 全エンドポイント網羅（初期は代表 + error + query。段階拡張）

## 成功条件

- 新 CI ジョブで api-stub が起動し、`dart test --tags integration` が green。
- default 往復・error→DioException・query 直列化の3系統が検証される。
- 通常の `melos run test:dart`（PR ジョブ）は integration タグを実行せず、従来どおり green。
- ローカルでも「stub 起動 → `dart test --tags integration`」手順で再現できる。

## ローカル実行手順（ドキュメント）

```sh
# 1) stub 起動
cd backend/api/api-stub && mise exec -- pnpm dev   # http://localhost:8790
# 2) 別シェルで結合テスト
cd packages/eqmonitor_api && mise exec -- dart test --tags integration
```

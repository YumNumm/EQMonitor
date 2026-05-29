# Spec ① 契約/drift テスト — 詳細設計

- 日付: 2026-05-30
- 層: L1（テストピラミッド最下層）
- 親: [app-server-integration-testing-overview](./2026-05-30-app-server-integration-testing-overview.md)
- ステータス: 設計（ユーザーレビュー待ち）

## 目的

backend の API レスポンス形状が変わったとき、**Flutter 側の Freezed モデルが追従できているか**を
CI で自動検出する。新規インフラ0・純 Dart・既存 `flutter test` ジョブで完結させる。

### なぜこれが「両端 drift 検出」になるか

- backend 側: `contract.test.ts` が `DEFAULT_MOCKS`（= 各エンドポイントの default フィクスチャ）を
  本家 Valibot schema で `v.parse` 検証している。→ **DEFAULT_MOCKS は常に本家 API の形と一致**。
- アプリ側（本 spec）: 同じ `DEFAULT_MOCKS` を JSON として取り込み、対応する Freezed モデルの
  `fromJson` でパースする。
- 結果、`backend Valibot 検証 → 同一 JSON を Dart がパース` の経路が成立し、
  「backend が形を変えた／アプリのモデルが古い」のどちらでも検出できる。

## 課題と解法：フィクスチャの受け渡し

`DEFAULT_MOCKS` は TypeScript オブジェクトで、JSON ファイルとしては書き出されていない
（dump スクリプトなし）。純 Dart テストから読むには **JSON にエクスポートしてリポジトリにコミット**する。

### 構成要素

1. **エクスポータ（backend 側 / TS）**
   - `backend/api/api-stub/` に `export-fixtures` スクリプトを追加。
   - `DEFAULT_MOCKS` をエンドポイントキーごとに JSON へ書き出す。
   - 動的ディレクティブ（`@field_diff` 等）は **固定の基準時刻に解決して**出力する。
     time-resolver に**固定タイムスタンプ（定数）を注入**して呼び、出力を決定論的にする。
     こうすることで日時フィールドは妥当な ISO8601 値になり Dart の `DateTime.parse` を通る一方、
     基準時刻が固定なので再生成しても diff が出ず stale ガードが安定する。
   - 出力先: `packages/eqmonitor_api/test/fixtures/contract/<safe-key>.json`
     （例 `GET /v2/earthquake/:eventId` → `get__v2_earthquake_eventId.json`）。
   - 併せて、キー→Dart モデル名のマッピングと、どのキーをどのモデルでパースするかの
     インデックス（`index.json`）を出力する。

2. **ドリフトテスト（Dart 側）**
   - 場所: `packages/eqmonitor_api/test/contract_drift_test.dart`。
   - `index.json` を読み、各フィクスチャ JSON を対応する Freezed モデルの `fromJson` でパース。
   - パース成功＝合格。例外発生＝drift として fail（どのキー/モデルで落ちたか明示）。
   - 既存流儀（`test` パッケージ・手書き、外部 mock ライブラリ非依存）に従う。

3. **鮮度ガード（CI）**
   - フィクスチャ JSON はコミットされた成果物なので、backend 変更時に再生成が要る。
   - **再生成と staleガードは backend CI（Node/pnpm あり）側に置く**:
     `export-fixtures` を実行し `git diff --exit-code` でコミット漏れを検出。
     → app CI は純 Dart のまま、コミット済み JSON を読むだけ。
   - `regen-api-schema` フロー（openapi 再生成 → submodule pin → Dart codegen）に
     fixture エクスポートを1ステップ追加し、API 変更時に自然に更新されるようにする。

## データフロー

```
backend/api/api-stub/src/default-mocks.ts (DEFAULT_MOCKS, Valibot検証済み)
        │  pnpm export-fixtures（time-resolver通さず raw JSON 化）
        ▼
packages/eqmonitor_api/test/fixtures/contract/*.json  +  index.json   ← commit
        │  flutter/dart test（既存 app CI、純Dart）
        ▼
packages/eqmonitor_api/test/contract_drift_test.dart
   各 JSON を対応 Freezed モデル .fromJson でパース → 成功/失敗
```

## 対象エンドポイント（初期スコープ）

api-stub contract の GET 系 24 キー（アプリが表示に使う読み取り系）を対象とする。
`contract.test.ts` が現在 Valibot 検証している 14 を**最優先**で網羅し、残りは
Dart モデルが存在するものから順次追加する。

主要対象（抜粋）:
`/v2/earthquake`, `/v2/earthquake/:eventId`, `/v2/earthquake/intensity/{region,prefecture,city,station}/:code`,
`/v2/earthquake/epicenter/:code`, `/v2/eew`, `/v2/eew/latest`, `/v2/eew/:eventId(/:serialNo)`,
`/v2/tsunami(/active|/:tsunamiId|/by-event-id/:eventId)`, `/v2/telegram(/:id|/type/:type|/eventId/:eventId)`,
`/v1/changelog`, `/v1/start`, `/v2/parameters/manifest`, `/v2/parameters/:type`, `/health`。

## エラーハンドリング / エッジケース

- **キー↔モデル対応が無いエンドポイント**: `index.json` に含めない（スキップを明示ログ）。
  「silent に網羅した気になる」ことを避けるため、対象外キーをテスト出力に列挙する。
- **nullable/optional フィールド**: default フィクスチャは「フィールドが揃った代表値」。
  optional が欠けるケースの検証は本 spec のスコープ外（②以降の error/fixture モードで扱う）。
- **動的ディレクティブ**: エクスポータで固定基準時刻に解決済み（上記参照）。Dart 側は
  通常の ISO8601 日時としてパースできる。実装計画フェーズの最初の検証項目として、
  time-resolver に固定値を注入する経路が既存 time-resolver API で可能かを確認する。

## テスト戦略（この spec 自体の検証）

- まず1エンドポイント（例 `GET /v2/earthquake`）でエクスポータ→JSON→Dart パースの
  経路を通し、グリーンを確認（TDD: 落ちる→通すの順）。
- 故意に Dart モデルへ必須フィールドを追加 or 削除して**テストが赤くなる**ことを確認
  （drift 検出が機能する証明）。
- 全 24 キーへ拡張。

## スコープ外（明示）

- 実際の HTTP 通信（→ Spec ②）
- UI/widget の挙動（→ Spec ③）
- WebSocket/リアルタイム（→ Spec ④）
- optional フィールド欠落・エラーレスポンス形状の網羅（→ Spec ②）

## 成功条件

- `packages/eqmonitor_api/test/contract_drift_test.dart` が既存 `flutter test`/`dart test` で実行され、
  対象エンドポイントの default フィクスチャをすべてパースできる。
- backend で response 形を変えて Dart モデルが未追従なら、CI が赤くなる。
- fixture 再生成が `regen-api-schema` フローに組み込まれ、backend CI の stale ガードで
  コミット漏れを検出できる。
- 新規の外部テスト依存（mocktail 等）を増やさない。

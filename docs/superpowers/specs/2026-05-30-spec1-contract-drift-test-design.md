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
   - `backend/api/api-stub/` に `generate:fixtures` スクリプトを追加（`tsx` で実行）。
   - `DEFAULT_MOCKS`（= `FIXTURE_REGISTRY` の default）をエンドポイントキーごとに JSON へ書き出す。
   - **union を持つキーは named fixtures も出力**（上記「Union 型の網羅」参照）。1キー複数 JSON 可。
   - 動的ディレクティブ（`@field_diff`/`@field_random`）は **決定論的に解決**して出力する。
     現状 `resolveDirectives` は内部で `Date.now()`/`Math.random()` を直接使うため、
     **`resolveDirectives(value, { nowMs, pickFirst })` のオプション引数を追加**する
     （引数省略時は現状動作を維持。これらが唯一の非決定要因であることを確認）。
     エクスポートは `nowMs` = 固定定数、`pickFirst` = 配列先頭固定 で呼ぶ。
     → 日時は妥当な ISO8601 になり Dart の `DateTime.parse` を通り、再生成しても diff が出ない。
   - 出力先: backend submodule 内（例 `backend/api/api-stub/generated/contract-fixtures/`）。
     `<safe-key>.json`（例 `GET /v2/earthquake/:eventId` → `get__v2_earthquake_eventId.json`、
     named fixture は `get__v2_parameters_type__jma_code_table.json` 等）。
   - 併せて `index.json`（`[{ key, file }]` の配列）を出力。Dart 側はこの file 名で
     パーサ（モデルの fromJson）を引く。

2. **ドリフトテスト（Dart 側）**
   - 場所: `packages/eqmonitor_api/test/contract_drift_test.dart`。
   - `index.json` を読み、各フィクスチャ JSON を対応する Freezed モデルの `fromJson` でパース。
   - パース成功＝合格。例外発生＝drift として fail（どのキー/モデルで落ちたか明示）。
   - 既存流儀（`test` パッケージ・手書き、外部 mock ライブラリ非依存）に従う。

3. **配置とコピー（必須）**
   - **app CI（`wc-check-dart-test.yaml`）は backend submodule を checkout しない**ことを確認済み。
     → Dart テストは `../../backend/...` を直読みできない。**fixture をメインリポ
     `packages/eqmonitor_api/test/fixtures/contract/` にコミットするのは必須**。
     openapi.json が `backend/api/api/openapi.json` → `packages/eqmonitor_api/openapi/openapi.json`
     にコピーされるのと同一の理由・同一の流儀。
   - 取り込みは `packages/eqmonitor_api/bin/generate.dart`（既に openapi.json を submodule から
     コピーしている入口）に「fixtures コピー」ステップを追加して行う。
   - ⚠️ 「submodule から直読みして簡素化」は **CI を壊す**ため禁止。zero-infra 性が Spec ① の肝。

4. **鮮度ガード（CI）と、その射程の正直な明示**
   - **backend CI（Node/pnpm あり）で再生成 + `git diff --exit-code`** により、
     **submodule 側のコピー**のコミット漏れを検出する。
   - ただし**テストが実際に読むのはメインリポ側のコピー**で、これは手動の `regen-api-schema`
     実行でしか同期されない。app CI 側にメインリポコピーの鮮度を検証する仕組みは無い。
   - これは openapi.json が既に抱えるのと**同じ「開発フロー信頼」ギャップ**であり、一貫性のため
     許容する。ガードが「テスト入力の鮮度」まで守るかのように過大評価しないこと。
   - `regen-api-schema` フロー（openapi 再生成 → submodule pin → Dart codegen）に
     fixture エクスポートを1ステップ追加し、API 変更時に自然に更新されるようにする。

## データフロー

```
backend/api/api-stub/src/{default-mocks,fixture-registry}.ts (Valibot検証済み)
        │  pnpm generate:fixtures（resolveDirectives を nowMs/pickFirst 固定で決定論化）
        ▼
backend/api/api-stub/generated/contract-fixtures/*.json + index.json  ← submodule に commit
        │  generate.dart のコピーステップ（regen-api-schema 経由）
        ▼
packages/eqmonitor_api/test/fixtures/contract/*.json + index.json  ← メインリポに commit（必須）
        │  dart test（既存 app CI、純Dart、submodule 不要）
        ▼
packages/eqmonitor_api/test/contract_drift_test.dart
   index.json を走査 → file 名で引いた Freezed モデル .fromJson でパース → 成功/失敗
```

## 対象エンドポイント（初期スコープ）

api-stub contract の GET 系 24 キー（アプリが表示に使う読み取り系）を対象とする。
`contract.test.ts` が現在 Valibot 検証している 14 を**最優先**で網羅し、残りは
Dart モデルが存在するものから順次追加する。

### Union 型の網羅（重要）

`DEFAULT_MOCKS` は各キー1バリアントしか持たないため、**union 型を持つエンドポイントは
default だけでは drift を取り逃す**。最も壊れやすい手書きコードは `generate.dart` の
union/enum パッチ（`ParameterDataResponseUnion` は 4 variant: jma_code_table /
kyoshin_observation_points / earthquake_stations / tsunami_stations）。
`/v2/parameters/:type` は対象 24 キーに含まれるが default は1 variant しか通らない。

→ **union を持つエンドポイントは `FIXTURE_REGISTRY` の named fixtures も併せてエクスポート**し、
variant ごとに JSON を出す（filename→model マップは1キー複数ファイルに自然に拡張できる）。

逆に **`FeedItemDataUnion` / `TargetUnion` は GET 24 キーから到達しない**（feed/webhook 系・
POST 系）。これらのパッチは Spec ① の対象外であることを明記し、「union を全網羅した」と
誤認しないようにする（②以降または別途カバー）。

主要対象（抜粋）:
`/v2/earthquake`, `/v2/earthquake/:eventId`, `/v2/earthquake/intensity/{region,prefecture,city,station}/:code`,
`/v2/earthquake/epicenter/:code`, `/v2/eew`, `/v2/eew/latest`, `/v2/eew/:eventId(/:serialNo)`,
`/v2/tsunami(/active|/:tsunamiId|/by-event-id/:eventId)`, `/v2/telegram(/:id|/type/:type|/eventId/:eventId)`,
`/v1/changelog`, `/v1/start`, `/v2/parameters/manifest`, `/v2/parameters/:type`, `/health`。

## エラーハンドリング / エッジケース

- **キー↔モデル対応が無いエンドポイント**: Dart 側マップに含めない（スキップを明示ログ）。
  「silent に網羅した気になる」ことを避けるため、対象外キーをテスト出力に列挙する。
- **マップ済みキーの fixture ファイルが欠落**（エンドポイント rename/削除など）: **fail loud**。
  これは drift そのものなので「モデル無し」スキップとは区別し、テストを赤にする。
- **CI が新テストを拾うことの確認**: `eqmonitor_api` は `test: ^1.29.0` 依存済み。`test/` を
  追加すれば melos `test:dart`（`dependsOn: test` + `dirExists: test`）が拾う。実装時に
  「ローカルで `dart test` が通る」だけでなく「melos 経由で CI が実行する」ことを確認する。
  モデルパースは純 Dart なので Flutter SDK 非依存（`dart test` で完結）。
- **nullable/optional フィールド**: default フィクスチャは「フィールドが揃った代表値」。
  optional が欠けるケースの検証は本 spec のスコープ外（②以降の error/fixture モードで扱う）。
- **動的ディレクティブ**: エクスポータで固定基準時刻に解決済み（上記参照）。Dart 側は
  通常の ISO8601 日時としてパースできる。実装計画フェーズの最初の検証項目として、
  time-resolver に固定値を注入する経路が既存 time-resolver API で可能かを確認する。

## テスト戦略（この spec 自体の検証）

**core-test-first**（パイプラインより先にテスト本体を固める）:

1. **手で1つだけ** fixture JSON（例 `GET /v2/earthquake`）を `test/fixtures/contract/` に置く。
2. Dart の drift テストを書き、`dart test` で**グリーン**を確認。
3. 故意に Dart モデルへ必須フィールドを追加 or 削除して**テストが赤くなる**ことを確認
   （drift 検出が機能する証明）。
4. これで「DateTime パースが通るか」「union の discriminator が実ペイロードで効くか」という
   最も驚きやすい2点を**先に**潰す。
5. その後にエクスポータ（TS）→ generate.dart コピー → CI 鮮度ガードを構築。
6. 全 24 キー（+ union named fixtures）へ拡張。

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

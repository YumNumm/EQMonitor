# 計画B: API スキーマ反映 (eqmonitor_api 再生成) 実装計画

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 計画A で変更された backend の `openapi.json` / 契約 fixtures を `packages/eqmonitor_api` へ取り込み、`EarthquakePartial` に `updatedAt`/`lastReportedAt`、scope 系メソッドに `lastUpdatedSince`/`cacheId` クエリ、`StartResponse` に `cacheId` を生成して契約 (`CONTRACT.md §2`) を満たす Dart API クライアントを産出する。

**Architecture:** 本計画は手書きをしない。`regen-api-schema` スキルの手順を具体化し、(1) backend submodule pin を計画A のコミットへ更新 → (2) `dart run bin/generate.dart` で openapi コピー + swagger_parser + 後処理パッチ + build_runner + fixtures コピー → (3) 生成物を grep で検証 → (4) 既存パッチ機構が新フィールド/新クエリで崩れる場合のみ追加パッチ → (5) analyze + test → (6) PR の順で進める。生成物 (`*.dart` / `*.freezed.dart` / `*.g.dart` / fixtures) はすべてコミット対象。

**Tech Stack:** Dart, swagger_parser ^1.42.0, retrofit ^4.9.2, freezed ^3.x, dio ^5.9.1, build_runner, melos, git submodule, gh CLI

## Global Constraints

- **前提 (依存):** 計画A が完了し、backend に `updated_at`/`last_reported_at` を持つ `EarthquakePartial`、`lastUpdatedSince`/`cacheId` を受理する `EarthquakeQueryParams`、`cache_id` を持つ `StartResponseSchema` が反映され、**backend のブランチ/コミットが remote (`origin`) に push 済み**であること。本計画は計画A の backend コミット SHA を前提入力として受け取る (本書では `<BACKEND_SHA>` と表記)。
- **生成物はコミットする:** `packages/eqmonitor_api/lib/src/` 配下、`packages/eqmonitor_api/openapi/openapi.json`、`packages/eqmonitor_api/test/fixtures/contract/` はすべて git 追跡対象。再生成後の diff を漏れなく add する。
- **手書き禁止:** `lib/src/` の生成コードを手で直さない。型が崩れる場合は `bin/generate.dart` のパッチを足して再実行する (CONTRACT.md §2 冒頭「手書きしない」)。
- `melos run analyze` がクリーン (警告なし) であること。
- `dart format` 準拠。
- PR は **常に `--repo YumNumm/EQMonitor`**、base ブランチは **`develop`** (親リポジトリ側)。
- 契約で確定した名前 (verbatim): `EarthquakePartial.updatedAt` (`@JsonKey(name: 'updated_at')`, `DateTime`)、`EarthquakePartial.lastReportedAt` (`@JsonKey(name: 'last_reported_at')`, `DateTime`)、scope メソッドの `@Query('lastUpdatedSince') String? lastUpdatedSince`、`@Query('cacheId') String? cacheId`、`StartResponse.cacheId` (`@JsonKey(name: 'cache_id')`, `String`)。
- 対象 scope メソッドは合計 5 つ: `getV2Earthquake`、`getV2EarthquakeIntensityRegionCode`、`getV2EarthquakeIntensityPrefectureCode`、`getV2EarthquakeIntensityCityCode`、`getV2EarthquakeIntensityStationCode` (`getV2EarthquakeEventId` は対象外 = クエリを持たない)。

## File Structure (このプランで触れるファイル)

- `backend/` (submodule pin) — 親リポジトリの gitlink。計画A のコミットを指すよう更新。
- `packages/eqmonitor_api/openapi/openapi.json` — backend の `api/api/openapi.json` のコピー (generate.dart が自動コピー)。
- `packages/eqmonitor_api/lib/src/models/earthquake_partial.dart` — 再生成で `updatedAt`/`lastReportedAt` 追加。
- `packages/eqmonitor_api/lib/src/models/start_response.dart` — 再生成で `cacheId` 追加。
- `packages/eqmonitor_api/lib/src/clients/earthquake_api_client.dart` — 再生成で 5 メソッドに `lastUpdatedSince`/`cacheId` クエリ追加。
- `packages/eqmonitor_api/lib/src/models/*.freezed.dart` / `*.g.dart`、`clients/earthquake_api_client.g.dart` — build_runner 生成物。
- `packages/eqmonitor_api/test/fixtures/contract/` — generate.dart が backend submodule からコピー。
- `packages/eqmonitor_api/bin/generate.dart:445-488` (`_patchDynamicQueryParameters`) / `:766-794` (`_patchOriginTimeDateTimeToString`) — **必要な場合のみ** 追加パッチ。

---

### Task 1: backend submodule pin を計画A のコミットへ更新

**Files:**
- Modify: `backend` (submodule gitlink — 親リポジトリのインデックス)

**Interfaces:**
- Consumes: 計画A の backend コミット SHA `<BACKEND_SHA>` (remote `origin` に push 済み)。
- Produces: 親リポジトリのインデックスに `backend` の新 pin がステージされた状態。`backend/api/api/openapi.json` と `backend/api/api-stub/generated/contract-fixtures/` が新スキーマを反映している状態 (後続 Task が消費)。

- [ ] **Step 1: 現在の submodule pin を記録**

Run:
```bash
git -C /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor submodule status backend
```
Expected: `<旧SHA> backend (...)` が表示される。ロールバック用に控える。

- [ ] **Step 2: submodule を初期化 (未初期化の場合の保険)**

Run:
```bash
git -C /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor submodule update --init backend
```
Expected: エラーなく完了 (既に初期化済みなら無出力)。

- [ ] **Step 3: backend で計画A のコミットを fetch & checkout**

`<BACKEND_SHA>` は計画A 完了時に確定する実際の SHA に置き換える。
```bash
git -C /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor/backend fetch origin
git -C /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor/backend checkout <BACKEND_SHA>
```
Expected: `HEAD is now at <BACKEND_SHA> ...` (detached HEAD)。`error: pathspec ... did not match` が出た場合は計画A が remote に push されていない → 計画A 担当に確認 (Global Constraints の前提違反)。

- [ ] **Step 4: 新スキーマが反映されているか確認**

Run:
```bash
grep -n 'last_reported_at\|updated_at' /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor/backend/api/api/openapi.json
grep -n 'cache_id' /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor/backend/api/api/openapi.json
grep -n 'lastUpdatedSince\|cacheId' /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor/backend/api/api/openapi.json
```
Expected: `updated_at` / `last_reported_at` (EarthquakePartial)、`cache_id` (StartResponse)、`lastUpdatedSince` / `cacheId` (クエリパラメータ) がそれぞれ 1 件以上ヒット。0 件なら計画A が未完 → 中断。

- [ ] **Step 5: 契約 fixtures が新スキーマを反映しているか確認**

Run:
```bash
ls /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor/backend/api/api-stub/generated/contract-fixtures/ | head
grep -rl 'last_reported_at' /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor/backend/api/api-stub/generated/contract-fixtures/ | head
```
Expected: `index.json` を含む `*.json` 群が存在し、`v2_earthquake` 系 fixture に `last_reported_at` がヒットする。ヒットしない場合は計画A が `pnpm generate:fixtures` を未実行 → 計画A 担当に確認。

- [ ] **Step 6: 親リポジトリで submodule pin をステージ**

Run:
```bash
git -C /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor add backend
git -C /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor diff --cached --submodule backend
```
Expected: `Submodule backend <旧SHA>..<BACKEND_SHA>` の差分が表示される。

- [ ] **Step 7: コミット**

Run:
```bash
git -C /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor commit -m "chore: bump backend submodule for earthquake SWR diff API"
```
Expected: 1 ファイル (gitlink) のコミットが作成される。

---

### Task 2: Dart codegen を実行し openapi.json / fixtures を取り込む

**Files:**
- Modify: `packages/eqmonitor_api/openapi/openapi.json` (generate.dart が backend からコピー)
- Modify: `packages/eqmonitor_api/lib/src/` 全体 (削除 → 再生成)
- Modify: `packages/eqmonitor_api/test/fixtures/contract/` (backend submodule からコピー)

**Interfaces:**
- Consumes: Task 1 で更新した `backend/api/api/openapi.json` と `backend/api/api-stub/generated/contract-fixtures/`。
- Produces: 再生成された `lib/src/models/*.dart` / `lib/src/clients/*.dart` と `*.g.dart` / `*.freezed.dart`、コピーされた `openapi/openapi.json` と `test/fixtures/contract/*.json`。後続 Task 3〜6 が検証する。

- [ ] **Step 1: melos bootstrap (依存解決の保険)**

Run:
```bash
mise exec -- melos bootstrap
```
Expected: 全パッケージの依存が解決して完了。`pub get` 失敗時は MEMORY の「依存解決の落とし穴」を参照。

- [ ] **Step 2: generate.dart を実行**

Run:
```bash
cd /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor/packages/eqmonitor_api && mise exec -- dart run bin/generate.dart
```
Expected: 以下のステップが順に `Done` する: `lib/src/ を削除` → `外部 OpenAPI ファイルをコピー` → `swagger_parser でクライアントコードを生成` → 各パッチ群 → `build_runner で Freezed / Retrofit コードを生成` → `契約 fixtures を submodule からコピー (copied N fixtures)` → 末尾に `✅ コード生成が完了しました`。途中で `exit(code)` (build_runner 失敗等) が出たら Task 4 の型崩れの可能性 — Task 3 の検証へ進み原因を切り分ける。

- [ ] **Step 3: openapi.json がコピーされたか確認**

Run:
```bash
grep -c 'last_reported_at' /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor/packages/eqmonitor_api/openapi/openapi.json
```
Expected: `1` 以上 (backend のコピーが反映されている)。

- [ ] **Step 4: 契約 fixtures がコピーされたか確認**

Run:
```bash
test -f /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor/packages/eqmonitor_api/test/fixtures/contract/index.json && echo "index ok"
grep -rl 'last_reported_at' /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor/packages/eqmonitor_api/test/fixtures/contract/ | head
```
Expected: `index ok` と、`last_reported_at` を含む `v2_earthquake` 系 fixture がヒットする。

---

### Task 3: 生成された EarthquakePartial / StartResponse を検証

**Files:**
- Verify: `packages/eqmonitor_api/lib/src/models/earthquake_partial.dart`
- Verify: `packages/eqmonitor_api/lib/src/models/start_response.dart`

**Interfaces:**
- Consumes: Task 2 の生成物。
- Produces: 契約 §2.1 / §2.3 を満たすモデルの確認。崩れていれば Task 4 のパッチ要否を判定する材料。

> **背景:** `updated_at` / `last_reported_at` は backend で `v.isoTimestamp()` (= `format: date-time`)、`cache_id` は `v.string()`。swagger_parser は `format: date-time` を `DateTime`、`string` を `String` にマップし、`@JsonKey(name: 'snake_case')` を付与する。いずれも `EarthquakePartial` / `StartResponse` のような object schema のフィールドであり、`bin/generate.dart` のクエリパラメータ向けパッチ (statuses / dynamic / originTime) は通らない。よって追加パッチ不要が期待値。本 Task はそれを grep で確認する。

- [ ] **Step 1: EarthquakePartial に updatedAt / lastReportedAt が出ているか確認**

Run:
```bash
grep -n "updated_at\|last_reported_at\|updatedAt\|lastReportedAt" /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor/packages/eqmonitor_api/lib/src/models/earthquake_partial.dart
```
Expected: 次の 2 フィールドが含まれる (必須 = `required`、`DateTime` 型、JsonKey snake_case):
```dart
@JsonKey(name: 'updated_at') required DateTime updatedAt,
@JsonKey(name: 'last_reported_at') required DateTime lastReportedAt,
```
NG パターン: `String updatedAt` (DateTime でない) / `DateTime? updatedAt` (nullable で required でない) / フィールドが出ない。NG なら backend schema 側の `v.isoTimestamp()` / required 指定を計画A 担当に確認 (このパッケージ側ではパッチしない方針)。

- [ ] **Step 2: StartResponse に cacheId が出ているか確認**

Run:
```bash
grep -n "cache_id\|cacheId" /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor/packages/eqmonitor_api/lib/src/models/start_response.dart
```
Expected: 次のフィールドが含まれる:
```dart
@JsonKey(name: 'cache_id') required String cacheId,
```
NG なら backend `StartResponseSchema` の `cache_id: v.string()` 必須化を計画A 担当に確認。

---

### Task 4: scope 系 5 メソッドのクエリパラメータを検証し、型が崩れていればパッチ

**Files:**
- Verify: `packages/eqmonitor_api/lib/src/clients/earthquake_api_client.dart`
- Modify (条件付き): `packages/eqmonitor_api/bin/generate.dart:445-488` (`_patchDynamicQueryParameters` の `overrides`)
- Modify (条件付き): `packages/eqmonitor_api/bin/generate.dart:766-794` (`_patchOriginTimeDateTimeToString`)

**Interfaces:**
- Consumes: Task 2 の生成済み `earthquake_api_client.dart`。
- Produces: 契約 §2.2 を満たす 5 メソッド (`@Query('lastUpdatedSince') String? lastUpdatedSince` と `@Query('cacheId') String? cacheId`)。パッチ追加時は再現可能な generate.dart 修正。

> **背景 (型崩れの可能性分析):**
> - `cacheId` は `v.string()` (optional) → swagger_parser は素直に `@Query('cacheId') String? cacheId` を生成する見込み。既存パッチは通らない。
> - `lastUpdatedSince` は `HourBucketJstSchema` (`v.pipe(v.string(), v.regex(...), ...)`) → 通常 `String?` にマップされるが、2 つの崩れリスクがある:
>   1. backend が `pattern` だけでなく `format: date-time` を出すと swagger_parser が **`DateTime?`** を生成する。これは `originTime` と同じ崩れ方 (`_patchOriginTimeDateTimeToString` と同型の手当てが要る)。
>   2. backend が `anyOf` (例: string | array) を出すと swagger_parser が **`dynamic`** を生成する (`statuses` / `epicenterCodes` と同じ崩れ方)。この場合 `_patchDynamicQueryParameters` の正規表現 `@Query\('(\w+)'\)\s+dynamic\s+(\w+)` にマッチし、`overrides` に無いため **デフォルトで `String?` にフォールバックされる** (= 既存機構で自動的に正しくなる)。
>   よって `dynamic` 化は既存パッチが救済し、`DateTime?` 化のみ手当てが要る可能性がある。本 Task はまず生成結果を確認し、崩れた場合のみパッチする。

- [ ] **Step 1: 5 メソッドすべてに lastUpdatedSince / cacheId が出ているか件数確認**

Run:
```bash
grep -c "@Query('lastUpdatedSince')" /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor/packages/eqmonitor_api/lib/src/clients/earthquake_api_client.dart
grep -c "@Query('cacheId')" /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor/packages/eqmonitor_api/lib/src/clients/earthquake_api_client.dart
```
Expected: いずれも `5` (getV2Earthquake + intensity scope 4 メソッド)。`6` 以上または `4` 以下なら backend の OpenAPI のパラメータ付与漏れ/過剰を計画A 担当に確認。

- [ ] **Step 2: 型が String? になっているか確認**

Run:
```bash
grep -n "@Query('lastUpdatedSince')\|@Query('cacheId')" /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor/packages/eqmonitor_api/lib/src/clients/earthquake_api_client.dart
```
Expected (契約 §2.2 通り):
```dart
@Query('lastUpdatedSince') String? lastUpdatedSince,
@Query('cacheId') String? cacheId,
```
- ✅ 両方 `String?` → 追加パッチ不要。Step 6 (analyze) へスキップ。
- ⚠️ `lastUpdatedSince` が `DateTime?` → Step 3 (originTime 型パッチを拡張) へ。
- ⚠️ どちらかが `dynamic` のまま残っている → Step 4 (overrides 追加) へ。
- ⚠️ 何も出ない (`grep` で 0 件) → Step 1 の件数が 0 のはず。backend 側の問題。

- [ ] **Step 3 (条件付き — `lastUpdatedSince` が `DateTime?` のとき): originTime 型パッチを拡張**

`bin/generate.dart` の `_patchOriginTimeDateTimeToString` (現状 originTimeGte/Lte のみ) に `lastUpdatedSince` の置換を追加する。

`packages/eqmonitor_api/bin/generate.dart` の以下を編集:
```dart
    content = content.replaceAll(
      "@Query('originTimeLte') DateTime? originTimeLte",
      "@Query('originTimeLte') String? originTimeLte",
    );
```
の直後に追記:
```dart
    content = content.replaceAll(
      "@Query('lastUpdatedSince') DateTime? lastUpdatedSince",
      "@Query('lastUpdatedSince') String? lastUpdatedSince",
    );
```
あわせて関数の doc コメント (`/// originTimeGte / originTimeLte は ...`) に `lastUpdatedSince` (HourBucketJst 文字列を送る) も対象である旨を 1 行追記する。
編集後、Task 2 Step 2 の generate.dart を再実行してから Step 2 を再確認する。

- [ ] **Step 4 (条件付き — `lastUpdatedSince` か `cacheId` が `dynamic` のとき): overrides に明示型を追加**

`_patchDynamicQueryParameters` の `overrides` は未知 dynamic を `String?` にフォールバックするため通常は自動救済されるが、明示しておくと意図が固定される。`bin/generate.dart` の:
```dart
  const overrides = {
    'epicenterCodes': 'List<String>?',
    'telegramTypes': 'List<EarthquakeTelegramType>?',
  };
```
を:
```dart
  const overrides = {
    'epicenterCodes': 'List<String>?',
    'telegramTypes': 'List<EarthquakeTelegramType>?',
    'lastUpdatedSince': 'String?',
    'cacheId': 'String?',
  };
```
に変更する。編集後、Task 2 Step 2 の generate.dart を再実行してから Step 2 を再確認する。

- [ ] **Step 5 (Step 3 か 4 を実施した場合のみ): パッチを再実行して型を再確認**

Run:
```bash
cd /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor/packages/eqmonitor_api && mise exec -- dart run bin/generate.dart
grep -n "@Query('lastUpdatedSince')\|@Query('cacheId')" /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor/packages/eqmonitor_api/lib/src/clients/earthquake_api_client.dart
```
Expected: 全ヒットが `String?` になっている。なお generate.dart のパッチは冪等 (置換ベース) のため再実行は安全。

- [ ] **Step 6: Retrofit 生成物 (.g.dart) にパラメータが反映されているか確認**

Run:
```bash
grep -c "lastUpdatedSince\|cacheId" /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor/packages/eqmonitor_api/lib/src/clients/earthquake_api_client.g.dart
```
Expected: `1` 以上 (Retrofit が `queryParameters` に組み込んでいる)。0 件なら build_runner が未実行 → Task 2 Step 2 を再実行。

---

### Task 5: パッケージ単体の analyze と契約 drift テスト

**Files:**
- Verify: `packages/eqmonitor_api/` 全体
- Verify: `packages/eqmonitor_api/test/contract_drift_test.dart` (既存マッピングが新フィールドで壊れないこと)

**Interfaces:**
- Consumes: Task 2〜4 の生成物。
- Produces: analyze クリーン・テスト緑の確認。

> **背景:** `contract_drift_test.dart:28` は `'GET /v1/start': StartResponse.fromJson`、`:46` 相当で earthquake 系を `EarthquakeListResponse.fromJson` 等にマッピング済み。`StartResponse` / `EarthquakePartial` に **required フィールドが増える**と、対応する fixture に当該キーが無い場合 `fromJson` が型エラーで落ちうる。ただし `get__v1_start*.json` は現状 `_quarantine` に入っており、新 fixture (計画A の `generate:fixtures` 産物) が `cache_id` を含む前提なので緑になるはず。earthquake 系 fixture も計画A 産物が `updated_at`/`last_reported_at` を含む。本 Task はそれを実行で確認する。

- [ ] **Step 1: パッケージ単体 analyze**

Run:
```bash
cd /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor/packages/eqmonitor_api && mise exec -- dart analyze
```
Expected: `No issues found!`。`The argument type 'DateTime' can't be assigned ...` 等が出たら Task 4 の型崩れを再点検。

- [ ] **Step 2: 契約 drift テストを実行**

Run:
```bash
cd /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor/packages/eqmonitor_api && mise exec -- dart test test/contract_drift_test.dart
```
Expected: quarantine / SKIP 以外がすべて PASS。`GET /v2/earthquake [...]` 系の fixture が `EarthquakeListResponse.fromJson` でパースできる。

- [ ] **Step 3 (失敗時のみ): earthquake 系 fixture の必須キー欠落を切り分け**

`GET /v2/earthquake [...]` が落ちた場合、fixture に `updated_at`/`last_reported_at` が無い可能性。確認:
```bash
grep -rL 'last_reported_at' /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor/packages/eqmonitor_api/test/fixtures/contract/get__v2_earthquake__*.json
```
Expected: 出力が空 (全 earthquake fixture が `last_reported_at` を持つ)。欠落 fixture が列挙されたら計画A の `generate:fixtures` が新カラムを emit していない → 計画A 担当に差し戻し (本パッケージ側では fixture を手書きしない)。

- [ ] **Step 4: body parse テストも実行 (回帰確認)**

Run:
```bash
cd /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor/packages/eqmonitor_api && mise exec -- dart test
```
Expected: `contract_drift_test.dart` / `verify_body_parse_test.dart` / `test/integration/` を含む全テストが PASS (quarantine/SKIP を除く)。

---

### Task 6: 全パッケージ analyze・format とコミット

**Files:**
- Modify: `packages/eqmonitor_api/` 全体 (生成 diff をコミット)

**Interfaces:**
- Consumes: Task 2〜5 の検証済み生成物。
- Produces: コミット済みの再生成結果。後続 Task 7 (PR) が push する。

- [ ] **Step 1: モノレポ全体 analyze**

Run:
```bash
cd /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor && mise exec -- melos run analyze
```
Expected: 全パッケージで `No issues found!`。`app` 側が `updatedAt`/`lastReportedAt`/`cacheId` 追加で壊れることは無い (既存呼び出しはこれらを参照しないため。required フィールド追加はコンストラクタ呼び出し側にのみ影響するが、`EarthquakePartial` / `StartResponse` はデコード専用で app 側に手書きインスタンス化が無い)。万一 app 側で手書きインスタンス化が見つかった場合はそれは計画D/E のスコープ — ここでは analyze エラーの該当箇所を報告のみ行い、本計画では触らない。

- [ ] **Step 2: format 適用**

Run:
```bash
cd /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor/packages/eqmonitor_api && mise exec -- dart format .
```
Expected: 生成物の整形差分 (あれば) が適用される。

- [ ] **Step 3: 生成 diff の全体像を確認**

Run:
```bash
git -C /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor status --short packages/eqmonitor_api/
```
Expected: `earthquake_partial.dart` / `start_response.dart` / `earthquake_api_client.dart` と対応 `*.g.dart` / `*.freezed.dart`、`openapi/openapi.json`、`test/fixtures/contract/*.json` (+ Task 4 を実施したなら `bin/generate.dart`) が変更/追加されている。想定外のモデルの大量 rename が出ていないか目視 (enum 自動採番ドリフトの兆候 — `regen-api-schema` の落とし穴)。

- [ ] **Step 4: コミット**

Run:
```bash
git -C /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor add packages/eqmonitor_api/
git -C /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor commit -m "chore(eqmonitor_api): regenerate for earthquake SWR diff API

- EarthquakePartial: add updatedAt / lastReportedAt (DateTime)
- StartResponse: add cacheId (String)
- earthquake scope methods: add lastUpdatedSince / cacheId queries
- contract fixtures and openapi.json updated"
```
Expected: 生成物一式のコミットが作成される。

---

### Task 7: PR 作成 (親リポジトリ)

**Files:**
- (なし — git 操作のみ)

**Interfaces:**
- Consumes: Task 1 (submodule pin) と Task 6 (生成物) のコミット。
- Produces: `YumNumm/EQMonitor` への PR (base `develop`)。

- [ ] **Step 1: develop からブランチを作成 (未作成の場合)**

現在のブランチが `develop` なら作業用ブランチへ切る。既に feature ブランチ上ならスキップ。
```bash
git -C /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor rev-parse --abbrev-ref HEAD
```
Expected: 表示が `develop` の場合のみ次を実行:
```bash
git -C /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor switch -c feat/earthquake-swr-api-schema
```

- [ ] **Step 2: push**

Run:
```bash
git -C /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor push -u origin HEAD
```
Expected: ブランチが `origin` へ push される。

- [ ] **Step 3: PR 作成**

Run:
```bash
gh pr create --repo YumNumm/EQMonitor --base develop \
  --title "chore(eqmonitor_api): earthquake SWR 差分 API をアプリへ反映" \
  --body "計画B: backend (計画A) の openapi.json / 契約 fixtures を eqmonitor_api へ再生成して反映。

## 変更
- backend submodule pin を計画A のコミット (<BACKEND_SHA>) へ更新
- EarthquakePartial に updatedAt / lastReportedAt (DateTime) を追加 (生成)
- StartResponse に cacheId (String) を追加 (生成)
- earthquake scope 系 5 メソッドに lastUpdatedSince / cacheId クエリを追加 (生成)
- 契約 fixtures / openapi.json を更新

## 検証
- packages/eqmonitor_api: dart analyze クリーン
- contract_drift_test.dart / verify_body_parse_test.dart PASS
- melos run analyze クリーン

CONTRACT.md §2 準拠。"
```
Expected: PR URL が表示される。`<BACKEND_SHA>` は実際の SHA に置換済みであること。

- [ ] **Step 4: CI 確認**

Run:
```bash
gh pr checks --repo YumNumm/EQMonitor
```
Expected: `flutter.yaml` (analyze + unit tests) が走り、緑になる。

---

## Self-Review

**1. Spec coverage (本計画の責務 = CONTRACT.md §2 + 指示の 8 項目):**
- ① submodule で計画A ブランチ取り込み + 親で `git add backend` → Task 1。
- ② openapi.json 再生成・コピー → Task 2 (generate.dart が backend → `openapi/openapi.json` を自動コピー、Step 3 で確認)。
- ③ `dart run bin/generate.dart` codegen → Task 2 Step 2。
- ④ 生成検証 (`EarthquakePartial.updatedAt`/`lastReportedAt`、5 メソッドの `lastUpdatedSince`/`cacheId` Query、`StartResponse.cacheId`) → Task 3 + Task 4。
- ⑤ パッチが崩れる場合の追加手順 (`lastUpdatedSince`/`cacheId` の dynamic→型・DateTime→String) → Task 4 Step 3/4 で originTime 系・statuses 系パッチと同型の手当てを条件付きで明示。
- ⑥ `melos run analyze` + 契約 fixtures コピー確認 → Task 6 Step 1 + Task 2 Step 4。
- ⑦ eqmonitor_api テスト (`dart test`) → Task 5。
- ⑧ PR 作成 (`--repo YumNumm/EQMonitor --base develop`、親リポ側) → Task 7。
- 計画A 完了が前提 → Global Constraints 冒頭に明記。

**2. Placeholder scan:** `<BACKEND_SHA>` は意図的な前提入力プレースホルダで、出現箇所すべてに「実 SHA へ置換」の注記あり。それ以外の TBD/TODO/「適切に」型の曖昧表現は無し。条件付き Task 4 のパッチは実コード差分を提示済み。

**3. Type consistency:** 契約と一致を確認 — `updatedAt`/`lastReportedAt` (`DateTime`, JsonKey `updated_at`/`last_reported_at`)、`cacheId` (StartResponse は `String` required / クエリは `String?`)、`@Query('lastUpdatedSince') String?` / `@Query('cacheId') String?`。scope メソッドは 5 個 (getV2Earthquake + intensity 4) で統一。generate.dart の参照行 (`_patchDynamicQueryParameters` の `overrides`、`_patchOriginTimeDateTimeToString`) は実ファイルの該当箇所と一致。

**懸念点:**
- `lastUpdatedSince` の生成型は backend の OpenAPI 出力次第 (`String?` / `DateTime?` / `dynamic` の 3 分岐)。Task 4 で 3 分岐すべてに対処済みだが、計画A の `HourBucketJstSchema` が `format` をどう emit するかが確定するまで実型は未知 → 実行時に Step 2 で判定する設計。
- 契約 fixtures の `get__v1_start*.json` は現状 `_quarantine` に入っているため、`StartResponse.cacheId` 必須化のテスト緑化は quarantine 解除に依存しない (drift test では落ちない)。`cacheId` の実反映は Task 4/6 の grep + analyze で担保。
- app 側の手書きインスタンス化があると Task 6 Step 1 で analyze が落ちうるが、それは計画D/E のスコープのため本計画では報告のみ (修正しない)。

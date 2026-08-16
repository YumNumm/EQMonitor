# 地震履歴の震度区別・ソートページング Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 地域指定時の観測震度と最大震度を明示し、全ソート・全フィルターでページ境界の順序、重複、欠落を正す。

**Architecture:** バックエンドの最新 `origin/main` を独立Worktreeで修正し、通常一覧と地域検索4種へ共通の最小keyset Cursor規則を適用する。地域検索レスポンスを `observed_intensity` へリネームしてOpenAPIからDartクライアントを再生成し、FlutterのDomain変換、検索条件転送、一覧表示を追従させる。

**Tech Stack:** TypeScript / Hono / Drizzle ORM / Valibot / Vitest / PGlite / OpenAPI / Dart / Flutter / Riverpod / Freezed / Widget Test

## Global Constraints

- Cursorは現在ページで返さない `limit + 1` 件目、つまり次ページ先頭を指す。
- Cursorにはページ位置の最小キーだけを入れ、`limit`、フィルター、`sortBy`、`sortOrder` は入れない。
- nullableなソート値は昇順・降順とも `NULLS LAST` とする。
- 地域検索の震度範囲は対象地域の観測震度、`max_intensity` ソートは地震全体の最大震度へ適用する。
- 地域検索レスポンスは破壊的に `intensity` から `observed_intensity` へ変更し、旧フィールドを併記しない。
- Flutter / Dart コマンドは必ず `mise exec --` 経由で実行する。
- 既存の未コミット変更は編集、整形、stageしない。

## Execution Workspaces

- Flutter: `/home/yumnumm/.codex/worktrees/e3271883-deaf-4b62-b79c-c0622995f7e0/EQMonitor`
- Backend: `/home/yumnumm/.codex/worktrees/e3271883-deaf-4b62-b79c-c0622995f7e0/EQMonitor/backend/.worktrees/fix-earthquake-history-intensity-pagination`
- Backend branch: `fix/earthquake-history-intensity-pagination` from `origin/main`

実装開始時に次を実行する。

```bash
git -C backend worktree add .worktrees/fix-earthquake-history-intensity-pagination \
  -b fix/earthquake-history-intensity-pagination origin/main
cd backend/.worktrees/fix-earthquake-history-intensity-pagination
pnpm install --frozen-lockfile
pnpm --dir api/api test -- src/features/earthquake/model/list-cursor.test.ts \
  src/features/earthquake/datasource/datasource.test.ts \
  src/features/earthquake/datasource/datasource.pglite.test.ts
```

Expected: Worktree作成成功。既存の地震一覧テストがすべてPASS。

---

### Task 1: Cursorを次ページ先頭の最小キーへ変更

**Files:**
- Modify: `backend/.worktrees/fix-earthquake-history-intensity-pagination/api/api/src/features/earthquake/model/list-cursor.ts`
- Modify: `backend/.worktrees/fix-earthquake-history-intensity-pagination/api/api/src/features/earthquake/model/list-cursor.test.ts`
- Modify: `backend/.worktrees/fix-earthquake-history-intensity-pagination/api/api/test/earthquake/earthquake-routes.test.ts`

**Interfaces:**
- Produces: `EarthquakeListCursorPayload { eventId: string; sortValue?: string | null }`
- Produces: `encodeEarthquakeListCursor({ cursor, sortBy }): string`
- Produces: `parseEarthquakeListCursor({ id, sortBy }): EarthquakeListCursorPayload | null`

- [ ] **Step 1: 最小Cursor契約の失敗テストを書く**

`list-cursor.test.ts` の既存期待値を次へ変更する。

```ts
it('event_idソートはEvent IDだけを保持する', () => {
  const token = encodeEarthquakeListCursor({
    cursor: { eventId: '20240101000001' },
    sortBy: 'event_id',
  });
  expect(decodeCursor(token).id).toBe('20240101000001');
  expect(
    parseEarthquakeListCursor({
      id: decodeCursor(token).id,
      sortBy: 'event_id',
    }),
  ).toEqual({ eventId: '20240101000001' });
});

it('magnitudeソートは値とEvent IDだけを保持する', () => {
  const token = encodeEarthquakeListCursor({
    cursor: { eventId: '20240101000001', sortValue: '6.5' },
    sortBy: 'magnitude',
  });
  expect(decodeCursor(token).id).toBe(
    '{"e":"20240101000001","v":"6.5"}',
  );
});

it('非event_idソートへEvent IDだけのCursorは受け付けない', () => {
  expect(
    parseEarthquakeListCursor({
      id: '20240101000001',
      sortBy: 'magnitude',
    }),
  ).toBeNull();
});
```

Routeテストでは、Cursor JSONに `k`、`o`、`limit`、フィルター名が存在しないことも検証する。

- [ ] **Step 2: REDを確認する**

```bash
cd backend/.worktrees/fix-earthquake-history-intensity-pagination
pnpm --dir api/api test -- src/features/earthquake/model/list-cursor.test.ts \
  test/earthquake/earthquake-routes.test.ts
```

Expected: 既存Cursorが `k` と `o` を含めるためFAIL。

- [ ] **Step 3: 最小Cursor codecを実装する**

`event_id` では `PAGING:20240101000001`、その他では
`PAGING:{"e":"20240101000001","v":"6.5"}` の形を生成する。
`parseEarthquakeListCursor` は外から渡された `sortBy` で形式を選び、Event IDを `/^\d{1,14}$/` で検証する。

```ts
export interface EarthquakeListCursorPayload {
  eventId: string;
  sortValue?: string | null;
}

export function encodeEarthquakeListCursor(input: {
  cursor: EarthquakeListCursorPayload;
  sortBy: EarthquakeSortBy;
}): string {
  const id =
    input.sortBy === 'event_id'
      ? input.cursor.eventId
      : JSON.stringify({
          e: input.cursor.eventId,
          v: input.cursor.sortValue ?? null,
        });
  return encodeCursor({ type: 'PAGING', id });
}
```

Route側は `parseEarthquakeListCursor({ id: query.cursor.id, sortBy })` と
`encodeEarthquakeListCursor({ cursor: nextCursor, sortBy })` を使い、Cursor内のソート条件一致検証を削除する。

- [ ] **Step 4: GREENを確認する**

```bash
cd backend/.worktrees/fix-earthquake-history-intensity-pagination
pnpm --dir api/api test -- src/features/earthquake/model/list-cursor.test.ts \
  test/earthquake/earthquake-routes.test.ts
```

Expected: PASS。

- [ ] **Step 5: Backend commitを作る**

```bash
cd backend/.worktrees/fix-earthquake-history-intensity-pagination
git add api/api/src/features/earthquake/model/list-cursor.ts \
  api/api/src/features/earthquake/model/list-cursor.test.ts \
  api/api/test/earthquake/earthquake-routes.test.ts
git commit -m "fix(api): 地震一覧Cursorを最小ページ位置へ変更"
```

---

### Task 2: 通常一覧をinclusiveな次ページ先頭Cursorへ変更

**Files:**
- Modify: `backend/.worktrees/fix-earthquake-history-intensity-pagination/api/api/src/features/earthquake/datasource/datasource.ts`
- Modify: `backend/.worktrees/fix-earthquake-history-intensity-pagination/api/api/src/features/earthquake/datasource/datasource.test.ts`
- Modify: `backend/.worktrees/fix-earthquake-history-intensity-pagination/api/api/src/features/earthquake/datasource/datasource.pglite.test.ts`

**Interfaces:**
- Consumes: `EarthquakeListCursorPayload`
- Produces: `findEarthquakes(...).nextCursor` が未返却の `rows[limit]` を指す。

- [ ] **Step 1: ページ境界の失敗テストを書く**

PGliteテストで各ソートキー×ASC/DESCを `limit=3` で巡回し、一括取得と同じID列になる既存テストを維持する。
加えて第1ページの `nextCursor` が返却済み最終行ではなく次の未返却行を指すことを追加する。

```ts
it('nextCursorはlimit+1件目を指し、次ページはその行を含む', async () => {
  const first = await datasource.findEarthquakes({
    query: query('magnitude', 'DESC', 3),
  });
  expect(first.items.map(item => item.earthquake.eventId)).toEqual([
    '20240101000001',
    '20240101000006',
    '20240101000002',
  ]);
  expect(first.nextCursor).toEqual({
    eventId: '20240101000008',
    sortValue: '5.0',
  });
  const second = await datasource.findEarthquakes({
    query: query('magnitude', 'DESC', 3, first.nextCursor),
  });
  expect(second.items[0]?.earthquake.eventId).toBe('20240101000008');
});
```

- [ ] **Step 2: REDを確認する**

```bash
cd backend/.worktrees/fix-earthquake-history-intensity-pagination
pnpm --dir api/api test -- src/features/earthquake/datasource/datasource.test.ts \
  src/features/earthquake/datasource/datasource.pglite.test.ts
```

Expected: 現実装は返却済み最終行をCursorにするためFAIL。

- [ ] **Step 3: inclusive keysetを実装する**

第1ソートキーは従来どおりstrictな `lt` / `gt`、同値時の `event_id` は
次ページ先頭を含める `lte` / `gte` にする。`event_id` 単独ソートも `lte` / `gte` を使う。

```ts
function atOrAfterOperator(sortOrder: SortOrder): 'lte' | 'gte' {
  return sortOrder === 'DESC' ? 'lte' : 'gte';
}
```

`nextCursor` は `items.at(-1)` ではなく `earthquakes.at(query.limit)` から作り、
レスポンスitemsは `earthquakes.slice(0, query.limit)` のままにする。

- [ ] **Step 4: GREENを確認する**

```bash
cd backend/.worktrees/fix-earthquake-history-intensity-pagination
pnpm --dir api/api test -- src/features/earthquake/datasource/datasource.test.ts \
  src/features/earthquake/datasource/datasource.pglite.test.ts
```

Expected: 全ソートキー、ASC/DESC、同値、NULL、`magnitudeGte` 併用がPASS。

- [ ] **Step 5: Backend commitを作る**

```bash
cd backend/.worktrees/fix-earthquake-history-intensity-pagination
git add api/api/src/features/earthquake/datasource/datasource.ts \
  api/api/src/features/earthquake/datasource/datasource.test.ts \
  api/api/src/features/earthquake/datasource/datasource.pglite.test.ts
git commit -m "fix(api): 次ページ先頭Cursorでソート順を維持"
```

---

### Task 3: 地域検索4種を共通ソート・フィルターへ統一

**Files:**
- Modify: `backend/.worktrees/fix-earthquake-history-intensity-pagination/api/api/src/features/earthquake/datasource/datasource.ts`
- Modify: `backend/.worktrees/fix-earthquake-history-intensity-pagination/api/api/src/features/earthquake/datasource/datasource.pglite.test.ts`
- Modify: `backend/.worktrees/fix-earthquake-history-intensity-pagination/api/api/src/features/earthquake/routes/earthquake.ts`
- Modify: `backend/.worktrees/fix-earthquake-history-intensity-pagination/api/api/test/earthquake/earthquake-routes.test.ts`

**Interfaces:**
- Produces: 4つの `findIntensity*` が `nextCursor?: EarthquakeListCursorPayload` を返す。
- Produces: 地域検索でも全 `EarthquakeQueryParams` と `sortBy` / `sortOrder` が有効になる。

- [ ] **Step 1: 地域検索の失敗するPGliteテストを書く**

DDLへcities/stationsを追加し、全4テーブルへ同一コードのseedを投入する。
各検索で `magnitude DESC` の複数ページが一括結果と一致し、対象地域震度の下限と
地震属性フィルターが同時に効くことを検証する。

対象地域震度はEvent ID末尾 `01=6+`、`06=5+`、`02=4`、`08=3`、`04=3`、
`07=2`、`03/05=NULL` とし、`intensityGte=3` の期待値を手計算可能にする。

```ts
it.each(['region', 'prefecture', 'city', 'station'] as const)(
  '%s検索はmagnitude DESCと観測震度フィルターをページ間で維持する',
  async scope => {
    const eventIds = await fetchScopedByPages({
      scope,
      code: '1300000',
      sortBy: 'magnitude',
      sortOrder: 'DESC',
      intensityGte: '3',
      magnitudeGte: 5,
      limit: 2,
    });
    expect(eventIds).toEqual([
      '20240101000001',
      '20240101000006',
      '20240101000002',
      '20240101000008',
      '20240101000004',
    ]);
  },
);
```

別ケースで `maxLpgmIntensityGte`、`epicenterCodes`、`earthquakeType`、`datasource`、
`telegramTypes`、緯度経度の各条件が地域検索でも落ちないことを表形式で検証する。

- [ ] **Step 2: REDを確認する**

```bash
cd backend/.worktrees/fix-earthquake-history-intensity-pagination
pnpm --dir api/api test -- src/features/earthquake/datasource/datasource.pglite.test.ts \
  test/earthquake/earthquake-routes.test.ts
```

Expected: 地域検索がevent_idのみで並び、一部フィルターを無視するためFAIL。

- [ ] **Step 3: 地域検索の共通queryを実装する**

対象震度テーブルと `earthquake` を `event_id` でinner joinし、次を1回目のqueryで取得する。

```ts
type ScopedIntensityRow = {
  eventId: string;
  observedIntensity: string;
  sortValue: string | null;
};
```

条件は対象テーブルの `code` と `intensityGte/Lte`、地震テーブルの残り全フィルター、
Task 2のinclusive Cursor条件を `and(...)` で結合する。orderは地震テーブルの指定列、
`NULLS LAST`、`event_id` の順にする。`limit + 1` 行からページ行と次ページ先頭を分ける。
API schemaでは観測震度が必須なので、対象テーブルの `intensity IS NOT NULL` も常に条件へ加える。

ページ行のEvent IDを `findEarthquakesByEventIds` へ渡し、Mapで元の順序へ戻して、
対象テーブル行と `EarthquakePartialResult` を結合する。4つの公開メソッドはテーブルとscope名だけを
共通queryへ渡す薄い入口にする。

- [ ] **Step 4: Routeを共通Cursorへ追従させる**

地域専用の `intensityCursorEventId` を削除する。各RouteはTask 1のparserへリクエストの
`sortBy` を渡し、DataSourceの `nextCursor` をTask 1のencoderへ渡す。
OpenAPI descriptionから「sortByパラメータは無視」を削除する。

- [ ] **Step 5: GREENを確認する**

```bash
cd backend/.worktrees/fix-earthquake-history-intensity-pagination
pnpm --dir api/api test -- src/features/earthquake/datasource/datasource.test.ts \
  src/features/earthquake/datasource/datasource.pglite.test.ts \
  test/earthquake/earthquake-routes.test.ts
pnpm --dir api/api type-check
```

Expected: 全テストPASS、型エラーなし。

- [ ] **Step 6: Backend commitを作る**

```bash
cd backend/.worktrees/fix-earthquake-history-intensity-pagination
git add api/api/src/features/earthquake/datasource/datasource.ts \
  api/api/src/features/earthquake/datasource/datasource.pglite.test.ts \
  api/api/src/features/earthquake/routes/earthquake.ts \
  api/api/test/earthquake/earthquake-routes.test.ts
git commit -m "fix(api): 地域検索へ共通ソートと全フィルターを適用"
```

---

### Task 4: 観測震度API契約をリネームして生成物を更新

**Files:**
- Modify: `backend/.worktrees/fix-earthquake-history-intensity-pagination/api/api/src/features/earthquake/model/responses.ts`
- Modify: `backend/.worktrees/fix-earthquake-history-intensity-pagination/api/api/src/features/earthquake/routes/earthquake.ts`
- Modify: `backend/.worktrees/fix-earthquake-history-intensity-pagination/api/api/test/earthquake/earthquake-routes.test.ts`
- Regenerate: `backend/.worktrees/fix-earthquake-history-intensity-pagination/api/api/openapi.json`
- Regenerate: `backend/.worktrees/fix-earthquake-history-intensity-pagination/api/api-stub/generated/contract-fixtures/*.json`

**Interfaces:**
- Produces: 4種類の検索項目に `observed_intensity: JmaIntensity`。
- Removes: 4種類の検索項目の外側 `intensity`。

- [ ] **Step 1: 破壊的リネームの失敗テストを書く**

Routeテストの地域検索レスポンスで次を検証する。

```ts
expect(body.items[0]).toMatchObject({ observed_intensity: '4' });
expect(body.items[0]).not.toHaveProperty('intensity');
expect(body.items[0].earthquake).toMatchObject({
  intensity: { max_intensity: '6-' },
});
```

- [ ] **Step 2: REDを確認する**

```bash
cd backend/.worktrees/fix-earthquake-history-intensity-pagination
pnpm --dir api/api test -- test/earthquake/earthquake-routes.test.ts
```

Expected: レスポンスが旧 `intensity` のためFAIL。

- [ ] **Step 3: SchemaとRouteをリネームする**

`IntensityRegionSearchItem`、`IntensityPrefectureSearchItem`、
`IntensityCitySearchItem`、`IntensityStationSearchItem` のキーを
`observed_intensity` へ変更する。Routeのresponse mapperも同名へ変更する。

- [ ] **Step 4: OpenAPIとfixtureを再生成する**

```bash
cd backend/.worktrees/fix-earthquake-history-intensity-pagination
pnpm --dir api/api generate:openapi
pnpm --dir api/api-stub generate:fixtures
```

Expected: 4種類のSearchItem schemaとfixtureが `observed_intensity` のみを持つ。

- [ ] **Step 5: Backend検証とcommitを行う**

```bash
cd backend/.worktrees/fix-earthquake-history-intensity-pagination
pnpm --dir api/api test -- test/earthquake/earthquake-routes.test.ts
pnpm --dir api/api-stub test
pnpm --dir api/api type-check
git add api/api/src/features/earthquake/model/responses.ts \
  api/api/src/features/earthquake/routes/earthquake.ts \
  api/api/test/earthquake/earthquake-routes.test.ts \
  api/api/openapi.json api/api-stub/generated/contract-fixtures
git commit -m "feat(api): 地域検索の観測震度フィールドを明確化"
```

---

### Task 5: Dart APIクライアントとDomain変換を同期

**Files:**
- Modify: `backend` submodule pointer
- Generate temporarily: `packages/eqmonitor_api/openapi/openapi.json`（gitignore対象）
- Regenerate: `packages/eqmonitor_api/lib/src/**`
- Regenerate: `packages/eqmonitor_api/test/fixtures/contract/*.json`
- Modify: `app/lib/feature/earthquake_history/data/model/earthquake_search_response.dart`
- Modify: `app/test/feature/earthquake_history/data/earthquake_partial_converter_test.dart`

**Interfaces:**
- Consumes: 生成型の `observedIntensity`。
- Produces: 市区町村は `EarthquakePartialCity(cityIntensity: ...)`。

- [ ] **Step 1: Domain変換の失敗テストを書く**

4種類の生成SearchResponseをDomainへ変換し、それぞれ対応するsealed subtypeと観測震度になることを追加する。
市区町村の核心assertionは次とする。

```dart
expect(result.items.single, isA<EarthquakePartialCity>());
expect(
  (result.items.single as EarthquakePartialCity).cityIntensity,
  JmaIntensity.fiveLower,
);
```

- [ ] **Step 2: Backend branch tipをsubmoduleへ反映してDart生成を行う**

```bash
cd /home/yumnumm/.codex/worktrees/e3271883-deaf-4b62-b79c-c0622995f7e0/EQMonitor
git -C backend switch --detach fix/earthquake-history-intensity-pagination
cd packages/eqmonitor_api
mise exec -- dart run bin/generate.dart
```

Expected: SearchItem生成型に `observedIntensity` があり、旧 `intensity` がない。

- [ ] **Step 3: REDを確認する**

```bash
cd /home/yumnumm/.codex/worktrees/e3271883-deaf-4b62-b79c-c0622995f7e0/EQMonitor
mise exec -- flutter test app/test/feature/earthquake_history/data/earthquake_partial_converter_test.dart
```

Expected: Domain converterが旧プロパティを参照するか、市区町村をRegionへ変換するためFAIL。

- [ ] **Step 4: Domain converterを修正する**

4つのextensionで `item.observedIntensity` を読む。
`IntensityCitySearchResponseToApp` の戻り値を
`PaginatedResponse<EarthquakePartialCity>` とし、`EarthquakePartialCity` を生成する。

- [ ] **Step 5: GREENと生成契約を確認する**

```bash
cd /home/yumnumm/.codex/worktrees/e3271883-deaf-4b62-b79c-c0622995f7e0/EQMonitor
mise exec -- flutter test app/test/feature/earthquake_history/data/earthquake_partial_converter_test.dart
mise exec -- dart test packages/eqmonitor_api/test/contract_drift_test.dart
```

Expected: PASS。

- [ ] **Step 6: Flutter repository commitを作る**

```bash
cd /home/yumnumm/.codex/worktrees/e3271883-deaf-4b62-b79c-c0622995f7e0/EQMonitor
git add backend packages/eqmonitor_api \
  app/lib/feature/earthquake_history/data/model/earthquake_search_response.dart \
  app/test/feature/earthquake_history/data/earthquake_partial_converter_test.dart
git commit -m "Gen: 観測震度API契約へDartクライアントを同期"
```

---

### Task 6: Flutterの地域検索条件とページング転送を完全化

**Files:**
- Modify: `app/lib/feature/earthquake_history/data/model/earthquake_history_parameter_x.dart`
- Modify: `app/lib/feature/earthquake_history/data/repository/earthquake_history_repository.dart`
- Modify: `app/lib/feature/earthquake_history/data/notifier/earthquake_history_data_source.dart`
- Modify: `app/test/feature/earthquake_history/earthquake_history_parameter_x_test.dart`
- Modify: `app/test/feature/earthquake_history/earthquake_history_data_source_fetch_test.dart`

**Interfaces:**
- Produces: `withRegion` が現在の `sortBy` / `sortOrder` を維持する。
- Produces: RefreshとAppendでCursor以外の全検索条件が同一になる。

- [ ] **Step 1: sort保持とAppend転送の失敗テストを書く**

`withRegion` の既存「eventIdへ強制」期待値を `magnitude` 維持へ変更する。
Spy repositoryは初回に `nextToken: 'page-2'`、追加取得に空ページを返し、2回のcall mapを比較する。

```dart
await dataSource.load(const Refresh());
await dataSource.load(const Append('page-2'));

final refresh = repository.searchByCityCalls[0];
final append = repository.searchByCityCalls[1];
expect(append['cursor'], 'page-2');
expect(
  {...append}..remove('cursor')..remove('limit'),
  {...refresh}..remove('cursor')..remove('limit'),
);
expect(append['sortBy'], EarthquakeSortBy.magnitude);
expect(append['intensityGte'], JmaIntensity.fiveLower);
```

call mapにはstatuses、epicenterCodes、earthquakeType、datasource、telegramTypes、
originTime、LPGM、緯度経度をすべて記録する。

- [ ] **Step 2: REDを確認する**

```bash
cd /home/yumnumm/.codex/worktrees/e3271883-deaf-4b62-b79c-c0622995f7e0/EQMonitor
mise exec -- flutter test \
  app/test/feature/earthquake_history/earthquake_history_parameter_x_test.dart \
  app/test/feature/earthquake_history/earthquake_history_data_source_fetch_test.dart
```

Expected: sortがeventIdへ変わり、地域検索で一部条件が欠落するためFAIL。

- [ ] **Step 3: 全条件転送を実装する**

`withRegion` の4分岐すべてで `sortBy: sortBy` を使う。
Repositoryの4地域検索メソッドへ `datasource`、`telegramTypes`、緯度経度を追加し、
生成APIクライアントへ渡す。DataSourceの4分岐もParameterの全共通フィールドをRepositoryへ渡す。
市区町村メソッドの戻り値を `PaginatedResponse<EarthquakePartialCity>` に合わせる。

- [ ] **Step 4: GREENを確認する**

```bash
cd /home/yumnumm/.codex/worktrees/e3271883-deaf-4b62-b79c-c0622995f7e0/EQMonitor
mise exec -- flutter test \
  app/test/feature/earthquake_history/earthquake_history_parameter_x_test.dart \
  app/test/feature/earthquake_history/earthquake_history_data_source_fetch_test.dart
```

Expected: PASS。

- [ ] **Step 5: Flutter commitを作る**

```bash
cd /home/yumnumm/.codex/worktrees/e3271883-deaf-4b62-b79c-c0622995f7e0/EQMonitor
git add app/lib/feature/earthquake_history/data/model/earthquake_history_parameter_x.dart \
  app/lib/feature/earthquake_history/data/repository/earthquake_history_repository.dart \
  app/lib/feature/earthquake_history/data/notifier/earthquake_history_data_source.dart \
  app/test/feature/earthquake_history/earthquake_history_parameter_x_test.dart \
  app/test/feature/earthquake_history/earthquake_history_data_source_fetch_test.dart
git commit -m "Fix: 地域検索でもソートと絞り込み条件を維持"
```

---

### Task 7: 最大震度と対象地域の観測震度を明記

**Files:**
- Modify: `app/lib/feature/earthquake_history/ui/components/earthquake_history_list_tile.dart`
- Create: `app/test/feature/earthquake_history/ui/earthquake_history_list_tile_test.dart`

**Interfaces:**
- Consumes: `EarthquakePartial` の粒度別観測震度と `earthquake.intensity.maxIntensity`。
- Produces: 地域指定時に「最大震度」と「東京都 観測震度」の形で表示する。

- [ ] **Step 1: 表示と文字拡大の失敗Widgetテストを書く**

最大震度7、東京都の観測震度5弱を持つPrefecture itemを作る。
`regionNameProvider(RegionSearchType.prefecture, '13')` を「東京都」でoverrideする。

```dart
expect(find.text('最大震度 7'), findsOneWidget);
expect(find.text('東京都 観測震度 5弱'), findsOneWidget);
expect(
  find.bySemanticsLabel(RegExp('最大震度7')),
  findsWidgets,
);
expect(tester.takeException(), isNull);
```

同じWidgetを
`MediaQuery(data: const MediaQueryData(textScaler: TextScaler.linear(2)), child: ...)`
でpumpし、overflow例外がないことも検証する。

- [ ] **Step 2: REDを確認する**

```bash
cd /home/yumnumm/.codex/worktrees/e3271883-deaf-4b62-b79c-c0622995f7e0/EQMonitor
mise exec -- flutter test \
  app/test/feature/earthquake_history/ui/earthquake_history_list_tile_test.dart
```

Expected: 現在は「最大震度」ラベルと「観測震度」文言がないためFAIL。

- [ ] **Step 3: 折り返し可能な震度表示を実装する**

地域指定時のsubtitleへ `Wrap(spacing: 4, runSpacing: 4)` を置き、既存の震度色解決を使う
2つのprivate Widgetを配置する。最大震度がnullなら最大震度側だけ非表示とし、観測震度は必ず表示する。
左端 `JmaIntensityIcon` を `Semantics(label: '最大震度${maxIntensity.label}')` で包む。
地域指定なしでは従来のsubtitleを維持する。

- [ ] **Step 4: GREENを確認する**

```bash
cd /home/yumnumm/.codex/worktrees/e3271883-deaf-4b62-b79c-c0622995f7e0/EQMonitor
mise exec -- flutter test \
  app/test/feature/earthquake_history/ui/earthquake_history_list_tile_test.dart
```

Expected: 通常scaleと2.0 scaleでPASS、overflowなし。

- [ ] **Step 5: Flutter commitを作る**

```bash
cd /home/yumnumm/.codex/worktrees/e3271883-deaf-4b62-b79c-c0622995f7e0/EQMonitor
git add app/lib/feature/earthquake_history/ui/components/earthquake_history_list_tile.dart \
  app/test/feature/earthquake_history/ui/earthquake_history_list_tile_test.dart
git commit -m "Feat: 最大震度と地域の観測震度を明記"
```

---

### Task 8: 全体検証とpush

**Files:**
- Verify only: Backend branch and Flutter branch changes

**Interfaces:**
- Produces: BackendとFlutterの独立した検証結果。

- [ ] **Step 1: Backend対象テストと静的検査を実行する**

```bash
cd backend/.worktrees/fix-earthquake-history-intensity-pagination
pnpm --dir api/api test -- src/features/earthquake/model/list-cursor.test.ts \
  src/features/earthquake/datasource/datasource.test.ts \
  src/features/earthquake/datasource/datasource.pglite.test.ts \
  test/earthquake/earthquake-routes.test.ts
pnpm --dir api/api-stub test
pnpm --dir api/api type-check
pnpm exec oxfmt --check \
  api/api/src/features/earthquake \
  api/api/test/earthquake/earthquake-routes.test.ts
```

Expected: 全コマンドexit 0。

- [ ] **Step 2: Flutter対象テストと解析を実行する**

```bash
cd /home/yumnumm/.codex/worktrees/e3271883-deaf-4b62-b79c-c0622995f7e0/EQMonitor
mise exec -- flutter test app/test/feature/earthquake_history/
mise exec -- dart test packages/eqmonitor_api/test/contract_drift_test.dart
cd app
mise exec -- flutter analyze lib/feature/earthquake_history
mise exec -- flutter analyze test/feature/earthquake_history
cd ../packages/eqmonitor_api
mise exec -- dart analyze
```

Expected: 全コマンドexit 0。既存の未コミットファイルを解析・整形で変更しない。

- [ ] **Step 3: 差分と生成同期を確認する**

```bash
cd /home/yumnumm/.codex/worktrees/e3271883-deaf-4b62-b79c-c0622995f7e0/EQMonitor
git --no-pager diff --check origin/fix/earthquake-history-intensity-pagination...HEAD
git -C backend/.worktrees/fix-earthquake-history-intensity-pagination \
  --no-pager diff --check origin/main...HEAD
rg -n "observedIntensity" \
  packages/eqmonitor_api/lib/src/models/intensity_*_search_item.dart
rg -n '"observed_intensity"' backend/api/api/openapi.json
```

Expected: whitespace errorなし、OpenAPIは一致。

- [ ] **Step 4: 明示承認後に両リモートへpushする**

```bash
git -C backend/.worktrees/fix-earthquake-history-intensity-pagination \
  push -u origin fix/earthquake-history-intensity-pagination
git push origin fix/earthquake-history-intensity-pagination
```

Expected: `YumNumm/eqmonitor-backend` と `YumNumm/EQMonitor` の同名ブランチが更新される。

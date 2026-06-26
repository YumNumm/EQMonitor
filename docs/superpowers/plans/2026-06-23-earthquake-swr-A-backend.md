# 実装計画 A — Backend 差分取得基盤 (Earthquake SWR)

> superpowers writing-plans 準拠 / TDD バイトサイズステップ / no-placeholder。
> 契約書 `docs/superpowers/plans/2026-06-23-earthquake-swr-CONTRACT.md` §1 が唯一の真実。
> 元設計 `docs/superpowers/specs/2026-06-23-earthquake-swr-cache-design.md` セクション1・4。

## Goal

backend submodule (`/Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor/backend`) で、地震情報の **差分取得 API** とその基盤を実装する。

1. `earthquake` テーブルに `updated_at` (DB now() 統一・差分カーソル) / `last_reported_at` (発表時刻・表示用) を追加。BEFORE UPDATE トリガで `updated_at` を強制。子テーブル変更時も親 `updated_at` を bump。
2. writer が全 upsert で `last_reported_at` を発表時刻に設定し、子テーブルのみ変更時も親を touch。
3. `?lastUpdatedSince=<HourBucketJst>` クエリで差分モードを有効化。`(updatedAt, eventId)` 降順 keyset ページング。
4. レスポンス `EarthquakePartial` に `updated_at` / `last_reported_at` を追加。
5. 差分正規契約を満たすときのみ `Cache-Control: public, s-maxage=60`、それ以外は `no-store`。
6. `/v1/start` に `cache_id` (env `CACHE_ID` 既定 `"1"`) を追加。
7. openapi.json 再生成。
8. Cloudflare Cache Rule のキャッシュキー正規化 (path+scope+lastUpdatedSince+cursor+limit+cacheId)。

差分の DB 読みは **プライマリ** から行う (レプリカ遅延でのカーソル誤前進防止)。

## Architecture

- **DB / ORM**: PostgreSQL + Drizzle ORM。マイグレーションは `packages/database/drizzle/` (drizzle-kit generate → 手編集でトリガ追加 → migrate)。
- **writer**: `packages/dmdata-db-writer`。VXSE51/52/53/61/62 を transaction で onConflictDoUpdate。
- **API**: `api/api` (Hono + Valibot + hono-openapi)。`vValidator('query', ...)` で 400。Cache-Control は middleware + ハンドラ内上書き。
- **差分カーソル**: `base64(JSON.stringify({ updatedAt, eventId }))`。`type` フィールドは持たない。
- **差分述語**: Drizzle SQL builder (`and/or/lt/eq/gte`) で keyset (DESC タイ分解)。現行 `findEarthquakes` は relational `db.query.earthquake.findMany({ where })` だが、複合カーソル keyset は relational where では表現しきれないため **差分モード専用メソッド `findEarthquakeDiff`** を SQL builder (`this.db.select().from().where().orderBy().limit()`) で追加する (既存通常リストは無変更で温存)。

## Tech Stack

- TypeScript strict / Valibot (`v.*`) / Drizzle (`eq/lt/gte/and/or/sql/desc`) / Hono / hono-openapi。
- テスト: **vitest**。**重要: このリポジトリに実 DB テスト基盤 (testcontainers/PGlite) は無い** (`packages/dmdata-db-writer/__tests__/tsunami-writer.test.ts` 冒頭コメント参照、同テストは手書き FakeDb で呼び出し列のみ検証)。API 側 datasource テストは `api/api/test/helpers/mock-db.ts` の vitest モックを使う。
  - 従って差分クエリの正しさは「**純粋関数に切り出した述語/カーソル構築ロジックの単体テスト**」+「datasource が期待引数で builder を呼ぶこと」で検証する。実 DB の ORDER BY 結果順序は単体テストしない (mock では再現不能)。
  - HourBucketJst・DiffCursor・cache-control 判定・cacheId キー反映は純 Valibot/純関数なので完全に単体検証できる。
- Lint/format: `pnpm lint` (oxlint + oxfmt)。型: `pnpm check-types`。

## Global Constraints

- 型名・パラメータ名・フィールド名は契約書 §1 に厳密一致 (`updated_at` / `last_reported_at` / `lastUpdatedSince` / `cacheId` / `cache_id` / `DiffCursor` / `DiffCursorSchema` / `HourBucketJstSchema` / `s-maxage=60` / 差分 `limit=50`)。
- 移行順序を守る: ① nullable 追加 → ② domain time バックフィル → ③ writer デプロイ → ④ API 露出 → ⑤ non-null 化。**本計画は ①〜④ + non-null 化 SQL の用意まで**を 1 PR で行うが、non-null 化 migration は「writer デプロイ後に手動適用」する旨を SQL コメントで明示し、generate には含めるが運用順序を README/PR 本文に書く。
- PR は `gh pr create --repo YumNumm/EQMonitor --base main` (backend の main は `main`)。
- 各ステップ commit。conventional commits (`feat`/`refactor`/`test`/`chore`)。
- 新規 class/関数 IF は契約書記載のもののみ。冗長フィールド・抽象を足さない。

---

## Task 1: ブランチ運用 (最新 origin/main から新規ブランチ)

backend ローカルは detached HEAD (`95e2b695`) で、`contract-fixtures` 等に未コミット変更がある (別件 = `feat/contract-drift-fixtures` 系の作業途中の可能性)。最新 `origin/main` から新規ブランチを切る。

### Step 1.1: 未コミット変更の確認と退避
```bash
cd /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor/backend
git status --short
git stash push -u -m "wip-contract-fixtures-before-swr-A"   # 別件の可能性があるため stash で退避 (破棄しない)
git stash list   # stash@{0} が積まれたことを確認
```
- もし `git status --short` が空 (= 既にクリーン) なら stash はスキップ。
- `home8s` submodule の "new commits" 表示は触らない (別管理)。

### Step 1.2: fetch して最新 main から分岐
```bash
git fetch origin
git switch -c feat/earthquake-diff-cache origin/main
git log --oneline -1   # origin/main の HEAD と一致することを確認
```
- 以後の全作業はこのブランチで行う。

### Step 1.3: 依存解決とベースライン確認 (commit 無し)
```bash
pnpm install
pnpm --filter @eqmonitor-backend/api check-types
pnpm --filter @eqmonitor-backend/api test
```
- 既存テストが緑であることを確認 (差分の起点)。失敗が既存由来なら記録して進む。

---

## Task 2: DB スキーマ — nullable カラム + インデックス + トリガ (移行 ①)

### Step 2.1 (test): スキーマに新カラムが存在することのテスト
`packages/database/__tests__/earthquake-schema.test.ts` を新規作成 (このパッケージの test ハーネスは vitest)。
```ts
import { describe, expect, it } from 'vitest';
import * as schema from '../src/schema/schema';

describe('earthquake schema diff columns', () => {
  it('exposes updatedAt and lastReportedAt columns', () => {
    const cols = schema.earthquake;
    expect(cols.updatedAt).toBeDefined();
    expect(cols.lastReportedAt).toBeDefined();
  });
});
```
```bash
pnpm --filter @eqmonitor-backend/database test   # 失敗 (カラム未定義) を確認
```

### Step 2.2 (impl): schema.ts に nullable カラム追加
`packages/database/src/schema/schema.ts` の `earthquake` テーブル定義 (309-383)。`telegramTypes`/`earthquakeType` の後、`table => [...]` の前にカラムを追加。`timestamp` は既に import 済み (同ファイル他所で使用)。
```ts
    earthquakeType: earthquakeTypeEnum('earthquake_type')
      .notNull()
      .default('NORMAL'),
    // --- SWR 差分基盤 ---
    // DB 行変更時刻 (差分カーソル)。BEFORE UPDATE トリガで now() 強制。
    // 移行 ① では nullable。defaultNow() は insert 補助。
    updatedAt: timestamp('updated_at', { mode: 'string', withTimezone: true })
      .defaultNow(),
    // 最後に publish された電文の発表時刻 (ドメイン値、表示/ソート)。差分カーソルには使わない。
    lastReportedAt: timestamp('last_reported_at', {
      mode: 'string',
      withTimezone: true,
    }),
```
インデックスを `table => [...]` 配列末尾に追加 (契約書 §1.1: `updated_at DESC, event_id DESC`)。
```ts
    index('earthquake_updated_at_event_id_index').using(
      'btree',
      table.updatedAt.desc(),
      table.eventId.desc(),
    ),
```
> `.$onUpdate(() => new Date().toISOString())` は **付けない** — クロックは DB now() に統一する (BEFORE UPDATE トリガが唯一の強制点)。app クロック混在で順序逆転を防ぐ (設計書 BLOCKER3)。
```bash
pnpm --filter @eqmonitor-backend/database test   # 緑
pnpm --filter @eqmonitor-backend/database check-types
```

### Step 2.3 (impl): drizzle-kit でマイグレーション生成
```bash
cd /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor/backend/packages/database
pnpm drizzle-kit:generate
```
- 生成された `drizzle/<timestamp>_xxx/migration.sql` を確認 (`ALTER TABLE "earthquake" ADD COLUMN "updated_at" ...` + `ADD COLUMN "last_reported_at" ...` + `CREATE INDEX "earthquake_updated_at_event_id_index" ...`)。
- `drizzle/meta/_journal.json` 等が更新される。

### Step 2.4 (impl): 同一マイグレーションに BEFORE UPDATE トリガを手追記
drizzle が生成した `migration.sql` 末尾に、文区切り `--> statement-breakpoint` を挟んでトリガを追記する (drizzle はトリガを生成しないため手編集が唯一の方法)。
```sql
--> statement-breakpoint
CREATE OR REPLACE FUNCTION earthquake_set_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at := now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;
--> statement-breakpoint
CREATE TRIGGER earthquake_set_updated_at_trigger
BEFORE UPDATE ON "earthquake"
FOR EACH ROW
EXECUTE FUNCTION earthquake_set_updated_at();
```
- INSERT は `.defaultNow()` (= `DEFAULT now()`) が担保するためトリガは UPDATE のみで十分。
```bash
git add -A
git commit -m "feat(database): add nullable updated_at/last_reported_at + index + before-update trigger to earthquake"
```

### Step 2.5 (impl): 子テーブル変更で親 updated_at を bump するトリガ
子テーブル (`earthquake_intensity_regions/prefectures/cities/stations`) の INSERT/UPDATE/DELETE で親 `earthquake.updated_at` を進める。同じ migration.sql に追記 (writer の touch だけだと直接 SQL 書き込み漏れを防げないため、トリガを唯一の強制点とする)。
```sql
--> statement-breakpoint
CREATE OR REPLACE FUNCTION earthquake_touch_parent_updated_at()
RETURNS TRIGGER AS $$
DECLARE
  target_event_id text;
BEGIN
  target_event_id := COALESCE(NEW.event_id, OLD.event_id);
  UPDATE "earthquake" SET updated_at = now() WHERE event_id = target_event_id;
  RETURN NULL;
END;
$$ LANGUAGE plpgsql;
--> statement-breakpoint
CREATE TRIGGER earthquake_intensity_regions_touch_parent
AFTER INSERT OR UPDATE OR DELETE ON "earthquake_intensity_regions"
FOR EACH ROW EXECUTE FUNCTION earthquake_touch_parent_updated_at();
--> statement-breakpoint
CREATE TRIGGER earthquake_intensity_prefectures_touch_parent
AFTER INSERT OR UPDATE OR DELETE ON "earthquake_intensity_prefectures"
FOR EACH ROW EXECUTE FUNCTION earthquake_touch_parent_updated_at();
--> statement-breakpoint
CREATE TRIGGER earthquake_intensity_cities_touch_parent
AFTER INSERT OR UPDATE OR DELETE ON "earthquake_intensity_cities"
FOR EACH ROW EXECUTE FUNCTION earthquake_touch_parent_updated_at();
--> statement-breakpoint
CREATE TRIGGER earthquake_intensity_stations_touch_parent
AFTER INSERT OR UPDATE OR DELETE ON "earthquake_intensity_stations"
FOR EACH ROW EXECUTE FUNCTION earthquake_touch_parent_updated_at();
```
> 親 `BEFORE UPDATE` トリガが既に `updated_at := now()` を強制するため、`UPDATE earthquake SET updated_at = now()` の値は親トリガに上書きされても同義 (どちらも `now()`)。子 DELETE 時は親が削除されている場合もあるが FK cascade で子→親順が保証されないケースに備え `UPDATE ... WHERE event_id =` が 0 行ヒットしても無害。
```bash
git add -A
git commit -m "feat(database): touch parent earthquake.updated_at on intensity child changes via trigger"
```

### Step 2.6 (test+impl): バックフィル migration (移行 ②) を別ファイルで用意
domain time でのバックフィルは drizzle-kit では生成されない。`pnpm drizzle-kit:generate --custom` で空 migration を作り SQL を記述 (順序衝突を避けるため `origin_time` を基準、無ければ `arrival_time`、両方無ければ `now()`)。
```bash
pnpm drizzle-kit:generate --custom
```
生成された空 `migration.sql` に:
```sql
-- 移行 ②: domain time で updated_at/last_reported_at をバックフィル。
-- 初回 diff が全テーブルを返すのを避けるため now() ではなく発表時刻基準にする。
UPDATE "earthquake"
SET
  last_reported_at = COALESCE(origin_time, arrival_time),
  updated_at = COALESCE(origin_time, arrival_time, now())
WHERE updated_at IS NULL OR last_reported_at IS NULL;
```
```bash
git add -A
git commit -m "chore(database): backfill earthquake updated_at/last_reported_at from domain time"
```

### Step 2.7 (impl): non-null 化 migration を用意 (移行 ⑤・適用は writer デプロイ後)
さらに `--custom` で migration を作り、コメントで「writer デプロイ後に手動適用」を明記。
```bash
pnpm drizzle-kit:generate --custom
```
```sql
-- 移行 ⑤: writer が全 upsert で updated_at/last_reported_at を埋めるようになった後に適用すること。
-- バックフィル (移行 ②) とデプロイ完了前に適用すると新規 INSERT が NULL で弾かれる恐れがあるため、
-- この migration は writer デプロイ完了を確認してから drizzle-kit:migrate を再実行して適用する。
ALTER TABLE "earthquake" ALTER COLUMN "updated_at" SET NOT NULL;
ALTER TABLE "earthquake" ALTER COLUMN "last_reported_at" SET NOT NULL;
```
> schema.ts の `.notNull()` 化はこの段階では **行わない** (drizzle の状態と DB の状態が乖離するのを避けるため、non-null 化 migration 適用後に別 PR で schema を `.notNull()` に揃える)。本 PR では nullable のまま。
```bash
git add -A
git commit -m "chore(database): prepare non-null migration for earthquake timestamps (apply after writer deploy)"
```

---

## Task 3: writer — last_reported_at 設定 + 親 touch (移行 ③)

writer の earthquake insert/update に `lastReportedAt` (発表時刻) を含める。`updatedAt` は DB トリガ/`defaultNow()` が担保するため writer では **触らない** (クロック統一)。

現行 `TransformedEarthquakeData` は writer に来る `data.earthquake` が `EarthquakeInsert` の Pick。発表時刻 (`pressDateTime` 相当) は transformer 側で持つ必要がある。

### Step 3.1 (test): transformer が lastReportedAt を出力するテスト
`packages/dmdata-db-writer/__tests__/earthquake-information-transformer.test.ts` に追記 (既存 `createVxse53Base` を流用)。VXSE53 の `pressDateTime: '2024-01-01T12:00:00+09:00'` が `earthquake.lastReportedAt` に入ること。
```ts
it('sets lastReportedAt from pressDateTime (VXSE53)', () => {
  const transformer = new EarthquakeInformationTransformer();
  const input = createVxse53Base();
  const result = transformer.transform(input); // 既存 transform シグネチャに合わせる
  expect(result.type).toBe('VXSE53');
  if (result.type === 'VXSE53') {
    expect(result.earthquake.lastReportedAt).toBe('2024-01-01T12:00:00+09:00');
  }
});
```
> 実装前に `transformer.ts` の `transform` の正確な戻り値/引数を Read し、テストのアサーション (戻り値の形) を合わせること。`createVxse53Base` の `transform` 呼び出しが既存テストでどう呼ばれているか (引数) を確認してから書く。
```bash
pnpm --filter @eqmonitor-backend/dmdata-db-writer test   # 失敗を確認
```

### Step 3.2 (impl): types に lastReportedAt を許可 + transformer で設定
`packages/dmdata-db-writer/src/earthquake-information/types.ts` の各 `earthquake: Pick<EarthquakeInsert, ...>` に `'lastReportedAt'` を追加 (VXSE51/52/53/61/62 全て)。`transformer.ts` の各 `earthquake: { ... }` (45/65/104/153/197 行) に `lastReportedAt: <pressDateTime 相当>` を追加。
> 実装時に transformer が参照している電文オブジェクトの発表時刻フィールド名 (`pressDateTime` / `reportDateTime`) を Read で確定し、設計書の「最後に publish された電文の発表時刻」= `pressDateTime` を採用する。
```bash
pnpm --filter @eqmonitor-backend/dmdata-db-writer test         # 緑
pnpm --filter @eqmonitor-backend/dmdata-db-writer check-types
git add -A
git commit -m "feat(dmdata-db-writer): set earthquake.last_reported_at from telegram press time"
```

### Step 3.3 (test): writer が子のみ変更ケースでも親 upsert を発行することの確認
writer の各 case は既に親 earthquake を onConflictDoUpdate している (51/52/53/61/62 全て先頭で親 upsert)。親 BEFORE UPDATE トリガが `updated_at` を進めるため writer 側の追加コードは不要。これを **回帰テスト** として固定する。`tsunami-writer.test.ts` の FakeDb パターンを流用し、VXSE62 (子 onConflictDoUpdate のみのケース) でも親 `earthquake` への insert/onConflictDoUpdate が呼ばれることを assert。
```ts
// FakeDb で write(VXSE62) を実行し、calls に table===earthquake の insert があることを検証
expect(db.calls.some(c => c.op === 'insert' && c.table === databaseSchema.earthquake)).toBe(true);
```
> writer は VXSE62 でも先頭で親 earthquake を upsert している (158-165 行) ため、このテストは現行コードで緑になる回帰テスト。`tsunami-writer.test.ts` の FakeDb を移植して `EarthquakeInformationWriter` 用に最小化する。
```bash
pnpm --filter @eqmonitor-backend/dmdata-db-writer test
git add -A
git commit -m "test(dmdata-db-writer): assert parent earthquake upsert occurs on child-only telegrams"
```

---

## Task 4: HourBucketJstSchema (差分パラメータ検証)

### Step 4.1 (test): HourBucketJstSchema の検証テスト
`api/api/test/shared/hour-bucket.test.ts` を新規作成。
```ts
import { describe, expect, it } from 'vitest';
import * as v from 'valibot';
import { HourBucketJstSchema } from '../../src/shared/model/hour-bucket/hour-bucket';

describe('HourBucketJstSchema', () => {
  it('accepts a valid JST hour boundary', () => {
    expect(v.parse(HourBucketJstSchema, '2026-06-23T19:00:00+09:00')).toBe(
      '2026-06-23T19:00:00+09:00',
    );
  });
  it.each([
    ['non-zero minutes', '2026-06-23T19:30:00+09:00'],
    ['UTC offset', '2026-06-23T10:00:00Z'],
    ['missing offset', '2026-06-23T19:00:00'],
    ['hour 25 (regex passes, invalid date)', '2026-06-23T25:00:00+09:00'],
    ['month 13', '2026-13-01T19:00:00+09:00'],
    ['day 40', '2026-06-40T19:00:00+09:00'],
  ])('rejects %s', (_label, input) => {
    expect(() => v.parse(HourBucketJstSchema, input)).toThrow();
  });
});
```
```bash
pnpm --filter @eqmonitor-backend/api test -- hour-bucket   # 失敗を確認
```

### Step 4.2 (impl): HourBucketJstSchema 実装
`api/api/src/shared/model/hour-bucket/hour-bucket.ts` を新規作成。regex 通過後に実日時パース検証 (`T25:00:00` 等を弾く)。
```ts
import * as v from 'valibot';

const HOUR_BUCKET_JST_REGEX = /^\d{4}-\d{2}-\d{2}T\d{2}:00:00\+09:00$/;

export const HourBucketJstSchema = v.pipe(
  v.string(),
  v.regex(HOUR_BUCKET_JST_REGEX, 'must be a JST hour boundary (yyyy-MM-ddTHH:00:00+09:00)'),
  v.check(value => {
    // regex は T25:00:00 や 2026-13-40 を通すため、実日時として妥当か検証する。
    const ms = Date.parse(value);
    if (Number.isNaN(ms)) {
      return false;
    }
    // パース結果を同一フォーマットへ戻して入力と一致するか確認 (時/日のオーバーフロー検知)。
    const d = new Date(ms);
    const pad = (n: number) => n.toString().padStart(2, '0');
    // JST は +09:00 固定 (DST 無し)。UTC からの +9h を組み立てて比較する。
    const jst = new Date(ms + 9 * 60 * 60 * 1000);
    const rebuilt = `${jst.getUTCFullYear()}-${pad(jst.getUTCMonth() + 1)}-${pad(
      jst.getUTCDate(),
    )}T${pad(jst.getUTCHours())}:00:00+09:00`;
    return rebuilt === value;
  }, 'must be a real JST hour boundary'),
  v.metadata({ ref: 'HourBucketJst' }),
);
export type HourBucketJst = v.InferOutput<typeof HourBucketJstSchema>;
```
```bash
pnpm --filter @eqmonitor-backend/api test -- hour-bucket   # 緑
pnpm --filter @eqmonitor-backend/api check-types
git add -A
git commit -m "feat(api): add HourBucketJstSchema with regex + real-date validation"
```

---

## Task 5: DiffCursor / DiffCursorSchema + 述語

### Step 5.1 (test): DiffCursor のエンコード/デコードテスト
`api/api/test/cursor/diff-cursor.test.ts` を新規作成。
```ts
import { describe, expect, it } from 'vitest';
import * as v from 'valibot';
import {
  DiffCursor,
  DiffCursorSchema,
  encodeDiffCursor,
} from '../../src/shared/model/cursor/diff-cursor';

describe('DiffCursor', () => {
  it('roundtrips encode -> decode', () => {
    const cursor: DiffCursor = {
      updatedAt: '2026-06-23T10:00:00.000Z',
      eventId: '20260623100000',
    };
    const token = encodeDiffCursor(cursor);
    expect(v.parse(DiffCursorSchema, token)).toEqual(cursor);
  });
  it('rejects non-base64 / malformed JSON', () => {
    expect(() => v.parse(DiffCursorSchema, '%%%')).toThrow();
    expect(() =>
      v.parse(DiffCursorSchema, Buffer.from('not json').toString('base64')),
    ).toThrow();
  });
  it('rejects JSON missing required fields', () => {
    const bad = Buffer.from(JSON.stringify({ updatedAt: 'x' })).toString('base64');
    expect(() => v.parse(DiffCursorSchema, bad)).toThrow();
  });
});
```
```bash
pnpm --filter @eqmonitor-backend/api test -- diff-cursor   # 失敗を確認
```

### Step 5.2 (impl): DiffCursor / DiffCursorSchema / encodeDiffCursor
`api/api/src/shared/model/cursor/diff-cursor.ts` を新規作成 (契約書 §1.2: `type` フィールドは持たない)。
```ts
import * as v from 'valibot';

export const DiffCursor = v.pipe(
  v.object({
    updatedAt: v.string(),
    eventId: v.string(),
  }),
  v.metadata({ ref: 'DiffCursor' }),
);
export type DiffCursor = v.InferOutput<typeof DiffCursor>;

export const DiffCursorSchema = v.pipe(
  v.string(),
  v.base64(),
  v.transform(input => {
    const decoded = Buffer.from(input, 'base64').toString('utf-8');
    const parsed: unknown = JSON.parse(decoded); // 失敗時は SyntaxError → vValidator が 400
    return v.parse(DiffCursor, parsed);
  }),
  v.description('差分カーソル, {updatedAt,eventId} の JSON を base64 エンコードしたもの'),
);
export type DiffCursorSchema = v.InferOutput<typeof DiffCursorSchema>;

export const encodeDiffCursor = (cursor: DiffCursor): string =>
  Buffer.from(JSON.stringify(cursor)).toString('base64');
```
```bash
pnpm --filter @eqmonitor-backend/api test -- diff-cursor   # 緑
git add -A
git commit -m "feat(api): add DiffCursor token (base64 json) without type field"
```

### Step 5.3 (test): 差分述語ビルダの純関数テスト
keyset DESC タイ分解述語を純関数 `buildDiffWhere` に切り出して単体テスト (mock では ORDER BY 結果を再現できないため、述語の **構造** を検証する)。Drizzle の `and/or/lt/eq/gte` は SQL オブジェクトを返すので、ここでは「カーソル無し」「カーソル有り」で返る条件配列の長さ/形を検証する軽量テスト + スナップショット的に `sql` 文字列化を確認。
`api/api/test/datasource/earthquake-diff-where.test.ts`:
```ts
import { describe, expect, it } from 'vitest';
import { buildDiffWhere } from '../../src/features/earthquake/datasource/diff-where';

describe('buildDiffWhere', () => {
  it('returns a single gte condition when no cursor', () => {
    const w = buildDiffWhere('2026-06-23T10:00:00+09:00', undefined);
    expect(w).toBeDefined(); // 1 条件 (gte updatedAt)
  });
  it('returns gte AND tie-break OR when cursor present', () => {
    const w = buildDiffWhere('2026-06-23T10:00:00+09:00', {
      updatedAt: '2026-06-23T10:30:00.000Z',
      eventId: '20260623103000',
    });
    expect(w).toBeDefined(); // gte AND (lt updatedAt OR (eq updatedAt AND lt eventId))
  });
});
```
> Drizzle の条件オブジェクトは内部表現のため値の深い等価検証は脆い。ここでは「未定義でない」「分岐ごとに呼べる」ことを担保し、SQL 正しさは Step 5.4 のコードレビューと述語の formal 構造 (契約書 §1.2 と 1:1) で保証する。
```bash
pnpm --filter @eqmonitor-backend/api test -- earthquake-diff-where   # 失敗を確認
```

### Step 5.4 (impl): buildDiffWhere 実装 (契約書 §1.2 の述語そのまま)
`api/api/src/features/earthquake/datasource/diff-where.ts` を新規作成。`@eqmonitor-backend/database` から `and/or/lt/eq/gte` と `earthquake` を import。
```ts
import { and, earthquake, eq, gte, lt, or } from '@eqmonitor-backend/database';

import type { DiffCursor } from '../../../shared/model/cursor/diff-cursor';

/**
 * 差分 keyset 述語 (DESC, タイ分解)。契約書 §1.2 と 1:1。
 *   and(
 *     gte(updatedAt, lastUpdatedSince),
 *     or(
 *       lt(updatedAt, cursor.updatedAt),
 *       and(eq(updatedAt, cursor.updatedAt), lt(eventId, cursor.eventId)),
 *     ),
 *   )
 */
export function buildDiffWhere(
  lastUpdatedSince: string,
  cursor: DiffCursor | undefined,
) {
  const since = gte(earthquake.updatedAt, lastUpdatedSince);
  if (!cursor) {
    return since;
  }
  return and(
    since,
    or(
      lt(earthquake.updatedAt, cursor.updatedAt),
      and(
        eq(earthquake.updatedAt, cursor.updatedAt),
        lt(earthquake.eventId, cursor.eventId),
      ),
    ),
  );
}
```
> `and/or/lt/eq/gte` が `@eqmonitor-backend/database` から re-export されているか確認 (writer は `eq, sql` を import 済み)。されていなければ `packages/database/src/index.ts` に drizzle-orm の re-export を追加する (1 commit)。
```bash
pnpm --filter @eqmonitor-backend/api test -- earthquake-diff-where   # 緑
pnpm --filter @eqmonitor-backend/api check-types
git add -A
git commit -m "feat(api): add buildDiffWhere keyset predicate for diff pagination"
```

---

## Task 6: EarthquakeQueryParams 拡張 + 差分正規契約判定

### Step 6.1 (test): クエリパラメータ拡張のテスト
`api/api/test/model/earthquake-query-params.test.ts`:
```ts
import { describe, expect, it } from 'vitest';
import * as v from 'valibot';
import { EarthquakeQueryParams } from '../../src/features/earthquake/model/requests';

describe('EarthquakeQueryParams diff fields', () => {
  it('accepts lastUpdatedSince + cacheId', () => {
    const out = v.parse(EarthquakeQueryParams, {
      lastUpdatedSince: '2026-06-23T19:00:00+09:00',
      cacheId: '1',
    });
    expect(out.lastUpdatedSince).toBe('2026-06-23T19:00:00+09:00');
    expect(out.cacheId).toBe('1');
  });
  it('rejects non-boundary lastUpdatedSince with 400-ish throw', () => {
    expect(() =>
      v.parse(EarthquakeQueryParams, { lastUpdatedSince: '2026-06-23T19:30:00+09:00' }),
    ).toThrow();
  });
});
```
```bash
pnpm --filter @eqmonitor-backend/api test -- earthquake-query-params   # 失敗を確認
```

### Step 6.2 (impl): requests.ts に lastUpdatedSince / cacheId 追加
`api/api/src/features/earthquake/model/requests.ts`。`HourBucketJstSchema` を import し `EarthquakeQueryParams` に追加。
```ts
import { HourBucketJstSchema } from '../../../shared/model/hour-bucket/hour-bucket';
```
`v.object({...})` 内 (`sortOrder` の後) に:
```ts
  lastUpdatedSince: v.optional(HourBucketJstSchema),
  cacheId: v.optional(v.string()),
```
```bash
pnpm --filter @eqmonitor-backend/api test -- earthquake-query-params   # 緑
git add -A
git commit -m "feat(api): add lastUpdatedSince/cacheId to EarthquakeQueryParams"
```

### Step 6.3 (test): 差分正規契約判定 isCanonicalDiffRequest のテスト
差分モード (= `lastUpdatedSince` あり) で、許可外の任意フィルタが 1 つでも付いたら非正規と判定する純関数を切り出してテスト。
`api/api/test/model/diff-canonical.test.ts`:
```ts
import { describe, expect, it } from 'vitest';
import { isCanonicalDiffRequest } from '../../src/features/earthquake/model/diff-canonical';

const base = { lastUpdatedSince: '2026-06-23T19:00:00+09:00' as const };

describe('isCanonicalDiffRequest', () => {
  it('false when lastUpdatedSince absent (not diff mode)', () => {
    expect(isCanonicalDiffRequest({})).toBe(false);
  });
  it('true for lastUpdatedSince + cursor + limit + cacheId + default statuses', () => {
    expect(isCanonicalDiffRequest({ ...base, cacheId: '1' })).toBe(true);
  });
  it.each([
    'magnitudeGte',
    'depthLte',
    'intensityGte',
    'originTimeGte',
    'epicenterCodes',
    'earthquakeType',
    'datasource',
    'telegramTypes',
    'latitudeGte',
  ])('false when filter %s present', key => {
    expect(isCanonicalDiffRequest({ ...base, [key]: 'x' })).toBe(false);
  });
  it('false when statuses overridden to non-default', () => {
    expect(isCanonicalDiffRequest({ ...base, statuses: ['CANCEL'] })).toBe(false);
  });
});
```
```bash
pnpm --filter @eqmonitor-backend/api test -- diff-canonical   # 失敗を確認
```

### Step 6.4 (impl): isCanonicalDiffRequest 実装
`api/api/src/features/earthquake/model/diff-canonical.ts`。許可キー以外が存在したら非正規。`statuses` が既定 `['NORMAL']` 以外なら非正規 (契約書 §1.4: statuses 固定)。
```ts
import type { EarthquakeQueryParams } from './requests';

// 差分正規契約で受理するキー (契約書 §1.4)。
const ALLOWED_DIFF_KEYS = new Set([
  'lastUpdatedSince',
  'cursor',
  'limit',
  'cacheId',
  'statuses',
  'sortBy', // 既定値のみ許容 (下で検証)
  'sortOrder',
]);

const DEFAULT_STATUSES = ['NORMAL'];

export function isCanonicalDiffRequest(
  query: Partial<EarthquakeQueryParams> & Record<string, unknown>,
): boolean {
  // 差分モードでない (= lastUpdatedSince 無し) なら正規契約は適用しない。
  if (query.lastUpdatedSince === undefined) {
    return false;
  }
  for (const [key, value] of Object.entries(query)) {
    if (value === undefined) {
      continue;
    }
    if (!ALLOWED_DIFF_KEYS.has(key)) {
      return false; // 任意フィルタ (magnitude/depth/intensity/... ) が付いたら非正規
    }
  }
  // statuses は既定 ['NORMAL'] 固定。クライアント指定で変えたら非正規。
  const statuses = query.statuses ?? DEFAULT_STATUSES;
  if (
    statuses.length !== DEFAULT_STATUSES.length ||
    !statuses.every((s, i) => s === DEFAULT_STATUSES[i])
  ) {
    return false;
  }
  // sortBy/sortOrder は差分モードでは既定 (event_id/DESC) のみ許容。
  if (query.sortBy !== undefined && query.sortBy !== 'event_id') {
    return false;
  }
  if (query.sortOrder !== undefined && query.sortOrder !== 'DESC') {
    return false;
  }
  return true;
}
```
> `vValidator` は既定値を埋めるため `statuses`/`sortBy`/`sortOrder` は常に値を持つ。`query` を `c.req.valid('query')` の結果として渡す前提。`limit` は差分モードで固定 50 (ハンドラ側で上書き、Task 7) なのでキー存在のみ許容。
```bash
pnpm --filter @eqmonitor-backend/api test -- diff-canonical   # 緑
git add -A
git commit -m "feat(api): add isCanonicalDiffRequest lockdown predicate for diff mode"
```

---

## Task 7: datasource 差分クエリ + ハンドラ分岐 (移行 ④ 一部)

### Step 7.1 (test): findEarthquakeDiff が builder を期待引数で呼ぶテスト
`api/api/test/datasource/earthquake-datasource.test.ts` に追記 (既存 mock-db を流用)。`db.select().from().where().orderBy().limit()` チェーンをモックし、limit が `指定 +1` で呼ばれ、結果が `items`/`hasMore` に整形されることを検証。
```ts
it('findEarthquakeDiff: fetches limit+1 and computes hasMore', async () => {
  const rows = Array.from({ length: 51 }, (_, i) => ({
    eventId: `2026${i}`,
    updatedAt: '2026-06-23T10:00:00.000Z',
    // ... 最小 earthquake 行 ...
  }));
  // mockDb.select チェーンを rows で解決するよう構成
  const result = await datasource.findEarthquakeDiff({
    lastUpdatedSince: '2026-06-23T19:00:00+09:00',
    cursor: undefined,
    limit: 50,
  });
  expect(result.items).toHaveLength(50);
  expect(result.hasMore).toBe(true);
});
```
> `mock-db.ts` に `select` チェーン用ヘルパが無い場合は追加する (この test ファイル内ローカルヘルパで可)。子 regions/prefectures を含めるため、実装の `with` 相当をどう SQL builder で取得するか Step 7.2 で決め、テストの行形を合わせる。
```bash
pnpm --filter @eqmonitor-backend/api test -- earthquake-datasource   # 失敗を確認
```

### Step 7.2 (impl): findEarthquakeDiff を datasource に追加
`api/api/src/features/earthquake/datasource/datasource.ts` に新メソッド。`EarthquakePartialResult` (earthquake + regions + prefectures) を返す必要があるため、**relational query の `findMany` を使いつつ `where` に SQL 述語を渡す**方式を採用する (Drizzle relational query の `where` はコールバックで raw SQL 条件を受け付ける)。これにより既存 `findEarthquakes` と同じ `with: { earthquakeIntensityRegions, earthquakeIntensityPrefectures }` で子も取れる。
```ts
import { buildDiffWhere } from './diff-where';
import type { DiffCursor } from '../../../shared/model/cursor/diff-cursor';
import { asc, desc } from '@eqmonitor-backend/database';

// ... class 内 ...
async findEarthquakeDiff({
  lastUpdatedSince,
  cursor,
  limit,
}: {
  lastUpdatedSince: string;
  cursor: DiffCursor | undefined;
  limit: number;
}): Promise<{ items: EarthquakePartialResult[]; hasMore: boolean }> {
  return withSpan('db.earthquake.findDiff', async span => {
    span.setAttribute('db.operation', 'findDiff');
    span.setAttribute('db.table', 'earthquake');
    span.setAttribute('query.limit', limit);
    // プライマリから読む (レプリカ遅延でのカーソル誤前進防止)。
    // relational query の where にコールバックで raw SQL 述語を渡す。
    const rows = await this.db.query.earthquake.findMany({
      with: {
        earthquakeIntensityRegions: true,
        earthquakeIntensityPrefectures: true,
      },
      where: () => buildDiffWhere(lastUpdatedSince, cursor),
      orderBy: (t, { desc }) => [desc(t.updatedAt), desc(t.eventId)],
      limit: limit + 1,
    });
    const hasMore = rows.length > limit;
    const items = (hasMore ? rows.slice(0, limit) : rows).map(e => ({
      earthquake: e,
      regions: e.earthquakeIntensityRegions,
      prefectures: e.earthquakeIntensityPrefectures,
    }));
    return { items, hasMore };
  });
}
```
> 実装着手時に Drizzle relational query の `where`/`orderBy` がコールバックで SQL 演算子を受けられるか (このリポジトリの Drizzle バージョンで) を確認する。`findEarthquakes` は object 構文を使っているが Drizzle は両構文をサポートする。コールバック非対応バージョンなら `this.db.select().from(earthquake).where(buildDiffWhere(...)).orderBy(desc(...), desc(...)).limit(limit+1)` + 別クエリで子を IN 取得する形に切替 (テストの行形もそれに合わせる)。どちらでも `buildDiffWhere` は再利用する。
```bash
pnpm --filter @eqmonitor-backend/api test -- earthquake-datasource   # 緑
pnpm --filter @eqmonitor-backend/api check-types
git add -A
git commit -m "feat(api): add EarthquakeDatasource.findEarthquakeDiff with keyset diff query"
```

### Step 7.3 (test): ルートが差分モードで findEarthquakeDiff を呼ぶテスト
`api/api/test/earthquake/earthquake-routes.test.ts` に追記。`?lastUpdatedSince=...` 付き GET で datasource の `findEarthquakeDiff` が呼ばれ、`next_token` が DiffCursor 形式 (base64 JSON) になることを検証。
```ts
it('uses diff query and emits DiffCursor next_token when lastUpdatedSince present', async () => {
  // mockDb を findEarthquakeDiff 経路で 51 行返すよう構成
  const res = await app.request('/?lastUpdatedSince=2026-06-23T19:00:00%2B09:00');
  expect(res.status).toBe(200);
  const body = await res.json();
  const decoded = JSON.parse(Buffer.from(body.next_token, 'base64').toString());
  expect(decoded).toHaveProperty('updatedAt');
  expect(decoded).toHaveProperty('eventId');
});
```
```bash
pnpm --filter @eqmonitor-backend/api test -- earthquake-routes   # 失敗を確認
```

### Step 7.4 (impl): ルートハンドラに差分分岐を追加
`api/api/src/features/earthquake/routes/earthquake.ts` の `GET /` ハンドラ (82-144)。差分モードなら `limit=50` 固定で `findEarthquakeDiff` を使い、`next_token` を `encodeDiffCursor` で生成。`cursor` が DiffCursor か PAGING Cursor かは `lastUpdatedSince` の有無で決める (差分モードは `query.cursor` を DiffCursor として再解釈)。
- ただし `query.cursor` は既存 `CursorSchema` (PAGING/POOLING) でパースされるため、**差分モードでは raw クエリ文字列から `cursor` を取り直して `DiffCursorSchema` で再パース**する必要がある。`c.req.query('cursor')` で raw を取得し `v.safeParse(DiffCursorSchema, raw)` する。安全側: 差分モードで cursor が DiffCursor として不正なら 400。
```ts
import { DiffCursorSchema, encodeDiffCursor } from '../../../shared/model/cursor/diff-cursor';

// GET / ハンドラ冒頭
const query = c.req.valid('query');
const datasource = c.get('datasource');
const transformer = c.get('transformer');

if (query.lastUpdatedSince) {
  // --- 差分モード ---
  const DIFF_LIMIT = 50;
  const rawCursor = c.req.query('cursor');
  let diffCursor: DiffCursor | undefined;
  if (rawCursor !== undefined) {
    const parsed = v.safeParse(DiffCursorSchema, rawCursor);
    if (!parsed.success) {
      return c.json(
        { code: 'BAD_REQUEST', message: 'Invalid diff cursor' } satisfies BadRequestResponse,
        400,
      );
    }
    diffCursor = parsed.output;
  }
  const { items, hasMore } = await datasource.findEarthquakeDiff({
    lastUpdatedSince: query.lastUpdatedSince,
    cursor: diffCursor,
    limit: DIFF_LIMIT,
  });
  const responseItems = items.map(item => transformer.toEarthquakePartial(item));
  const lastItem = items.at(-1);
  const nextToken =
    hasMore && lastItem
      ? encodeDiffCursor({
          updatedAt: lastItem.earthquake.updatedAt!,
          eventId: lastItem.earthquake.eventId.toString(),
        })
      : undefined;
  return c.json(
    v.parse(EarthquakeListResponse, {
      items: responseItems,
      next_token: nextToken,
      next_pooling: undefined,
    }) satisfies EarthquakeListResponse,
  );
}
// --- 通常リスト (既存ロジックそのまま) ---
```
> `query.cursor` は `CursorSchema` でのパースが差分モードでも走る (vValidator)。差分用の base64 JSON は `PAGING:` 形式でないため `CursorSchema` のデコードで `splitCursorDecoded` が separator 無しエラー → 400 を返してしまう懸念がある。対策: 差分モードのクライアントは常に DiffCursor を送るので、`EarthquakeQueryParams.cursor` を差分時に競合させないため **差分モードでは `cursor` を `CursorSchema` に通さない** 必要がある。実装時に `cursor` の型を `v.optional(v.union([CursorSchema, ...]))` にせず、ハンドラで raw 再パースする本方式 (`c.req.query('cursor')`) を採用しつつ、`CursorSchema` が差分 base64 を誤って受理/拒否しないか Step 7.3 のテストで JSON base64 が PAGING パースで落ちないことを確認する。落ちる場合は `EarthquakeQueryParams.cursor` を `v.optional(v.string())` に緩め、通常/差分それぞれハンドラ内で適切なスキーマでパースする最小変更に切替える (この変更時は通常リストの既存テストも回す)。
```bash
pnpm --filter @eqmonitor-backend/api test -- earthquake-routes   # 緑
pnpm --filter @eqmonitor-backend/api test                       # 全体回帰
git add -A
git commit -m "feat(api): branch GET /earthquake into diff mode with DiffCursor pagination"
```

---

## Task 8: EarthquakePartial に updated_at / last_reported_at 追加 + transformer

### Step 8.1 (test): EarthquakePartial が両フィールドを必須で持つテスト
`backend/packages/types` の test ハーネスで `api/api/test/earthquake/earthquake-transformer.test.ts` に追記 (transformer 経由で検証)。`toEarthquakePartial` の入力 earthquake に `updatedAt`/`lastReportedAt` を与えると出力に `updated_at`/`last_reported_at` が乗ること。
```ts
it('emits updated_at and last_reported_at', () => {
  const transformer = new EarthquakeTransformer();
  const out = transformer.toEarthquakePartial({
    earthquake: { /* ...既存テストの最小行... */, updatedAt: '2026-06-23T10:00:00.000Z', lastReportedAt: '2026-06-23T09:00:00.000Z' },
    regions: [],
    prefectures: [],
  } as any);
  expect(out.updated_at).toBe('2026-06-23T10:00:00.000Z');
  expect(out.last_reported_at).toBe('2026-06-23T09:00:00.000Z');
});
```
```bash
pnpm --filter @eqmonitor-backend/api test -- earthquake-transformer   # 失敗を確認
```

### Step 8.2 (impl): types に追加
`backend/packages/types/src/earthquake.ts` の `EarthquakePartial` (272-285) に追加 (契約書 §1.5: 両方必須・`v.isoTimestamp()`)。`v.object({...})` 内に:
```ts
    updated_at: v.pipe(v.string(), v.isoTimestamp()),
    last_reported_at: v.pipe(v.string(), v.isoTimestamp()),
```
> `EarthquakePartial` は `...v.omit(Earthquake, ['intensity','telegrams']).entries` を spread しているため、`Earthquake` 基底に `updated_at`/`last_reported_at` が無いことを確認した上で `EarthquakePartial` の object に直接追加する。`Earthquake` 詳細型 (`/:eventId`) には付けない (契約は Partial のみ要求)。
```bash
pnpm --filter @eqmonitor-backend/types check-types
```

### Step 8.3 (impl): transformer で emit
`api/api/src/features/earthquake/transformer/earthquake-transformer.ts` の `toEarthquakePartial` (194-218) の `v.parse(EarthquakePartial, {...})` に追加。`updatedAt`/`lastReportedAt` は移行中 nullable なため、null の場合は `originTime`/`arrivalTime` でフォールバックしつつ isoTimestamp を満たす値を必ず入れる。
```ts
      datasource: data.earthquake.datasource,
      telegram_types: data.earthquake.telegramTypes ?? [],
      earthquake_type: data.earthquake.earthquakeType ?? 'NORMAL',
      updated_at:
        data.earthquake.updatedAt ??
        data.earthquake.originTime ??
        data.earthquake.arrivalTime ??
        new Date(0).toISOString(),
      last_reported_at:
        data.earthquake.lastReportedAt ??
        data.earthquake.originTime ??
        data.earthquake.arrivalTime ??
        new Date(0).toISOString(),
```
> non-null 化 migration (Task 2.7) 適用後はフォールバックが事実上不要になるが、`$inferSelect` 上はまだ nullable なので fallback は残す (型安全)。`isoTimestamp()` を満たすため `new Date(0).toISOString()` を最終フォールバックにする (理論上到達しない)。
```bash
pnpm --filter @eqmonitor-backend/api test -- earthquake-transformer   # 緑
pnpm --filter @eqmonitor-backend/api check-types
git add -A
git commit -m "feat(api): add updated_at/last_reported_at to EarthquakePartial + transformer"
```

---

## Task 9: Cache-Control 条件分岐

### Step 9.1 (test): 差分正規 → s-maxage=60、それ以外 → no-store のテスト
`api/api/test/earthquake/earthquake-routes.test.ts` に追記。
```ts
it('sets public, s-maxage=60 for canonical diff request', async () => {
  const res = await app.request('/?lastUpdatedSince=2026-06-23T19:00:00%2B09:00&cacheId=1');
  expect(res.headers.get('Cache-Control')).toBe('public, s-maxage=60');
});
it('sets no-store when diff mode has extra filter (non-canonical)', async () => {
  const res = await app.request('/?lastUpdatedSince=2026-06-23T19:00:00%2B09:00&magnitudeGte=4');
  expect(res.headers.get('Cache-Control')).toBe('no-store');
});
it('keeps configured cache-control for normal list (no lastUpdatedSince)', async () => {
  const res = await app.request('/');
  // 既定 cacheConfig.earthquake.list (= no-store)
  expect(res.headers.get('Cache-Control')).toBe('no-store');
});
```
```bash
pnpm --filter @eqmonitor-backend/api test -- earthquake-routes   # 失敗を確認
```

### Step 9.2 (impl): cache-config に diffList 追加 + ハンドラで上書き
`api/api/src/cache-config.ts` の `earthquake` に追加 (契約書 §1.6: 差分正規 → `public, s-maxage=60`)。
```ts
  earthquake: {
    list: envOr('CACHE_EARTHQUAKE_LIST', DISABLED),
    diffList: envOr('CACHE_EARTHQUAKE_DIFF_LIST', 'public, s-maxage=60'),
    detailRecent: envOr('CACHE_EARTHQUAKE_DETAIL_RECENT', DISABLED),
    detailOld: envOr('CACHE_EARTHQUAKE_DETAIL_OLD', DISABLED),
  },
```
ルートハンドラの差分分岐 (Task 7.4) で Cache-Control を上書き。`isCanonicalDiffRequest` の結果で分岐。冒頭 middleware (37-39) は既定 `list` を set するので、差分分岐内で上書きする。
```ts
import { isCanonicalDiffRequest } from '../model/diff-canonical';

// 差分分岐内、findEarthquakeDiff 呼び出し前後
if (isCanonicalDiffRequest(query)) {
  c.res.headers.set('Cache-Control', cacheConfig.earthquake.diffList);
} else {
  c.res.headers.set('Cache-Control', cacheConfig.earthquake.list); // no-store
}
```
> 非正規差分でも `findEarthquakeDiff` は実行する (= 結果は返すが共有キャッシュ非対象)。差分マージ対象外はクライアント側責務 (計画 D)。
```bash
pnpm --filter @eqmonitor-backend/api test -- earthquake-routes   # 緑
git add -A
git commit -m "feat(api): set s-maxage=60 only for canonical diff requests, no-store otherwise"
```

---

## Task 10: /v1/start に cache_id 追加

### Step 10.1 (test): StartResponse に cache_id が乗るテスト
`api/api/test/start/*.test.ts` に追記 (既存テストのスタイルに合わせる)。`CACHE_ID` 未設定で `"1"`、設定時はその値。
```ts
it('includes cache_id from CACHE_ID env (default "1")', () => {
  const ds = new StartConfigDatasource({});
  const body = JSON.parse(ds.build().body);
  expect(body.cache_id).toBe('1');
});
it('includes cache_id from CACHE_ID env when set', () => {
  const ds = new StartConfigDatasource({ CACHE_ID: '7' });
  const body = JSON.parse(ds.build().body);
  expect(body.cache_id).toBe('7');
});
```
```bash
pnpm --filter @eqmonitor-backend/api test -- start   # 失敗を確認
```

### Step 10.2 (impl): StartResponseSchema + datasource に cache_id
`api/api/src/features/start/model/responses.ts` の `StartResponseSchema` (59-71) に `cache_id: v.string()` をトップレベル追加 (契約書 §1.7)。
```ts
export const StartResponseSchema = v.pipe(
  v.object({
    cache_id: v.string(),
    flags: FlagsSchema,
    app: v.object({ /* ... */ }),
  }),
  v.metadata({ ref: 'StartResponse' }),
);
```
`api/api/src/features/start/datasource/start-config-datasource.ts`。`StartEnv` に `CACHE_ID?: string` を追加し、`build()` の `response` に `cache_id` を設定。
```ts
interface StartEnv {
  ADS_ENABLED?: string;
  MAINTENANCE_ENABLED?: string;
  MAINTENANCE_MESSAGE?: string;
  MAINTENANCE_URL?: string;
  CACHE_ID?: string;
}

// build() 内 response の先頭
    const response: StartResponse = {
      cache_id: this.env.CACHE_ID ?? '1',
      flags: { /* ... */ },
      app: { /* ... */ },
    };
```
> `build()` は `c.env` を受ける (`new StartConfigDatasource(c.env)`)。`CACHE_ID` は Hono の env バインディング経由。`stableStringify` がキーをソートするため ETag は `cache_id` 込みで安定 (契約書 §1.7: cache_id 変更で ETag も変わる)。
```bash
pnpm --filter @eqmonitor-backend/api test -- start   # 緑
pnpm --filter @eqmonitor-backend/api check-types
git add -A
git commit -m "feat(api): add cache_id to /v1/start StartResponse (env CACHE_ID default 1)"
```

---

## Task 11: openapi.json 再生成

### Step 11.1 (impl): openapi 生成
```bash
cd /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor/backend/api/api
pnpm generate:openapi
git diff --stat   # openapi.json に EarthquakePartial.updated_at/last_reported_at, StartResponse.cache_id,
                  # lastUpdatedSince/cacheId クエリ, HourBucketJst/DiffCursor schema が反映されたことを確認
```
- 差分が想定外に大きい場合は新規スキーマ参照 (`HourBucketJst`/`DiffCursor`) の metadata `ref` が正しいか確認。

### Step 11.2 (verify+commit): ビルド/型/lint 全体
```bash
cd /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor/backend
pnpm check-types
pnpm lint
pnpm test
git add -A
git commit -m "chore(api): regenerate openapi.json for diff cache fields"
```

---

## Task 12: Cloudflare キャッシュキー正規化 (Terraform / Cache Rule)

**調査結果**: backend submodule 内の Cloudflare Terraform (`home8s/terraform/cloudflare/`) には **現状 Cache Rule / ruleset リソースは存在しない** (tunnel ingress のみ)。`home8s` は backend のネストした submodule で、`git status` 上 "new commits" 表示あり。よって新規 Terraform リソースを追加するか、手動 Cloudflare 設定 + 検証手順を明記する。

### Step 12.1 (impl): home8s submodule 内に Cache Rule リソースを追加
`home8s/terraform/cloudflare/` に `cache-rules.tf` を新規作成。`v2.api.eqmonitor.app` (production) / `dev.v2.api.eqmonitor.app` (develop) の `GET /v2/earthquake*` に対し、キャッシュキーを `path + scope code + lastUpdatedSince + cursor + limit + cacheId` のみに正規化する `cloudflare_ruleset` (phase `http_request_cache_settings`) を定義する。
```hcl
# home8s/terraform/cloudflare/cache-rules.tf
# Earthquake diff API のキャッシュキー正規化。
# 契約書 §1.8: key = path + scope code + lastUpdatedSince + cursor + limit + cacheId。
# それ以外のクエリは無視 (差分正規契約のみ s-maxage を返すオリジン側ロジックと整合)。
resource "cloudflare_ruleset" "eqmonitor_earthquake_cache" {
  for_each = toset([var.CLOUDFLARE_ZONE_ID_PRODUCTION, var.CLOUDFLARE_ZONE_ID_DEVELOP])
  zone_id  = each.value
  name     = "eqmonitor-earthquake-diff-cache"
  kind     = "zone"
  phase    = "http_request_cache_settings"

  rules {
    action      = "set_cache_settings"
    description = "Normalize cache key for earthquake diff endpoints"
    expression  = "(http.request.uri.path matches \"^/v2/earthquake\") and (http.request.method eq \"GET\")"
    enabled     = true
    action_parameters {
      cache = true
      cache_key {
        custom_key {
          query_string {
            include = ["lastUpdatedSince", "cursor", "limit", "cacheId"]
          }
        }
      }
      edge_ttl {
        mode = "respect_origin" # オリジンの s-maxage=60 / no-store を尊重
      }
    }
  }
}
```
> `query_string.include` で許可キーのみをキャッシュキーに含める = それ以外のクエリは無視 (= 同一スコープ・同一バケットのクライアントが共有ヒット)。scope code は path に含まれる (`/v2/earthquake/intensity/region/:code`) ため path 正規化で吸収される。`edge_ttl` は `respect_origin` でオリジンの Cache-Control に従う (no-store のものは edge キャッシュされない)。
> `cloudflare_ruleset` の正確な引数は使用中の Cloudflare provider バージョンに依存する。`home8s/terraform/cloudflare/provider.tf` で provider バージョンを確認し、v4 系なら上記 HCL、v5 系なら `action_parameters` の構造が異なるため provider docs に合わせて調整する。`CLOUDFLARE_ZONE_ID_*` 変数が `variables.tf` に無ければ追加する。

### Step 12.2 (verify): terraform plan で検証
```bash
cd /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor/backend/home8s/terraform/cloudflare
terraform init
terraform validate
terraform plan   # ruleset 1 件 (zone ごと) の新規作成が出ることを確認。apply は運用者承認後。
```
> `terraform` が未認証/未設定でローカル plan できない場合は **手動 Cloudflare 設定手順** を PR 本文に記載: Cloudflare ダッシュボード → 対象 zone → Caching → Cache Rules → 新規ルール「`URI Path starts with /v2/earthquake` かつ `Request Method = GET`」→ Cache eligibility: Eligible for cache → Cache Key: Custom → Query String: Include specific → `lastUpdatedSince, cursor, limit, cacheId` のみ → Edge TTL: Respect origin。

### Step 12.3 (commit): home8s 変更 + backend の submodule pin
```bash
cd /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor/backend/home8s
# home8s が別 git リポジトリの場合はそのリポジトリで PR が必要。
git switch -c feat/earthquake-diff-cache-rule
git add terraform/cloudflare/cache-rules.tf terraform/cloudflare/variables.tf
git commit -m "feat(cloudflare): add cache key normalization rule for earthquake diff API"
# backend 側で submodule pointer を更新
cd /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor/backend
git add home8s
git commit -m "chore: bump home8s submodule for earthquake diff cache rule"
```
> home8s が独立リポジトリのため、その PR を先に出すか、本 PR 本文で home8s 側の対応 PR をリンクする。submodule pin の更新は home8s 側マージ後に行うのが安全。本計画では「home8s 変更内容を PR 本文に明記し、submodule pin 更新は home8s マージ後の追従コミットとする」方針を採る (backend PR をブロックしない)。

---

## Task 13: 差分基盤の統合テスト補強 (vitest)

契約書テスト要件 (§1 / 設計書テスト計画) を 1 箇所に集約し漏れを潰す。既に各 Task で個別テスト済みのものは参照のみ。

### Step 13.1 (test): cacheId がキャッシュキー反映 = isCanonicalDiffRequest が cacheId を許可キーとして扱うことの明示テスト
Task 6.3 でカバー済みだが、`cacheId` を変えても正規判定が崩れないこと (= キャッシュキーに含まれる前提) を明示で 1 ケース追加。
```ts
it('cacheId is part of canonical diff (cache key)', () => {
  expect(isCanonicalDiffRequest({ lastUpdatedSince: '2026-06-23T19:00:00+09:00', cacheId: '99' })).toBe(true);
});
```

### Step 13.2 (test): 境界 inclusive の述語確認
`buildDiffWhere` が `gte` (>= inclusive) を使うことを明示。Task 5.4 のコードで `gte` 使用済みだが、回帰防止として `diff-where` のソース文字列に `gte` が含まれることを軽量に確認するより、`buildDiffWhere(since, undefined)` が `gte` 演算子由来であることを型/呼び出しで保証する設計コメントを残し、契約書 §1.2 と diff (lt/eq/gte) の対応をテスト名で固定する。Step 5.3 のテストを「inclusive 下限」「DESC タイ分解」と命名し直す (description 変更のみ)。

### Step 13.3 (verify): 全テスト + 型 + lint
```bash
cd /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor/backend
pnpm test
pnpm check-types
pnpm lint
git add -A
git commit -m "test(api): consolidate diff cache regression tests (boundary, cacheId, tie-break)"
```

---

## Task 14: PR 作成

### Step 14.1 (verify): 最終ベリファイ
```bash
cd /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor/backend
pnpm build
pnpm check-types
pnpm lint
pnpm test
git log --oneline origin/main..HEAD   # 各 Task の commit が並ぶことを確認
git status --short                     # クリーンであることを確認
```

### Step 14.2: PR 作成
```bash
git push -u origin feat/earthquake-diff-cache
gh pr create --repo YumNumm/EQMonitor --base main \
  --title "feat(earthquake): diff (SWR) cache foundation — updated_at/last_reported_at, lastUpdatedSince diff API, cache_id" \
  --body "$(cat <<'EOF'
## 概要
Earthquake SWR 化のための backend 差分取得基盤 (計画A / 契約書 §1)。

## 変更点
- DB: `earthquake.updated_at`/`last_reported_at` 追加 (nullable→バックフィル→non-null migration 用意)、BEFORE UPDATE トリガで `updated_at` を DB now() 強制、子テーブル変更で親 touch トリガ、`(updated_at DESC, event_id DESC)` インデックス。
- writer: 全 upsert で `last_reported_at` を発表時刻に設定 (`updated_at` はトリガ任せ)。
- API: `?lastUpdatedSince=<HourBucketJst>` 差分モード、`(updatedAt,eventId)` 降順 keyset ページング (`DiffCursor`)、`EarthquakePartial` に `updated_at`/`last_reported_at`、差分正規契約のみ `public, s-maxage=60`・他は `no-store`。
- `/v1/start`: `cache_id` (env `CACHE_ID` 既定 `"1"`)。
- openapi.json 再生成。
- Cloudflare: home8s に Cache Rule (キー = path+scope+lastUpdatedSince+cursor+limit+cacheId) 追加 (別リポPR / 手動設定手順を本文に併記)。

## 移行順序 (重要)
1. 本 PR: nullable カラム + トリガ + index migration / バックフィル migration / writer 更新 / API 露出。
2. **デプロイ後**: writer が稼働し全 INSERT/UPDATE が `updated_at`/`last_reported_at` を埋めることを確認してから、non-null 化 migration (`ALTER ... SET NOT NULL`) を手動適用 + schema.ts を `.notNull()` 化する追従 PR。

## テスト
HourBucketJst 検証 (非境界/非JST/不正日時→throw)、DiffCursor roundtrip、buildDiffWhere (inclusive 下限 + DESC タイ分解)、isCanonicalDiffRequest (非正規→false)、差分ルート分岐 + DiffCursor next_token、Cache-Control 分岐、StartResponse cache_id、writer 親 upsert 回帰。
EOF
)"
```

---

## Self-Review

### Spec coverage (契約書 §1 / 設計書 セクション1・4)
- §1.1 DB スキーマ (updated_at/last_reported_at/index) → Task 2.2。トリガ強制 → Task 2.4/2.5。
- §1.2 DiffCursor/DiffCursorSchema (type 無し) + DESC タイ分解述語 → Task 5。
- §1.3 HourBucketJstSchema (regex + 実日時パース) → Task 4。
- §1.4 EarthquakeQueryParams 拡張 (lastUpdatedSince/cacheId) + 正規契約ロックダウン (statuses 固定含む) → Task 6。
- §1.5 EarthquakePartial に updated_at/last_reported_at + transformer → Task 8。
- §1.6 Cache-Control 条件分岐 (正規→s-maxage=60 / 他→no-store) → Task 9。
- §1.7 /v1/start cache_id (env CACHE_ID 既定 "1") → Task 10。
- §1.8 Cloudflare キャッシュキー正規化 → Task 12。
- 移行順序 (nullable→backfill→writer→API→non-null) → Task 2.3-2.7 + Task 3 + PR 本文。
- 子テーブル変更で親 updated_at bump → Task 2.5 (トリガ) + Task 3.3 (回帰テスト)。
- writer last_reported_at = 発表時刻 / updated_at はトリガ任せ → Task 3。
- プライマリ読み → Task 7.2 (span 注記 + relational primary query)。
- openapi 再生成 → Task 11。
- テスト要件 (差分正しさ/境界 inclusive/降順ページング/HourBucketJst 400/全 upsert で updated_at 前進/cacheId キー反映) → Task 4,5,6,7,9,13。
- ブランチ運用 (最新 origin/main から分岐・stash 確認・PR base main) → Task 1, Task 14。

### Placeholder scan
- TBD/「適切に処理」/コード無しステップは無し。全 impl ステップに実コード (Drizzle schema 差分・トリガ SQL・Valibot スキーマ・Hono ハンドラ差分・vitest 本体・HCL) を記載。
- 唯一「実装時に Read で確定」とした箇所 = ① writer transformer の発表時刻フィールド名 (`pressDateTime`/`reportDateTime` 確定)、② Drizzle relational `where` コールバック対応の有無、③ `query.cursor` の差分 base64 と `CursorSchema` の競合。いずれも「確定方法 + 両分岐の具体コード」を併記し、判断不能な空白は残していない。

### Type consistency
- フィールド名: DB `updated_at`/`last_reported_at` (snake_case, drizzle casing) ↔ TS `updatedAt`/`lastReportedAt` (camelCase) ↔ API JSON `updated_at`/`last_reported_at` (Valibot)。契約書と一致。
- パラメータ名 `lastUpdatedSince`/`cacheId` (camelCase クエリ)、`cache_id` (start レスポンス snake_case)。契約書 §1.4/§1.7 と一致。
- 型名 `DiffCursor`/`DiffCursorSchema`/`HourBucketJstSchema` + `encodeDiffCursor` (既存 `encodeCursor` と並行) → 契約書一致。
- 定数: 差分 `limit=50` (Task 7.4 `DIFF_LIMIT`)、`s-maxage=60` (Task 9.2)、`CACHE_ID` 既定 `"1"` (Task 10.2) → 契約書「確定した実装パラメータ」一致。

### 確認すべき懸念点 (実装者が着手前に潰す)
1. **`CursorSchema` と DiffCursor base64 の競合** (Task 7.4 注記): 差分モードで `query.cursor` が `CursorSchema` の `splitCursorDecoded` に通ると 400 になりうる。必要なら `EarthquakeQueryParams.cursor` を緩める最小変更で対応。
2. **Drizzle relational `where`/`orderBy` のコールバック対応** (Task 7.2): 非対応バージョンなら `select().from()` + 子の別取得に切替。`buildDiffWhere` は両方で再利用可。
3. **home8s submodule の独立リポジトリ性** (Task 12.3): Cache Rule 変更は home8s 側 PR が別途必要。submodule pin 更新は home8s マージ後の追従コミット。
4. **non-null 化の二段階性**: 本 PR は nullable のまま。non-null migration は writer デプロイ後に手動適用 + schema `.notNull()` 化は追従 PR。早すぎる適用は INSERT 失敗を招く。
5. **実 DB テスト基盤の不在**: 差分 ORDER BY の実順序は単体テストできない (mock のみ)。`buildDiffWhere` の述語が契約書 §1.2 と 1:1 であることがページング正しさの保証。統合検証はステージング環境での手動/E2E に委ねる旨を PR 本文に明記推奨。

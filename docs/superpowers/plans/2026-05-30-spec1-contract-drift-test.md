# Spec ① 契約/drift テスト Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** backend の API レスポンス形状が変わったとき、Flutter 側の Freezed モデルが追従できているかを CI（既存 `dart test`）で自動検出する drift テストを、純 Dart・新規依存ゼロで導入する。

**Architecture:** api-stub の `DEFAULT_MOCKS`/`FIXTURE_REGISTRY`（backend が Valibot で検証済み）を決定論的に JSON 化して backend submodule にコミット → `generate.dart` がメインリポ `packages/eqmonitor_api/test/fixtures/contract/` にコピー → Dart テストが各 JSON を対応 Freezed モデルの `fromJson` でパースし、失敗を drift として検出する。openapi.json の取り込み経路を正確にミラーする。

**Tech Stack:** TypeScript（api-stub, `tsx`/`vitest`）、Dart（`package:test`, freezed models）、melos、既存 `generate.dart` codegen 入口。

**関連 spec:** `docs/superpowers/specs/2026-05-30-spec1-contract-drift-test-design.md`、親 overview `2026-05-30-app-server-integration-testing-overview.md`

---

## File Structure

新規・変更ファイルと責務:

- **Create** `packages/eqmonitor_api/test/contract_drift_test.dart` — drift テスト本体（index.json を走査し、file 名 → モデル `fromJson` でパース）。
- **Create** `packages/eqmonitor_api/test/fixtures/contract/*.json` + `index.json` — メインリポにコミットする fixture（generate.dart が生成・コピー）。
- **Create** `backend/api/api-stub/scripts/generate-fixtures.ts` — DEFAULT_MOCKS/named fixtures を決定論 JSON 化するエクスポータ。
- **Create** `backend/api/api-stub/generated/contract-fixtures/*.json` + `index.json` — submodule にコミットする生成物（エクスポータ出力・コピー元）。
- **Modify** `backend/api/api-stub/src/time-resolver.ts` — `resolveDirectives` に `{ nowMs, pickFirst }` オプション追加（省略時は現状動作維持）。
- **Create** `backend/api/api-stub/test/generate-fixtures.test.ts` — エクスポータの決定論性テスト。
- **Modify** `backend/api/api-stub/package.json` — `generate:fixtures` スクリプト追加。
- **Modify** `packages/eqmonitor_api/bin/generate.dart` — fixtures コピーステップ追加。
- **Modify** backend CI（`backend/.github/workflows/wc-check-ts-test.yaml` 等）— 鮮度ガード（再生成 + `git diff --exit-code`）。
- **Modify** `~/.claude/skills/regen-api-schema/SKILL.md` — fixture 再生成ステップを手順に追記。

---

## Task 1: Dart drift テストの core を確立（手置き fixture 1件で red/green 証明）

エクスポータより**先に**テスト本体を固める。最も驚きやすい「DateTime パース」「union discriminator」を先に潰す。

**Files:**
- Create: `packages/eqmonitor_api/test/fixtures/contract/index.json`
- Create: `packages/eqmonitor_api/test/fixtures/contract/get__v2_earthquake.json`
- Create: `packages/eqmonitor_api/test/contract_drift_test.dart`

- [ ] **Step 1: 手置き fixture を1件生成する**

backend stub の default mock を決定論解決して1ファイルだけ書き出す（使い捨てワンライナー）。

```bash
cd /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor/backend/api/api-stub
mise exec -- pnpm exec tsx -e "
import { DEFAULT_MOCKS } from './src/default-mocks.ts';
import { resolveDirectives } from './src/time-resolver.ts';
// nowMs/pickFirst 追加前なので Date.now/Math.random を一時固定
const _now = Date.now; Date.now = () => 1700000000000;
const _rand = Math.random; Math.random = () => 0;
const out = resolveDirectives(DEFAULT_MOCKS['GET /v2/earthquake']);
Date.now = _now; Math.random = _rand;
import { mkdirSync, writeFileSync } from 'node:fs';
const dir = '../../../packages/eqmonitor_api/test/fixtures/contract';
mkdirSync(dir, { recursive: true });
writeFileSync(dir + '/get__v2_earthquake.json', JSON.stringify(out, null, 2) + '\n');
console.log('wrote get__v2_earthquake.json');
"
```

Expected: `wrote get__v2_earthquake.json`。生成 JSON の日時フィールドが `2023-11-14T...Z` 形式の ISO8601 になっていること（`@..._diff` が文字列のまま残っていないこと）を目視確認する。

- [ ] **Step 2: index.json を手書きする**

```json
[
  { "key": "GET /v2/earthquake", "file": "get__v2_earthquake.json" }
]
```

- [ ] **Step 3: drift テストを書く（失敗する状態）**

```dart
import 'dart:convert';
import 'dart:io';

import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:test/test.dart';

/// fixture の file 名 → 対応モデルの fromJson。
/// 対応モデルが未定義の file は実行時に skip ログを出す（silent 網羅を防ぐ）。
final Map<String, Object? Function(Map<String, Object?>)> _parsers = {
  'get__v2_earthquake.json': EarthquakeListResponse.fromJson,
};

void main() {
  final fixturesDir = Directory('test/fixtures/contract');
  final indexFile = File('${fixturesDir.path}/index.json');

  test('contract fixtures index exists', () {
    expect(indexFile.existsSync(), isTrue,
        reason: 'index.json が無い。generate.dart で fixtures をコピーしたか確認');
  });

  final index = (jsonDecode(indexFile.readAsStringSync()) as List)
      .cast<Map<String, Object?>>();

  for (final entry in index) {
    final key = entry['key']! as String;
    final file = entry['file']! as String;
    final parser = _parsers[file];

    if (parser == null) {
      // 対応モデル未定義: スキップを明示（テスト出力に列挙）
      test('SKIP (no Dart model mapping): $key [$file]', () {
        printOnFailure('no parser mapped for $file');
      }, skip: 'no Dart model mapping for $file');
      continue;
    }

    test('$key [$file] が Freezed モデルでパースできる', () {
      final fixtureFile = File('${fixturesDir.path}/$file');
      // マップ済みキーの fixture 欠落は drift → fail loud
      expect(fixtureFile.existsSync(), isTrue,
          reason: 'mapped fixture が欠落: $file（endpoint rename/削除の疑い）');

      final json = jsonDecode(fixtureFile.readAsStringSync())
          as Map<String, Object?>;
      // パース例外が drift。throwsA でなく「投げないこと」を検証。
      expect(() => parser(json), returnsNormally);
    });
  }
}
```

- [ ] **Step 4: テストを実行してグリーンを確認**

Run: `cd packages/eqmonitor_api && mise exec -- dart test test/contract_drift_test.dart`
Expected: PASS（`GET /v2/earthquake` がパースできる）。もし `DateTime.parse` 系で落ちるなら、Step 1 のディレクティブ解決が効いているか再確認する。

- [ ] **Step 5: 故意に壊して red を確認（drift 検出の証明）**

`packages/eqmonitor_api/lib/src/models/earthquake_list_response.dart` の必須フィールドを1つ一時的にリネーム（例 `items` → `items_BROKEN`）し、`build_runner` で再生成せず手で `.g.dart` の該当 `fromJson` 参照も合わせて壊すか、より簡単には**fixture 側のキーを1つ削る**でも良い。

Run: `mise exec -- dart test test/contract_drift_test.dart`
Expected: FAIL（パース例外）。確認後、変更を**元に戻す**。

- [ ] **Step 6: コミット**

```bash
cd /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor
git add packages/eqmonitor_api/test/contract_drift_test.dart \
        packages/eqmonitor_api/test/fixtures/contract/index.json \
        packages/eqmonitor_api/test/fixtures/contract/get__v2_earthquake.json
git commit -m "test(eqmonitor_api): 契約driftテストのcoreを追加（fixture1件で検証）"
```

---

## Task 2: time-resolver に決定論オプションを追加（backend submodule / TS）

`resolveDirectives` が内部で使う `Date.now()`/`Math.random()` を、引数で固定できるようにする。省略時は現状動作維持（live stub を壊さない）。

**Files:**
- Modify: `backend/api/api-stub/src/time-resolver.ts`
- Test: `backend/api/api-stub/test/generate-fixtures.test.ts`（決定論性をここで検証）

- [ ] **Step 1: 失敗するテストを書く**

`backend/api/api-stub/test/time-resolver-deterministic.test.ts` を作成:

```ts
import { describe, expect, it } from 'vitest';
import { resolveDirectives } from '../src/time-resolver';

describe('resolveDirectives deterministic options', () => {
  it('nowMs 固定で @_diff が決定論になる', () => {
    const input = { '@t_diff': '5 minutes ago', t: null };
    const out = resolveDirectives(input, { nowMs: 1_700_000_000_000 }) as {
      t: string;
    };
    expect(out.t).toBe(new Date(1_700_000_000_000 - 5 * 60_000).toISOString());
  });

  it('pickFirst で @_random が配列先頭固定になる', () => {
    const input = { '@v_random': ['a', 'b', 'c'], v: null };
    const out = resolveDirectives(input, { pickFirst: true }) as { v: string };
    expect(out.v).toBe('a');
  });

  it('オプション省略時は従来通り動作する（例外を投げない）', () => {
    expect(() => resolveDirectives({ '@t_diff': 'now', t: null })).not.toThrow();
  });
});
```

- [ ] **Step 2: テスト実行で失敗確認**

Run: `cd backend/api/api-stub && mise exec -- pnpm test -- time-resolver-deterministic`
Expected: FAIL（`resolveDirectives` が第2引数を受け取らない / pickFirst 未対応）。

- [ ] **Step 3: time-resolver を実装変更**

`resolveDirectives` にオプション引数を追加し、内部の再帰呼び出しへ伝播する:

```ts
export interface ResolveOptions {
  /** @_diff の基準時刻（ms）。省略時は Date.now()。 */
  nowMs?: number;
  /** true なら @_random は配列先頭を選ぶ（決定論）。省略時は Math.random()。 */
  pickFirst?: boolean;
}

export function resolveDirectives(
  value: unknown,
  opts: ResolveOptions = {},
): unknown {
  if (Array.isArray(value)) {
    return value.map(item => resolveDirectives(item, opts));
  }
  if (value !== null && typeof value === 'object') {
    const src = value as Record<string, unknown>;

    const diffs = new Map<string, string>();
    const randoms = new Map<string, unknown[]>();

    for (const key of Object.keys(src)) {
      if (key.startsWith('@') && key.endsWith('_diff')) {
        diffs.set(key.slice(1, -5), src[key] as string);
      } else if (key.startsWith('@') && key.endsWith('_random')) {
        randoms.set(key.slice(1, -7), src[key] as unknown[]);
      }
    }

    const result: Record<string, unknown> = {};
    for (const [key, val] of Object.entries(src)) {
      if (key.startsWith('@')) continue;

      if (randoms.has(key)) {
        const choices = randoms.get(key)!;
        const idx = opts.pickFirst
          ? 0
          : Math.floor(Math.random() * choices.length);
        result[key] = resolveDirectives(choices[idx], opts);
      } else if (diffs.has(key)) {
        result[key] = resolveDiffDirective(diffs.get(key)!, opts.nowMs);
      } else {
        result[key] = resolveDirectives(val, opts);
      }
    }
    return result;
  }
  return value;
}
```

`resolveDiffDirective` を変更:

```ts
function resolveDiffDirective(directive: string, nowMs?: number): string {
  const ms = parseDurationMs(directive);
  const base = nowMs ?? Date.now();
  return new Date(base + ms).toISOString();
}
```

- [ ] **Step 4: テスト実行でグリーン確認 + 既存テストの非回帰**

Run: `cd backend/api/api-stub && mise exec -- pnpm test`
Expected: 新テスト PASS、既存テスト（contract.test.ts 等）も全 PASS。

- [ ] **Step 5: コミット（submodule 内）**

```bash
cd backend
git checkout -b feat/contract-fixtures-export 2>/dev/null || git checkout feat/contract-fixtures-export
git add api/api-stub/src/time-resolver.ts api/api-stub/test/time-resolver-deterministic.test.ts
git commit -m "feat(api-stub): resolveDirectives に決定論オプション(nowMs/pickFirst)を追加"
```

---

## Task 3: fixtures エクスポータを実装（backend submodule / TS）

DEFAULT_MOCKS（default）+ union を持つキーの named fixtures を決定論 JSON 化し、`index.json` と共に submodule に出力する。

**Files:**
- Create: `backend/api/api-stub/scripts/generate-fixtures.ts`
- Modify: `backend/api/api-stub/package.json`（`generate:fixtures` スクリプト）
- Test: `backend/api/api-stub/test/generate-fixtures.test.ts`

- [ ] **Step 1: 失敗するテストを書く**

```ts
import { execSync } from 'node:child_process';
import { existsSync, readFileSync, rmSync } from 'node:fs';
import { afterAll, describe, expect, it } from 'vitest';

const OUT = 'generated/contract-fixtures';

describe('generate-fixtures', () => {
  afterAll(() => rmSync(OUT, { recursive: true, force: true }));

  it('index.json と default fixture を決定論的に出力する', () => {
    execSync('pnpm exec tsx scripts/generate-fixtures.ts', { stdio: 'inherit' });
    expect(existsSync(`${OUT}/index.json`)).toBe(true);
    expect(existsSync(`${OUT}/get__v2_earthquake.json`)).toBe(true);

    // 2回実行しても同一（決定論）
    const first = readFileSync(`${OUT}/get__v2_earthquake.json`, 'utf8');
    execSync('pnpm exec tsx scripts/generate-fixtures.ts', { stdio: 'inherit' });
    const second = readFileSync(`${OUT}/get__v2_earthquake.json`, 'utf8');
    expect(second).toBe(first);

    // 日時に未解決ディレクティブが残らない
    expect(first).not.toContain('@');
  });
});
```

- [ ] **Step 2: テスト実行で失敗確認**

Run: `cd backend/api/api-stub && mise exec -- pnpm test -- generate-fixtures`
Expected: FAIL（スクリプト未作成）。

- [ ] **Step 3: エクスポータを実装**

`backend/api/api-stub/scripts/generate-fixtures.ts`:

```ts
/**
 * DEFAULT_MOCKS と union を持つキーの named fixtures を決定論 JSON 化して
 * generated/contract-fixtures/ に出力する。出力は Dart の drift テストが読む。
 */
import { mkdirSync, rmSync, writeFileSync } from 'node:fs';

import { DEFAULT_MOCKS } from '../src/default-mocks';
import { FIXTURE_REGISTRY } from '../src/fixture-registry';
import { resolveDirectives } from '../src/time-resolver';

const OUT_DIR = 'generated/contract-fixtures';
const FIXED_NOW_MS = 1_700_000_000_000; // 2023-11-14T22:13:20Z 固定基準時刻

/** endpoint key を安全な file 名に変換する。 */
function toFileName(key: string, fixtureName?: string): string {
  const base = key
    .replace(/^GET /, 'get_')
    .replace(/^POST /, 'post_')
    .replaceAll(/[/]/g, '_')
    .replaceAll(':', '')
    .replaceAll(/[^a-zA-Z0-9_]/g, '');
  return fixtureName ? `${base}__${fixtureName}.json` : `${base}.json`;
}

/** union を持つため named fixtures も出力するキー。 */
const UNION_KEYS = new Set<string>(['GET /v2/parameters/:type']);

function resolve(value: unknown): unknown {
  return resolveDirectives(value, { nowMs: FIXED_NOW_MS, pickFirst: true });
}

function main(): void {
  rmSync(OUT_DIR, { recursive: true, force: true });
  mkdirSync(OUT_DIR, { recursive: true });

  const index: { key: string; file: string; fixture?: string }[] = [];

  for (const key of Object.keys(DEFAULT_MOCKS)) {
    // default
    const defFile = toFileName(key);
    writeFileSync(
      `${OUT_DIR}/${defFile}`,
      `${JSON.stringify(resolve(DEFAULT_MOCKS[key as keyof typeof DEFAULT_MOCKS]), null, 2)}\n`,
    );
    index.push({ key, file: defFile });

    // union を持つキーは named fixtures も
    if (UNION_KEYS.has(key)) {
      const reg = FIXTURE_REGISTRY[key as keyof typeof FIXTURE_REGISTRY];
      const named = (reg as { fixtures?: Record<string, unknown> }).fixtures ?? {};
      for (const name of Object.keys(named)) {
        const f = toFileName(key, name);
        writeFileSync(
          `${OUT_DIR}/${f}`,
          `${JSON.stringify(resolve(named[name]), null, 2)}\n`,
        );
        index.push({ key, file: f, fixture: name });
      }
    }
  }

  index.sort((a, b) => a.file.localeCompare(b.file));
  writeFileSync(`${OUT_DIR}/index.json`, `${JSON.stringify(index, null, 2)}\n`);
  console.log(`wrote ${index.length} fixtures to ${OUT_DIR}`);
}

main();
```

> 注: `FIXTURE_REGISTRY` の named fixtures の実プロパティ名（`fixtures` か `named` か等）は
> `backend/api/api-stub/src/fixture-registry.ts` を読んで合わせること。UNION_KEYS は
> `ParameterDataResponseUnion` の4 variant を網羅できる named fixtures があるか確認して確定する。

`package.json` の scripts に追加:

```json
"generate:fixtures": "tsx scripts/generate-fixtures.ts",
```

- [ ] **Step 4: テスト実行でグリーン確認**

Run: `cd backend/api/api-stub && mise exec -- pnpm test -- generate-fixtures`
Expected: PASS（決定論・未解決ディレクティブ無し）。

- [ ] **Step 5: 本生成してコミット（submodule 内）**

```bash
cd backend/api/api-stub && mise exec -- pnpm generate:fixtures
cd /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor/backend
git add api/api-stub/scripts/generate-fixtures.ts api/api-stub/package.json \
        api/api-stub/test/generate-fixtures.test.ts \
        api/api-stub/generated/contract-fixtures/
git commit -m "feat(api-stub): 契約fixturesエクスポータ(generate:fixtures)を追加"
```

---

## Task 4: generate.dart に fixtures コピーステップを追加（メインリポ / Dart）

openapi.json を submodule からコピーするのと同じ入口で、fixtures もコピーする。

**Files:**
- Modify: `packages/eqmonitor_api/bin/generate.dart`

- [ ] **Step 1: コピーステップを追加**

`generate.dart` の `main` 末尾（`✅ コード生成が完了しました` の直前）に追加:

```dart
  await _step('契約 fixtures を submodule からコピー', () async {
    final srcDir = Directory('../../backend/api/api-stub/generated/contract-fixtures');
    final dstDir = Directory('${packageDir.path}/test/fixtures/contract');
    if (!srcDir.existsSync()) {
      stderr.writeln('  contract-fixtures が見つかりません: ${srcDir.path}');
      return;
    }
    if (dstDir.existsSync()) {
      dstDir.deleteSync(recursive: true);
    }
    dstDir.createSync(recursive: true);
    for (final f in srcDir.listSync().whereType<File>()) {
      if (!f.path.endsWith('.json')) continue;
      final name = f.uri.pathSegments.last;
      f.copySync('${dstDir.path}/$name');
    }
    stdout.writeln('  copied fixtures → ${dstDir.path}');
  });
```

- [ ] **Step 2: 実行して取り込みを確認**

Run: `cd packages/eqmonitor_api && mise exec -- dart run bin/generate.dart`
Expected: `copied fixtures → .../test/fixtures/contract`。`index.json` と全 default JSON が更新される。

> 注: `generate.dart` は swagger_parser/build_runner も走らせるため lib/src 全体が再生成される。
> Spec ① のスコープ外の差分（codegen rename 連鎖）が混ざらないよう、**fixtures 関連の差分のみ**を
> このタスクでコミットする（lib/src の差分が出た場合は別途精査）。

- [ ] **Step 3: コミット（メインリポ）**

```bash
cd /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor
git add packages/eqmonitor_api/bin/generate.dart \
        packages/eqmonitor_api/test/fixtures/contract/
git commit -m "feat(eqmonitor_api): generate.dartに契約fixturesコピーを追加"
```

---

## Task 5: drift テストを全キー + union named fixtures に拡張（メインリポ / Dart）

Task 1 の `_parsers` マップを、`contract.test.ts` が検証する 14 キーを最優先に拡張する。

**Files:**
- Modify: `packages/eqmonitor_api/test/contract_drift_test.dart`

- [ ] **Step 1: パーサマップを拡張する**

`contract.test.ts` の import から判明している response 型に対応する Dart モデルでマップを埋める。
file 名は Task 3 の `toFileName` 規則（例 `get__v2_earthquake_eventId.json`）。

```dart
final Map<String, Object? Function(Map<String, Object?>)> _parsers = {
  'get__v2_earthquake.json': EarthquakeListResponse.fromJson,
  'get__v2_earthquake_eventId.json': EarthquakeDetailResponse.fromJson,
  'get__v2_earthquake_intensity_region_code.json':
      IntensityRegionSearchResponse.fromJson,
  'get__v2_earthquake_intensity_prefecture_code.json':
      IntensityPrefectureSearchResponse.fromJson,
  'get__v2_earthquake_intensity_city_code.json':
      IntensityCitySearchResponse.fromJson,
  'get__v2_earthquake_intensity_station_code.json':
      IntensityStationSearchResponse.fromJson,
  'get__v2_earthquake_epicenter_code.json': EpicenterSearchResponse.fromJson,
  'get__v2_eew.json': EewListResponse.fromJson,
  'get__v2_eew_latest.json': EewLatestResponse.fromJson,
  'get__v2_tsunami.json': TsunamiListResponse.fromJson,
  'get__v2_tsunami_tsunamiId.json': TsunamiDetailResponse.fromJson,
  'get__v2_telegram.json': TelegramListResponse.fromJson,
  'get__v2_telegram_id.json': TelegramDetailResponse.fromJson,
  // 残りの GET キー（changelog/start/parameters/health/eew detail/tsunami active 等）は
  // 対応 Dart モデルを packages/eqmonitor_api/lib/src/models/ で確認しつつ順次追加。
  // 対応モデルが無い／union で raw map 受けのものはマップに入れず SKIP ログに任せる。
};
```

> 各 Dart クラス名は `lib/src/models/<snake>.dart` の `factory Xxx.fromJson` で実在を確認する。
> Valibot の ref 名と Dart クラス名は一致する設計（例 `EarthquakeListResponse`）。
> 一致しないものは `lib/src/models/` を grep して正しいクラス名に直す。

- [ ] **Step 2: テスト実行**

Run: `cd packages/eqmonitor_api && mise exec -- dart test test/contract_drift_test.dart`
Expected: PASS。SKIP されたキーがテスト出力に列挙されること、`/v2/parameters/:type` の
named fixtures（4 variant）がパースされることを確認。

- [ ] **Step 3: union 網羅の赤確認**

`ParameterDataResponseUnion` の variant 1つ（例 jma_code_table）の必須フィールドを
fixture 側で一時的に削り、テストが赤くなることを確認 → 戻す。

- [ ] **Step 4: コミット**

```bash
cd /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor
git add packages/eqmonitor_api/test/contract_drift_test.dart
git commit -m "test(eqmonitor_api): 契約driftテストを主要エンドポイント+union網羅に拡張"
```

---

## Task 6: backend CI に鮮度ガードを追加（submodule / CI）

submodule 側 fixtures のコミット漏れを検出する（`generate:fixtures` 再実行 → `git diff --exit-code`）。

**Files:**
- Modify: `backend/.github/workflows/wc-check-ts-test.yaml`（既存 TS テストジョブ。pnpm セットアップ済み）

- [ ] **Step 1: ガードステップを追加**

`pnpm test` の前後どちらかに、api-stub の fixtures 再生成 + diff チェックを追加:

```yaml
      - name: contract fixtures が最新かを検証
        working-directory: api/api-stub
        run: |
          pnpm generate:fixtures
          git diff --exit-code generated/contract-fixtures \
            || { echo '::error::contract-fixtures が古い。pnpm generate:fixtures を実行してコミットしてください'; exit 1; }
```

> 既存ワークフローの step 記法・mise セットアップに合わせる（`wc-check-ts-test.yaml` を読んで整合）。

- [ ] **Step 2: ローカルで等価チェックが通ることを確認**

Run:
```bash
cd backend/api/api-stub && mise exec -- pnpm generate:fixtures && git -C ../.. diff --exit-code api/api-stub/generated/contract-fixtures && echo CLEAN
```
Expected: `CLEAN`（直近で生成済みなら diff 無し）。

- [ ] **Step 3: コミット（submodule）してリモートに push**

```bash
cd /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor/backend
git add .github/workflows/wc-check-ts-test.yaml
git commit -m "ci(api-stub): contract fixtures の鮮度ガードを追加"
git push origin feat/contract-fixtures-export
```

> 親リポの submodule pin 更新は Task 7 でまとめて行う（push 後でないと pin できない）。

---

## Task 7: regen フロー統合・pin 更新・CI 実行確認・spec/skill 反映

**Files:**
- Modify: `~/.claude/skills/regen-api-schema/SKILL.md`
- Modify: 親リポの submodule pin（`backend` のコミットハッシュ）

- [ ] **Step 1: submodule pin を更新**

```bash
cd /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor
git -C backend fetch origin feat/contract-fixtures-export
git -C backend checkout $(git -C backend rev-parse origin/feat/contract-fixtures-export)
git add backend
git commit -m "chore: backend submodule pin を更新（contract fixtures export）"
```

- [ ] **Step 2: melos 経由で CI が新テストを拾うことを確認**

Run: `cd /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor && mise exec -- melos run test:dart`
Expected: `eqmonitor_api` パッケージで `contract_drift_test.dart` が実行され PASS
（`dependsOn: test` + `dirExists: test` のフィルタに掛かる）。掛からない場合は
`packages/eqmonitor_api/pubspec.yaml` の `test` 依存と `test/` の存在を再確認。

- [ ] **Step 3: regen-api-schema skill に fixture 再生成手順を追記**

`~/.claude/skills/regen-api-schema/SKILL.md` の「必須の順序」に、openapi 再生成の直後ステップとして追記:

```md
2.5. **契約 fixtures を再生成**（drift テスト用）
   ```sh
   cd backend/api/api-stub
   pnpm generate:fixtures   # generated/contract-fixtures/*.json を更新
   ```
   これも backend commit に含める。`generate.dart`（step 5）が
   `packages/eqmonitor_api/test/fixtures/contract/` へコピーする。
```

- [ ] **Step 4: spec のステータスを更新してコミット**

`docs/superpowers/specs/2026-05-30-spec1-contract-drift-test-design.md` のステータスを
「実装完了」に更新。

```bash
cd /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor
git add docs/superpowers/specs/2026-05-30-spec1-contract-drift-test-design.md
git commit -m "docs: Spec①ステータスを実装完了に更新"
```

- [ ] **Step 5: 全体検証**

Run:
```bash
cd /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor
mise exec -- melos run analyze
mise exec -- melos run test:dart
```
Expected: analyze 警告なし、`contract_drift_test.dart` 含め全テスト PASS。

---

## 既知の限界（spec と一致）

- 鮮度ガードは **submodule 側コピー**を守る。テストが読む**メインリポ側コピー**は手動
  `regen-api-schema` 実行でのみ同期され、app CI に鮮度検証は無い（openapi.json と同じギャップ）。
- `FeedItemDataUnion` / `TargetUnion` は GET 24 キーから到達しないため Spec ① の対象外。
- optional フィールド欠落・エラーレスポンス形状の網羅は Spec ②（client↔stub）に委ねる。

## Self-Review（記入済み）

- **Spec coverage**: drift 検出（Task 1,5）/ DEFAULT_MOCKS 取り込み（Task 3,4）/ 決定論
  （Task 2）/ union 網羅（Task 3,5）/ 鮮度ガード（Task 6）/ regen 統合（Task 7）/ CI 実行
  確認（Task 7 Step2）すべてにタスクが対応。
- **Placeholder scan**: 実コード/実コマンドを各ステップに記載。`fixture-registry` の named
  プロパティ名と Dart クラス名の実在確認のみ「読んで合わせる」と明記（環境依存のため）。
- **Type consistency**: `resolveDirectives(value, opts)` のシグネチャ、`toFileName` 規則、
  `_parsers` の file 名が Task 2/3/5 で一貫。

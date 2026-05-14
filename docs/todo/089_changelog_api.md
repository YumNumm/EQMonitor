# Changelog API 仕様書 — バージョン履歴配信

**作成日**: 2026-05-15
**対象ブランチ**: develop
**ステータス**: 設計完了 / 実装未着手
**関連**: [088_start_api.md](088_start_api.md)

---

## 背景

アプリ内に「変更履歴」画面を提供したい。

- Start API の `latest` は最新1件のみで、全履歴は別エンドポイントに分離する（ペイロード肥大化を防ぐ）
- 履歴はバックエンド TypeScript ファイルに埋め込みで管理し、リリース時に PR で更新する（DB管理は過剰）
- Start API と同じソース（`packages/changelog`）を参照し、二重管理を避ける

---

## 要件

### 機能要件

1. **全履歴取得**: 全バージョンの変更履歴を返す
2. **差分取得**: `since` クエリで指定バージョン以降のみを返す（What's New 補助用）
3. **ETag によるキャッシュ**: Start API と同じパターン
4. **長期キャッシュ可能**: 履歴は変更頻度が低いので長めの TTL を設定

### 非機能要件

- **認証不要**: 起動前にも参照可能
- **オフライン耐性**: アプリ側でキャッシュし、オフラインでも参照可能にする

---

## エンドポイント仕様

### `GET /v1/changelog`

#### Query Parameters

| パラメータ | 型 | 必須 | 説明 |
|---|---|---|---|
| `since` | string (semver) | No | 指定バージョンより**新しい**ものだけ返す。例: `since=2.2.0` |
| `limit` | number | No | 最大件数。デフォルト 100、上限 200 |

#### Request Headers

| ヘッダ | 必須 | 説明 |
|---|---|---|
| `If-None-Match` | No | クライアントが保持しているETag |

#### Response Headers

| ヘッダ | 値 |
|---|---|
| `ETag` | `"<hex>"` |
| `Cache-Control` | `public, max-age=3600, stale-while-revalidate=86400` |
| `Content-Type` | `application/json; charset=utf-8` |

#### Response 200 ボディ

```typescript
interface ChangelogResponse {
  entries: {
    version: string;       // "x.y.z"
    date: string;          // ISO 8601
    sections: {
      title: string;       // "新機能" | "改善" | "修正" | "その他"
      items: string[];     // 各行 Markdown
    }[];
  }[];
}
```

- `entries` は **降順**（新しいバージョンが先頭）
- `since` 指定時はそれより新しいものだけ
- `show_whats_new` / `whats_new` は Start API 側の責務なのでこちらには含めない

#### Response 304

ボディなし。

#### Response 400

```typescript
interface BadRequestResponse {
  code: 'BAD_REQUEST';
  message: string; // "Invalid 'since' parameter: must be semver"
}
```

---

## valibot スキーマ案

`api/api/src/features/changelog/model/responses.ts` に配置。

```typescript
import * as v from 'valibot';

const VersionString = v.pipe(
  v.string(),
  v.regex(/^\d+\.\d+\.\d+$/),
);

export const ChangelogSectionSchema = v.object({
  title: v.string(),
  items: v.array(v.string()),
});

export const ChangelogEntrySchema = v.object({
  version: VersionString,
  date: v.pipe(v.string(), v.isoDate()),
  sections: v.array(ChangelogSectionSchema),
});

export const ChangelogResponseSchema = v.object({
  entries: v.array(ChangelogEntrySchema),
});

export const ChangelogQuerySchema = v.object({
  since: v.optional(VersionString),
  limit: v.optional(
    v.pipe(
      v.string(),
      v.transform(Number),
      v.integer(),
      v.minValue(1),
      v.maxValue(200),
    ),
  ),
});

export type ChangelogResponse = v.InferOutput<typeof ChangelogResponseSchema>;
```

---

## Changelog データソース

### `packages/changelog` 構成

```
packages/changelog/
├── package.json
├── tsconfig.json
└── src/
    ├── index.ts          ← export
    ├── changelog.ts      ← CHANGELOG[] 定義
    ├── store-url.ts      ← STORE_URL 定数
    └── types.ts          ← 型定義
```

### `types.ts`

```typescript
export type Version = `${number}.${number}.${number}`;

export interface ChangelogSection {
  title: '新機能' | '改善' | '修正' | 'その他';
  items: string[];
}

export interface ChangelogEntry {
  version: Version;
  date: string;              // ISO 8601 "YYYY-MM-DD"
  /** What's New ダイアログ表示要否（Start API用） */
  show_whats_new: boolean;
  /** What's New ダイアログのリッチ表現（Start API用） */
  whats_new?: {
    title?: string;
    content: string;         // Markdown
  };
  /** 変更履歴画面の項目別表示（Changelog API用） */
  sections: ChangelogSection[];
}

export interface RequiredVersion {
  version: Version;
  message?: string;
}

export interface StoreUrl {
  ios: string;
  android: string;
}
```

### `changelog.ts`

```typescript
import type { ChangelogEntry, RequiredVersion } from './types';

/** 新しい順に並べる */
export const CHANGELOG: ChangelogEntry[] = [
  {
    version: '2.3.0',
    date: '2026-05-15',
    show_whats_new: true,
    whats_new: {
      title: 'EQMonitor Pro 登場',
      content: `
**EQMonitor Pro** の提供を開始しました。

- EEW・地震情報の通知地点を最大 **5地点** に拡大
- 揺れ検知通知を **3地点** で利用可能
- 広告を非表示

サーバー運用費の支援にもなりますので、よろしければご検討ください。
`,
    },
    sections: [
      {
        title: '新機能',
        items: [
          'EQMonitor Pro サブスクリプションを追加',
          '無料プランで通知地点を最大3地点に拡大（従来1地点）',
        ],
      },
      {
        title: '改善',
        items: ['地震履歴の表示速度を改善'],
      },
    ],
  },
  {
    version: '2.2.0',
    date: '2026-04-01',
    show_whats_new: false,
    sections: [
      {
        title: '修正',
        items: ['通知設定が正しく保存されない不具合を修正'],
      },
    ],
  },
];

export const REQUIRED_VERSIONS: RequiredVersion[] = [
  // 強制アップデートが必要な場合のみ追加
];

export const STORE_URL = {
  ios: 'https://apps.apple.com/jp/app/...',
  android: 'https://play.google.com/store/apps/details?id=...',
} as const;
```

### `index.ts`

```typescript
export * from './changelog';
export * from './store-url';
export * from './types';
```

### `pnpm-workspace.yaml` への登録

既存のworkspaceに自動的に取り込まれるが、各サービスから参照するには `package.json` の `dependencies` に `@eqmonitor-backend/changelog: workspace:*` を追加する。

---

## バックエンド実装方針

### ディレクトリ構成

```
api/api/src/features/changelog/
├── datasource/
│   └── changelog-datasource.ts
├── model/
│   └── responses.ts
└── routes/
    └── changelog.ts
```

### Datasource

```typescript
// api/api/src/features/changelog/datasource/changelog-datasource.ts
import { CHANGELOG, type ChangelogEntry } from '@eqmonitor-backend/changelog';
import { createHash } from 'node:crypto';
import { compare } from 'semver';

export class ChangelogDatasource {
  build(options: { since?: string; limit: number }): {
    body: ChangelogResponse;
    etag: string;
  } {
    let entries = CHANGELOG;
    if (options.since) {
      const since = options.since;
      entries = entries.filter(e => compare(e.version, since) > 0);
    }
    entries = entries.slice(0, options.limit);

    const body: ChangelogResponse = {
      entries: entries.map(e => ({
        version: e.version,
        date: e.date,
        sections: e.sections,
      })),
    };
    const etag = this.computeEtag(body);
    return { body, etag };
  }

  private computeEtag(body: unknown): string {
    const json = JSON.stringify(body);
    return `"${createHash('sha256').update(json).digest('hex').slice(0, 16)}"`;
  }
}
```

### Honoルート

```typescript
// api/api/src/features/changelog/routes/changelog.ts
const CHANGELOG_CACHE_CONTROL =
  'public, max-age=3600, stale-while-revalidate=86400';

const app = new Hono<HonoBindings>()
  .get(
    '/',
    describeRoute({
      tags: ['Changelog'],
      description: 'アプリのバージョン履歴を返す',
      responses: {
        200: {
          description: '変更履歴',
          content: {
            'application/json': { schema: resolver(ChangelogResponseSchema) },
          },
        },
        304: { description: 'Not Modified' },
        400: {
          description: 'Bad Request',
          content: {
            'application/json': { schema: resolver(BadRequestResponse) },
          },
        },
      },
    }),
    vValidator('query', ChangelogQuerySchema),
    vValidator('header', v.object({ 'if-none-match': v.optional(v.string()) })),
    async c => {
      const { since, limit } = c.req.valid('query');
      const ds = new ChangelogDatasource();
      const { body, etag } = ds.build({ since, limit: limit ?? 100 });

      c.res.headers.set('ETag', etag);
      c.res.headers.set('Cache-Control', CHANGELOG_CACHE_CONTROL);
      if (isNotModified(c.req.header('if-none-match'), etag)) {
        return c.body(null, 304);
      }
      return c.json(body, 200);
    },
  );
```

### `index.ts` 登録

```typescript
import changelogApp from './features/changelog/routes/changelog';
app.route('/v1/changelog', changelogApp);
```

### OpenAPI タグ追加

`api/api/src/openapi.ts` の `tags` 配列に追加。

```typescript
{ name: 'Start', description: 'アプリ起動時メタ情報' },
{ name: 'Changelog', description: 'バージョン履歴' },
```

---

## Flutter 実装方針

### Repository

`app/lib/feature/changelog/data/repository/changelog_repository.dart`

```dart
@riverpod
ChangelogRepository changelogRepository(Ref ref) => ChangelogRepository(
  client: ref.watch(apiClientProvider),
  prefs: ref.watch(sharedPreferencesProvider),
);

class ChangelogRepository {
  static const _etagKey = 'changelog_etag';
  static const _bodyKey = 'changelog_body';

  Future<Result<ChangelogResponse, ApiException>> fetch({String? since}) async {
    final cachedEtag = since == null ? prefs.getString(_etagKey) : null;
    try {
      final response = await client.changelogApi.getChangelog(
        since: since,
        ifNoneMatch: cachedEtag,
      );
      if (response.statusCode == 304) {
        return Result.ok(_readCache());
      }
      // ... キャッシュ書き込み（since指定なしのフル取得時のみ）
      return Result.ok(response.data!);
    } on DioException catch (e) {
      final cached = _tryReadCache();
      if (cached != null) return Result.ok(cached);
      return Result.err(ApiException.fromDio(e));
    }
  }
}
```

### Notifier

```dart
@riverpod
class ChangelogNotifier extends _$ChangelogNotifier {
  @override
  Future<ChangelogResponse> build() async {
    final repo = ref.watch(changelogRepositoryProvider);
    return (await repo.fetch()).unwrapOrThrow();
  }
}
```

### UI

`app/lib/feature/changelog/ui/page/changelog_page.dart` を設定画面の「変更履歴」項目から開く。

- 各エントリは `version + date` のカードで表示
- 各 section を `title` (`新機能` 等) でグルーピング
- `items` の Markdown を `flutter_markdown` でレンダリング

---

## ルーティング図

```
GET /v1/start
  ↓ レスポンスに latest（最新1件のwhats_new含む）

GET /v1/changelog
  ↓ レスポンスに entries[]（全履歴 or since以降）

  両方とも packages/changelog の CHANGELOG[] を参照
```

```
リリースフロー:
  1. PR で packages/changelog/src/changelog.ts に新エントリを追加
  2. show_whats_new / whats_new / sections を埋める
  3. アプリのバージョンと一致させる
  4. デプロイ
  5. ユーザー側はアプリ起動時に新しい version を見て What's New 表示
```

---

## オープン項目

- **`compare(semver)` パッケージ追加**: npm `semver` を使うかネイティブ実装するか
- **`section.title` の enum 化**: TS側は型で縛れるが、API応答時に文字列のままで良いか
- **Markdown レンダラの選定**: アプリ側で `flutter_markdown` 採用前提。表組みや画像の扱い要確認
- **多言語対応**: 将来的に `en` 対応する場合は `Accept-Language` で分岐 or `entries[].translations` で持たせる

---

## 実装フェーズ

| Phase | 内容 | 依存 |
|---|---|---|
| **P1. パッケージ** | `packages/changelog` 新設（型・データ・export） | [088](088_start_api.md) P1 と共用 |
| **P2. バックエンド実装** | `features/changelog/` 配下のdatasource/model/route | P1 |
| **P3. OpenAPI生成** | Start APIと一緒に生成 | P2 |
| **P4. Flutter Repository / Notifier** | キャッシュ層含む実装 | P3 |
| **P5. UI** | Changelog画面（設定→変更履歴で開く） | P4 |
| **P6. リリースフロー文書化** | `docs/knowledge/{date}_release_flow.md` 作成 | P1-P5 |

---

## 参考リンク

- 既存ETag実装: `api/api/src/features/parameters/routes/parameters.ts`
- packages workspace: `/home/yumnumm/EQMonitor/backend/pnpm-workspace.yaml`
- npm semver: https://www.npmjs.com/package/semver

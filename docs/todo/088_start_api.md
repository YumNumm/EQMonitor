# Start API 仕様書 — アプリ起動時メタ情報配信

**作成日**: 2026-05-15
**対象ブランチ**: develop
**ステータス**: 設計完了 / 実装未着手
**関連**: [089_changelog_api.md](089_changelog_api.md) / [090_subscription_implementation.md](090_subscription_implementation.md)

---

## 背景

アプリ起動時にサーバから取得すべき情報が散在しており、以下の課題がある。

- **広告制御**: 大地震やメンテ時に広告を一斉に消す仕組みがない。現状はアプリの再ビルドが必要。
- **強制アップデート**: 重大バグや破壊的変更を持ち込んだ際にユーザーへ強制的にアップデートを促す仕組みがない。
- **What's New**: アップデート直後に何が変わったかをユーザーに伝える手段がない。
- **メンテナンス通知**: メンテ中の障害をユーザーに伝える手段がない。

これらをまとめて取得できる **Start API** を新設し、アプリ起動時の単一エンドポイントに集約する。

---

## 要件

### 機能要件

1. **フラグ配信**: 広告 ON/OFF・メンテナンスフラグ等の動的フラグを返す
2. **バージョン情報配信**: 最新バージョン・強制アップデート対象バージョン・ストアURLを返す
3. **What's New 配信**: 最新バージョンのリリースノート（Markdown）を返す
4. **ETag によるキャッシュ**: 変更がなければ 304 Not Modified を返し、アプリ側の通信量を削減
5. **エッジキャッシュ可能**: `Cache-Control` で CDN レイヤでもキャッシュさせる

### 非機能要件

- **可用性**: このAPIが落ちてもアプリは起動できる（クライアント側のキャッシュ・デフォルト値でフォールバック）
- **低レイテンシ**: 起動を遅らせないため p95 < 200ms を目標
- **認証不要**: 端末プロビジョニング前にも呼び出せる必要があるため、認証は不要

---

## エンドポイント仕様

### `GET /v1/start`

#### Request Headers

| ヘッダ | 必須 | 説明 |
|---|---|---|
| `If-None-Match` | No | クライアントが保持しているETag。一致すれば 304 を返す |
| `Accept-Language` | No | 将来の多言語対応用。現状は `ja` のみ |

#### Response Headers

| ヘッダ | 値 | 説明 |
|---|---|---|
| `ETag` | `"<hex>"` | コンテンツハッシュ |
| `Cache-Control` | `public, max-age=60, stale-while-revalidate=300` | CDNキャッシュ + 短期SWR |
| `Content-Type` | `application/json; charset=utf-8` | |

#### Response 200 ボディ

```typescript
interface StartResponse {
  flags: {
    ads_enabled: boolean;
    maintenance: {
      enabled: boolean;
      message?: string;  // Markdown
      url?: string;      // 詳細ページURL（例: ステータスページ）
    };
  };
  app: {
    version: {
      latest?: {
        version: string;        // "x.y.z"
        date: string;           // ISO 8601 (例: "2026-05-15")
        show_whats_new: boolean;
        whats_new?: {
          title?: string;
          content: string;      // Markdown
        };
      };
      required_versions: {
        version: string;        // "x.y.z" — このバージョン未満は強制アップデート
        message?: string;       // Markdown — なぜ強制更新が必要か
      }[];
    };
    store_url: {
      ios: string;
      android: string;
    };
  };
}
```

#### Response 304

ボディなし。ETagが一致した場合に返す。

#### Response 5xx

```typescript
interface InternalServerErrorResponse {
  code: 'INTERNAL_SERVER_ERROR';
  message: string;
}
```

---

## valibot スキーマ案

`api/api/src/features/start/model/responses.ts` に配置。

```typescript
import * as v from 'valibot';

const VersionString = v.pipe(
  v.string(),
  v.regex(/^\d+\.\d+\.\d+$/, 'must be semver x.y.z'),
);

export const MaintenanceInfoSchema = v.object({
  enabled: v.boolean(),
  message: v.optional(v.string()),
  url: v.optional(v.pipe(v.string(), v.url())),
});

export const FlagsSchema = v.object({
  ads_enabled: v.boolean(),
  maintenance: MaintenanceInfoSchema,
});

export const WhatsNewSchema = v.object({
  title: v.optional(v.string()),
  content: v.string(),
});

export const LatestVersionSchema = v.object({
  version: VersionString,
  date: v.pipe(v.string(), v.isoDate()),
  show_whats_new: v.boolean(),
  whats_new: v.optional(WhatsNewSchema),
});

export const RequiredVersionSchema = v.object({
  version: VersionString,
  message: v.optional(v.string()),
});

export const StoreUrlSchema = v.object({
  ios: v.pipe(v.string(), v.url()),
  android: v.pipe(v.string(), v.url()),
});

export const StartResponseSchema = v.object({
  flags: FlagsSchema,
  app: v.object({
    version: v.object({
      latest: v.optional(LatestVersionSchema),
      required_versions: v.array(RequiredVersionSchema),
    }),
    store_url: StoreUrlSchema,
  }),
});

export type StartResponse = v.InferOutput<typeof StartResponseSchema>;
```

---

## バックエンド実装方針

### ディレクトリ構成

```
api/api/src/features/start/
├── datasource/
│   └── start-config-datasource.ts   ← 設定ソースの読み込み
├── model/
│   └── responses.ts                 ← valibotスキーマ
└── routes/
    └── start.ts                     ← Honoルート
```

### 設定ソース戦略

フラグ・バージョン情報・What's New は **TypeScript ファイルに埋め込み** で管理する。
- ホットフィックスで切り替えたい `ads_enabled` / `maintenance` は環境変数 or Cloudflare KV / Valkey から読む
- `latest` / `required_versions` は `packages/changelog`（後述）から参照する

```typescript
// api/api/src/features/start/datasource/start-config-datasource.ts
import { CHANGELOG, STORE_URL, REQUIRED_VERSIONS } from '@eqmonitor-backend/changelog';

export class StartConfigDatasource {
  constructor(
    private readonly env: {
      ADS_ENABLED?: string;
      MAINTENANCE_ENABLED?: string;
      MAINTENANCE_MESSAGE?: string;
      MAINTENANCE_URL?: string;
    },
  ) {}

  build(): { body: StartResponse; etag: string } {
    const latest = CHANGELOG[0];
    const body: StartResponse = {
      flags: {
        ads_enabled: this.env.ADS_ENABLED !== 'false',
        maintenance: {
          enabled: this.env.MAINTENANCE_ENABLED === 'true',
          message: this.env.MAINTENANCE_MESSAGE,
          url: this.env.MAINTENANCE_URL,
        },
      },
      app: {
        version: {
          latest: latest && {
            version: latest.version,
            date: latest.date,
            show_whats_new: latest.show_whats_new,
            whats_new: latest.whats_new,
          },
          required_versions: REQUIRED_VERSIONS,
        },
        store_url: STORE_URL,
      },
    };
    const etag = computeEtag(body);
    return { body, etag };
  }
}

const computeEtag = (body: unknown): string => {
  // 決定的なETagを得るため、キー順序をソートしてからシリアライズ
  const json = stableStringify(body);
  return `"${createHash('sha256').update(json).digest('hex').slice(0, 16)}"`;
};

/** JSON.stringify は object key 挿入順依存。fast-json-stable-stringify 等を使う */
const stableStringify = (value: unknown): string => {
  // npm: fast-json-stable-stringify
  return require('fast-json-stable-stringify')(value);
};
```

### Honoルート

```typescript
// api/api/src/features/start/routes/start.ts
const START_CACHE_CONTROL = 'public, max-age=60, stale-while-revalidate=300';

const app = new Hono<HonoBindings>()
  .get(
    '/',
    describeRoute({
      tags: ['Start'],
      description: 'アプリ起動時のフラグ・バージョン情報を返す',
      responses: {
        200: {
          description: 'Start情報',
          content: {
            'application/json': { schema: resolver(StartResponseSchema) },
          },
        },
        304: { description: 'Not Modified' },
      },
    }),
    vValidator('header', v.object({ 'if-none-match': v.optional(v.string()) })),
    async c => {
      const ds = new StartConfigDatasource(c.env);
      const { body, etag } = ds.build();
      c.res.headers.set('ETag', etag);
      c.res.headers.set('Cache-Control', START_CACHE_CONTROL);
      if (isNotModified(c.req.header('if-none-match'), etag)) {
        return c.body(null, 304);
      }
      return c.json(body, 200);
    },
  );
```

### `index.ts` 登録

```typescript
import startApp from './features/start/routes/start';
app.route('/v1/start', startApp);
```

---

## Flutter 実装方針

### パッケージ配置

`packages/eqmonitor_api` の OpenAPI 自動生成に乗せる（既存パターン踏襲）。

### Repository

`app/lib/feature/start/data/repository/start_repository.dart` に新規作成。

```dart
@riverpod
StartRepository startRepository(Ref ref) => StartRepository(
  client: ref.watch(apiClientProvider),
  prefs: ref.watch(sharedPreferencesProvider),
);

class StartRepository {
  StartRepository({required this.client, required this.prefs});
  final ApiClient client;
  final SharedPreferences prefs;

  static const _etagKey = 'start_etag';
  static const _bodyKey = 'start_body';

  Future<Result<StartResponse, ApiException>> fetch() async {
    final cachedEtag = prefs.getString(_etagKey);
    try {
      final response = await client.startApi.getStart(
        ifNoneMatch: cachedEtag,
      );
      if (response.statusCode == 304) {
        return Result.ok(_readCache());
      }
      final body = response.data!;
      final etag = response.headers.value('etag');
      if (etag != null) {
        await prefs.setString(_etagKey, etag);
        await prefs.setString(_bodyKey, jsonEncode(body.toJson()));
      }
      return Result.ok(body);
    } on DioException catch (e) {
      // フォールバック: キャッシュがあればそれを返す
      final cached = _tryReadCache();
      if (cached != null) {
        return Result.ok(cached);
      }
      return Result.err(ApiException.fromDio(e));
    }
  }

  StartResponse _readCache() { /* ... */ }
  StartResponse? _tryReadCache() { /* ... */ }
}
```

### Notifier

```dart
@Riverpod(keepAlive: true)
class StartNotifier extends _$StartNotifier {
  @override
  Future<StartResponse> build() async {
    final repo = ref.watch(startRepositoryProvider);
    final result = await repo.fetch();
    return result.unwrapOrThrow();
  }
}
```

### 起動フロー組み込み

`app/lib/main.dart` または `app/lib/app.dart` で：

1. `StartNotifier` を起動時にプリフェッチ（`ref.read(startNotifierProvider.future)`）
2. 完了を待たずに UI を表示開始
3. `required_versions` チェックは別 Flow で実施（後述）
4. `show_whats_new == true` なら What's New ダイアログを表示

### 強制アップデート判定

```dart
@riverpod
ForcedUpdateState forcedUpdate(Ref ref) {
  final start = ref.watch(startNotifierProvider).valueOrNull;
  if (start == null) return ForcedUpdateState.notRequired();

  final currentVersion = ref.watch(packageInfoProvider).version;
  final required = start.app.version.requiredVersions;

  for (final req in required) {
    if (Version.parse(currentVersion) < Version.parse(req.version)) {
      return ForcedUpdateState.required(
        targetVersion: req.version,
        message: req.message,
      );
    }
  }
  return ForcedUpdateState.notRequired();
}
```

### What's New 表示判定

```dart
// app/lib/feature/start/data/flow/whats_new_flow.dart
Future<void> maybeShowWhatsNew(WidgetRef ref, BuildContext context) async {
  final start = await ref.read(startNotifierProvider.future);
  final latest = start.app.version.latest;
  if (latest == null || !latest.showWhatsNew) return;

  final prefs = ref.read(sharedPreferencesProvider);
  final lastSeen = prefs.getString('whats_new_last_seen');
  if (lastSeen == latest.version) return;

  if (!context.mounted) return;
  await showDialog(
    context: context,
    builder: (ctx) => WhatsNewDialog(content: latest.whatsNew!),
  );
  await prefs.setString('whats_new_last_seen', latest.version);
}
```

---

## 運用フロー

### 通常時

```
ads_enabled = true
maintenance.enabled = false
latest = 最新リリース情報
required_versions = []
```

### 大地震発生時

`ADS_ENABLED=false` を環境変数 or KV に設定して即時反映。
CDN キャッシュ TTL が短い（60秒）ため最大1分以内にユーザーへ伝播する。

### メンテナンス時

```
maintenance.enabled = true
maintenance.message = "## 緊急メンテナンス\nサーバ更新作業のため一時的に..."
maintenance.url = "https://status.eqmonitor.app"
```

アプリ側はメンテ画面を全画面表示（ただし強震モニタ・EEW受信等のローカル機能は継続）。

### 強制アップデート時

```
required_versions = [
  { version: "2.5.0", message: "重大なバグ修正のためアップデートが必要です" }
]
```

アプリ側はストアへの遷移ダイアログを表示し、それ以下のバージョンでは操作不可。

---

## オープン項目（実装中に決める）

- **フラグの設定ソース**: 環境変数か Cloudflare KV か Valkey か。即時反映性を優先するなら KV/Valkey。
- **ETag算出範囲**: ボディ全体のハッシュで良いか、`flags` と `app.version` を分けて別ETagにすべきか（前者で十分のはず）。
- **ETag決定性**: `JSON.stringify` のキー順序は挿入順依存のため `fast-json-stable-stringify` 等で決定化が必要。データソース変更時の不要なETag変動を避ける。
- **Maintenance Message のレンダリング**: アプリ側でMarkdownレンダラ（`flutter_markdown`）導入が必要。既存ライブラリ確認が必要。
- **rollout 段階**: `latest.show_whats_new` を段階的にtrueにする仕組みがあると安心（A/B分割等）。初期は不要。

---

## 実装フェーズ

| Phase | 内容 | 依存 |
|---|---|---|
| **P1. Changelogパッケージ** | `packages/changelog` を新設し `CHANGELOG[]` / `REQUIRED_VERSIONS` / `STORE_URL` を定義 | なし |
| **P2. バックエンド** | `features/start/` 配下のdatasource/model/route実装、`index.ts` に登録 | P1 |
| **P3. OpenAPI生成** | OpenAPIスキーマ生成 + `packages/eqmonitor_api` にクライアント取り込み | P2 |
| **P4. Flutter Repository** | `feature/start/data/repository/` + キャッシュ層実装 | P3 |
| **P5. Flutter Notifier** | `StartNotifier` + `forcedUpdate` provider実装 | P4 |
| **P6. UI** | What's Newダイアログ、強制アップデートダイアログ、メンテナンス画面 | P5 |
| **P7. 起動フロー組み込み** | `main.dart` / `app.dart` への組み込み、テスト | P6 |
| **P8. Codegen + Analyze** | `melos run generate` → `melos run analyze` | P1-P7 |

---

## 参考リンク

- 既存ETag実装: `api/api/src/features/parameters/routes/parameters.ts`
- Honoルート登録例: `api/api/src/index.ts`
- OpenAPI生成設定: `packages/eqmonitor_api/swagger_parser.yaml`
- Riverpod Notifier規約: `AGENTS.md` の「状態管理」セクション

# v2→v3 マイグレーション調査ノート — backend側 (2026-07-07)

backend = origin/main a82e9185 / app = develop 7906eedd3

## 実装ファイル

- `api/api/src/features/migration/routes/migration.ts:1-202` — `POST /v2/device/migrate` エンドポイント（device.ts L414 で `.route('/migrate', migrationRoutes)`）
- `api/api/src/features/migration/datasource/supabase-reader.ts:1-107` — v2 Supabase 読み込み（`SupabaseReader.fromEnv()`、`readOldDeviceData`、`markAsMigrated`）
- `api/api/src/features/migration/datasource/migration-writer.ts:1-121` — v3 DB 書き込み（`db.transaction()` 内で settings/notification/slots を insert）
- `api/api/src/features/migration/model/requests.ts` — `old_device_id`（UUID必須, valibot）
- `api/api/src/features/migration/model/responses.ts` — `migrated: {earthquake_regions, eew_regions, notification_settings}`
- `api/api/src/clickhouse-event.ts:1-33` — `recordDeviceEvent(deviceId, event, opts)`（device_event テーブル、非致命 try-catch）→ **migration では未使用**
- `packages/clickhouse/src/client.ts` — ClickHouse クライアント（async_insert=1, wait_for_async_insert=0）

## 処理フロー

1. リクエスト検証 → `SupabaseReader.fromEnv()`（SUPABASE_URL / SUPABASE_SECRET_KEY 必須、欠落 400）
2. `withSpan()` でトレース開始、属性: migration.device_id / old_device_id
3. `readOldDeviceData(oldDeviceId)`: devices の `migrated_at` チェック（非NULLなら `AlreadyMigratedError`→409）、earthquake/eew/notification settings を Promise.all で読む
4. `writer.migrate(deviceId, data)`: トランザクション内で deviceNotificationSettings（onConflictDoNothing）、deviceNotification（onConflictDoNothing）、deviceNotificationSlots（onConflictDoUpdate、既存の相補フラグは SQL で温存）
5. `markAsMigrated(oldDeviceId)`: Supabase devices.migrated_at = now()
6. ログ: 成功 `logger.info('Migration completed', {component:'migration', status:'success', duration_ms, ...})`、409は info/skipped、404/400は warn、他は error+500

## エラーマッピング

| エラー | HTTP | ログ |
|---|---|---|
| SupabaseMigrationReaderConfigError | 400 | warn |
| AlreadyMigratedError | 409 | info (skipped) |
| OldDeviceNotFoundError | 404 | warn |
| その他 | 500 | error |

## 既存テスト（19ケース）

- `api/api/test/migration/migration-routes.test.ts`（7）— Hono app.request + vi.mock で reader/writer/logger/withSpan をモック
- `api/api/test/migration/supabase-reader.test.ts`(9) / `migration-writer.test.ts`(3)
- 流儀: vitest, `test/helpers/mock-db.ts`（Drizzle tx mock）, `test/helpers/test-env.ts`

## 懸念点（backend）

### 重大
- B1: DB書き込み成功後に Supabase markAsMigrated 失敗 → 500。リトライで冪等だが部分成功状態が残る（DBに新データあり・Supabase未マーク）
- B2: deviceNotificationSlots onConflictDoUpdate のマージロジック — 2回目 migrate 呼び出しで既存相補フラグ上書きリスク（実際は migrated_at チェックで防止、理論的脆弱性）

### 中
- B3: **ClickHouse 記録なし** — recordDeviceEvent() を migration で未使用。運用観測は Loki ログのみ ← ユーザー要望に直結
- B4: withSpan 属性が実際に Tempo に記録されるか未確認
- B5: `migrated_at` カラムが supabase/migrations の SQL に無い（database.types.ts には有る）— スキーマ管理の一元化欠如

### 軽度
- B6: error ログに stack trace 無し
- B7: fromEnv の `?? ''` パターン（fromEnv 内でチェックあり、実害なし）
- B8: v2「通知設定なし」ユーザーは v3 でデフォルト値挿入され状態が消滅（仕様確認要）
- B9: Supabase 側 SELECT→UPDATE 間のロックなし（migrated_at チェックでほぼ冪等、race window あり）

### 仕様/設計
- B10: 一方向マイグレーション、ロールバック手段なし
- B11: old_device_id UUID 必須 — v2 デバイスIDが必ず UUID か要確認
- B12: ClickHouse migration イベント記録テスト無し（未実装なので当然）

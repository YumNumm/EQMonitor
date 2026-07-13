# v2→v3 マイグレーション調査ノート — app側 (2026-07-07)

## 実装ファイル

- `app/lib/feature/devices/data/workflow/device_migration_workflow.dart:29-128` — Durable Workflow（4ステップ: ensureDeviceAbsent → registerDevice → migrateLegacySettings → markLocalComplete）。instanceId=`v3-device-migration-v1`
- `app/lib/feature/devices/data/notifier/device_provisioning_notifier.dart:53-104` — provision()（RetryController 付き）
- `app/lib/feature/devices/data/repository/device_repository.dart:117-167` — migrateFromLegacy()（POST /v2/device/me/migrate）
- `app/lib/feature/devices/data/repository/device_provisioning_repository.dart:36-45` — legacyDeviceId / deviceMigratedFromLegacy の読み書き
- `app/lib/feature/devices/data/persistence/shared_preferences_workflow_persistence.dart` — `_wf:` プレフィックスのステップ結果保存
- `app/lib/feature/devices/data/exception/device_provisioning_exception.dart` — 9種 sealed 例外（retryable フラグ付き）
- `app/lib/feature/devices/data/exception/dio_exception_mapper.dart` — DioException→例外マッピング
- `app/lib/feature/devices/data/retry/retry_controller.dart` — 指数バックオフ（最大6回、jitter、最大60s、Retry-After 優先）
- `packages/eqmonitor_api/.../device_api_client.dart:250-254` — postV2DeviceMeMigrate()（**未使用**）
- `packages/eqmonitor_api/.../migration_response.dart` / `migration_result_response.dart` — **未使用モデル**

## 起動フロー

home_page.dart:61-73（自動トリガー）/ welcome_step_page.dart（オンボーディング provision()）/ notification_settings_step_page.dart（migrated フラグでUI切替）

## SharedPreferences キー

`device_id`(v2旧ID) / `device_migrated_from_legacy` / `device_provisioned` / `_wf:v3-device-migration-v1:<step>` ×4 / `_wf:__m__:v3-device-migration-v1`

## 既存テスト

- `app/test/feature/migration/v3_migration_workflow_test.dart` — 7ケース（ハッピーパス、キャッシュ冪等、401/unauthenticated、PUT失敗復帰、migrate失敗復帰、500伝播）
- `app/test/core/theme/migration/theme_migration_test.dart` — 5ケース（別件のテーマ移行）

## 懸念点（app）

- A1: migrateFromLegacy() が生成 API クライアントを使わず直接 Dio POST（インターセプタ経路の不一致）
- A2: 409/404 を無言で成功扱い — 「旧デバイス未検出(404)」と「移行成功」を区別しない。移行フラグは立つが実際は何も移行されていない可能性
- A3: 完了フラグ二重管理（deviceMigratedFromLegacy と _wf markLocalComplete ステップ）の不一致リスク
- A4: **ログ出力が完全に欠落**（開始/各ステップ/エラー時ともに無し。Crashlytics は例外のみ）
- A5: MigrationResponse/MigrationResultResponse 未使用 — 移行件数情報を捨てている
- A6: 旧デバイスID (`device_id`) をマイグレーション後に削除しない → 毎回ワークフロー再評価（キャッシュ/409で実害は薄い）
- A7: registerDevice() で deviceLocale=.ja ハードコード
- A8: **テスト不足**: retry_controller / dio_exception_mapper / device_provisioning_notifier.provision() / migrateFromLegacy(404/409/成功パス) のテスト無し
- A9: instanceId ハードコード（実務上問題なし）
- A10: manual retry (reset()) と RetryController の状態管理分離

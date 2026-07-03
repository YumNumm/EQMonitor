# テレメトリ機能 仕様書

EQMonitor アプリのクライアントテレメトリ収集基盤の仕様をまとめる。アプリ内で発生する各種イベント（アプリ起動・通知・画面遷移・Live Activity など）をローカル SQLite に蓄積し、バッチでバックエンドへ送信して ClickHouse に保存する仕組みを対象とする。

> 対象コミット時点の実装をもとに記述している。実装変更時は本ドキュメントも更新すること。

## 1. 目的とスコープ

### 1.1 目的

- アプリの利用状況・ユーザー行動・通知配信結果・端末特性を、粒度の細かいイベントとして収集する。
- Firebase Analytics / Crashlytics では表現しづらい、アプリ固有のイベント（EEW Live Activity のライフサイクル、通知受信→開封の経過時間など）を独自スキーマで記録する。
- 収集データを自前のバックエンド（ClickHouse）に集約し、分析コスト・収集内容を自前でコントロールする。

### 1.2 Firebase 系モニタリングとの棲み分け

| システム | 役割 | 収集先 | 有効/無効の制御 |
|---|---|---|---|
| Firebase Crashlytics | クラッシュ・例外レポート | Firebase | `setCrashlyticsCollectionEnabled(!kDebugMode)`（デバッグ時のみ無効） |
| Firebase Analytics | 標準的なライフサイクル分析・画面遷移 | Firebase | Firebase 設定に依存（`FirebaseAnalyticsObserver`） |
| **EQMonitor Telemetry（本仕様）** | アプリ固有のイベント追跡（オフライン蓄積＋バッチ送信） | 自前 ClickHouse | **現状オプトアウトなし**（Web を除き常時有効） |

画面遷移の収集は Firebase Analytics の `FirebaseAnalyticsObserver` が担う。本テレメトリ側の画面遷移収集（`TelemetryNavigatorObserver`）は削除済み。

### 1.3 スコープ

- 対象プラットフォーム: iOS / Android。**Web は無効**（`kIsWeb` チェックで初期化をスキップ）。
- 対象パッケージ: `packages/telemetry_store`（プラットフォーム非依存の Dart パッケージ）、`app/lib/feature/telemetry`（アプリ層統合）、`backend/api/api/src/features/telemetry`（受信 API）、`backend/clickhouse`（保存先）。

## 2. アーキテクチャ

```
┌──────────────────────── App (Flutter) ────────────────────────┐
│                                                                │
│  収集サイト                                                     │
│   ├─ AppLaunchWatcher            (アプリ起動: cold_start/resume)│
│   ├─ FirebaseMessagingInteraction(通知: received/opened)       │
│   └─ LiveActivityTokenSyncService(Live Activity: 開始/更新/終了)│
│              │ TelemetryEvent                                   │
│              ▼                                                  │
│   TelemetryRecorder ──► SQLite (Drift, telemetry.db)           │
│   AppLaunchRecorder      synced=false で蓄積                    │
│              ▲                                                  │
│              │ getUnsyncedEvents / markAsSynced                 │
│   TelemetryUploader ──► ApiEventSender (Dio)                   │
│                              │ POST /v2/device/me/telemetry/events
└──────────────────────────────┼────────────────────────────────┘
                               ▼
┌──────────────────────── Backend (Hono) ───────────────────────┐
│  POST /v2/device/me/telemetry/events (device bearer 認証)      │
│   ├─ app_launch      → ClickHouse: app_launch テーブル         │
│   └─ それ以外        → ClickHouse: client_telemetry テーブル   │
└────────────────────────────────────────────────────────────────┘
```

### 2.1 レイヤー構成と責務

| レイヤー | 場所 | 責務 |
|---|---|---|
| ドメイン/永続化パッケージ | `packages/telemetry_store/` | プラットフォーム非依存。イベントモデル定義、SQLite 永続化、記録、バッチ送信ロジック。アプリ固有 import を持たない |
| アプリ統合層 | `app/lib/feature/telemetry/` | Riverpod Provider、ナビゲーション/Firebase/Live Activity との統合、HTTP 送信実装、iOS App Group パス解決 |
| 受信 API | `backend/api/api/src/features/telemetry/` | ステートレス HTTP 受信、イベント振り分け、ClickHouse への INSERT |
| 保存先 | `backend/clickhouse/init/` | `client_telemetry` / `app_launch` テーブル定義（TTL 付き） |

## 3. イベントモデル

### 3.1 TelemetryEvent（sealed union / 7 種）

`packages/telemetry_store/lib/src/models/telemetry_event.dart` で定義される Freezed sealed class。`@Freezed(toJson: false, fromJson: false)` でシリアライズは手書きの `toPayload()` を使用する。各バリアントは `eventType`（DB の `event_type` になる文字列）と `eventId`（オプション）、`toPayload()`（JSON ペイロード）を持つ。

ペイロードの `?key`（Dart のマップ内 null 除外構文）により、null のフィールドはペイロードに含まれない。

| バリアント | `eventType` | 主なフィールド | payload キー（snake_case） | 用途 |
|---|---|---|---|---|
| `NotificationReceivedEvent` | `notification_received` | `framework` (fcm/apns), `channelId`, `title?`, `eventId?`, `priority?` | `framework`, `channel_id`, `title`, `priority` | 通知の受信（開封前） |
| `NotificationOpenedEvent` | `notification_opened` | `coldStart`, `eventId?`, `elapsedMs?` | `cold_start`, `elapsed_ms` | 通知タップによる開封。受信→開封の経過時間 |
| `LiveActivityStartedEvent` | `live_activity_started` | `activityType` (eew/shakeDetection), `activityId` | `activity_type`, `activity_id` | Live Activity 表示開始 |
| `LiveActivityUpdatedEvent` | `live_activity_updated` | `activityType`, `activityId`, `eventId?` | `activity_type`, `activity_id` | Live Activity 内容更新 |
| `LiveActivityEndedEvent` | `live_activity_ended` | `activityType`, `activityId`, `endReason` (completed/dismissed/timeout), `durationMs?` | `activity_type`, `activity_id`, `end_reason`, `duration_ms` | Live Activity 終了。表示時間を含む |
| `ErrorTelemetryEvent` | `error` | `errorType`, `message`, `stackTrace?` | `error_type`, `message`, `stack_trace` | アプリ実行時エラー（Crashlytics とは別系統） |
| `AppLaunchEvent` | `app_launch` | 下記 3.3 参照 | 下記 3.3 参照 | アプリ起動時の端末プロファイル |

> 画面遷移テレメトリ（`UserActionEvent` / `user_action` と `UserActionType`）は削除済み。過去に収集された `user_action` レコードは ClickHouse に残存し得るが、新規収集は行われない。

補足:
- `eventId` を持つのは `notification_received` / `notification_opened` / `live_activity_updated`。地震イベント ID（例: `eq-123`）を紐づけるためのキー。
- `LiveActivityUpdatedEvent` はフィールドに `eventId` を持つが、`toPayload()` には `activity_type` / `activity_id` のみ出力される（`eventId` は DB の `event_id` カラム側に格納される）。

### 3.2 補助 enum

| enum | 定義 | 値 |
|---|---|---|
| `LiveActivityType` | `models/live_activity_type.dart` | `eew`, `shakeDetection` |
| `LiveActivityEndReason` | `models/live_activity_end_reason.dart` | `completed`, `dismissed`, `timeout` |
| `NotificationFramework` | `models/notification_framework.dart` | `fcm`, `apns` |

### 3.3 AppLaunchEvent のフィールド

`AppLaunchEvent` は端末プロファイルとして 16 フィールドを持つ（`toPayload()` は snake_case で出力）。

| フィールド | 型 | payload キー | 必須 | 備考 |
|---|---|---|---|---|
| `launchType` | String | `launch_type` | ○ | `cold_start` / `resume` |
| `appVersion` | String | `app_version` | ○ | |
| `buildNumber` | int | `build_number` | ○ | パース失敗時は 0 |
| `platform` | String | `platform` | ○ | `ios` / `android` |
| `osVersion` | String | `os_version` | ○ | |
| `deviceModel` | String | `device_model` | ○ | iOS は `utsname.machine` |
| `locale` | String | `locale` | ○ | `Platform.localeName` |
| `isPhysicalDevice` | bool | `is_physical_device` | ○ | |
| `physicalRamMb` | int | `physical_ram_mb` | ○ | |
| `cpuCores` | int | `cpu_cores` | ○ | `Platform.numberOfProcessors` |
| `manufacturer` | String | `manufacturer` | ○ | iOS は固定で `Apple` |
| `androidSdkInt` | int? | `android_sdk_int` | Android のみ | |
| `securityPatch` | String? | `security_patch` | Android のみ | `YYYY-MM-DD` 形式 |
| `isLowRamDevice` | bool? | `is_low_ram_device` | Android のみ | |
| `installerStore` | String? | `installer_store` | 任意 | インストール元ストア |

## 4. ローカル永続化（SQLite / Drift）

### 4.1 テーブル定義

`packages/telemetry_store/lib/src/database/telemetry_events_table.dart`

```dart
class TelemetryEvents extends Table {
  IntColumn  get id           => integer().autoIncrement()();
  TextColumn get eventType    => text()();                     // イベント種別
  IntColumn  get timestampMs  => integer()();                  // イベント発生時刻(Unix ms)
  TextColumn get eventId      => text().nullable()();          // 地震イベント等の識別子
  TextColumn get payload      => text()();                     // JSON エンコードされたペイロード
  BoolColumn get synced       => boolean().withDefault(false)();// 送信済みフラグ
  IntColumn  get createdAtMs  => integer()();                  // レコード作成時刻(Unix ms)
}
```

### 4.2 インデックス

- `idx_telemetry_synced`: `synced` に対する部分インデックス（`WHERE synced = 0`）。未送信イベントの高速抽出用。
- `idx_telemetry_event_type`: `(event_type, timestamp_ms)` の複合インデックス。種別×時間範囲での検索用。

### 4.3 主なクエリ（`telemetry_database.dart`）

| メソッド | 内容 |
|---|---|
| `getUnsyncedEvents(limit)` | `synced=0` を `createdAtMs` 昇順で取得（デフォルト上限 100） |
| `markAsSynced(ids)` | 指定 ID を `synced=1` に更新 |
| `deleteOldSyncedEvents(beforeMs)` | 送信済みかつ古いレコードを削除 |
| `getAllEvents(limit, offset)` | デバッグ UI 用の全件取得 |

### 4.4 DB ファイルパス

`app/lib/feature/telemetry/data/provider/telemetry_database_provider.dart` でパスを解決し、`main.dart` から Provider override で注入する。

- iOS: ネイティブ MethodChannel（`net.yumnumm.eqmonitor/app_group`）で App Group コンテナの `containerURL` を取得。通知拡張（Notification Service Extension / Live Activity）とデータを共有するため。
- Android: `getApplicationDocumentsDirectory()` + `telemetry.db`。
- Web: 無効（`main.dart` の `kIsWeb` チェックで `telemetryDbPath = null`）。

## 5. 記録（Recorder）

### 5.1 TelemetryRecorder

`packages/telemetry_store/lib/src/recorder/telemetry_recorder.dart`。単一責務。`TelemetryEvent` を受け取り、`toPayload()` を JSON エンコードし、タイムスタンプ（`timestampMs` / `createdAtMs`）を付与して `TelemetryEventsCompanion` として INSERT する（`synced` はデフォルト false）。

### 5.2 AppLaunchRecorder

`packages/telemetry_store/lib/src/recorder/app_launch_recorder.dart`。`app_launch` 専用のラッパー。**30 秒のデバウンス**を持ち、バックグラウンド/フォアグラウンドの短時間往復で `resume` イベントが多重記録されるのを防ぐ。

## 6. 収集ポイント

| トリガー | 実装ファイル | 記録されるイベント |
|---|---|---|
| アプリ起動 | `app/lib/feature/telemetry/data/provider/app_launch_watcher_provider.dart` | `AppLaunchWatcher.build()` で `cold_start`、`didChangeAppLifecycleState(resumed)` で `resume`（30 秒デバウンス） |
| 通知受信/開封 | `app/lib/core/provider/firebase/firebase_messaging_interaction.dart` | FCM メッセージ到着で `notification_received`、タップで `notification_opened`。記録後 `uploader.flush()` |
| Live Activity | `app/lib/feature/live_activity/data/repository/live_activity_token_sync_service.dart` | `live_activity_started` / `live_activity_updated` / `live_activity_ended` |

> 画面遷移テレメトリ（`TelemetryNavigatorObserver`）は削除済み。

`AppLaunchWatcher` は `main.dart` で `container.read(appLaunchWatcherProvider)` により起動時に登録され、即座に cold_start を記録する。

## 7. 送信（Uploader）

### 7.1 TelemetryUploader.flush()

`packages/telemetry_store/lib/src/uploader/telemetry_uploader.dart`。

1. 未送信イベントを取得（`batchSize`、デフォルト 100）。空なら即 return。
2. 各行を `{event_type, timestamp_ms, event_id, payload, created_at_ms}` の Map に整形。
3. `EventSender.send(events)` を呼ぶ。
4. 成功時: 対象 ID を `markAsSynced`。`UploadResult(sentCount, 0)`。
5. 失敗時（send が false）: `synced=false` のまま。`UploadResult(0, failedCount)`。
6. 例外時: 握りつぶして `UploadResult(0, 0)` を返す（テレメトリはアプリをクラッシュさせない）。

### 7.2 EventSender / ApiEventSender

- `EventSender`（`uploader/event_sender.dart`）は HTTP 転送層の抽象インターフェース。
- `ApiEventSender`（`app/lib/feature/telemetry/data/api_event_sender.dart`）が実装。`POST /v2/device/me/telemetry/events` にイベントバッチを送信する。

### 7.3 送信トリガー

| タイミング | 実装 |
|---|---|
| アプリ起動時 | `main.dart` で `uploader.flush()`（`unawaited`、非ブロッキング） |
| 通知開封後 | `firebase_messaging_interaction.dart` で記録後 |

> 明示的な定期タイマー送信はなく、上記イベント駆動で `flush()` が呼ばれる。送信失敗したイベントは `synced=false` のまま残り、次回 `flush()` で再送される（オフラインファースト）。

## 8. バックエンド API

### 8.1 エンドポイント

`POST /v2/device/me/telemetry/events`（デバイス Bearer 認証 / `device-bearer-auth` ミドルウェア）
実装: `backend/api/api/src/features/telemetry/routes/telemetry.ts`

### 8.2 リクエストスキーマ（Valibot / `model/requests.ts`）

```jsonc
{
  "events": [                        // 1〜500 件
    {
      "event_type":  "string",       // 1〜255 文字
      "timestamp_ms": 0,             // integer
      "event_id":    "string|null",
      "payload":     "string|null",  // JSON 文字列
      "created_at_ms": 0             // integer
    }
  ]
}
```

`app_launch` の payload は別途 `AppLaunchPayload` スキーマで検証される（`launch_type` は `cold_start`/`resume`、`platform` は `ios`/`android`、各文字列 1〜256 文字など）。

### 8.3 レスポンススキーマ（`model/responses.ts`）

```jsonc
{
  "accepted": 0,          // integer（= events.length）
  "warning":  "string?"   // ClickHouse 永続化遅延時のみ
}
```

### 8.4 処理ロジック

1. `event_type === 'app_launch'` とそれ以外に振り分ける。
2. `app_launch` 以外は `client_telemetry` テーブルへ一括 INSERT（`device_id` と `received_at`＝サーバー受信時刻を付与）。ClickHouse 失敗時は warn ログを出しつつ `warning` を付けて 200 を返す。
3. `app_launch` は `insertAppLaunch()` で `app_launch` テーブルへ個別 INSERT（**fire-and-forget / 非致命**）。payload の JSON パース・Valibot 検証・`security_patch` の日付形式検証を行い、失敗しても warn ログのみで継続。
4. レスポンスは常に `accepted: events.length` を返す（ClickHouse 失敗でもアプリ側は成功扱い）。

## 9. データ保存（ClickHouse）

### 9.1 client_telemetry（`clickhouse/init/002_client_telemetry.sql`）

- カラム: `device_id`, `event_type`(LowCardinality), `event_id`(Nullable), `payload`(Nullable), `timestamp_ms`(Int64), `created_at_ms`(Int64), `received_at`(DateTime64(3, 'Asia/Tokyo'))。
- エンジン: `MergeTree` / `PARTITION BY toYYYYMM(received_at)` / `ORDER BY (device_id, received_at)`。
- **TTL: `received_at` + 3 ヶ月で DELETE**。

### 9.2 app_launch（`clickhouse/init/003_app_launch.sql`）

- `AppLaunchPayload` の各フィールドを型付きカラムで保持（`launch_type`/`platform` は Enum8、`security_patch` は `Nullable(Date)` など）。`launched_at` はクライアントの `timestamp_ms` 由来、`received_at` はサーバー受信時刻（デフォルト `now64`）。
- エンジン: `MergeTree` / `PARTITION BY toYYYYMM(launched_at)` / `ORDER BY (platform, app_version, device_id, launched_at)`。
- **TTL: `launched_at` + 1 年**。

## 10. 初期化・ライフサイクル

`app/lib/main.dart` の起動シーケンス:

1. `telemetryDbPath = kIsWeb ? null : await resolveTelemetryDbPath()` で DB パス解決。
2. パスが解決できたら `telemetryDbPathProvider.overrideWithValue(dbPath)`。
3. `uploader.flush()`（`unawaited`）で起動時にキュー済みイベントを送信。
4. `container.read(appLaunchWatcherProvider)` でライフサイクル監視を登録し、cold_start を記録。

DB は Riverpod dispose 時にクローズ。処理中のイベントは SQLite に永続化されているのでアプリ再起動後も残る。

## 11. プライバシー / オプトアウト

### 11.1 現状

- **ユーザー向けのオプトアウト（無効化トグル）は未実装**。
- 収集同意ダイアログ・ビルドフラグ・環境変数による無効化も存在しない。
- Web を除く iOS/Android では常時有効。

### 11.2 デバッグ UI

`app/lib/feature/settings/children/config/debug/telemetry/debug_telemetry_page.dart`

- DB 内の全イベントを一覧表示（同期状態アイコン: `cloud_done` / `cloud_upload_outlined`）。
- 全イベントの手動削除、payload の JSON 確認が可能。
- あくまで開発者向けの確認/デバッグ用であり、プライバシー制御機能ではない。

## 12. エラーハンドリング方針

- テレメトリ処理はすべて**非致命**。失敗は `debugPrint` / `logger.warn` でログ化し、例外を投げない（アプリをクラッシュさせない）。
- 記録の失敗（DB 書き込み失敗など）: 握りつぶす。
- 送信の失敗（ネットワーク/サーバーエラー）: `synced=false` のまま残し、次回 `flush()` で再送。
- ClickHouse 永続化失敗: API は 200 + `warning` を返し、アプリは成功扱い。

## 13. 拡張時の変更箇所

| 追加したいもの | 変更するファイル |
|---|---|
| 新しいイベント種別 | `packages/telemetry_store/lib/src/models/telemetry_event.dart` の sealed union にバリアント追加（`eventType` / `toPayload()` も更新） |
| 記録の呼び出し | 収集サイトで `ref.read(telemetryRecorderProvider)` を注入し `.record(event)` |
| バックエンドの新テーブル振り分け | `backend/api/api/src/features/telemetry/routes/telemetry.ts` と `backend/clickhouse/init/` |

## 14. 主要ファイル一覧

### パッケージ（`packages/telemetry_store/`）
- `lib/telemetry_store.dart` — 公開エクスポート
- `lib/src/database/telemetry_database.dart` / `telemetry_events_table.dart` / `schema_ddl.dart` — Drift DB
- `lib/src/models/telemetry_event.dart` — イベント sealed union
- `lib/src/models/{live_activity_type,live_activity_end_reason,notification_framework,upload_result}.dart` — 補助モデル
- `lib/src/recorder/{telemetry_recorder,app_launch_recorder}.dart` — 記録
- `lib/src/uploader/{telemetry_uploader,event_sender}.dart` — 送信

### アプリ（`app/lib/feature/telemetry/`）
- `data/provider/{telemetry_database,telemetry_recorder,telemetry_uploader,app_launch_recorder,app_launch_watcher}_provider.dart` — Riverpod Provider
- `data/api_event_sender.dart` — HTTP 送信実装
- 収集サイト: `core/provider/firebase/firebase_messaging_interaction.dart`, `feature/live_activity/data/repository/live_activity_token_sync_service.dart`

### バックエンド
- `backend/api/api/src/features/telemetry/routes/telemetry.ts` — 受信ルート
- `backend/api/api/src/features/telemetry/model/{requests,responses}.ts` — スキーマ
- `backend/clickhouse/init/002_client_telemetry.sql` / `003_app_launch.sql` — 保存テーブル

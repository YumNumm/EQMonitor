# Live Activity pushTokenUpdates 実装進捗

作成日: 2026-04-23

## 概要

pushToStart APNs を使った Live Activity **起動**はすでに実装済み（EEWのみ）。
このドキュメントは「起動された Live Activity の update token を監視・送信し、iOS < 18 でのサーバプッシュ更新を可能にする」実装の進捗と今後の作業をまとめる。

---

## 背景・技術的前提

| 項目 | 内容 |
|------|------|
| iOS 18+ | APNs Broadcast チャンネル方式（update token 不要）- backend 実装済み |
| iOS < 18 | per-device update token 方式が必要。現在 Flutter 側送信が未実装 |
| ActivityKit 型識別 | モジュール名**なし**の型名のみで識別（確認済み: backend が `attributes-type: "EewLiveActivityAttributes"` を送信） |
| pushToStart でのアプリ起動 | iOS は pushToStart 受信時にメインアプリをバックグラウンド起動する。アプリ側で `Activity<T>.activityUpdates` → `activity.pushTokenUpdates` でトークン取得可能 |

---

## 完了済み作業

### ✅ Step 1: EQMLiveActivityUtil.swift — pushTokenUpdates 監視メソッド追加

**ファイル**: `packages/live_activity_util/ios/live_activity_util/Sources/live_activity_util/EQMLiveActivityUtil.swift`

追加内容:
- **ミラー型** `EewLiveActivityAttributes` / `ShakeDetectionLiveActivityAttributes` を同ファイルに定義（ContentState は空 — 監視には不要、ActivityKit の型名マッチングは unqualified name のみで動作する）
- `observeEewActivityPushTokenUpdates(_ onUpdate: (NSString, NSString) -> Void)` メソッド — EEW Live Activity の (liveActivityId, pushToken) ペアをコールバックで流す
- `observeShakeDetectionActivityPushTokenUpdates(_ onUpdate: (NSString, NSString) -> Void)` メソッド — 揺れ検知 Live Activity 用（同パターン）

---

## 未完了タスク（実装順）

### Step 2: Dart FFI バインディング再生成

`live_activity_util` パッケージの `ffigen` を再実行して、2引数 ObjC ブロック型 `ObjCBlock_ffiVoid_NSString_NSString` を生成する。

```bash
cd packages/live_activity_util
flutter pub run build_runner build
# または ffigen を直接実行
dart run ffigen --config ffigen.yaml
```

生成後、`lib/src/live_activity_util.dart` に `ObjCBlock_ffiVoid_NSString_NSString` クラスが追加されることを確認。

### Step 3: Flutter — Live Activity update token Stream Provider

**新規作成**: `app/lib/feature/live_activity/data/provider/live_activity_token_stream.dart`

既存の `app/lib/feature/settings/features/notification/data/provider/notification_token_stream.dart` のパターンを参考にする。

```dart
// 概要: EEW / ShakeDetection activity の update token を Stream で流す computed provider
@Riverpod(keepAlive: true)
Stream<({String liveActivityId, String token, String activityType})>
    liveActivityPushTokenUpdates(Ref ref)
```

実装ポイント:
- `eqmLiveActivityUtil.observeEewActivityPushTokenUpdates(ObjCBlock_ffiVoid_NSString_NSString.listener(...))` で EEW トークン購読
- `observeShakeDetectionActivityPushTokenUpdates` で揺れ検知トークン購読
- `StreamController.broadcast()` で両方を merge する
- `activityType`: `'eew'` / `'shakeDetection'` を付与

### Step 4: Flutter — LiveActivityTokenSyncService（サービスクラス）

**新規作成**: `app/lib/feature/live_activity/data/repository/live_activity_token_sync_service.dart`

> Riverpod 規約: 副作用（サーバ送信）は Provider/build 関数内に書かない。`class HogeService { Future<T> sendHoge() }` パターンを使う。

```dart
class LiveActivityTokenSyncService {
  LiveActivityTokenSyncService({required DeviceRepository deviceRepository});

  /// token stream を購読してサーバ同期を開始する（呼び出し側が管理する）
  void startListening({
    required String deviceId,
    required Stream<({String liveActivityId, String token, String activityType})> tokenStream,
    bool debugMode = false,
  });

  /// update token を 1 件サーバに送信する
  Future<Result<void, Exception>> syncToken({
    required String deviceId,
    required String liveActivityId,
    required String token,
    bool debugMode = false,
  });

  void dispose();
}

// Riverpod provider — DI のみ（副作用を build で行わない）
@Riverpod(keepAlive: true)
Future<LiveActivityTokenSyncService> liveActivityTokenSyncService(Ref ref) async;
```

デバッグ通知: `debugMode` が true かつ `kDebugMode` の場合、`flutter_local_notifications` で `[Debug] LA Token Updated` 通知を表示する。

### Step 5: Flutter — device_repository に syncLiveActivityUpdateToken 追加

**変更**: `app/lib/feature/devices/data/repository/device_repository.dart`

```dart
Future<Result<void, Exception>> syncLiveActivityUpdateToken({
  required String deviceId,
  required String liveActivityId,
  required String token,
});
// → _api.device.putV2DeviceDeviceIdLiveActivityLiveActivityIdToken(...) を呼ぶ
```

### Step 6: Flutter — App Groups UserDefaults

**新規作成**: `app/lib/core/provider/app_group_preferences.dart`

```dart
@Riverpod(keepAlive: true)
Future<SharedPreferencesWithOptions> appGroupPreferences(Ref ref) =>
    SharedPreferencesWithOptions.getInstance(
      const SharedPreferencesOptions(
        ios: IosSharedPreferencesStoreOptions(
          suiteName: 'group.net.yumnumm.eqmonitor',
        ),
      ),
    );
```

**新規作成**: `app/lib/core/provider/app_group_settings_writer.dart`

アプリ起動時に `apiServerUrl` と `debugMode` を App Groups UserDefaults に書き込む provider。

### Step 7: iOS Widget — App Groups から API URL 読み込み

**変更**: `app/ios/Widget/Services/EarthquakeAPIClient.swift`

```swift
private static var apiBaseUrl: String {
    let defaults = UserDefaults(suiteName: "group.net.yumnumm.eqmonitor")
    return defaults?.string(forKey: "apiServerUrl")
        ?? Bundle.main.object(forInfoDictionaryKey: "REST_API_URL") as? String
        ?? "https://api.eqmonitor.app"
}
```

---

## Backend 未完了タスク

### Step 8: notification-resolver — Valkey に update token をキャッシュ

**変更**: `backend/service/notification-resolver/src/repository/redis.ts`

```typescript
// key: la:update:{eventId}  →  Hash: "{deviceId}:{liveActivityId}" → token, TTL 1800s
async setLiveActivityUpdateToken(eventId, deviceId, liveActivityId, token): Promise<void>
async getLiveActivityUpdateTokensForEvent(eventId): Promise<Array<{deviceId, liveActivityId, token}>>
async deleteLiveActivityUpdateToken(eventId, deviceId, liveActivityId): Promise<void>
```

### Step 9: api — live-activity.ts で Valkey にも書き込む

**変更**: `backend/api/api/src/features/device/routes/live-activity.ts`

`PUT /:liveActivityId/token` handler — PostgreSQL 更新後に:
```
HSET la:update:{eventId} {deviceId}:{liveActivityId} {token}
EXPIRE la:update:{eventId} 1800
```

### Step 10: notification-resolver — EEW 終了を 3 分遅延

**新規作成**: `backend/service/notification-resolver/src/live-activity/end-scheduler.ts`

```typescript
export class LiveActivityEndScheduler {
  scheduleEewEnd(event, contentState, delayMs = 3 * 60 * 1000): void
  scheduleShakeEnd(eventId, contentState, delayMs = 2 * 60 * 1000): void  // 新イベントごとにタイマーリセット
  cancelIfExists(eventId: string): void
}
```

**変更**: `backend/service/notification-resolver/src/index.ts`

現在 `isLastInfo || isCancel` で即時 `event: 'end'` を送信しているのを、`endScheduler.scheduleEewEnd()` に変更。

### Step 11: notification-resolver — 揺れ検知 Live Activity 実装

**変更**: `backend/service/notification-resolver/src/types/shake-detection.ts`

`ShakeDetectionMatchedDevice` に `pushToStartToken: string | null` を追加。

**変更**: `backend/service/notification-resolver/src/repository/shake-detection.ts`

`getShakeDetectionMatchedDevices()` のクエリに `deviceApnsToken where type = 'LIVE_ACTIVITY_START'` を追加して `pushToStartToken` を返す。

**変更**: `backend/service/notification-resolver/src/index.ts` — `handleShakeDetectionEvent()` 追記:
1. 初回イベント（`lastLevel === null`）のデバイスに pushToStart APNs で Live Activity 起動
2. レベル更新時に broadcast update（`shake.all` / `shake.region.{name}` チャンネル）
3. 最後のイベントから 2 分後に `endScheduler.scheduleShakeEnd()` で終了

---

## 変更ファイル一覧

### Flutter / iOS
| ファイル | 状態 |
|---------|------|
| `packages/live_activity_util/…/EQMLiveActivityUtil.swift` | ✅ 完了 |
| `packages/live_activity_util/lib/src/live_activity_util.dart` | 🔲 FFI 再生成 |
| `app/lib/feature/live_activity/data/provider/live_activity_token_stream.dart` | 🔲 新規 |
| `app/lib/feature/live_activity/data/repository/live_activity_token_sync_service.dart` | 🔲 新規 |
| `app/lib/feature/devices/data/repository/device_repository.dart` | 🔲 syncLiveActivityUpdateToken 追加 |
| `app/lib/core/provider/app_group_preferences.dart` | 🔲 新規 |
| `app/lib/core/provider/app_group_settings_writer.dart` | 🔲 新規 |
| `app/ios/Widget/Services/EarthquakeAPIClient.swift` | 🔲 App Groups 読み込み |

### Backend
| ファイル | 状態 |
|---------|------|
| `backend/service/notification-resolver/src/repository/redis.ts` | 🔲 update token キャッシュ |
| `backend/api/api/src/features/device/routes/live-activity.ts` | 🔲 Valkey 書き込み |
| `backend/service/notification-resolver/src/live-activity/end-scheduler.ts` | 🔲 新規 |
| `backend/service/notification-resolver/src/index.ts` | 🔲 EEW end 遅延化・shake LA 実装 |
| `backend/service/notification-resolver/src/repository/shake-detection.ts` | 🔲 pushToStartToken 追加 |
| `backend/service/notification-resolver/src/types/shake-detection.ts` | 🔲 型定義追加 |

---

## 検証方法

1. **update token 収集**: 実機 iOS で pushToStart で Live Activity が起動されたあと、`[Debug] LA Token Updated` 通知が出ることを確認（debugMode 有効時）
2. **サーバ同期**: `PUT /v2/device/{id}/live-activity/{laId}/token` が呼ばれ、サーバログに update token が記録されることを確認
3. **Valkey 確認**: `redis-cli hgetall "la:update:{eventId}"` でトークンが格納されていることを確認
4. **EEW 終了遅延**: EEW 最終報受信から 3 分後に Live Activity が自動終了することを確認
5. **揺れ検知 Live Activity**: 揺れ検知イベント受信で Live Activity が起動・更新・終了することを確認
6. **App Groups**: Widget Extension が App Groups UserDefaults から API URL を読み取って正しいエンドポイントに接続することを確認
7. **型ミラーの動作検証**: 実機で `Activity<EewLiveActivityAttributes>.activityUpdates` に pushToStart で起動した activity が流れることを確認（失敗時は SPM 共有パッケージ方式に切り替え）

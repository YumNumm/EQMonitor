# デバイスプロビジョニング基盤 — 設計・実装計画

**作成日**: 2026-05-14
**対象ブランチ**: develop
**ステータス**: 設計完了 / 実装未着手

---

## 背景

現在、アプリ起動フローに「サーバーへのデバイス登録」「FCM/APNs/Live Activity Start トークンの送信」が組み込まれていない（`feature/devices/data/provider/debug_device_settings_providers.dart:24` の `debugDeviceSession` でしか実行されておらず、デバッグ画面を開かない限り走らない）。

加えて、v2.6 アプリの Supabase device ID を持つユーザーに対する v3 移行 workflow (`feature/migration/data/workflow/v3_migration_workflow.dart`) は実装済みだが、これも UI から呼び出されていない。

本タスクではこれらを統合し、**「初回登録」「移行」「トークン同期」を 1 つのシステム**として再構築する。アプリのコア機能であり、ここの信頼性がそのまま通知配信の信頼性に直結する。

---

## 要件

### 機能要件

1. **初回登録 or 移行**: アプリ初回起動時に
   - 旧 `device_id`（v2.6 互換）が SharedPreferences にある場合 → v3 移行 workflow を実行
   - ない場合 → デバイスを新規登録
   - どちらの場合も完了したら `SharedPreferencesKey.deviceProvisioned = true` を立てる
2. **トークン同期**: 登録完了後、FCM / APNs / APNs Push-to-Start の 3 種のトークンを監視
   - 起動時の現在値と前回送信値のハッシュを比較し、差分があれば PATCH
   - アプリ起動中にトークンが更新されたら都度 PATCH
   - 各トークンは独立に管理（部分成功を許容）
3. **再試行**: 「再試行可能な」エラー（ネットワーク / 5xx / RateLimit / AppCheck）は指数バックオフで自動再試行。ユーザーから手動再試行も可能。
4. **UI**: Home Sheet 内にバナーを表示
   - 進行中: 「通知設定を更新しています…」
   - 自動再試行待機中: 「N 秒後に再試行します…」
   - 再試行中: 「再試行中…」
   - 失敗（再試行不可 or 上限到達）: 「失敗しました [再試行]」
   - 正常完了: 非表示

### 非機能要件

- **非ブロッキング**: バナーは情報提示のみ。バナーの状態に関わらず他の UI/機能は通常通り動作する
- **副作用は Mutation に閉じ込める**: Notifier の `build()` は純粋な状態計算のみ。サーバー呼び出し・SharedPreferences 書き込みは Mutation 経由
- **型付き例外**: `DeviceProvisioningException` の sealed 階層で網羅。`userMessage` / `isRetryable` を持たせて UI で簡潔に分岐
- **idempotency**: 重複登録 (409 on migrate)、同一ハッシュの再送は無害

---

## 議論で確定した設計判断

| # | 決定事項 | 理由 |
|---|---|---|
| 1 | `feature/migration/` を解体して `feature/devices/` に統合 | `feature/migration` は実態の一部しか表現していない。デバイスのライフサイクル全体を `feature/devices` に集約する |
| 2 | リポジトリ名: `device_provisioning_repository.dart` | 「移行 + 初回登録 + トークン同期」の責務範囲を正しく表現 |
| 3 | `feature/settings/features/notification/` 配下のトークン関連を移動 | `notification_token_stream.dart` は device-scoped なのに settings 配下にあった。`feature/devices/data/provider/` へ |
| 4 | `eqm_live_activity_util.dart` は `feature/live_activity/data/provider/` へ | ネイティブブリッジは Live Activity feature 側が自然 |
| 5 | `debug_device_settings_providers.dart` は削除し debug 画面を新 Notifier に乗せ換え | コードパスを 1 本化、「debug 画面を開くと裏で登録が走る」現状の暗黙挙動を解消 |
| 6 | `SharedPreferencesKey.deviceProvisioned` を完了フラグに使う | workflow persistence の内部キーを外から参照するのはレイヤ漏れ |
| 7 | トークン指紋: `sha256("${kind}\|${env}\|${token}")` | `kind` (fcm/apns_notification/apns_push_to_start)、`env` (kDebugMode ? dev : prod) を含めることでフレーバー切替・環境変化に追従 |
| 8 | トークン同期トリガ: ストリーム購読 + 起動時 1 回チェック | `notificationTokenStream` を listen し続け、差分があれば PATCH。起動時イベントは初回値で自然にカバー |
| 9 | バナー UI: 1 種類で provisioning/sync 両方を表現、手動再試行ボタン | UX をシンプルに保つ |
| 10 | Exception 配置: `feature/devices/data/exception/` に集約 | feature ごとに Exception を持つパターン |
| 11 | トークン同期は部分成功を許容、状態に保持 | Android では APNs token が無く「失敗」と区別する必要、FCM だけ送信成功・APNs だけ失敗のようなケースを正確に表現 |
| 12 | AppCheck 失敗の検出: Interceptor で reject 時にシグネル付与 | message 文字列マッチより頑丈 |
| 13 | **自動再試行: 指数バックオフ** | `isRetryable == true` の例外で `delay = base * 2^attempt + jitter`、上限到達でユーザー判断に委ねる |

### `build()` を純粋に保つ理由（再確認）

`build()` で他 Notifier の `future` を `await ref.watch(...)` するのは、上流 Provider の初期化を駆動するため副作用と見なす。サーバー呼び出し・SharedPreferences への書き込みは必ず Mutation 経由で実行する。

---

## 想定エラーと Exception 階層

### 想定エラー一覧

| 分類 | エラー | 発生源 | 再試行可能 |
|---|---|---|---|
| 通信 | オフライン / DNS / TLS | `DioExceptionType.connectionError`, `badCertificate` | ✓ |
| 通信 | タイムアウト | `connection/send/receiveTimeout` | ✓ |
| サーバー | 400/422 | リクエスト不正（バグ・互換性） | ✗ |
| サーバー | 401 | 認証なし | ✗ |
| サーバー | 403 | 拒否 | ✗ |
| サーバー | 404 on getDevice | 未登録（**正常パス**、リポジトリで吸収） | — |
| サーバー | 409 on migrate | already migrated（**idempotent OK**、リポジトリで吸収） | — |
| サーバー | 429 | レート制限 | ✓ (Retry-After 尊重) |
| サーバー | 5xx | サーバー起因 | ✓ |
| Firebase | App Check token 取得失敗 | `app_check_interceptor.dart:34` で `FirebaseException` → `DioException.requestCancelled` 変換 | ✓ |
| OS | FCM token 取得失敗 / 返り値 null | `messaging.getToken()` | ✓ |
| OS | APNs token 取得失敗 | `getAPNSToken()` が null（シミュレータ含む） | ✓ |
| OS | Push-to-start token 取得失敗 | Live Activity 未対応端末等 | ✗ (notSupported) / ✓ (それ以外) |
| OS | 通知パーミッション拒否 | `requestPermission` で denied | ✗ |
| ローカル | SharedPreferences 書き込み失敗 | 極稀 | ✓ |

### Exception 階層（配置: `app/lib/feature/devices/data/exception/`）

```dart
sealed class DeviceProvisioningException implements Exception {
  const DeviceProvisioningException({this.cause, this.stackTrace});
  final Object? cause;
  final StackTrace? stackTrace;

  String get userMessage;
  bool get isRetryable;
}

final class NetworkUnreachableException extends DeviceProvisioningException {
  // isRetryable = true
}

final class ServerErrorException extends DeviceProvisioningException {
  // statusCode (5xx), body
  // isRetryable = true
}

final class InvalidRequestException extends DeviceProvisioningException {
  // statusCode (400/422), body
  // isRetryable = false
}

enum AuthorizationFailureReason { appCheckUnavailable, unauthenticated, forbidden }
final class AuthorizationException extends DeviceProvisioningException {
  // reason
  // isRetryable = (reason == appCheckUnavailable)
}

final class RateLimitedException extends DeviceProvisioningException {
  // retryAfter: Duration?
  // isRetryable = true
}

enum PushTokenKind { fcm, apnsNotification, apnsPushToStart }
enum PushTokenFailureReason { permissionDenied, serviceUnavailable, notSupported, unknown }
final class PushTokenUnavailableException extends DeviceProvisioningException {
  // kind, reason
  // isRetryable = (reason in {serviceUnavailable, unknown})
}

final class LocalStorageException extends DeviceProvisioningException {
  // isRetryable = true
}

final class UnexpectedProvisioningException extends DeviceProvisioningException {
  // isRetryable = false
}
```

### Dio → 型付き例外のマッピング

```dart
DeviceProvisioningException mapDioToProvisioningException(
  DioException e, [StackTrace? stack]) {
  // AppCheck rejection は最優先
  if (e.type == DioExceptionType.cancel && _isAppCheckRejection(e)) {
    return AuthorizationException(
      reason: AuthorizationFailureReason.appCheckUnavailable, ...);
  }
  return switch (e.type) {
    connectionTimeout | sendTimeout | receiveTimeout |
    connectionError | badCertificate => NetworkUnreachableException(...),
    badResponse => _fromStatus(e.response?.statusCode, ...),
    _ => UnexpectedProvisioningException(...),
  };
}
```

### AppCheck 失敗のシグナル化

`app_check_interceptor.dart` を修正:

```dart
class AppCheckRejection {
  const AppCheckRejection(this.cause);
  final FirebaseException cause;
}

// onRequest 内の reject:
handler.reject(
  DioException.requestCancelled(
    requestOptions: options,
    reason: 'Failed to get AppCheck Token: ...',
    stackTrace: stackTrace,
  )..error = AppCheckRejection(exception),  // ← シグナル付与
);
```

マッパー側で `e.error is AppCheckRejection` を見て判別する（message 文字列マッチより頑丈）。

---

## 再試行戦略（指数バックオフ）

### パラメータ

```dart
const _retryBaseDelay = Duration(seconds: 2);
const _retryMaxDelay = Duration(seconds: 60);
const _retryMaxAttempts = 6;  // 約 2+4+8+16+32+60 ≈ 122 秒
// delay(attempt) = min(base * 2^attempt + jitter, max)
// jitter = Random().nextInt(1000) ms
```

`RateLimitedException` の `retryAfter` が指定されていればそれを優先。

### Retry 制御の置き場所

Notifier の Mutation 内ではなく、**専用の `RetryController` クラス**として切り出す。これにより:
- テストで時間モックを差し込みやすい
- Notifier は再試行ロジックを意識しなくてよい
- UI が `RetryController.state` を watch して「N 秒後に再試行」を表示できる

```dart
sealed class RetryControllerState {
  const RetryControllerState();
}
class RetryIdle extends RetryControllerState {}
class RetryRunning extends RetryControllerState { final int attempt; }
class RetryWaiting extends RetryControllerState {
  final int attempt;
  final DateTime resumeAt;
  final DeviceProvisioningException lastError;
}
class RetryExhausted extends RetryControllerState {
  final DeviceProvisioningException lastError;
}
```

### UI 表示マッピング

| 状態 | 表示 |
|---|---|
| `RetryIdle` + Mutation 未実行 | バナー非表示 |
| `RetryRunning(attempt: 0)` | 「通知設定を更新しています…」 |
| `RetryRunning(attempt: n > 0)` | 「再試行中…(n 回目)」 |
| `RetryWaiting(resumeAt)` | 「N 秒後に再試行します…」（毎秒更新） |
| `RetryExhausted` or `isRetryable: false` 例外 | 「失敗しました [再試行]」（再試行ボタンで attempt をリセットして再実行） |

手動「再試行」押下時は `RetryController.reset()` してから新規 Mutation を発火する。

---

## ファイル構成（最終形）

```
app/lib/feature/devices/
  data/
    exception/
      device_provisioning_exception.dart            ← 新規
      dio_exception_mapper.dart                     ← 新規
      app_check_rejection.dart                      ← 新規（Interceptor シグナル）
    repository/
      device_repository.dart                        ← 既存（API 1:1 を維持）
      device_provisioning_repository.dart           ← 新規（高レベル: フラグ/ハッシュ永続化、移行 or 登録の振り分け）
    notifier/
      device_provisioning_notifier.dart             ← 新規
      push_token_sync_notifier.dart                 ← 新規
    workflow/
      device_migration_workflow.dart                ← 移動・改名（旧: feature/migration/.../v3_migration_workflow.dart）
    persistence/
      shared_preferences_workflow_persistence.dart  ← 移動（旧: feature/migration/.../persistence/）
    provider/
      notification_token_stream.dart                ← 移動（旧: feature/settings/features/notification/data/provider/）
    model/
      registered_device.dart                        ← 既存
      notification_token.dart                       ← 移動（旧: feature/settings/features/notification/data/model/）
    retry/
      retry_controller.dart                         ← 新規
  ui/
    component/
      device_provisioning_banner.dart               ← 新規
    page/
      debug_device_settings_page.dart               ← 既存（新 Notifier 用に書き換え）

app/lib/feature/live_activity/data/provider/
  eqm_live_activity_util.dart                       ← 移動（旧: feature/settings/features/notification/data/provider/）

app/lib/core/provider/interceptor/
  app_check_interceptor.dart                        ← 修正（AppCheckRejection を付与）

app/lib/core/data/preferences/shared/
  shared_preferences_key.dart                       ← enum 追加（deviceProvisioned + 3 種のハッシュキー）

app/lib/page/
  home_page.dart                                    ← `DeviceProvisioningBanner` を埋め込み

app/lib/main.dart                                   ← `liveActivityTokenSyncWiring` の provisioning ゲート追加
```

### 削除

- `app/lib/feature/migration/` フォルダ全体
- `app/lib/feature/devices/data/provider/debug_device_settings_providers.dart`
- `app/lib/feature/settings/features/notification/` フォルダ全体（中身は移動済みになるため）

### SharedPreferencesKey に追加するエントリ

```dart
deviceProvisioned('device_provisioned'),
lastFcmTokenHash('last_fcm_token_hash'),
lastApnsTokenHash('last_apns_token_hash'),
lastApnsPushToStartTokenHash('last_apns_push_to_start_token_hash'),
```

---

## Notifier 設計

### `DeviceProvisioningNotifier`

```dart
enum DeviceProvisioningStatus { required, notRequired }

@Riverpod(keepAlive: true)
class DeviceProvisioningNotifier extends _$DeviceProvisioningNotifier {
  static final provisionMutation = Mutation<void>();

  @override
  Future<DeviceProvisioningStatus> build() async {
    // 純粋: フラグ読みだけ
    final repo = ref.watch(deviceProvisioningRepositoryProvider);
    return await repo.isProvisioned()
      ? DeviceProvisioningStatus.notRequired
      : DeviceProvisioningStatus.required;
  }

  Future<void> provision() async {
    // 副作用: workflow or registerDevice → markProvisioned
    final repo = ref.read(deviceProvisioningRepositoryProvider);
    final deviceRepo = await ref.read(deviceRepositoryProvider.future);
    final deviceId = await ref.read(deviceIdProvider.future);

    final legacy = await repo.readLegacyDeviceId();
    if (legacy != null && legacy.isNotEmpty) {
      await runDeviceMigrationWorkflow(
        runner: repo.buildRunner(),
        repository: deviceRepo,
        deviceId: deviceId,
        oldDeviceId: legacy,
      );
    } else {
      await deviceRepo.registerDevice(deviceId: deviceId, ...);
    }
    await repo.markProvisioned();
    state = const AsyncData(DeviceProvisioningStatus.notRequired);
  }
}
```

### `PushTokenSyncNotifier`

```dart
@freezed
abstract class PushTokenSyncSnapshot with _$PushTokenSyncSnapshot {
  const factory PushTokenSyncSnapshot({
    required PushTokenKindState fcm,
    required PushTokenKindState apnsNotification,
    required PushTokenKindState apnsPushToStart,
  }) = _PushTokenSyncSnapshot;
}

@freezed
sealed class PushTokenKindState with _$PushTokenKindState {
  const factory PushTokenKindState.notApplicable() = _NotApplicable;
  const factory PushTokenKindState.absent() = _Absent;
  const factory PushTokenKindState.synced() = _Synced;
  const factory PushTokenKindState.pending() = _Pending;
  const factory PushTokenKindState.failed({
    required DeviceProvisioningException error,
  }) = _Failed;
}

@Riverpod(keepAlive: true)
class PushTokenSyncNotifier extends _$PushTokenSyncNotifier {
  static final syncMutation = Mutation<void>();

  @override
  Future<PushTokenSyncSnapshot> build() async {
    // 純粋: 現在のトークンと保存済みハッシュを比較
    final repo = ref.watch(deviceProvisioningRepositoryProvider);
    if (!await repo.isProvisioned()) {
      // provisioning 前は notApplicable 扱い（mutation 抑止）
      return const PushTokenSyncSnapshot(
        fcm: PushTokenKindState.notApplicable(),
        apnsNotification: PushTokenKindState.notApplicable(),
        apnsPushToStart: PushTokenKindState.notApplicable(),
      );
    }
    final token = ref.watch(notificationTokenStreamProvider).valueOrNull;
    return repo.computeSnapshot(token);
  }

  Future<void> sync() async {
    // 各 kind を独立に PATCH → 成功したものだけハッシュを保存し、kind 状態を synced に
    // 失敗したものは failed(error) に
    // 1 つも pending/failed が残ったまま全部終わったら最後の error を throw
    // → Mutation 側で MutationError として扱われる
  }
}
```

---

## 実装フェーズ（タスク分割）

実装は次の順序で進める。各フェーズはアトミックにレビューできる粒度。

| Phase | 内容 | 依存 |
|---|---|---|
| **P1. 基盤** | `SharedPreferencesKey` に 4 エントリ追加 + Exception 階層 + Dio mapper + `AppCheckRejection` 付与 | なし |
| **P2. ファイル移動** | `notification_token_stream` / `notification_token` / `eqm_live_activity_util` / `v3_migration_workflow` / `shared_preferences_workflow_persistence` を新パスへ移動 + import 書き換え（ロジック変更なし） | P1 不要だが先にやるとマージしやすい |
| **P3. Repository** | `DeviceProvisioningRepository` 実装（フラグ・ハッシュ永続化、move-or-register 分岐の facade） | P1, P2 |
| **P4. RetryController** | 指数バックオフ + 状態モデル + テスト | P1 |
| **P5. Notifier** | `DeviceProvisioningNotifier` / `PushTokenSyncNotifier` 実装、Mutation 内で RetryController を使う | P3, P4 |
| **P6. UI** | `DeviceProvisioningBanner` 実装 + `home_page.dart` 組み込み | P5 |
| **P7. クリーンアップ** | `feature/migration/` 削除、`debug_device_settings_providers.dart` 削除、`debug_device_settings_page.dart` を新 Notifier に書き換え、`liveActivityTokenSyncWiring` を provisioning ゲート化 | P5, P6 |
| **P8. Codegen + Analyze** | `melos run generate` → `melos run analyze` → 修正 | P1-P7 |

---

## オープン項目（実装中に決める）

- **RetryController のテスタビリティ**: 時間進行を `Clock` 抽象で注入するか、`Stream.periodic` のモックでやるか。実装着手時に判断。
- **macOS の扱い**: 既存 `liveActivityTokenSyncWiring` は iOS のみ。新規 `PushTokenSyncNotifier` も iOS / Android のみ対象とし、macOS は notApplicable 全埋めで良いか後で確認。
- **debug 画面の再現範囲**: 新 Notifier に置き換えると、現状の「サーバー上の ID」「ユーザー」「種別」表示はそのまま再現可能。トークン同期失敗エラーの可視化を debug 画面でも見せるかは追加検討。
- **メモリ的な再試行限界**: 6 回（≈ 122 秒）で打ち切るのが妥当か。テスト後に調整。

---

## 参考リンク

- 既存 v3 workflow: `app/lib/feature/migration/data/workflow/v3_migration_workflow.dart`
- AppCheck Interceptor: `app/lib/core/provider/interceptor/app_check_interceptor.dart`
- トークン取得ストリーム: `app/lib/feature/settings/features/notification/data/provider/notification_token_stream.dart`
- DeviceRepository (API ラッパ): `app/lib/feature/devices/data/repository/device_repository.dart`
- 既存の Mutation 使用例: `app/lib/feature/settings/features/notification_settings/data/notifier/general_notification_settings_notifier.dart`

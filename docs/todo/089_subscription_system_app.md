# アプリ: サブスクリプション基盤 / デバイス認証リワーク

**作成日**: 2026-05-15
**対象ブランチ**: develop
**ステータス**: 設計完了 / 実装未着手
**関連**: [088_subscription_system_backend.md](./088_subscription_system_backend.md)（バックエンド側仕様）

---

## 背景

バックエンド側でサーバー発行のデバイス ID + JWT Bearer 認証に切り替えるため、アプリ側もそれに追従する必要がある。同時に RevenueCat SDK 統合とサブスク UI を新規実装する。

### 現状の構造

- デバイス ID: `SHA512(UDID) → UUID` 形式をアプリで生成 (`app/lib/core/provider/device_id.dart`)
- 登録: `PUT /v2/device/{deviceId}` + Firebase App Check Limited-Use Token
- 認証: `x-eqmonitor-device-id` ヘッダー + App Check Token を毎リクエスト
- ストレージ: SharedPreferences

### 本タスクで実現すること

- **flutter_secure_storage 採用**: deviceId + JWT を OS 標準のセキュアストレージに保存
- **POST /v2/device 対応**: サーバーから deviceId + JWT を受け取り、ストレージに保存
- **Bearer JWT による認証**: 全 device-scoped API で `Authorization: Bearer <JWT>` を付与
- **チャレンジ登録パスの UI**: 開発者から受け取った response を入力するフロー
- **401/403 ハンドリング**: クレデンシャルを破棄してオンボーディングへ遷移
- **RevenueCat SDK 統合**: 購入処理を SDK に委譲
- **サブスク UI**: Paywall 画面 + サブスク状態確認

### 既存ユーザーマイグレーション

**不要**。アプリは未リリースのため、既存の `device_id` 形式や `deviceProvisioned` フラグは無視してよい。`SharedPreferencesKey` から該当エントリも削除する。

---

## 要件

### 機能要件

1. **初回起動時**: クレデンシャル未保存ならオンボーディングへ
2. **通常パス**: オンボーディング画面の「次へ」で App Check Token を取得 → `POST /v2/device` → クレデンシャル保存
3. **チャレンジパス**: オンボーディング画面の隠し導線（長押し等）からチャレンジ画面へ → `POST /v2/device/challenge` → 表示されたコードを開発者に送る → 受け取った response を入力 → `POST /v2/device` → クレデンシャル保存
4. **2 回目以降の起動**: クレデンシャルを Keychain/Keystore から読み出し、認証済み状態でホームへ
5. **API 認証**: Dio Interceptor で全 device-scoped リクエストに `Authorization: Bearer <JWT>` を自動付与
6. **401/403 検出**: Repository が DioException を `CredentialInvalidException` にマップ → Notifier でクレデンシャル消去 → オンボーディングへ
7. **サブスク**: RevenueCat SDK で購入処理、サブスク状態は `GET /v2/subscription/me` から取得して UI に反映
8. **プレミアム機能ゲート**: 対象画面・機能はサブスク状態に応じて非表示 or Paywall 誘導

### 非機能要件

- **セキュアストレージ**: deviceId + JWT は `flutter_secure_storage` に保存（SharedPreferences は使わない）
- **オフライン耐性**: クレデンシャルがあればオフラインでもキャッシュ済みデータは表示可能（既存仕様維持）
- **インターセプターはレイヤ分離**: Dio の関心事と Riverpod の関心事を混ぜない（コールバック注入パターン）
- **副作用は Mutation に閉じ込める**: Notifier の `build()` は純粋（既存方針踏襲）
- **型付き例外**: `DeviceProvisioningException` 階層に `CredentialInvalidException` を追加

---

## 設計判断（確定事項）

| # | 決定事項 | 理由 |
|---|---|---|
| 1 | クレデンシャル保存先: `flutter_secure_storage` | iOS Keychain / Android Keystore に保存。SharedPreferences より秘匿性高 |
| 2 | `deviceIdProvider`（既存）は撤去 | アプリ側で deviceId を計算する必要がなくなる |
| 3 | 全 device-scoped API で Bearer JWT を使用 | `x-eqmonitor-device-id` は不要 |
| 4 | App Check Interceptor は `POST /v2/device` のみで動作 | 登録時の bot 排除以外では使わない |
| 5 | 401/403 検出はグローバル Interceptor ではなく Repository 層 | 関心の分離。各 Repository が型付き例外にマップ |
| 6 | クレデンシャル消去のトリガは Notifier から | Repository から直接 invalidate しない（テスタビリティ確保） |
| 7 | `flutter_secure_storage` のキー: `device_id`, `device_token` | シンプルな 2 エントリ |
| 8 | チャレンジ画面はオンボーディング配下の隠し導線 | 一般ユーザーには見せたくない |
| 9 | RevenueCat 連携時のユーザー ID = `deviceId` | サーバー側 `app_user_id` と一致 |
| 10 | サブスク状態の取得は `GET /v2/subscription/me` を使う | RevenueCat SDK の `customerInfo` ではなくサーバーを信頼源とする |
| 11 | Paywall は RevenueCat の UI 機能（`presentPaywall`）を使う | 独自実装よりメンテ容易 |
| 12 | `DeviceProvisioningStatus` に `requireChallenge` 等の状態は追加しない | チャレンジは UI の遷移であって provisioning 状態とは独立 |
| 13 | 既存 `feature/migration/` と v3 migration workflow は撤去済みの想定 | (086 で完了している前提) |
| 14 | クレデンシャル消去時は通知設定もリセットされる前提でよい | ローカル保存していないので自動でリセットされる |

---

## クレデンシャル保存設計

### `DeviceCredential` モデル

```dart
// app/lib/feature/devices/data/credential/device_credential.dart

@freezed
abstract class DeviceCredential with _$DeviceCredential {
  const factory DeviceCredential({
    required String deviceId,
    required String deviceToken,  // JWT
  }) = _DeviceCredential;
}
```

### `DeviceCredentialStore`

```dart
// app/lib/feature/devices/data/credential/device_credential_store.dart

class DeviceCredentialStore {
  DeviceCredentialStore(this._storage);
  final FlutterSecureStorage _storage;

  static const _keyDeviceId = 'eqm_device_id';
  static const _keyDeviceToken = 'eqm_device_token';

  Future<DeviceCredential?> read() async {
    final id = await _storage.read(key: _keyDeviceId);
    final token = await _storage.read(key: _keyDeviceToken);
    if (id == null || token == null) return null;
    return DeviceCredential(deviceId: id, deviceToken: token);
  }

  Future<void> save(DeviceCredential credential) async {
    await Future.wait([
      _storage.write(key: _keyDeviceId, value: credential.deviceId),
      _storage.write(key: _keyDeviceToken, value: credential.deviceToken),
    ]);
  }

  Future<void> clear() async {
    await Future.wait([
      _storage.delete(key: _keyDeviceId),
      _storage.delete(key: _keyDeviceToken),
    ]);
  }
}

@Riverpod(keepAlive: true)
DeviceCredentialStore deviceCredentialStore(Ref ref) =>
    DeviceCredentialStore(const FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
      iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
    ));
```

### iOS Keychain アクセシビリティ

`KeychainAccessibility.first_unlock`: 端末ロック解除後ならバックグラウンドでも読める。再起動直後（ロック前）は読めない。

### Android Keystore

`encryptedSharedPreferences: true` で `EncryptedSharedPreferences` を使う。Android 6.0+ で機能する。

---

## インターセプター構成変更

### 現状

```
AppCheckInterceptor → DeviceIdInterceptor → TalkerDioLogger
```

### 変更後

```
AppCheckInterceptor      → POST /v2/device のみで App Check Token を付与
BearerAuthInterceptor    → POST /v2/device 以外で Authorization: Bearer <JWT> を付与
TalkerDioLogger          → ログ出力（変更なし）
```

`DeviceIdInterceptor` は **撤去**。

### `BearerAuthInterceptor`

```dart
// app/lib/core/provider/interceptor/bearer_auth_interceptor.dart

class BearerAuthInterceptor extends Interceptor {
  BearerAuthInterceptor({required this.tokenReader});
  final Future<String?> Function() tokenReader;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // POST /v2/device 自体は除外（クレデンシャル発行前なので JWT がない）
    if (options.method == 'POST' && options.path == '/v2/device') {
      return handler.next(options);
    }
    // POST /v2/device/challenge も除外（認証不要）
    if (options.method == 'POST' && options.path == '/v2/device/challenge') {
      return handler.next(options);
    }

    final token = await tokenReader();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}
```

### `AppCheckInterceptor`（修正）

```dart
@override
Future<void> onRequest(...) async {
  final isDeviceRegistration =
      options.method == 'POST' && options.path == '/v2/device';
  if (!isDeviceRegistration) {
    // 登録以外では App Check ヘッダーは付けない
    return handler.next(options);
  }

  // Limited-Use Token を取得（既存ロジック）
  final token = await FirebaseAppCheck.instance.getLimitedUseToken();
  options.headers['X-Firebase-AppCheck'] = token;
  handler.next(options);
}
```

### Dio Provider での組み立て

```dart
final dioProvider = Provider((ref) {
  final dio = Dio(BaseOptions(...));
  dio.interceptors.addAll([
    AppCheckInterceptor(),
    BearerAuthInterceptor(
      tokenReader: () async {
        final cred = await ref.read(deviceCredentialStoreProvider).read();
        return cred?.deviceToken;
      },
    ),
    TalkerDioLogger(...),
  ]);
  return dio;
});
```

---

## エラーハンドリング（Repository 層で 401/403 をマップ）

### Exception 階層拡張

既存 `DeviceProvisioningException` (`feature/devices/data/exception/device_provisioning_exception.dart`) に追加:

```dart
final class CredentialInvalidException extends DeviceProvisioningException {
  const CredentialInvalidException({super.cause, super.stackTrace});

  @override
  String get userMessage => 'デバイス認証が失効しました。再登録します。';

  @override
  bool get isRetryable => false;
}
```

### `DioExceptionMapper` 拡張

```dart
// app/lib/feature/devices/data/exception/dio_exception_mapper.dart

DeviceProvisioningException mapDioToProvisioningException(
  DioException e, [StackTrace? stack]) {
  // 既存の AppCheckRejection 判定...

  return switch (e.type) {
    DioExceptionType.connectionTimeout ||
    DioExceptionType.sendTimeout ||
    DioExceptionType.receiveTimeout ||
    DioExceptionType.connectionError ||
    DioExceptionType.badCertificate => NetworkUnreachableException(...),

    DioExceptionType.badResponse => _fromStatus(e, stack),

    _ => UnexpectedProvisioningException(...),
  };
}

DeviceProvisioningException _fromStatus(DioException e, StackTrace? stack) {
  final status = e.response?.statusCode;
  return switch (status) {
    401 || 403 => CredentialInvalidException(cause: e, stackTrace: stack),
    429 => RateLimitedException(...),
    >= 500 && < 600 => ServerErrorException(...),
    400 || 422 => InvalidRequestException(...),
    _ => UnexpectedProvisioningException(...),
  };
}
```

### Notifier 側の処理

```dart
// 任意の Notifier (例: NotificationSettingsNotifier)

Future<void> updateSetting(...) async {
  try {
    await ref.read(notificationSettingsRepositoryProvider).update(...);
  } on CredentialInvalidException {
    // クレデンシャル消去 → オンボーディング遷移
    await ref.read(deviceCredentialStoreProvider).clear();
    ref.invalidate(deviceProvisioningProvider);
    return;
  }
}
```

頻出する場合は共通ハンドラとして抽象化できる:

```dart
// app/lib/feature/devices/data/notifier/credential_invalidation_handler.dart

extension CredentialInvalidationRef on Ref {
  Future<void> invalidateCredential() async {
    await read(deviceCredentialStoreProvider).clear();
    invalidate(deviceProvisioningProvider);
  }
}
```

---

## デバイスプロビジョニング Notifier 改修

### `DeviceProvisioningStatus`

```dart
enum DeviceProvisioningStatus {
  required,        // クレデンシャルなし → オンボーディングへ
  notRequired,     // クレデンシャルあり → ホームへ
}
```

### `DeviceProvisioningNotifier`

```dart
@Riverpod(keepAlive: true)
class DeviceProvisioningNotifier extends _$DeviceProvisioningNotifier {
  static final provisionMutation = Mutation<void>();

  @override
  Future<DeviceProvisioningStatus> build() async {
    final store = ref.watch(deviceCredentialStoreProvider);
    final cred = await store.read();
    return cred != null
        ? DeviceProvisioningStatus.notRequired
        : DeviceProvisioningStatus.required;
  }

  /// 通常パス: App Check Token を使った登録
  Future<void> provisionWithAppCheck({
    required DevicePlatform type,
    required DeviceLocale locale,
  }) async {
    final repo = await ref.read(deviceRepositoryProvider.future);
    final result = await repo.registerDeviceWithAppCheck(type: type, locale: locale);
    await ref.read(deviceCredentialStoreProvider).save(result.credential);
    state = const AsyncData(DeviceProvisioningStatus.notRequired);
  }

  /// チャレンジパス: code + response を使った登録
  Future<void> provisionWithChallenge({
    required String challengeCode,
    required String challengeResponse,
    required DevicePlatform type,
    required DeviceLocale locale,
  }) async {
    final repo = await ref.read(deviceRepositoryProvider.future);
    final result = await repo.registerDeviceWithChallenge(
      challengeCode: challengeCode,
      challengeResponse: challengeResponse,
      type: type,
      locale: locale,
    );
    await ref.read(deviceCredentialStoreProvider).save(result.credential);
    state = const AsyncData(DeviceProvisioningStatus.notRequired);
  }
}
```

### `DeviceRepository` API 変更

```dart
// app/lib/feature/devices/data/repository/device_repository.dart

class DeviceRepository {
  // 既存: PUT /v2/device/{id} → 撤去
  // 既存: GET /v2/device/{id}  → /me に変更
  // 既存: DELETE /v2/device/{id} → /me に変更

  Future<RegistrationResult> registerDeviceWithAppCheck({
    required DevicePlatform type,
    required DeviceLocale locale,
  }) async {
    // POST /v2/device
    // AppCheckInterceptor が X-Firebase-AppCheck を付与
    final res = await _client.createDevice(type: type, locale: locale);
    return RegistrationResult(
      credential: DeviceCredential(deviceId: res.deviceId, deviceToken: res.deviceToken),
    );
  }

  Future<RegistrationResult> registerDeviceWithChallenge({
    required String challengeCode,
    required String challengeResponse,
    required DevicePlatform type,
    required DeviceLocale locale,
  }) async {
    // POST /v2/device
    // X-Challenge-Code, X-Challenge-Response ヘッダーを付与
    final res = await _client.createDeviceWithChallenge(
      challengeCode: challengeCode,
      challengeResponse: challengeResponse,
      type: type,
      locale: locale,
    );
    return RegistrationResult(
      credential: DeviceCredential(deviceId: res.deviceId, deviceToken: res.deviceToken),
    );
  }

  Future<RegisteredDevice> fetchMe() async {
    final res = await _client.getDeviceMe();
    return RegisteredDevice.fromResponse(res);
  }

  Future<void> deleteMe() async {
    await _client.deleteDeviceMe();
    await _credStore.clear();
  }
}
```

### `ChallengeRepository`（新規）

```dart
// app/lib/feature/devices/data/repository/challenge_repository.dart

class ChallengeRepository {
  ChallengeRepository(this._client);
  final ChallengeApiClient _client;

  Future<ChallengeCode> requestChallenge() async {
    // POST /v2/device/challenge (認証不要)
    final res = await _client.createChallenge();
    return ChallengeCode(code: res.challengeCode, expiresAt: res.expiresAt);
  }
}
```

---

## オンボーディング画面の改修

### 現状 (`076_onboarding_permission_flow.md` 参照)

オンボーディングは `feature/onboarding/` 配下に既存。

### 改修ポイント

1. **「次へ」ボタンの先で `provisionWithAppCheck` を呼ぶ**
2. **隠し導線**: バージョン番号エリアの **長押し（5秒）** で `ChallengeRegistrationPage` へ遷移
3. **進捗バナー**: 登録中・失敗時の表示は既存パターン踏襲

### `ChallengeRegistrationPage`（新規）

```
画面構成:

  ┌─────────────────────────────────┐
  │ チャレンジ登録                    │
  │                                 │
  │ Step 1: コードを取得              │
  │   [コードを取得する]               │
  │                                 │
  │   表示されたコード:                │
  │   ┌──────────┐                  │
  │   │  A3K9P2  │                  │
  │   └──────────┘                  │
  │   [コピー] [Slackで送る]          │
  │                                 │
  │ Step 2: 開発者から受け取ったコード   │
  │   ┌──────────────────┐          │
  │   │                  │          │
  │   └──────────────────┘          │
  │   [登録する]                      │
  │                                 │
  └─────────────────────────────────┘
```

### 状態モデル

```dart
@freezed
sealed class ChallengeRegistrationState with _$ChallengeRegistrationState {
  const factory ChallengeRegistrationState.initial() = _Initial;
  const factory ChallengeRegistrationState.requestingCode() = _RequestingCode;
  const factory ChallengeRegistrationState.codeIssued({
    required String code,
    required DateTime expiresAt,
  }) = _CodeIssued;
  const factory ChallengeRegistrationState.registering({
    required String code,
  }) = _Registering;
  const factory ChallengeRegistrationState.registered() = _Registered;
  const factory ChallengeRegistrationState.failed({
    required DeviceProvisioningException error,
  }) = _Failed;
}
```

### `ChallengeRegistrationNotifier`

```dart
@Riverpod(keepAlive: false)
class ChallengeRegistrationNotifier extends _$ChallengeRegistrationNotifier {
  @override
  ChallengeRegistrationState build() => const ChallengeRegistrationState.initial();

  Future<void> requestCode() async {
    state = const ChallengeRegistrationState.requestingCode();
    try {
      final challenge = await ref.read(challengeRepositoryProvider).requestChallenge();
      state = ChallengeRegistrationState.codeIssued(
        code: challenge.code,
        expiresAt: challenge.expiresAt,
      );
    } on DeviceProvisioningException catch (e) {
      state = ChallengeRegistrationState.failed(error: e);
    }
  }

  Future<void> submit(String response) async {
    final current = state;
    if (current is! _CodeIssued) return;

    state = ChallengeRegistrationState.registering(code: current.code);
    try {
      await ref.read(deviceProvisioningProvider.notifier).provisionWithChallenge(
        challengeCode: current.code,
        challengeResponse: response,
        type: _detectPlatform(),
        locale: _detectLocale(),
      );
      state = const ChallengeRegistrationState.registered();
    } on DeviceProvisioningException catch (e) {
      state = ChallengeRegistrationState.failed(error: e);
    }
  }
}
```

---

## RevenueCat SDK 統合

### パッケージ

```yaml
# app/pubspec.yaml
dependencies:
  purchases_flutter: ^8.0.0  # 最新版
```

### 初期化

クレデンシャル取得後、デバイス ID で RC を初期化:

```dart
// app/lib/feature/subscription/data/provider/revenuecat_initializer.dart

@Riverpod(keepAlive: true)
Future<void> revenueCatInitializer(Ref ref) async {
  final cred = await ref.watch(deviceCredentialStoreProvider).read();
  if (cred == null) return;  // 未登録時は何もしない

  await Purchases.configure(
    PurchasesConfiguration(
      Platform.isIOS ? Env.revenueCatApiKeyIos : Env.revenueCatApiKeyAndroid,
    )..appUserID = cred.deviceId,
  );
}
```

`Env.revenueCatApiKeyIos`, `Env.revenueCatApiKeyAndroid` は `environment/.env.dev` に追加。

### `SubscriptionRepository`

```dart
// app/lib/feature/subscription/data/repository/subscription_repository.dart

class SubscriptionRepository {
  SubscriptionRepository(this._apiClient);
  final SubscriptionApiClient _apiClient;

  /// サーバーから現在のサブスク状態を取得（信頼源）
  Future<SubscriptionStatus> fetchStatus() async {
    // GET /v2/subscription/me
    final res = await _apiClient.getSubscription();
    return SubscriptionStatus.fromResponse(res);
  }

  /// RevenueCat の Offerings を取得（購入可能なプラン）
  Future<List<Package>> fetchOfferings() async {
    final offerings = await Purchases.getOfferings();
    return offerings.current?.availablePackages ?? [];
  }

  /// Paywall を表示して購入処理
  Future<PaywallResult> presentPaywall() async {
    return await RevenueCatUI.presentPaywall();
  }

  /// 購入の復元
  Future<void> restorePurchases() async {
    await Purchases.restorePurchases();
    // RC が webhook を送る → サーバー側で subscriptions 更新される
    // → アプリ側で fetchStatus() を呼んで反映
  }
}
```

### `SubscriptionNotifier`

```dart
@freezed
abstract class SubscriptionStatus with _$SubscriptionStatus {
  const factory SubscriptionStatus.active({
    required String productId,
    required DateTime? expiresAt,
    required bool willRenew,
  }) = _Active;
  const factory SubscriptionStatus.inactive() = _Inactive;
}

@Riverpod(keepAlive: true)
class SubscriptionNotifier extends _$SubscriptionNotifier {
  @override
  Future<SubscriptionStatus> build() async {
    // 起動時は inactive デフォルト + 非同期で fetch
    final repo = ref.watch(subscriptionRepositoryProvider);
    return await repo.fetchStatus();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() =>
      ref.read(subscriptionRepositoryProvider).fetchStatus()
    );
  }
}
```

### Webhook 反映タイミング

購入完了 → RC 側でレシート検証 → RC からサーバーに webhook → サーバーで `subscriptions` 更新 → アプリで `subscriptionNotifier.refresh()` を呼ぶ。

タイミングのギャップを埋めるため:
- 購入完了直後にアプリ側で 2-3 秒待ってから `refresh()` を呼ぶ
- それでも反映されなければ「数秒後にもう一度確認してください」表示

---

## サブスク UI

### Paywall 画面

RevenueCat の `RevenueCatUI.presentPaywall()` を使う。Paywall のデザインは RevenueCat ダッシュボードで設定。

### サブスク設定画面

```
設定 → サブスクリプション

  現在のプラン: プレミアム
  次回更新: 2026-06-15

  [購入を復元]
  [サブスクリプションを管理]  ← App Store / Play Store へ
```

```dart
// app/lib/feature/subscription/ui/page/subscription_settings_page.dart

class SubscriptionSettingsPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subState = ref.watch(subscriptionNotifierProvider);
    // ...
  }
}
```

### プレミアム機能ゲート

```dart
// 例: プレミアム機能が必要な画面で
class PremiumGate extends ConsumerWidget {
  const PremiumGate({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sub = ref.watch(subscriptionNotifierProvider);
    return sub.when(
      data: (status) => switch (status) {
        SubscriptionStatusActive() => child,
        SubscriptionStatusInactive() => PaywallPromptView(),
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => const PaywallPromptView(),
    );
  }
}
```

### Paywall 誘導 (`PaywallPromptView`)

```
┌─────────────────────────────┐
│ ⭐ プレミアム機能              │
│                             │
│ この機能を使うには             │
│ プレミアムプランへの加入が     │
│ 必要です。                    │
│                             │
│  [プランを見る]               │
│  [購入を復元]                 │
└─────────────────────────────┘
```

---

## ファイル構成（最終形）

```
app/lib/feature/devices/
  data/
    credential/
      device_credential.dart                       ← 新規（Freezed）
      device_credential_store.dart                 ← 新規（Secure Storage ラッパー）
    repository/
      device_repository.dart                       ← 既存修正（POST /v2/device, /me 系）
      challenge_repository.dart                    ← 新規（POST /v2/device/challenge）
      device_provisioning_repository.dart          ← 既存修正（フラグ廃止、credential ベース）
    exception/
      device_provisioning_exception.dart           ← 既存修正（CredentialInvalidException 追加）
      dio_exception_mapper.dart                    ← 既存修正（401/403 マップ追加）
      app_check_rejection.dart                     ← 既存（変更なし）
    notifier/
      device_provisioning_notifier.dart            ← 既存修正
      challenge_registration_notifier.dart         ← 新規
      push_token_sync_notifier.dart                ← 既存修正（API パス変更）
    model/
      registered_device.dart                       ← 既存修正（id を /me 経由で取得）
      device_credential.dart                       ← 上記と同じ
      challenge_code.dart                          ← 新規
    workflow/
      device_migration_workflow.dart               ← 撤去（移行不要）
  ui/
    page/
      onboarding_page.dart                         ← 既存修正（隠し導線追加）
      challenge_registration_page.dart             ← 新規

app/lib/feature/subscription/                     ← 新規 feature
  data/
    provider/
      revenuecat_initializer.dart                  ← 新規
    repository/
      subscription_repository.dart                 ← 新規
    notifier/
      subscription_notifier.dart                   ← 新規
    model/
      subscription_status.dart                     ← 新規（Freezed）
  ui/
    page/
      subscription_settings_page.dart              ← 新規
    component/
      premium_gate.dart                            ← 新規
      paywall_prompt_view.dart                     ← 新規

app/lib/core/provider/interceptor/
  app_check_interceptor.dart                       ← 既存修正（POST /v2/device のみで動作）
  bearer_auth_interceptor.dart                     ← 新規
  device_id_interceptor.dart                       ← 削除

app/lib/core/provider/
  device_id.dart                                   ← 削除（deviceId はサーバー発行に）
  dio_provider.dart                                ← 既存修正（インターセプター差し替え）

app/lib/core/data/preferences/shared/
  shared_preferences_key.dart                      ← 既存修正（deviceProvisioned, tokenHash 等は削除可）

packages/eqmonitor_api/lib/src/
  clients/
    device_api_client.dart                         ← 既存修正（POST /v2/device, /me 系）
    challenge_api_client.dart                      ← 新規
    subscription_api_client.dart                   ← 新規
  models/
    device_upsert_request.dart                     ← 削除（DeviceCreateRequest に置換）
    device_create_request.dart                     ← 新規
    device_create_response.dart                    ← 新規（deviceId + deviceToken）
    challenge_create_response.dart                 ← 新規
    subscription_response.dart                     ← 新規
```

### 削除リスト

- `app/lib/core/provider/device_id.dart`（クライアント側 deviceId 生成は廃止）
- `app/lib/core/provider/interceptor/device_id_interceptor.dart`
- `app/lib/feature/devices/data/workflow/device_migration_workflow.dart`（移行不要）
- `app/lib/feature/devices/data/persistence/shared_preferences_workflow_persistence.dart`（同上）

---

## 実装フェーズ

| Phase | 内容 | 依存（バックエンド） |
|---|---|---|
| **A1. Secure Storage 導入** | `flutter_secure_storage` 追加、`DeviceCredential` / `DeviceCredentialStore` 実装、Provider 整備 | なし |
| **A2. API クライアント刷新** | `DeviceApiClient` を POST `/v2/device` ベースに変更、`/me` 系エンドポイント追加、`ChallengeApiClient` 新規、`SubscriptionApiClient` 新規 | B3, B4, B5 |
| **A3. Interceptor 切り替え** | `BearerAuthInterceptor` 実装、`DeviceIdInterceptor` 削除、`AppCheckInterceptor` 修正（`POST /v2/device` のみ）、`dio_provider` 更新 | B3 |
| **A4. Exception マッパー拡張** | `CredentialInvalidException` 追加、`DioExceptionMapper` で 401/403 マップ、各 Repository で適切に変換 | B2 |
| **A5. DeviceProvisioningNotifier 改修** | `provisionWithAppCheck` / `provisionWithChallenge` 実装、`build()` で `DeviceCredentialStore.read()` ベースに | B3, B4 |
| **A6. オンボーディング画面修正** | 「次へ」で `provisionWithAppCheck` を呼ぶ、隠し導線（長押し）追加 | A5 |
| **A7. ChallengeRegistrationPage 実装** | コード取得 UI、response 入力 UI、`ChallengeRegistrationNotifier` 実装 | A5, B4 |
| **A8. 401/403 → 再オンボーディング** | 主要 Notifier に `CredentialInvalidException` ハンドラ追加（共通拡張 `ref.invalidateCredential()`） | A4 |
| **A9. RevenueCat SDK 導入** | `purchases_flutter` 追加、初期化 Provider 実装、`environment/.env.dev` に API キー追加 | なし |
| **A10. SubscriptionRepository / Notifier** | `fetchStatus`, `fetchOfferings`, `presentPaywall`, `restorePurchases` 実装 | B10, B11 |
| **A11. サブスク UI** | `SubscriptionSettingsPage`, `PremiumGate`, `PaywallPromptView` 実装 | A10 |
| **A12. プレミアム機能ゲート適用** | 対象画面に `PremiumGate` を被せる（機能スコープは別途決定） | A11 |
| **A13. クリーンアップ** | `deviceId.dart` / `DeviceIdInterceptor` / 旧 migration 系を削除、`SharedPreferencesKey` 整理 | A8 |
| **A14. Codegen + Analyze + Test** | `melos run generate` → `melos run analyze` → 修正、主要ユニットテスト追加 | A1-A13 |

---

## オープン項目

- **隠し導線の具体的な操作**: バージョン番号長押し以外の案（例: 設定画面の特定箇所を N 回タップ）
- **プレミアム機能のスコープ**: どの機能をプレミアム限定にするか（推計震度、Live Activity 拡張、過去地震データ深掘り、等）。別タスクで決定
- **RevenueCat Paywall の中身**: Paywall デザインは RevenueCat ダッシュボードで設定。実装着手後に並行で進める
- **macOS / Web 対応**: 当面 iOS/Android のみ。macOS は subscription_repository を `Unimplemented` でスタブ化
- **オフライン時の Paywall 起動**: `presentPaywall()` はネットワーク必須。オフライン検出時はメッセージ表示
- **サブスク状態のキャッシュ**: 起動時にすぐホーム画面でプレミアム機能を出すため、`SubscriptionStatus` を Hive 等にローカルキャッシュするか
- **デバイス削除フロー UI**: 設定画面に「このデバイスを削除（再登録される）」を出すか
- **iOS 再インストール時の挙動**: iOS Keychain は再インストール後も残るため自動復元される（既知の挙動として扱う）
- **Android 再インストール時**: クレデンシャル消えて再登録になる → サブスクは RevenueCat の `restorePurchases()` で復元可能

---

## 参考リンク

- バックエンド仕様: `docs/todo/088_subscription_system_backend.md`
- 既存 device 設計: `docs/todo/086_device_provisioning_system.md`
- 既存オンボーディング: `docs/todo/076_onboarding_permission_flow.md`
- 既存 `device_repository.dart`: `app/lib/feature/devices/data/repository/device_repository.dart`
- 既存 AppCheck Interceptor: `app/lib/core/provider/interceptor/app_check_interceptor.dart`
- `flutter_secure_storage`: https://pub.dev/packages/flutter_secure_storage
- `purchases_flutter`: https://www.revenuecat.com/docs/getting-started/installation/flutter

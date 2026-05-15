# EQMonitor Pro 実装計画書 — サブスクリプション + 広告

**作成日**: 2026-05-15
**対象ブランチ**: develop
**ステータス**: 設計完了 / 実装未着手
**関連**: Start API / Changelog API はバックエンド・Flutter ともに実装済み（`backend/api/api/src/features/start/`、`feature/start/`、`feature/changelog/`）。

---

## 背景

EQMonitorの運用費（サーバ・配信・開発）を継続的にまかなうため、**サブスクリプション「EQMonitor Pro」** と **広告** の両方を導入する。

ただし以下を守る:

- **機能で大きく制限しない**: 防災アプリの性質上、無料ユーザーの安全性を損なわない
- **アクセシビリティ重視**: NERV防災と同じ「機能制限ではなく支援への感謝」スタンス
- **広告は控えめ**: EEW・地震情報の即時性を阻害しない、大地震時は自動非表示

---

## サブスクプラン

### Free プラン（無料）

| 項目 | 上限 |
|---|---|
| EEW・地震情報通知 | **EEW/地震情報あわせて3地点**（現在地含む）/ 1地点ごとにEEW震度・地震情報震度を独立に設定可 |
| 揺れ検知通知 | **現在地のみ** ON/OFF |
| 広告 | 表示（設定画面・地震履歴一覧・1日以上前の地震履歴詳細） |
| その他機能 | フル機能（強震モニタ・地震履歴・履歴詳細・地図・Live Activity） |

### Pro プラン（課金）

| 項目 | 上限 |
|---|---|
| EEW通知 | **5地点**（現在地含む）— 地震情報とは独立 |
| 地震情報通知 | **5地点**（現在地含む）— EEWとは独立 |
| 揺れ検知通知 | **3地点** |
| 広告 | 非表示 |
| その他機能 | Freeと同じ |

### Free / Pro のモデル差

| 観点 | Free | Pro |
|---|---|---|
| 地点プール | EEW・地震情報で**1本のプール**（最大3地点）<br>各地点で「EEW震度しきい値」「地震情報震度しきい値」を独立設定（"通知しない"も可） | EEW用プール（最大5）と地震情報用プール（最大5）が**独立** |
| 地点追加UX | 「地点を1つ追加 → 各種別の震度を選ぶ」 | 「種別ごとに地点を追加・震度を選ぶ」（現状UX踏襲） |
| Pro→Free ダウングレード時 | EEW専用/地震情報専用に登録された地点があれば共有プールへ合流（上限超過分は無効化） | — |

### 価格

- 月額: **300円** 程度（要市場調査・最終決定）
- 年額: **3,000円** 程度（2ヶ月分割引）
- 価格は OPEN ITEM。リリース直前に決定する。

---

## 広告仕様

### 表示画面

| 画面 | 表示 |
|---|---|
| Home画面 | **表示しない** |
| 設定画面 | バナー小 |
| 地震履歴一覧 | バナー小 |
| 地震履歴詳細（**地震発生から24時間以上経過**） | バナー |
| 地震履歴詳細（24時間以内） | 表示しない |
| EEW画面 | **絶対に表示しない** |
| 強震モニタ画面 | 表示しない |
| その他 | 表示しない |

### 非表示条件（OR）

以下のいずれかに該当する場合は表示しない:

1. **Proユーザー**
2. **Start APIの `ads_enabled = false`**（大地震時・メンテ時にサーバから一斉オフ）
3. **EEW受信中**（アプリ内ローカル状態、サーバとは独立）
4. **ユーザー設定 `ads_opt_out = true`**（後述の販促フロー後にFreeでも非表示可能）
5. **地震履歴詳細**で発生から24時間未満（地震速報中相当として扱う）

### 広告SDK選定

| 候補 | Pros | Cons |
|---|---|---|
| **Google Mobile Ads (AdMob)** | デファクト、収益最大化、ターゲティング精度高 | プライバシー懸念、ATT必須(iOS) |
| **AppLovin MAX** | ウォーターフォール最適化、eCPM高め | 設定複雑 |
| **メディエーション無し（AdMob単体）** | 実装シンプル | 収益機会損失 |

**推奨**: 当面 **AdMob 単体** で開始。eCPMが伸び悩んだ段階でメディエーション導入を検討。

### Flutter パッケージ

- `google_mobile_ads` (Google公式)

---

## サブスク基盤の選定

### 候補

| 候補 | Pros | Cons |
|---|---|---|
| **RevenueCat** | iOS/Android 統一API、ウェブ管理画面、Webhook対応、Entitlement管理が楽 | 課金額に対する手数料（1%~）、外部依存 |
| **ネイティブのみ（StoreKit 2 / Play Billing）** | 手数料なし、ベンダーロック回避 | レシート検証・サブスク状態管理を自前実装、面倒 |
| **Glassfy / Adapty** | RevenueCatの代替 | エコシステムが小さい |

**推奨**: **RevenueCat**。理由:

- 個人開発に近い体制で、サブスク状態の信頼できる単一ソースを持てる
- iOS/Android のレシート検証を自前実装すると確実にバグる
- Webhook + REST API でバックエンドから entitlement を参照可能
- 手数料 1% は許容範囲（売上の小さい段階では実質コスト微少）

### Flutter パッケージ

- `purchases_flutter` (RevenueCat 公式)

---

## アーキテクチャ全体像

```
┌────────────────────────────────────────────────────────────────┐
│                        ユーザー端末                              │
│                                                                │
│  ┌──────────────┐    ┌─────────────────┐   ┌─────────────────┐ │
│  │  Flutter App │───▶│ purchases_flutter│──▶│ App Store /     │ │
│  │              │    │  (RevenueCat SDK)│   │ Play Store IAP  │ │
│  └──────┬───────┘    └────────┬─────────┘   └─────────────────┘ │
│         │                     │                                │
│         │   Customer Info     │                                │
│         │   (entitlement)     │                                │
│         │◀────────────────────┘                                │
└─────────┼──────────────────────────────────────────────────────┘
          │
          │ AppCheck 認証付き API リクエスト
          │
          ▼
┌────────────────────────────────────────────────────────────────┐
│                   EQMonitor Backend (Hono)                     │
│                                                                │
│  PATCH /v1/devices/:id/eew/regions                             │
│    ↓                                                           │
│  EntitlementGuard ─── entitlement (cached) ─── PostgreSQL      │
│    ↓                                                           │
│  上限チェック (Free: 3地点 / Pro: 5地点)                        │
│    ↓ 違反なら 403                                              │
│  既存のregion永続化処理                                          │
│                                                                │
│  POST /v1/webhooks/revenuecat                                  │
│    ↓ RevenueCatからのEntitlement変化通知                        │
│  device_entitlements テーブル更新                                │
└────────────────────────────────────────────────────────────────┘
```

### Entitlement の伝達経路

```
購入完了
  ↓ App Store / Play Store
RevenueCat (サブスク状態の正規源)
  ↓ Webhook
EQMonitor Backend (device_entitlements テーブルに反映)
  ↓ API呼び出し時
EntitlementGuard (上限チェック)
```

### アプリ側の Entitlement 確認

```
アプリ起動 / 復帰時
  ↓
RevenueCat.getCustomerInfo() でローカル取得
  ↓
EntitlementNotifier に保存
  ↓
UI / 設定変更ロジックで参照
```

---

## バックエンド設計

### データベース

`packages/database/src/schema/device_entitlements.ts` を新設:

```typescript
import { pgTable, text, timestamp, primaryKey } from 'drizzle-orm/pg-core';
import { devices } from './devices';

export const deviceEntitlements = pgTable('device_entitlements', {
  deviceId: text('device_id')
    .notNull()
    .references(() => devices.id, { onDelete: 'cascade' }),
  entitlementId: text('entitlement_id').notNull(), // 'pro'
  productId: text('product_id').notNull(),         // 'eqmonitor_pro_monthly'
  rcAppUserId: text('rc_app_user_id'),             // RevenueCat AppUserID
  status: text('status').notNull(),                // 'active' | 'expired' | 'in_grace'
  periodType: text('period_type'),                 // 'normal' | 'trial' | 'intro'
  startsAt: timestamp('starts_at').notNull(),
  expiresAt: timestamp('expires_at'),              // null = lifetime
  willRenew: text('will_renew').notNull(),
  updatedAt: timestamp('updated_at').notNull().defaultNow(),
}, t => ({
  pk: primaryKey({ columns: [t.deviceId, t.entitlementId] }),
}));
```

### RevenueCat Webhook 受信

`api/api/src/features/billing/routes/webhooks.ts`:

```typescript
const app = new Hono<HonoBindings>()
  .post(
    '/revenuecat',
    describeRoute({ tags: ['Billing'] }),
    async c => {
      const authHeader = c.req.header('authorization');
      if (authHeader !== `Bearer ${c.env.REVENUECAT_WEBHOOK_SECRET}`) {
        return c.json({ code: 'UNAUTHORIZED' }, 401);
      }
      const event = await c.req.json<RevenueCatWebhookEvent>();
      await handleRevenueCatEvent(event, c.env);
      return c.body(null, 204);
    },
  );
```

`handleRevenueCatEvent` の責務:

1. `event.type` が `INITIAL_PURCHASE` / `RENEWAL` / `CANCELLATION` / `EXPIRATION` / `BILLING_ISSUE` を判別
2. `event.app_user_id` から device_id を引き出す（RevenueCat の AppUserID に device_id を渡す前提）
3. `device_entitlements` テーブルを upsert / delete
4. 重要な変化は talker / OpenTelemetry にログ出力

### Entitlement 取得API

`api/api/src/features/billing/routes/entitlement.ts`:

```typescript
GET /v1/devices/:id/entitlement
  → { entitlements: [{ entitlementId, productId, status, expiresAt, willRenew }] }
```

主にデバッグ・ユーザーサポート用。実運用ではアプリは RevenueCat SDK から直接 entitlement を取得する。

### EntitlementGuard ミドルウェア

`api/api/src/features/billing/middleware/entitlement-guard.ts`:

```typescript
export const entitlementGuard = (entitlementId: string) =>
  createMiddleware<HonoBindings>(async (c, next) => {
    const deviceId = c.req.param('deviceId') ?? c.req.param('id');
    const isActive = await checkEntitlement(c.env, deviceId, entitlementId);
    if (!isActive) {
      return c.json(
        { code: 'PRO_REQUIRED', message: 'EQMonitor Pro が必要です' },
        403,
      );
    }
    return next();
  });
```

### 通知設定APIの上限チェック

既存の `PUT /v1/devices/:id/eew/regions` 等を改修。**Free / Pro でモデルが異なる点に注意**。

#### Pro（既存モデル維持）

EEW・地震情報それぞれ独立に5地点まで:

```typescript
.put(
  '/eew/regions',
  vValidator('json', PutEewRegionsRequest),
  async c => {
    const { regions } = c.req.valid('json');
    const deviceId = c.req.param('id');
    const isPro = await checkEntitlement(c.env, deviceId, 'pro');
    if (!isPro) {
      // Free 用の合算ロジックへ
      return enforceSharedPoolLimit(c, deviceId, 'eew', regions);
    }
    if (regions.length > 5) {
      return c.json({ code: 'REGION_LIMIT_EXCEEDED', /* ... */ }, 403);
    }
    // 既存処理
  },
);
```

#### Free（共有プールモデル）

EEW + 地震情報の合計が3地点を超えてはならない。同一 `regionId` は EEW・地震情報の両方に存在可能（共有プール内の1地点として扱う）。

```typescript
async function enforceSharedPoolLimit(
  c: Context,
  deviceId: string,
  kind: 'eew' | 'earthquake',
  newRegions: Region[],
): Promise<Response | void> {
  const other = kind === 'eew'
    ? await getEarthquakeRegions(deviceId)
    : await getEewRegions(deviceId);

  // 「共有プール」= 両方のregionIdの和集合
  const sharedPool = new Set([
    ...newRegions.map(r => r.regionId),
    ...other.map(r => r.regionId),
  ]);
  if (sharedPool.size > 3) {
    return c.json(
      {
        code: 'REGION_LIMIT_EXCEEDED',
        message: 'Freeプランでは EEW・地震情報あわせて3地点までです',
        details: {
          limit: 3,
          currentPoolSize: sharedPool.size,
          isPro: false,
        },
      },
      403,
    );
  }
  // 既存処理
}
```

同様の対応を:

- `PUT /v1/devices/:id/earthquake/regions` (Free: 共有プール3 / Pro: 独立5)
- `PUT /v1/devices/:id/shake-detection/entries` (Free: 現在地のみ / Pro: 3地点)

### 通知配信側のロジック

通知配信側 (`service/notification-resolver`) では、配信時に各種別のRegions配列をそのまま使う。

- Pro: 各種別 5件まで通常配信
- Free: 共有プール上限のため、保存時点で3地点以下が保証されている（API側で弾く）。ただしレース条件で4件目が紛れ込んだ場合は `slice(0, 3)` で防御

```typescript
const limit = isProActive ? 5 : 3;
const eligibleEewRegions = device.eewRegions.slice(0, limit);
const eligibleEarthquakeRegions = device.earthquakeRegions.slice(0, limit);
// Free の場合、両方を slice(0, 3) しても合計6になり得るが、
// 共有プール制約により実際の登録は最大3地点に収まっている
```

### スキーマ追加（リクエスト/レスポンス）

```typescript
export const RegionLimitExceededResponseSchema = v.object({
  code: v.literal('REGION_LIMIT_EXCEEDED'),
  message: v.string(),
  details: v.object({
    limit: v.number(),
    requested: v.number(),
    isPro: v.boolean(),
  }),
});
```

---

## Flutter 設計

### ディレクトリ構成

```
app/lib/feature/subscription/
├── data/
│   ├── model/
│   │   ├── entitlement.dart                    ← 自前モデル（RC型ラッパ）
│   │   └── subscription_offering.dart          ← 価格・パッケージ
│   ├── repository/
│   │   └── subscription_repository.dart        ← purchases_flutter ラッパ
│   ├── notifier/
│   │   ├── entitlement_notifier.dart           ← Entitlement監視
│   │   └── subscription_offerings_notifier.dart ← 価格表示用
│   ├── provider/
│   │   ├── is_pro_provider.dart                ← bool computed
│   │   └── notification_limits_provider.dart   ← Free/Pro別の上限
│   └── flow/
│       └── purchase_flow.dart                  ← 購入実行 + UI操作
└── ui/
    ├── page/
    │   ├── paywall_page.dart                   ← サブスク販促画面
    │   └── manage_subscription_page.dart       ← 解約・履歴
    └── component/
        ├── pro_badge.dart                      ← Pro機能バッジ
        ├── upgrade_card.dart                   ← 「Proで5地点に拡大」誘導
        └── ads_opt_out_dialog.dart             ← 広告非表示の販促ボトムシート

app/lib/feature/ads/
├── data/
│   ├── model/
│   │   └── ad_visibility.dart                  ← 表示判定state
│   ├── notifier/
│   │   └── ads_opt_out_notifier.dart           ← ユーザー設定（ローカル）
│   ├── provider/
│   │   └── should_show_ads_provider.dart       ← 全条件AND判定
│   └── flow/
│       └── ads_opt_out_flow.dart               ← オプトアウト時の販促表示
└── ui/
    ├── component/
    │   ├── ad_banner.dart                      ← AdMob バナー Widget
    │   └── ad_placeholder.dart                 ← ローディング/エラー時
    └── page/
        └── ads_settings_page.dart              ← 設定→広告を非表示

app/lib/core/data/preferences/shared/
└── shared_preferences_key.dart                 ← `ads_opt_out` キー追加
```

### `EntitlementNotifier`

```dart
@Riverpod(keepAlive: true)
class EntitlementNotifier extends _$EntitlementNotifier {
  @override
  Future<Set<String>> build() async {
    final repo = ref.watch(subscriptionRepositoryProvider);
    final info = await repo.getCustomerInfo();
    return info.entitlements.active.keys.toSet();
  }

  Future<void> refresh() async {
    final repo = ref.read(subscriptionRepositoryProvider);
    final info = await repo.getCustomerInfo();
    state = AsyncData(info.entitlements.active.keys.toSet());
  }

  /// アプリ起動・フォアグラウンド復帰時に呼ぶ
  void listenForeground() {
    // CustomerInfoUpdateListener で監視
    ref.read(subscriptionRepositoryProvider).addUpdateListener((info) {
      state = AsyncData(info.entitlements.active.keys.toSet());
    });
  }
}

@riverpod
bool isPro(Ref ref) {
  final entitlements = ref.watch(entitlementNotifierProvider).valueOrNull;
  return entitlements?.contains('pro') ?? false;
}
```

### `NotificationLimits`

Free と Pro でモデルが異なる（Freeは共有プール、Proは独立プール）ため、データ型でも区別する。

```dart
@freezed
sealed class NotificationLimits with _$NotificationLimits {
  /// Free: EEW・地震情報は共有プール、揺れ検知は現在地のみ
  const factory NotificationLimits.free({
    @Default(3) int sharedRegionPoolLimit,
    @Default(1) int shakeDetectionLimit, // 現在地のみ
  }) = NotificationLimitsFree;

  /// Pro: 種別ごとに独立
  const factory NotificationLimits.pro({
    @Default(5) int eewRegionLimit,
    @Default(5) int earthquakeRegionLimit,
    @Default(3) int shakeDetectionLimit,
  }) = NotificationLimitsPro;
}

@riverpod
NotificationLimits notificationLimits(Ref ref) {
  final isPro = ref.watch(isProProvider);
  return isPro
    ? const NotificationLimits.pro()
    : const NotificationLimits.free();
}

/// 共有プール（Free専用）の使用済み地点数を取得
@riverpod
Future<int> sharedRegionPoolUsage(Ref ref) async {
  final eew = await ref.watch(eewSettingsNotifierProvider.future);
  final earthquake = await ref.watch(
    earthquakeSettingsNotifierProvider.future,
  );
  final pool = <int>{
    ...eew.regions.map((r) => r.regionId),
    ...earthquake.regions.map((r) => r.regionId),
  };
  return pool.length;
}
```

### 既存の通知設定UIへの影響

Free と Pro でUIの構造が大きく変わる。

- **Pro**: 既存通り、EEW タブ / 地震情報タブ別々に地点リスト管理
- **Free**: 1つの「通知地点」リスト + 各地点に「EEW震度しきい値」「地震情報震度しきい値」「揺れ検知ON/OFF」のカード表示

設計簡略化案として、**Free でも内部データモデルは既存（EEW regions / Earthquake regions が別）を維持し、UI レイヤで合算ビューを提供** する方針が現実的:

- アプリは内部的に2リストを持つ
- 「通知地点を追加」操作時に、EEW と地震情報の両方に同じ `regionId` を追加する（震度は別々に設定可能）
- 共有プールサイズ = `unique(eewRegions ∪ earthquakeRegions)` で計算
- 上限到達時はアップグレード誘導

### `ShouldShowAdsProvider`

```dart
@riverpod
bool shouldShowAds(Ref ref, {required AdPlacement placement}) {
  // 1. Proユーザー
  if (ref.watch(isProProvider)) return false;

  // 2. サーバフラグ
  final start = ref.watch(startNotifierProvider).valueOrNull;
  if (start?.flags.adsEnabled == false) return false;

  // 3. EEW受信中
  final isEewActive = ref.watch(activeEewProvider).valueOrNull?.isNotEmpty
    ?? false;
  if (isEewActive) return false;

  // 4. ユーザー設定
  if (ref.watch(adsOptOutNotifierProvider).valueOrNull == true) return false;

  // 5. placement別の判定（地震履歴詳細の24時間ルール等）
  return _isPlacementVisible(placement, ref);
}

enum AdPlacement {
  settings,
  earthquakeHistoryList,
  earthquakeHistoryDetail,
}
```

`earthquakeHistoryDetail` の場合は `EarthquakeHistoryDetail` の発生時刻と現在時刻の差を見て24時間以内なら非表示。

### `AdsOptOutFlow`（販促表示）

```dart
// app/lib/feature/ads/data/flow/ads_opt_out_flow.dart
Future<void> attemptOptOut(WidgetRef ref, BuildContext context) async {
  if (ref.read(isProProvider)) {
    // Pro なので元から非表示。設定上は単に閉じる
    return;
  }

  // 1. 販促ボトムシート表示
  final choice = await showModalBottomSheet<OptOutChoice>(
    context: context,
    builder: (ctx) => const AdsOptOutPromoSheet(),
  );

  switch (choice) {
    case OptOutChoice.subscribe:
      if (!context.mounted) return;
      await context.pushNamed('paywall');
    case OptOutChoice.optOutFree:
      await ref.read(adsOptOutNotifierProvider.notifier).setOptOut(true);
    case OptOutChoice.cancel:
    case null:
      return;
  }
}
```

### 販促ボトムシートの内容

```dart
class AdsOptOutPromoSheet extends StatelessWidget {
  Widget build(BuildContext context) {
    return // ...
      title: const Text('EQMonitorの運営を支援する'),
      body: const Text('''
EQMonitorはサーバー代・開発費を広告収入でまかなっています。
広告を非表示にする場合は、よろしければ EQMonitor Pro へのご加入をご検討ください。

なお、今後のアップデートで無料での広告非表示を終了する場合があります。あらかじめご了承ください。
      '''),
      actions: [
        FilledButton('EQMonitor Pro を見る', → OptOutChoice.subscribe),
        TextButton('広告なしで続ける（無料）', → OptOutChoice.optOutFree),
        TextButton('キャンセル', → OptOutChoice.cancel),
      ],
  }
}
```

### `PurchaseFlow`

```dart
// app/lib/feature/subscription/data/flow/purchase_flow.dart
Future<Result<void, PurchaseException>> purchase(
  WidgetRef ref,
  BuildContext context,
  Package package,
) async {
  final repo = ref.read(subscriptionRepositoryProvider);
  try {
    final info = await repo.purchasePackage(package);
    if (info.entitlements.active.containsKey('pro')) {
      await ref.read(entitlementNotifierProvider.notifier).refresh();
      if (!context.mounted) return Result.ok(());
      await showDialog(
        context: context,
        builder: (_) => const ThankYouDialog(),
      );
      return Result.ok(());
    }
    return Result.err(PurchaseException.notEntitled());
  } on PlatformException catch (e) {
    if (PurchasesErrorHelper.getErrorCode(e) ==
        PurchasesErrorCode.purchaseCancelledError) {
      return Result.err(PurchaseException.cancelled());
    }
    rethrow;
  }
}

Future<void> restorePurchases(WidgetRef ref) async {
  await ref.read(subscriptionRepositoryProvider).restorePurchases();
  await ref.read(entitlementNotifierProvider.notifier).refresh();
}
```

### 既存の通知設定UIへの組み込み

`app/lib/feature/settings/features/notification_settings/ui/` 配下の地点追加UIで:

```dart
final limits = ref.watch(notificationLimitsProvider);
final current = settings.regions.length;

if (current >= limits.eewRegionLimit) {
  // 上限到達: アップグレード誘導 or 単に追加ボタン無効化
  if (!ref.watch(isProProvider)) {
    return UpgradeCard(
      message: 'EQMonitor Proで最大${5}地点まで登録できます',
      onTap: () => context.pushNamed('paywall'),
    );
  } else {
    return Text('上限の5地点に達しています');
  }
}
```

### Entitlement 同期タイミング

- アプリ起動時: `EntitlementNotifier.build()` で初回取得
- フォアグラウンド復帰: `WidgetsBindingObserver.didChangeAppLifecycleState` で `refresh()`
- RevenueCat の `CustomerInfoUpdateListener` を常時購読
- 購入完了直後: `purchase_flow.dart` 内で `refresh()`

### AdMob 初期化

`app/lib/main.dart`:

```dart
await MobileAds.instance.initialize();
```

iOS の ATT 対応:

```dart
if (Platform.isIOS) {
  await AppTrackingTransparency.requestTrackingAuthorization();
}
```

### バナーWidget

```dart
class AdBanner extends HookConsumerWidget {
  const AdBanner({required this.placement, super.key});
  final AdPlacement placement;

  Widget build(BuildContext context, WidgetRef ref) {
    final shouldShow = ref.watch(shouldShowAdsProvider(placement: placement));
    if (!shouldShow) return const SizedBox.shrink();
    return _LoadedAdBanner(placement: placement);
  }
}
```

`_LoadedAdBanner` 内で `BannerAd` を生成・破棄。`placement` 別に AdUnitId を切り替え。

---

## RevenueCat 設定

### Entitlement / Product / Package

```
Entitlement: pro
  ├─ Product: eqmonitor_pro_monthly
  │    Package: $rc_monthly (300円/月)
  └─ Product: eqmonitor_pro_annual
       Package: $rc_annual (3,000円/年)
```

### App User ID

device_id をそのまま App User ID として使う。

```dart
await Purchases.configure(
  PurchasesConfiguration(rcApiKey)
    ..appUserID = deviceId,
);
```

これにより RevenueCat → Webhook → device_id への突き合わせが直接できる。

#### 端末移行・device_id 変更時の扱い

デバイスプロビジョニング（`app/lib/feature/devices/`）の v3 移行で device_id が変わるケース、およびアプリ再インストールで device_id が変わるケースが存在する。

- **v3 移行**: 旧 device_id で購入したユーザーが新 device_id になる場合、RevenueCat の **AppUserID alias 機能** で旧→新を紐付ける

  ```dart
  await Purchases.logIn(newDeviceId); // 旧 AppUserID と alias される
  ```

- **再インストール**: Apple ID / Google Account 単位で購入履歴が残るため、`Purchases.restorePurchases()` で復元可能
- **EntitlementNotifier 側**: device_id 変化を `deviceIdProvider` で watch し、変化したら `Purchases.logIn(newDeviceId)` を呼ぶ + Entitlement を再取得

```dart
@Riverpod(keepAlive: true)
class EntitlementNotifier extends _$EntitlementNotifier {
  @override
  Future<Set<String>> build() async {
    final deviceId = await ref.watch(deviceIdProvider.future);
    final repo = ref.watch(subscriptionRepositoryProvider);

    // device_id が変わったら RevenueCat 側にも反映
    await repo.identify(deviceId);

    final info = await repo.getCustomerInfo();
    return info.entitlements.active.keys.toSet();
  }
  // ...
}
```

### iOS / Android 課金商品の事前登録

- App Store Connect: Auto-Renewable Subscription 登録 + 審査
- Google Play Console: 定期購入 登録
- RevenueCat ダッシュボードでそれぞれを Product に紐付け、Package で束ねる

---

## エラーハンドリング

### 想定エラーと対応

| エラー | 発生源 | UX対応 |
|---|---|---|
| 購入キャンセル | StoreKit/Play Billing | ダイアログ閉じる、エラー表示なし |
| 購入失敗（決済不能） | StoreKit/Play Billing | エラーメッセージ + 再試行ボタン |
| ネットワーク失敗 | RevenueCat SDK | キャッシュされたEntitlement使用 + リトライ |
| RevenueCat Webhook 配信失敗 | RevenueCat → Backend | RevenueCat 側で自動リトライ、最終的にSDK側でリカバリ |
| Entitlement 失効反映遅延 | Backend cache | アプリ側は RevenueCat SDK を信頼、サーバは webhook 受信時に即時更新 |
| 端末変更後のリストア | ユーザー操作 | 設定画面の「購入を復元」ボタン → `restorePurchases()` |

---

## プライバシー・規約

### 必須対応

- **App Store Connect**: プライバシーポリシー・利用規約のリンク登録
- **Google Play Console**: 同上
- **アプリ内表示**:
  - 購入画面 (paywall) に「利用規約」「プライバシーポリシー」「自動更新の説明」「価格・期間」を明記（Apple のレギュレーション必須）
  - サブスク管理画面（解約・確認）への導線

### ATT / 広告ID

- iOS: AppTrackingTransparency で許可を取る
- Android: AAID 使用、Play Console でデータセーフティ申告
- AdMob: 同意管理プラットフォーム（UMP）で GDPR/CCPA 対応（日本居住者だけ対象にする場合は不要だが、安全側に倒すなら導入）

### ユーザーデータ削除

- アプリのプロビジョニング解除時に device_entitlements を残す（RevenueCat 側は別途解除手続きが必要なため）
- 法律上の削除要求があれば手動対応

---

## テスト戦略

### ユニットテスト

- `NotificationLimits` の Free/Pro 切替
- `ShouldShowAdsProvider` の各条件（5パターン）
- `EntitlementNotifier` のキャッシュ動作
- バックエンド: `EntitlementGuard` の境界値（3→4の境界、5→6の境界）

### 統合テスト

- App Store Sandbox / Play Console テスタートラックでの購入フロー
- RevenueCat の Webhook → DB 反映の E2E
- 通知設定APIで上限超過時の403応答

### 手動テスト

- 購入→アプリ強制終了→再起動でEntitlement復元
- 端末2台で同一AppUserIDのEntitlement共有
- 解約→更新期間まではEntitlement維持
- 大地震模擬 (`ads_enabled=false`) で広告が消える
- EEW受信中に広告が消える

---

## 実装フェーズ

| Phase | 内容 | 依存 |
|---|---|---|
| **P1. RevenueCat 環境** | Entitlement / Product / Package 定義、App Store / Play Console の商品登録、Sandbox 確認 | なし |
| **P2. DB スキーマ** | `device_entitlements` テーブル追加 + drizzle migration | なし |
| **P3. バックエンド Webhook** | `POST /v1/webhooks/revenuecat` + イベントハンドラ + ログ | P2 |
| **P4. バックエンド EntitlementGuard** | `checkEntitlement` + middleware + 既存通知設定APIへの上限チェック | P2, P3 |
| **P5. Flutter Subscription Repository** | `purchases_flutter` 統合、`SubscriptionRepository`、`EntitlementNotifier` | P1 |
| **P6. Flutter Limit 反映** | `NotificationLimits` provider + 既存通知設定UIへの組み込み（上限到達時のアップグレード誘導） | P5 |
| **P7. Paywall UI** | `paywall_page.dart` 実装、価格表示、利用規約・プライバシー導線 | P5 |
| **P8. AdMob 統合** | パッケージ追加、AdUnitId 登録、ATT、UMP（必要なら） | なし |
| **P9. Ads 表示判定** | `ShouldShowAdsProvider` + `AdBanner` + 各画面組み込み | P5, P8, Start API（`ads_enabled`、Flutter `feature/start/`）連携 |
| **P10. Ads オプトアウト** | `AdsOptOutNotifier` + 販促ボトムシート + 設定画面項目 | P9 |
| **P11. 管理画面** | 設定 → サブスクリプション管理画面（プラン確認・解約導線・購入復元） | P5 |
| **P12. プライバシー対応** | プライバシーポリシー更新、App Store / Play Console 申告、利用規約 | P1, P8 |
| **P13. テスト + 検証** | Sandbox購入、Webhook E2E、上限テスト、広告非表示テスト | P1-P12 |
| **P14. 段階リリース** | TestFlight / Internal Testing で先行確認 → ストア審査 → 段階公開 | P13 |

---

## オープン項目

- **価格**: 月額・年額の最終決定（リリース直前）。市場調査を別途実施
- **無料体験期間**: 7日間トライアルを設けるか
- **ファミリーシェアリング**: iOS のファミリー共有を許可するか（許可すると収益減・違反通報減）
- **Web 課金**: 当面アプリ内 IAP のみで、Stripe 等は導入しない
- **広告 AdUnitId 構成**: placement 別に分けるか統一するか。eCPM 計測の粒度に応じて決定
- **24時間以内/以後の地震履歴詳細**: 「24時間」が正しいか、もっと長く/短くすべきか。震度6弱以上はもっと長く扱うべきか
- **アクセシビリティテキスト**: paywall 画面の VoiceOver/TalkBack 読み上げの最適化
- **解約後の挙動**: 期限後にEntitlementが切れたとき、Pro時に登録した地点をどう扱うか
  - **案A**: 表示はするが通知は Free 上限（共有プール3地点）までに自動制限。データは残す
  - **案B**: ユーザーに削除させるダイアログ
  - 推奨は **案A**（破壊的でないため）。バックエンドの通知配信ロジックで「Free上限を超えた分は無視」する実装に
- **Free の共有プールUI**: 既存の「EEW/地震情報別タブ」モデルとどう接続するか。
  - **方針1**: Free 時のみ専用の「通知地点」一括管理画面を出す
  - **方針2**: 既存の2タブを維持しつつ、Free時は「合算3地点制約」を両タブで監視
  - 方針2のほうが既存コード資産を活かせるが、UXが分かりにくくなる懸念
- **Free→Pro 移行時のUX**: Freeで共有プールに登録した地点を、Pro移行時に EEW側 / 地震情報側 にどう振り分けるか
  - 推奨: 「全地点を両側にコピー」（ユーザーが後から調整可能）

---

## 解約後の通知配信ロジック

通知配信側 (`service/notification-resolver`) は、各送信時に entitlement を確認:

```typescript
const entitlement = await getEntitlement(deviceId, 'pro');
const isPro = entitlement?.status === 'active';

if (isPro) {
  // EEW / 地震情報それぞれ 5 件まで
  const eligibleEew = device.eewRegions.slice(0, 5);
  const eligibleEarthquake = device.earthquakeRegions.slice(0, 5);
  // ...
} else {
  // Free: 共有プールで3件まで
  const sharedPool = uniqBy(
    [...device.eewRegions, ...device.earthquakeRegions],
    r => r.regionId,
  ).slice(0, 3);
  const sharedRegionIds = new Set(sharedPool.map(r => r.regionId));

  // 共有プールに含まれる regionId だけ通知対象
  const eligibleEew = device.eewRegions
    .filter(r => sharedRegionIds.has(r.regionId));
  const eligibleEarthquake = device.earthquakeRegions
    .filter(r => sharedRegionIds.has(r.regionId));
}
```

- ユーザーが登録した順序を保ったまま、共有プールは「登録順 unique」で 3 件
- アプリのUIは Pro 解約後も全地点を表示し、Free上限超過分は「通知無効」として grayout 表示

---

## 参考リンク

- RevenueCat Flutter SDK: <https://www.revenuecat.com/docs/getting-started/installation/flutter>
- Google Mobile Ads Flutter: <https://pub.dev/packages/google_mobile_ads>
- AppTrackingTransparency: <https://pub.dev/packages/app_tracking_transparency>
- App Store Auto-Renewable Subscription: <https://developer.apple.com/app-store/subscriptions/>
- Google Play Billing: <https://developer.android.com/google/play/billing>
- 既存の通知設定モデル: `app/lib/feature/settings/features/notification_settings/data/model/`
- 既存の地点API: `api/api/src/features/device/routes/device.ts`
- AGENTS.md 設計規約: 本リポジトリの `AGENTS.md`

# RevenueCat Lazy Repository Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** RevenueCat の起動時初期化をやめ、Subscription 機能を Provider / Repository / Notifier の責務に分けて遅延初期化する。

**Architecture:** `main.dart` から RevenueCat SDK 初期化を削除し、`revenueCatInitializationProvider` が初回購読機能アクセス時に `Purchases.configure()` を実行する。`provider.dart` には enum や model を置かず、例外は `data/exception/`、結果モデルは Freezed の `data/model/`、SDK 呼び出しは `SubscriptionRepository` に集約する。`SubscriptionNotifier` は Repository だけを参照し、副作用を持つ購入・復元は Riverpod 3 の `Mutation` として、対象関数の直前に宣言する。

**Tech Stack:** Flutter 3.44, Dart 3.11, Riverpod 3 `@riverpod` / `Mutation`, purchases_flutter, Freezed, melos, mise

---

## File Structure

- Modify: `app/lib/main.dart`
  - `purchases_flutter` import、起動時 `await _configureRevenueCat()`、`_configureRevenueCat()` を削除する。
- Create: `app/lib/feature/subscription/data/exception/revenue_cat_unavailable_exception.dart`
  - 非対応プラットフォーム・API キー未設定など、RevenueCat を利用できない理由を enum と例外で表現する。
- Create: `app/lib/feature/subscription/data/model/purchase_failure_reason.dart`
  - `PurchaseResult.failed` の失敗理由を enum で表現し、UI 表示文言を集約する。
- Modify: `app/lib/feature/subscription/data/model/purchase_result.dart`
  - `failed(String message)` を `failed(PurchaseFailureReason reason)` に変更し、`unavailable` ケースを削除する。
- Create: `app/lib/feature/subscription/data/model/purchase_outcome.dart`
  - Repository から返す購入・復元結果を Freezed model として定義する。
- Create: `app/lib/feature/subscription/data/provider/revenue_cat_initialization_provider.dart`
  - RevenueCat SDK の遅延初期化だけを担当する keepAlive FutureProvider。戻り値は `void`。
- Create: `app/lib/feature/subscription/data/provider/subscription_product_id_provider.dart`
  - iOS / Android の月額 Product ID を Riverpod Provider に隠蔽する。
- Create: `app/lib/feature/subscription/data/repository/subscription_repository.dart`
  - concrete class の `SubscriptionRepository` を定義する。`abstract interface class` は作らない。
- Modify: `app/lib/feature/subscription/data/notifier/subscription_notifier.dart`
  - SDK 直接呼び出しを削除し、Repository 参照に置き換える。`refresh()` は削除する。
- Modify: `app/lib/feature/subscription/data/flow/paywall_flow.dart`
  - Notifier メソッドを `Mutation.run` 経由で呼ぶ。初期化不可例外は Flow で SnackBar に変換する。
- Modify: `app/lib/feature/subscription/ui/page/paywall_page.dart`
  - 購入 / 復元 Mutation の pending 状態でボタンを無効化する。
- Modify: `app/lib/feature/subscription/ui/page/subscription_settings_page.dart`
  - 復元 Mutation の pending 状態で復元ボタンを無効化する。
- Create: `app/test/feature/subscription/data/notifier/subscription_notifier_test.dart`
  - Repository Provider を差し替えて Notifier の状態遷移をテストする。
- Generated: `*.freezed.dart`, `*.g.dart`
  - `melos run generate` で更新する。手編集しない。

---

### Task 1: Remove Startup RevenueCat Configuration

**Files:**
- Modify: `app/lib/main.dart`

- [ ] **Step 1: Edit imports and startup block**

Remove this import:

```dart
import 'package:purchases_flutter/purchases_flutter.dart' as rc;
```

Change:

```dart
if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
  await MobileAds.instance.initialize();
  await _configureRevenueCat();
}
```

to:

```dart
if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
  await MobileAds.instance.initialize();
}
```

- [ ] **Step 2: Remove `_configureRevenueCat`**

Delete the entire private function:

```dart
Future<void> _configureRevenueCat() async {
  final apiKey = BuildConfig.fromEnvironment().revenueCatApiKey;
  if (apiKey == null || apiKey.isEmpty) {
    log('RevenueCat API key is not configured; skipping configure.');
    return;
  }
  try {
    await rc.Purchases.setLogLevel(rc.LogLevel.info);
    await rc.Purchases.configure(rc.PurchasesConfiguration(apiKey));
  } on Object catch (error, stackTrace) {
    talker.handle(error, stackTrace, 'Failed to configure RevenueCat');
  }
}
```

- [ ] **Step 3: Format**

Run:

```bash
mise exec -- dart format app/lib/main.dart
```

Expected: formatter exits successfully.

- [ ] **Step 4: Commit**

```bash
git add app/lib/main.dart
git commit -m "refactor: RevenueCatの起動時初期化を削除"
```

---

### Task 2: Add RevenueCat Exception and Failure Reason

**Files:**
- Create: `app/lib/feature/subscription/data/exception/revenue_cat_unavailable_exception.dart`
- Create: `app/lib/feature/subscription/data/model/purchase_failure_reason.dart`

- [ ] **Step 1: Create RevenueCat unavailable exception**

Create `app/lib/feature/subscription/data/exception/revenue_cat_unavailable_exception.dart`:

```dart
enum RevenueCatUnavailableReason {
  unsupportedPlatform,
  apiKeyNotConfigured,
}

final class RevenueCatUnavailableException implements Exception {
  const RevenueCatUnavailableException({required this.reason});

  final RevenueCatUnavailableReason reason;

  String get userMessage => switch (reason) {
    RevenueCatUnavailableReason.unsupportedPlatform => 'このプラットフォームでは購入できません',
    RevenueCatUnavailableReason.apiKeyNotConfigured => '現在この機能はご利用いただけません',
  };

  @override
  String toString() => 'RevenueCatUnavailableException(reason: $reason)';
}
```

- [ ] **Step 2: Create purchase failure reason enum**

Create `app/lib/feature/subscription/data/model/purchase_failure_reason.dart`:

```dart
enum PurchaseFailureReason {
  planNotFound,
  activationNotConfirmed,
  revenueCatConfiguration,
  purchaseFailed,
  restoreNotFound,
  restoreFailed,
}

extension PurchaseFailureReasonMessage on PurchaseFailureReason {
  String get message => switch (this) {
    PurchaseFailureReason.planNotFound => 'プラン情報を取得できませんでした',
    PurchaseFailureReason.activationNotConfirmed =>
      '購入は完了しましたが、Pro プランの有効化を確認できませんでした',
    PurchaseFailureReason.revenueCatConfiguration => '現在この機能はご利用いただけません',
    PurchaseFailureReason.purchaseFailed => '購入に失敗しました',
    PurchaseFailureReason.restoreNotFound => '復元できる購入が見つかりませんでした',
    PurchaseFailureReason.restoreFailed => '購入の復元に失敗しました',
  };
}
```

- [ ] **Step 3: Format**

Run:

```bash
mise exec -- dart format app/lib/feature/subscription/data/exception/revenue_cat_unavailable_exception.dart app/lib/feature/subscription/data/model/purchase_failure_reason.dart
```

Expected: formatter exits successfully.

- [ ] **Step 4: Commit**

```bash
git add app/lib/feature/subscription/data/exception/revenue_cat_unavailable_exception.dart app/lib/feature/subscription/data/model/purchase_failure_reason.dart
git commit -m "feat: RevenueCat利用不可と購入失敗理由を定義"
```

---

### Task 3: Refactor Purchase Models With Freezed

**Files:**
- Modify: `app/lib/feature/subscription/data/model/purchase_result.dart`
- Create: `app/lib/feature/subscription/data/model/purchase_outcome.dart`
- Generated: `app/lib/feature/subscription/data/model/purchase_result.freezed.dart`
- Generated: `app/lib/feature/subscription/data/model/purchase_outcome.freezed.dart`

- [ ] **Step 1: Update `PurchaseResult`**

Replace `app/lib/feature/subscription/data/model/purchase_result.dart` with:

```dart
import 'package:eqmonitor/feature/subscription/data/model/purchase_failure_reason.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'purchase_result.freezed.dart';

/// 課金フローの結果。UI 側のスナックバー / ダイアログ分岐に使う。
@Freezed()
sealed class PurchaseResult with _$PurchaseResult {
  const factory PurchaseResult.success() = PurchaseResultSuccess;
  const factory PurchaseResult.cancelled() = PurchaseResultCancelled;
  const factory PurchaseResult.failed(PurchaseFailureReason reason) =
      PurchaseResultFailed;
}
```

- [ ] **Step 2: Add `PurchaseOutcome` Freezed model**

Create `app/lib/feature/subscription/data/model/purchase_outcome.dart`:

```dart
import 'package:eqmonitor/feature/subscription/data/model/purchase_result.dart';
import 'package:eqmonitor/feature/subscription/data/model/subscription_status.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'purchase_outcome.freezed.dart';

@Freezed()
abstract class PurchaseOutcome with _$PurchaseOutcome {
  const factory PurchaseOutcome({
    required PurchaseResult result,
    SubscriptionStatus? status,
  }) = _PurchaseOutcome;
}
```

- [ ] **Step 3: Generate Freezed code**

Run:

```bash
mise exec -- melos run generate
```

Expected: `purchase_result.freezed.dart` is updated and `purchase_outcome.freezed.dart` is created.

- [ ] **Step 4: Format**

Run:

```bash
mise exec -- dart format app/lib/feature/subscription/data/model/purchase_result.dart app/lib/feature/subscription/data/model/purchase_outcome.dart
```

Expected: formatter exits successfully.

- [ ] **Step 5: Commit**

```bash
git add app/lib/feature/subscription/data/model/purchase_result.dart app/lib/feature/subscription/data/model/purchase_result.freezed.dart app/lib/feature/subscription/data/model/purchase_outcome.dart app/lib/feature/subscription/data/model/purchase_outcome.freezed.dart
git commit -m "refactor: 購入結果をenum理由とFreezed outcomeに変更"
```

---

### Task 4: Add RevenueCat Initialization and Product ID Providers

**Files:**
- Create: `app/lib/feature/subscription/data/provider/revenue_cat_initialization_provider.dart`
- Create: `app/lib/feature/subscription/data/provider/subscription_product_id_provider.dart`
- Generated: `app/lib/feature/subscription/data/provider/revenue_cat_initialization_provider.g.dart`
- Generated: `app/lib/feature/subscription/data/provider/subscription_product_id_provider.g.dart`

- [ ] **Step 1: Create initialization provider**

Create `app/lib/feature/subscription/data/provider/revenue_cat_initialization_provider.dart`:

```dart
import 'dart:developer';
import 'dart:io';

import 'package:eqmonitor/core/model/environment.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/subscription/data/exception/revenue_cat_unavailable_exception.dart';
import 'package:flutter/foundation.dart';
import 'package:purchases_flutter/purchases_flutter.dart' as rc;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'revenue_cat_initialization_provider.g.dart';

@Riverpod(keepAlive: true)
Future<void> revenueCatInitialization(Ref ref) async {
  if (kIsWeb || (!Platform.isIOS && !Platform.isAndroid)) {
    throw const RevenueCatUnavailableException(
      reason: RevenueCatUnavailableReason.unsupportedPlatform,
    );
  }

  final apiKey = BuildConfig.fromEnvironment().revenueCatApiKey;
  if (apiKey == null || apiKey.isEmpty) {
    log('RevenueCat API key is not configured; skipping configure.');
    throw const RevenueCatUnavailableException(
      reason: RevenueCatUnavailableReason.apiKeyNotConfigured,
    );
  }

  if (rc.Purchases.isConfigured) {
    return;
  }

  try {
    await rc.Purchases.setLogLevel(rc.LogLevel.info);
    await rc.Purchases.configure(rc.PurchasesConfiguration(apiKey));
  } on Object catch (error, stackTrace) {
    talker.handle(error, stackTrace, 'Failed to configure RevenueCat');
    Error.throwWithStackTrace(error, stackTrace);
  }
}
```

- [ ] **Step 2: Create Product ID provider**

Create `app/lib/feature/subscription/data/provider/subscription_product_id_provider.dart`:

```dart
import 'dart:io';

import 'package:eqmonitor/feature/subscription/data/exception/revenue_cat_unavailable_exception.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'subscription_product_id_provider.g.dart';

const _iosMonthlyProductId = 'net.yumnumm.eqmonitor.pro.monthly';
const _androidMonthlyProductId = 'eqmonitor.pro.monthly:eqmonitor-pro-monthly';

@riverpod
String monthlySubscriptionProductId(Ref ref) {
  if (kIsWeb) {
    throw const RevenueCatUnavailableException(
      reason: RevenueCatUnavailableReason.unsupportedPlatform,
    );
  }
  if (Platform.isIOS) {
    return _iosMonthlyProductId;
  }
  if (Platform.isAndroid) {
    return _androidMonthlyProductId;
  }
  throw const RevenueCatUnavailableException(
    reason: RevenueCatUnavailableReason.unsupportedPlatform,
  );
}
```

- [ ] **Step 3: Generate Riverpod code**

Run:

```bash
mise exec -- melos run generate
```

Expected: both provider `.g.dart` files are created.

- [ ] **Step 4: Format**

Run:

```bash
mise exec -- dart format app/lib/feature/subscription/data/provider/revenue_cat_initialization_provider.dart app/lib/feature/subscription/data/provider/subscription_product_id_provider.dart
```

Expected: formatter exits successfully.

- [ ] **Step 5: Commit**

```bash
git add app/lib/feature/subscription/data/provider/revenue_cat_initialization_provider.dart app/lib/feature/subscription/data/provider/revenue_cat_initialization_provider.g.dart app/lib/feature/subscription/data/provider/subscription_product_id_provider.dart app/lib/feature/subscription/data/provider/subscription_product_id_provider.g.dart
git commit -m "feat: RevenueCat初期化とProduct IDをProvider化"
```

---

### Task 5: Add Concrete Subscription Repository

**Files:**
- Create: `app/lib/feature/subscription/data/repository/subscription_repository.dart`
- Generated: `app/lib/feature/subscription/data/repository/subscription_repository.g.dart`

- [ ] **Step 1: Create repository**

Create `app/lib/feature/subscription/data/repository/subscription_repository.dart`:

```dart
import 'package:eqmonitor/feature/subscription/data/model/purchase_failure_reason.dart';
import 'package:eqmonitor/feature/subscription/data/model/purchase_outcome.dart';
import 'package:eqmonitor/feature/subscription/data/model/purchase_result.dart';
import 'package:eqmonitor/feature/subscription/data/model/subscription_status.dart';
import 'package:eqmonitor/feature/subscription/data/provider/revenue_cat_initialization_provider.dart';
import 'package:eqmonitor/feature/subscription/data/provider/subscription_product_id_provider.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart' as rc;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'subscription_repository.g.dart';

const _entitlementId = 'pro';

@Riverpod(keepAlive: true)
Future<SubscriptionRepository> subscriptionRepository(Ref ref) async {
  await ref.watch(revenueCatInitializationProvider.future);
  final monthlyProductId = ref.watch(monthlySubscriptionProductIdProvider);
  return SubscriptionRepository(monthlyProductId: monthlyProductId);
}

class SubscriptionRepository {
  const SubscriptionRepository({required String monthlyProductId})
    : _monthlyProductId = monthlyProductId;

  final String _monthlyProductId;

  Future<SubscriptionStatus> fetchStatus() async {
    final info = await rc.Purchases.getCustomerInfo();
    return info.toSubscriptionStatus();
  }

  Future<PurchaseOutcome> purchaseMonthly() async {
    try {
      final offerings = await rc.Purchases.getOfferings();
      final current = offerings.current;
      final matchingPackages = current == null
          ? <rc.Package>[]
          : current.availablePackages
                .where(
                  (package) =>
                      package.storeProduct.identifier == _monthlyProductId,
                )
                .toList();
      final monthlyPackage = matchingPackages.isEmpty
          ? current?.monthly
          : matchingPackages.first;
      if (monthlyPackage == null) {
        return const PurchaseOutcome(
          result: PurchaseResult.failed(PurchaseFailureReason.planNotFound),
        );
      }

      final result = await rc.Purchases.purchase(
        rc.PurchaseParams.package(monthlyPackage),
      );
      final status = result.customerInfo.toSubscriptionStatus();
      return PurchaseOutcome(
        result: status is SubscriptionStatusActive
            ? const PurchaseResult.success()
            : const PurchaseResult.failed(
                PurchaseFailureReason.activationNotConfirmed,
              ),
        status: status,
      );
    } on PlatformException catch (error) {
      final errorCode = rc.PurchasesErrorHelper.getErrorCode(error);
      if (errorCode == rc.PurchasesErrorCode.purchaseCancelledError) {
        return const PurchaseOutcome(result: PurchaseResult.cancelled());
      }
      if (errorCode == rc.PurchasesErrorCode.configurationError) {
        return const PurchaseOutcome(
          result: PurchaseResult.failed(
            PurchaseFailureReason.revenueCatConfiguration,
          ),
        );
      }
      return const PurchaseOutcome(
        result: PurchaseResult.failed(PurchaseFailureReason.purchaseFailed),
      );
    }
  }

  Future<PurchaseOutcome> restorePurchases() async {
    try {
      final info = await rc.Purchases.restorePurchases();
      final status = info.toSubscriptionStatus();
      return PurchaseOutcome(
        result: status is SubscriptionStatusActive
            ? const PurchaseResult.success()
            : const PurchaseResult.failed(PurchaseFailureReason.restoreNotFound),
        status: status,
      );
    } on PlatformException {
      return const PurchaseOutcome(
        result: PurchaseResult.failed(PurchaseFailureReason.restoreFailed),
      );
    }
  }
}

extension CustomerInfoToSubscriptionStatus on rc.CustomerInfo {
  SubscriptionStatus toSubscriptionStatus() {
    final entitlement = entitlements.active[_entitlementId];
    if (entitlement == null) {
      return const SubscriptionStatus.inactive();
    }
    final expiresIso = entitlement.expirationDate;
    final expiresAt = expiresIso == null ? null : DateTime.tryParse(expiresIso);
    return SubscriptionStatus.active(
      productId: entitlement.productIdentifier,
      expiresAt: expiresAt,
      willRenew: entitlement.willRenew,
    );
  }
}
```

- [ ] **Step 2: Generate Riverpod code**

Run:

```bash
mise exec -- melos run generate
```

Expected: `subscription_repository.g.dart` is created.

- [ ] **Step 3: Format**

Run:

```bash
mise exec -- dart format app/lib/feature/subscription/data/repository/subscription_repository.dart
```

Expected: formatter exits successfully.

- [ ] **Step 4: Commit**

```bash
git add app/lib/feature/subscription/data/repository/subscription_repository.dart app/lib/feature/subscription/data/repository/subscription_repository.g.dart
git commit -m "feat: RevenueCat用サブスクRepositoryを追加"
```

---

### Task 6: Refactor Subscription Notifier

**Files:**
- Modify: `app/lib/feature/subscription/data/notifier/subscription_notifier.dart`
- Generated: `app/lib/feature/subscription/data/notifier/subscription_notifier.g.dart`

- [ ] **Step 1: Replace notifier**

Replace `app/lib/feature/subscription/data/notifier/subscription_notifier.dart`:

```dart
import 'package:eqmonitor/feature/subscription/data/model/purchase_result.dart';
import 'package:eqmonitor/feature/subscription/data/model/subscription_status.dart';
import 'package:eqmonitor/feature/subscription/data/repository/subscription_repository.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'subscription_notifier.g.dart';

/// サブスクリプション状態を保持する AsyncNotifier。
///
/// RevenueCat SDK へのアクセスは [SubscriptionRepository] に集約する。
@Riverpod(keepAlive: true)
class SubscriptionNotifier extends _$SubscriptionNotifier {
  @override
  Future<SubscriptionStatus> build() async {
    final repository = await ref.watch(subscriptionRepositoryProvider.future);
    return repository.fetchStatus();
  }

  static final purchaseMonthlyMutation = Mutation<PurchaseResult>();
  Future<PurchaseResult> purchaseMonthly() async {
    final repository = await ref.read(subscriptionRepositoryProvider.future);
    final outcome = await repository.purchaseMonthly();
    final status = outcome.status;
    if (status != null) {
      state = AsyncData(status);
    }
    return outcome.result;
  }

  static final restorePurchasesMutation = Mutation<PurchaseResult>();
  Future<PurchaseResult> restorePurchases() async {
    final repository = await ref.read(subscriptionRepositoryProvider.future);
    final outcome = await repository.restorePurchases();
    final status = outcome.status;
    if (status != null) {
      state = AsyncData(status);
    }
    return outcome.result;
  }
}
```

- [ ] **Step 2: Confirm `refresh()` is gone**

Search:

```bash
rg "refresh\\(\\)" app/lib/feature/subscription
```

Expected: no `SubscriptionNotifier.refresh()` references remain.

- [ ] **Step 3: Generate Riverpod code**

Run:

```bash
mise exec -- melos run generate
```

Expected: `subscription_notifier.g.dart` is updated.

- [ ] **Step 4: Commit**

```bash
git add app/lib/feature/subscription/data/notifier/subscription_notifier.dart app/lib/feature/subscription/data/notifier/subscription_notifier.g.dart
git commit -m "refactor: サブスクNotifierをRepositoryとMutationに整理"
```

---

### Task 7: Update Paywall Flow

**Files:**
- Modify: `app/lib/feature/subscription/data/flow/paywall_flow.dart`

- [ ] **Step 1: Update imports**

Ensure these imports exist:

```dart
import 'package:eqmonitor/feature/subscription/data/exception/revenue_cat_unavailable_exception.dart';
import 'package:eqmonitor/feature/subscription/data/model/purchase_failure_reason.dart';
import 'package:riverpod/experimental/mutation.dart';
```

- [ ] **Step 2: Replace purchase flow**

Change `purchaseMonthly`:

```dart
Future<void> purchaseMonthly(WidgetRef ref, BuildContext context) async {
  try {
    final result = await SubscriptionNotifier.purchaseMonthlyMutation.run(
      ref,
      (transaction) async {
        return transaction
            .get(subscriptionProvider.notifier)
            .purchaseMonthly();
      },
    );
    if (!context.mounted) {
      return;
    }
    await handlePurchaseResult(
      context,
      result: result,
      popOnSuccess: true,
    );
  } on RevenueCatUnavailableException catch (error) {
    if (!context.mounted) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(error.userMessage)),
    );
  }
}
```

- [ ] **Step 3: Replace restore flow**

Change `restorePurchases`:

```dart
Future<void> restorePurchases(WidgetRef ref, BuildContext context) async {
  try {
    final result = await SubscriptionNotifier.restorePurchasesMutation.run(
      ref,
      (transaction) async {
        return transaction
            .get(subscriptionProvider.notifier)
            .restorePurchases();
      },
    );
    if (!context.mounted) {
      return;
    }
    await handlePurchaseResult(
      context,
      result: result,
      popOnSuccess: false,
    );
  } on RevenueCatUnavailableException catch (error) {
    if (!context.mounted) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(error.userMessage)),
    );
  }
}
```

- [ ] **Step 4: Update failed result handling**

Change `PurchaseResultFailed` handling:

```dart
case PurchaseResultFailed(:final reason):
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('購入に失敗しました: ${reason.message}')),
  );
```

Remove the old `PurchaseResultUnavailable()` case entirely.

- [ ] **Step 5: Format**

Run:

```bash
mise exec -- dart format app/lib/feature/subscription/data/flow/paywall_flow.dart
```

Expected: formatter exits successfully.

- [ ] **Step 6: Commit**

```bash
git add app/lib/feature/subscription/data/flow/paywall_flow.dart
git commit -m "refactor: PaywallフローをMutationとenum失敗理由に対応"
```

---

### Task 8: Reflect Mutation Pending State in UI

**Files:**
- Modify: `app/lib/feature/subscription/ui/page/paywall_page.dart`
- Modify: `app/lib/feature/subscription/ui/page/subscription_settings_page.dart`

- [ ] **Step 1: Update Paywall imports**

Add:

```dart
import 'package:eqmonitor/feature/subscription/data/notifier/subscription_notifier.dart';
import 'package:riverpod/experimental/mutation.dart';
```

- [ ] **Step 2: Add pending state to `PaywallPage.build`**

After `final flow = ref.watch(paywallFlowProvider);`, add:

```dart
final purchaseState = ref.watch(
  SubscriptionNotifier.purchaseMonthlyMutation,
);
final restoreState = ref.watch(
  SubscriptionNotifier.restorePurchasesMutation,
);
final isPurchasing = purchaseState is MutationPending;
final isRestoring = restoreState is MutationPending;
final isBusy = isPurchasing || isRestoring;
```

- [ ] **Step 3: Disable Paywall buttons**

Change upgrade button:

```dart
onPressed: isBusy ? null : () async => flow.purchaseMonthly(ref, context),
child: isPurchasing
    ? const SizedBox.square(
        dimension: 20,
        child: CircularProgressIndicator.adaptive(strokeWidth: 2),
      )
    : const Text('Pro にアップグレード'),
```

Change restore button:

```dart
onPressed: isBusy ? null : () async => flow.restorePurchases(ref, context),
```

- [ ] **Step 4: Update Subscription Settings imports**

Add:

```dart
import 'package:riverpod/experimental/mutation.dart';
```

- [ ] **Step 5: Disable restore buttons in both sections**

Inside `_ActiveSection.build` and `_InactiveSection.build`, after `final flow = ref.watch(paywallFlowProvider);`, add:

```dart
final restoreState = ref.watch(
  SubscriptionNotifier.restorePurchasesMutation,
);
final isRestoring = restoreState is MutationPending;
```

Change each restore button:

```dart
onPressed: isRestoring
    ? null
    : () async => flow.restorePurchases(ref, context),
```

- [ ] **Step 6: Format**

Run:

```bash
mise exec -- dart format app/lib/feature/subscription/ui/page/paywall_page.dart app/lib/feature/subscription/ui/page/subscription_settings_page.dart
```

Expected: formatter exits successfully.

- [ ] **Step 7: Commit**

```bash
git add app/lib/feature/subscription/ui/page/paywall_page.dart app/lib/feature/subscription/ui/page/subscription_settings_page.dart
git commit -m "refactor: サブスク画面にMutation状態を反映"
```

---

### Task 9: Add Notifier Tests

**Files:**
- Create: `app/test/feature/subscription/data/notifier/subscription_notifier_test.dart`

- [ ] **Step 1: Create test**

Create `app/test/feature/subscription/data/notifier/subscription_notifier_test.dart`:

```dart
import 'package:eqmonitor/feature/subscription/data/model/purchase_failure_reason.dart';
import 'package:eqmonitor/feature/subscription/data/model/purchase_outcome.dart';
import 'package:eqmonitor/feature/subscription/data/model/purchase_result.dart';
import 'package:eqmonitor/feature/subscription/data/model/subscription_status.dart';
import 'package:eqmonitor/feature/subscription/data/notifier/subscription_notifier.dart';
import 'package:eqmonitor/feature/subscription/data/repository/subscription_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FakeSubscriptionRepository extends SubscriptionRepository {
  FakeSubscriptionRepository({
    required this.initialStatus,
    required this.purchaseOutcome,
    required this.restoreOutcome,
  }) : super(monthlyProductId: 'test-product');

  SubscriptionStatus initialStatus;
  PurchaseOutcome purchaseOutcome;
  PurchaseOutcome restoreOutcome;
  int fetchCount = 0;

  @override
  Future<SubscriptionStatus> fetchStatus() async {
    fetchCount += 1;
    return initialStatus;
  }

  @override
  Future<PurchaseOutcome> purchaseMonthly() async => purchaseOutcome;

  @override
  Future<PurchaseOutcome> restorePurchases() async => restoreOutcome;
}

ProviderContainer containerWithRepository(
  FakeSubscriptionRepository repository,
) {
  return ProviderContainer(
    overrides: [
      subscriptionRepositoryProvider.overrideWith((ref) async => repository),
    ],
  );
}

void main() {
  group('SubscriptionNotifier', () {
    test('build returns repository status', () async {
      final repository = FakeSubscriptionRepository(
        initialStatus: const SubscriptionStatus.inactive(),
        purchaseOutcome: const PurchaseOutcome(
          result: PurchaseResult.cancelled(),
        ),
        restoreOutcome: const PurchaseOutcome(
          result: PurchaseResult.cancelled(),
        ),
      );
      final container = containerWithRepository(repository);
      addTearDown(container.dispose);

      final status = await container.read(subscriptionProvider.future);

      expect(status, const SubscriptionStatus.inactive());
      expect(repository.fetchCount, 1);
    });

    test('purchaseMonthly updates state when repository returns status', () async {
      final active = SubscriptionStatus.active(
        productId: 'net.yumnumm.eqmonitor.pro.monthly',
        expiresAt: DateTime.utc(2026, 6),
      );
      final repository = FakeSubscriptionRepository(
        initialStatus: const SubscriptionStatus.inactive(),
        purchaseOutcome: PurchaseOutcome(
          result: const PurchaseResult.success(),
          status: active,
        ),
        restoreOutcome: const PurchaseOutcome(
          result: PurchaseResult.cancelled(),
        ),
      );
      final container = containerWithRepository(repository);
      addTearDown(container.dispose);
      await container.read(subscriptionProvider.future);

      final result = await container
          .read(subscriptionProvider.notifier)
          .purchaseMonthly();

      expect(result, const PurchaseResult.success());
      expect(container.read(subscriptionProvider).value, active);
    });

    test('restorePurchases keeps state when repository returns no status', () async {
      final repository = FakeSubscriptionRepository(
        initialStatus: const SubscriptionStatus.inactive(),
        purchaseOutcome: const PurchaseOutcome(
          result: PurchaseResult.cancelled(),
        ),
        restoreOutcome: const PurchaseOutcome(
          result: PurchaseResult.failed(PurchaseFailureReason.restoreNotFound),
        ),
      );
      final container = containerWithRepository(repository);
      addTearDown(container.dispose);
      await container.read(subscriptionProvider.future);

      final result = await container
          .read(subscriptionProvider.notifier)
          .restorePurchases();

      expect(
        result,
        const PurchaseResult.failed(PurchaseFailureReason.restoreNotFound),
      );
      expect(
        container.read(subscriptionProvider).value,
        const SubscriptionStatus.inactive(),
      );
    });
  });
}
```

- [ ] **Step 2: Run focused test**

Run:

```bash
mise exec -- flutter test app/test/feature/subscription/data/notifier/subscription_notifier_test.dart
```

Expected: all tests pass.

- [ ] **Step 3: Commit**

```bash
git add app/test/feature/subscription/data/notifier/subscription_notifier_test.dart
git commit -m "test: サブスクNotifierのRepository連携を検証"
```

---

### Task 10: Final Verification

**Files:**
- Review all changed Dart and generated files.

- [ ] **Step 1: Run generation**

Run:

```bash
mise exec -- melos run generate
```

Expected: command exits successfully.

- [ ] **Step 2: Run formatter**

Run:

```bash
mise exec -- dart format app/lib/main.dart app/lib/feature/subscription app/test/feature/subscription
```

Expected: command exits successfully.

- [ ] **Step 3: Run focused tests**

Run:

```bash
mise exec -- flutter test app/test/feature/subscription/data/notifier/subscription_notifier_test.dart
```

Expected: all tests pass.

- [ ] **Step 4: Run analyzer**

Run:

```bash
mise exec -- melos run analyze
```

Expected: analyzer exits successfully with no warnings or errors.

- [ ] **Step 5: Inspect final diff**

Run:

```bash
git --no-pager diff --stat
git --no-pager diff -- app/lib/main.dart app/lib/feature/subscription app/test/feature/subscription
```

Expected: diff only contains the RevenueCat lazy initialization, Repository refactor, Mutation updates, tests, and generated files.

- [ ] **Step 6: Commit generated or formatting residue only when needed**

If Task 10 produced generation or formatting changes, commit them:

```bash
git add app/lib app/test
git commit -m "chore: サブスクRepositoryリファクタの生成物を更新"
```

If there are no remaining changes from Task 10, do not create an empty commit.

---

## Self-Review

- Spec coverage: 起動時初期化削除は Task 1、Provider に enum/model を置かない構成は Task 2 と Task 4、Freezed data model は Task 3、Product ID の Provider 隠蔽は Task 4、concrete Repository は Task 5、Notifier の Mutation 化と `refresh()` 削除は Task 6、Flow/UI 更新は Task 7 と Task 8、テストと検証は Task 9 と Task 10 でカバーしている。
- Placeholder scan: 未確定のまま実装者に判断を丸投げする表現は含めていない。
- Type consistency: `revenueCatInitializationProvider`、`monthlySubscriptionProductIdProvider`、`subscriptionRepositoryProvider`、`PurchaseOutcome`、`PurchaseFailureReason`、`SubscriptionNotifier.purchaseMonthlyMutation`、`SubscriptionNotifier.restorePurchasesMutation` の名称は定義と利用で一致している。

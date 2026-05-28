import 'dart:io';

import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/subscription/data/model/purchase_result.dart';
import 'package:eqmonitor/feature/subscription/data/model/subscription_status.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart' as rc;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'subscription_notifier.g.dart';

/// RevenueCat の Entitlement ID。
/// バックエンド (`/v2/subscription/me`) およびダッシュボード設定と一致する必要がある。
const _entitlementId = 'pro';

/// iOS の月額プラン Product ID (App Store Connect 登録値)。
const _iosMonthlyProductId = 'net.yumnumm.eqmonitor.pro.monthly';

/// Android の月額プラン Product ID (Play Console 登録値)。
const _androidMonthlyProductId = 'eqmonitor.pro.monthly:eqmonitor-pro-monthly';

/// サブスクリプション状態を保持する AsyncNotifier。
///
/// `Purchases.getCustomerInfo()` で取得した `CustomerInfo` から
/// active な `pro` Entitlement を判定し [SubscriptionStatus] を返す。
@Riverpod(keepAlive: true)
class SubscriptionNotifier extends _$SubscriptionNotifier {
  @override
  Future<SubscriptionStatus> build() async {
    if (!await _isPurchasesAvailable) {
      return const SubscriptionStatus.inactive();
    }
    try {
      final info = await rc.Purchases.getCustomerInfo();
      return info.toSubscriptionStatus();
    } on PlatformException catch (e, st) {
      talker.handle(e, st, 'subscription.build: getCustomerInfo failed');
      return const SubscriptionStatus.inactive();
    }
  }

  /// サブスク状態を再取得する。RC ダッシュボード変更や webhook 反映後に呼ぶ。
  Future<void> refresh() async {
    if (!await _isPurchasesAvailable) {
      return;
    }
    state = const AsyncLoading<SubscriptionStatus>();
    state = await AsyncValue.guard(() async {
      final info = await rc.Purchases.getCustomerInfo();
      return info.toSubscriptionStatus();
    });
  }

  /// 月額プランの購入フローを開始する。
  /// 結果は UI 側 (PaywallFlow) でスナックバー / ダイアログ表示に使う。
  Future<PurchaseResult> purchaseMonthly() async {
    if (!await _isPurchasesAvailable) {
      return const PurchaseResult.unavailable('このプラットフォームでは購入できません');
    }
    try {
      final package = await _findMonthlyPackage();
      if (package == null) {
        return const PurchaseResult.failed('プラン情報を取得できませんでした');
      }
      final result = await rc.Purchases.purchase(
        rc.PurchaseParams.package(package),
      );
      final status = result.customerInfo.toSubscriptionStatus();
      state = AsyncData(status);
      return status is SubscriptionStatusActive
          ? const PurchaseResult.success()
          : const PurchaseResult.failed('購入は完了しましたが、Pro プランの有効化を確認できませんでした');
    } on PlatformException catch (e, st) {
      final errorCode = rc.PurchasesErrorHelper.getErrorCode(e);
      if (errorCode == rc.PurchasesErrorCode.purchaseCancelledError) {
        return const PurchaseResult.cancelled();
      }
      if (errorCode == rc.PurchasesErrorCode.configurationError) {
        talker.warning('subscription.purchaseMonthly: RC configuration error (no products in dashboard)');
        return const PurchaseResult.failed('現在この機能はご利用いただけません');
      }
      talker.handle(e, st, 'subscription.purchaseMonthly failed');
      return PurchaseResult.failed(e.message ?? '購入に失敗しました');
    }
  }

  /// 過去の購入を復元する。別端末・再インストール後に利用。
  Future<PurchaseResult> restorePurchases() async {
    if (!await _isPurchasesAvailable) {
      return const PurchaseResult.unavailable('このプラットフォームでは復元できません');
    }
    try {
      final info = await rc.Purchases.restorePurchases();
      final status = info.toSubscriptionStatus();
      state = AsyncData(status);
      return status is SubscriptionStatusActive
          ? const PurchaseResult.success()
          : const PurchaseResult.failed('復元できる購入が見つかりませんでした');
    } on PlatformException catch (e, st) {
      talker.handle(e, st, 'subscription.restorePurchases failed');
      return PurchaseResult.failed(e.message ?? '購入の復元に失敗しました');
    }
  }

  Future<rc.Package?> _findMonthlyPackage() async {
    final offerings = await rc.Purchases.getOfferings();
    final current = offerings.current;
    if (current == null) {
      return null;
    }
    final productId = Platform.isIOS || Platform.isMacOS
        ? _iosMonthlyProductId
        : _androidMonthlyProductId;
    for (final pkg in current.availablePackages) {
      if (pkg.storeProduct.identifier == productId) {
        return pkg;
      }
    }
    return current.monthly;
  }
}

/// `purchases_flutter` は iOS / Android のみ対応、かつ `Purchases.configure()` 済みであること。
/// プラットフォームが対象外か configure 未実行の場合は false を返す。
Future<bool> get _isPurchasesAvailable async {
  if (!Platform.isIOS && !Platform.isAndroid) {
    return false;
  }
  return rc.Purchases.isConfigured;
}

/// `CustomerInfo` から [SubscriptionStatus] へ変換する extension。
/// クラス内 private method 禁止ポリシーのため、共通ロジックをここに集約する。
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

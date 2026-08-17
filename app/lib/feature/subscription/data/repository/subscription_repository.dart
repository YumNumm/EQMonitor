import 'package:eqmonitor/feature/subscription/data/model/purchase_failure_reason.dart';
import 'package:eqmonitor/feature/subscription/data/model/purchase_outcome.dart';
import 'package:eqmonitor/feature/subscription/data/model/purchase_result.dart';
import 'package:eqmonitor/feature/subscription/data/model/subscription_status.dart';
import 'package:eqmonitor/feature/subscription/data/provider/subscription_product_id_provider.dart';
import 'package:eqmonitor/feature/subscription/data/repository/revenue_cat_configurator.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart' as rc;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'subscription_repository.g.dart';

const _entitlementId = 'pro';

@Riverpod(keepAlive: true)
Future<SubscriptionRepository> subscriptionRepository(Ref ref) async {
  await const RevenueCatConfigurator().ensureConfigured();
  final monthlyProductId = ref.watch(monthlySubscriptionProductIdProvider);
  return SubscriptionRepository(monthlyProductId: monthlyProductId);
}

class SubscriptionRepository {
  const new({required String monthlyProductId})
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
            : const PurchaseResult.failed(
                PurchaseFailureReason.restoreNotFound,
              ),
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

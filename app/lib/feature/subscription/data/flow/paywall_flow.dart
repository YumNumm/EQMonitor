import 'dart:io' show Platform;

import 'package:eqmonitor/feature/subscription/data/exception/revenue_cat_unavailable_exception.dart';
import 'package:eqmonitor/feature/subscription/data/model/purchase_failure_reason.dart';
import 'package:eqmonitor/feature/subscription/data/model/purchase_result.dart';
import 'package:eqmonitor/feature/subscription/data/notifier/subscription_notifier.dart';
import 'package:eqmonitor/feature/subscription/ui/component/thank_you_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:url_launcher/url_launcher_string.dart';

part 'paywall_flow.g.dart';

@riverpod
PaywallFlow paywallFlow(Ref ref) => PaywallFlow();

/// Paywall / SubscriptionSettings から呼ばれる購入・復元・外部リンクの Flow。
class PaywallFlow {
  /// 月額プランの購入フロー。結果に応じてダイアログ / SnackBar を出す。
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

  /// 購入を復元する。
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

  Future<void> handlePurchaseResult(
    BuildContext context, {
    required PurchaseResult result,
    required bool popOnSuccess,
  }) async {
    switch (result) {
      case PurchaseResultSuccess():
        await showDialog<void>(
          context: context,
          builder: (context) => const ThankYouDialog(),
        );
        if (!context.mounted) {
          return;
        }
        if (popOnSuccess && Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
      case PurchaseResultCancelled():
        return;
      case PurchaseResultFailed(:final reason):
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('購入に失敗しました: ${reason.message}')),
        );
    }
  }

  /// 利用規約 / プライバシーポリシー / 特商法のページを外部ブラウザで開く。
  Future<void> openExternalUrl(String url) async {
    await launchUrlString(url, mode: LaunchMode.externalApplication);
  }

  /// App Store / Play Store のサブスクリプション管理画面を開く。
  Future<void> openStoreSubscriptionManagement() async {
    final url = Platform.isIOS
        ? 'https://apps.apple.com/account/subscriptions'
        : 'https://play.google.com/store/account/subscriptions';
    await launchUrlString(url, mode: LaunchMode.externalApplication);
  }
}

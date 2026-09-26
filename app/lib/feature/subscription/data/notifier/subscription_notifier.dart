import 'dart:async';

import 'package:clock/clock.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/provider/app_lifecycle.dart';
import 'package:eqmonitor/core/provider/environment/environment.dart';
import 'package:eqmonitor/feature/subscription/data/model/purchase_failure_reason.dart';
import 'package:eqmonitor/feature/subscription/data/model/purchase_outcome.dart';
import 'package:eqmonitor/feature/subscription/data/model/purchase_result.dart';
import 'package:eqmonitor/feature/subscription/data/model/subscription_status.dart';
import 'package:eqmonitor/feature/subscription/data/repository/subscription_repository.dart';
import 'package:eqmonitor/feature/subscription/data/repository/subscription_server_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:purchases_flutter/purchases_flutter.dart' as rc;
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'subscription_notifier.g.dart';

@Riverpod(keepAlive: true)
class SubscriptionNotifier extends _$SubscriptionNotifier {
  var _generation = 0;
  var _busy = false;
  Timer? _expiryTimer;

  @override
  Future<SubscriptionStatus> build() async {
    final generation = ++_generation;
    ref.onDispose(() {
      _generation++;
      _expiryTimer?.cancel();
    });
    if (!ref.watch(buildConfigProvider).isProFeaturesEnabled) {
      return const SubscriptionStatus.inactive();
    }
    final repository = await ref.watch(subscriptionRepositoryProvider.future);
    if (!ref.mounted) return const SubscriptionStatus.inactive();
    final server = await ref.watch(subscriptionServerRepositoryProvider.future);
    if (!ref.mounted) return const SubscriptionStatus.inactive();
    var ready = false;
    void onCustomerInfo(rc.CustomerInfo _) {
      if (ready && !_busy && ref.mounted) ref.invalidateSelf();
    }

    rc.Purchases.addCustomerInfoUpdateListener(onCustomerInfo);
    ref.onDispose(
      () => rc.Purchases.removeCustomerInfoUpdateListener(onCustomerInfo),
    );
    ref.listen(appLifecycleProvider, (previous, next) {
      if (next == AppLifecycleState.resumed && previous != next && !_busy)
        ref.invalidateSelf();
    });
    await repository.session.validateCredentials();
    var status = (await server.fetch()).unwrap();
    if (status is SubscriptionStatusInactive) {
      final storeStatus = await repository.fetchStatus();
      if (storeStatus is SubscriptionStatusActive) {
        status = (await server.fetch(synchronize: true))
            .toSyncedStatus(previous: status);
      }
    }

    await repository.session.validateCredentials();
    if (ref.mounted && generation == _generation) {
      ready = true;
      scheduleExpiry(status: status);
    }
    return status;
  }

  static final purchaseMonthlyMutation = Mutation<PurchaseResult>();
  Future<PurchaseResult> purchaseMonthly({required rc.Package package}) =>
      performPurchase(
        purchase: (repository) => repository.purchaseMonthly(package: package),
        skipWhenActive: true,
      );

  static final restorePurchasesMutation = Mutation<PurchaseResult>();
  Future<PurchaseResult> restorePurchases() => performPurchase(
    purchase: (repository) => repository.restorePurchases(),
    skipWhenActive: false,
  );

  Future<PurchaseResult> performPurchase({
    required Future<PurchaseOutcome> Function(SubscriptionRepository) purchase,
    required bool skipWhenActive,
  }) async {
    if (!ref.read(buildConfigProvider).isProFeaturesEnabled) {
      return const PurchaseResult.cancelled();
    }
    if (_busy)
      return const PurchaseResult.failed(
        PurchaseFailureReason.operationInProgress,
      );
    _busy = true;
    final generation = _generation;
    try {
      final repository = await ref.read(subscriptionRepositoryProvider.future);
      final server = await ref.read(
        subscriptionServerRepositoryProvider.future,
      );
      await repository.session.validateCredentials();
      final before = (await server.fetch()).unwrap();
      if (!ref.mounted || generation != _generation)
        return const PurchaseResult.cancelled();
      if (skipWhenActive && before is SubscriptionStatusActive) {
        state = AsyncData(before);
        scheduleExpiry(status: before);
        return const PurchaseResult.success();
      }
      state = AsyncData(
        before.copyWith(syncPhase: SubscriptionSyncPhase.synchronizing),
      );
      final outcome = await purchase(repository);
      if (!ref.mounted || generation != _generation)
        return const PurchaseResult.cancelled();
      if (outcome.result is PurchaseResultCancelled ||
          (outcome.result is PurchaseResultFailed && outcome.status == null)) {
        state = AsyncData(before);
        return outcome.result;
      }
      final synced = await server.fetch(synchronize: true);
      final status = switch ((synced, outcome.result)) {
        (
          Success(value: SubscriptionStatusInactive()),
          PurchaseResultFailed(reason: PurchaseFailureReason.restoreNotFound),
        ) =>
          const SubscriptionStatus.inactive(),
        _ => synced.toSyncedStatus(previous: before),
      };
      await repository.session.validateCredentials();
      if (!ref.mounted || generation != _generation)
        return const PurchaseResult.cancelled();
      state = AsyncData(status);
      scheduleExpiry(status: status);
      if (status is SubscriptionStatusInactive &&
          status.syncPhase == SubscriptionSyncPhase.idle) {
        return outcome.result;
      }
      return status is SubscriptionStatusActive &&
              status.syncPhase == SubscriptionSyncPhase.idle
          ? const PurchaseResult.success()
          : const PurchaseResult.pending();
    } catch (error, stackTrace) {
      if (ref.mounted && generation == _generation)
        state = AsyncError(error, stackTrace);
      rethrow;
    } finally {
      _busy = false;
    }
  }

  static final synchronizeMutation = Mutation<void>();
  Future<void> synchronize() async {
    if (!ref.read(buildConfigProvider).isProFeaturesEnabled || _busy) return;
    _busy = true;
    final generation = _generation;
    final previous = state.value ?? const SubscriptionStatus.inactive();
    state = AsyncData(
      previous.copyWith(syncPhase: SubscriptionSyncPhase.synchronizing),
    );
    try {
      final repository = await ref.read(subscriptionRepositoryProvider.future);
      final server = await ref.read(
        subscriptionServerRepositoryProvider.future,
      );
      // Reestablish identity after a failed logIn, without invoking purchase/restore.
      final storeStatus = await repository.fetchStatus();
      final synced = await server.fetch(synchronize: true);
      final status = switch ((storeStatus, synced)) {
        (
          SubscriptionStatusInactive(),
          Success(value: SubscriptionStatusInactive()),
        ) =>
          const SubscriptionStatus.inactive(),
        _ => synced.toSyncedStatus(previous: previous),
      };
      await repository.session.validateCredentials();
      if (!ref.mounted || generation != _generation) return;
      state = AsyncData(status);
      scheduleExpiry(status: status);
    } catch (error, stackTrace) {
      if (ref.mounted && generation == _generation)
        state = AsyncError(error, stackTrace);
      rethrow;
    } finally {
      _busy = false;
    }
  }

  void scheduleExpiry({required SubscriptionStatus status}) {
    _expiryTimer?.cancel();
    if (status case SubscriptionStatusActive(:final expiresAt?)) {
      final remaining = expiresAt.difference(clock.now());
      if (remaining > Duration.zero) {
        _expiryTimer = Timer(remaining, () {
          if (ref.mounted) ref.invalidateSelf();
        });
      }
    }
  }
}

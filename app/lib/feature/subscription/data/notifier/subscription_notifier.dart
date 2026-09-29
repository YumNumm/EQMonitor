import 'dart:async';
import 'dart:math';

import 'package:clock/clock.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/provider/app_lifecycle.dart';
import 'package:eqmonitor/feature/devices/data/retry/retry_controller.dart';
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
  Future<void>? _refreshing;
  var _pendingRetry = 0;
  final _random = Random();
  Timer? _expiryTimer;

  @override
  Future<SubscriptionStatus> build() async {
    final generation = ++_generation;
    cancelPendingRetry();
    ref.onDispose(() {
      _generation++;
      _expiryTimer?.cancel();
    });
    final repository = await ref.watch(subscriptionRepositoryProvider.future);
    if (!ref.mounted) return const SubscriptionStatus.inactive();
    final server = await ref.watch(subscriptionServerRepositoryProvider.future);
    if (!ref.mounted) return const SubscriptionStatus.inactive();
    var ready = false;
    void onCustomerInfo(rc.CustomerInfo _) {
      if (ready && !_busy && ref.mounted) unawaited(refresh());
    }

    rc.Purchases.addCustomerInfoUpdateListener(onCustomerInfo);
    ref.onDispose(
      () => rc.Purchases.removeCustomerInfoUpdateListener(onCustomerInfo),
    );
    ref.listen(appLifecycleProvider, (previous, next) {
      if (next == AppLifecycleState.resumed && previous != next && !_busy)
        unawaited(refresh());
    });
    final status = await fetchStatus(repository: repository, server: server);
    if (ref.mounted && generation == _generation) {
      ready = true;
      scheduleExpiry(status: status);
    }
    return status;
  }

  /// バックエンドの確認値を取得する。
  ///
  /// [retained] は同一 device で確認済みの Pro 権限。通信エラー時だけ期限まで維持する。
  Future<SubscriptionStatus> fetchStatus({
    required SubscriptionRepository repository,
    required SubscriptionServerRepository server,
    SubscriptionStatusActive? retained,
  }) async {
    await repository.session.validateCredentials();
    var status = switch ((await server.fetch(), retained)) {
      (
        Failure(
          exception: SubscriptionApiException(
            reason: SubscriptionApiFailure.unavailable,
          ),
        ),
        final SubscriptionStatusActive retained,
      ) =>
        retained.copyWith(syncPhase: SubscriptionSyncPhase.failed),
      (final result, _) => result.unwrap(),
    };
    if (status is SubscriptionStatusInactive) {
      final storeStatus = await repository.fetchStatus();
      if (storeStatus is SubscriptionStatusActive) {
        status = (await server.fetch(synchronize: true))
            .toSyncedStatus(previous: status);
      }
    }
    await repository.session.validateCredentials();
    return status;
  }

  /// 同一 device の権限を再確認する (foreground 復帰・SDK 更新)。
  ///
  /// 確認中も直前の確定値を保持し、通信エラーでは確認済みの Pro を期限まで維持する。
  /// 確定値がない、または取得に失敗した場合は通常の再構築に委ねる。
  Future<void> refresh() => _refreshing ??= _refresh().whenComplete(
    () => _refreshing = null,
  );

  Future<void> _refresh() async {
    final current = state;
    final previous = current.value;
    if (_busy) return;
    cancelPendingRetry();
    if (current.isLoading || current.hasError || previous == null) {
      ref.invalidateSelf();
      return;
    }
    final generation = _generation;
    try {
      final repository = await ref.read(subscriptionRepositoryProvider.future);
      final server = await ref.read(
        subscriptionServerRepositoryProvider.future,
      );
      final status = await fetchStatus(
        repository: repository,
        server: server,
        retained: switch (previous) {
          SubscriptionStatusActive(:final expiresAt)
              when expiresAt == null || expiresAt.isAfter(clock.now()) =>
            previous,
          _ => null,
        },
      );
      if (!ref.mounted || generation != _generation || _busy) return;
      state = AsyncData(status);
      scheduleExpiry(status: status);
    } catch (_) {
      if (ref.mounted && generation == _generation && !_busy)
        ref.invalidateSelf();
    }
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
    if (_busy)
      return const PurchaseResult.failed(
        PurchaseFailureReason.operationInProgress,
      );
    _busy = true;
    cancelPendingRetry();
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
      if (synced.isPendingFailure) {
        retryPendingSync(
          repository: repository,
          server: server,
          generation: generation,
        );
      }
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
    if (_busy) return;
    _busy = true;
    cancelPendingRetry();
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

  /// 購入直後の同期が 409 pending のとき、Webhook の到着を待って同期を再試行する。
  ///
  /// 間隔・回数は端末登録の [RetryController] と同じ (2s 基準・上限 60s・初回込み最大
  /// [retryMaxAttempts] 回)。409 以外の結果で終了し、foreground 復帰・手動同期・
  /// 購入/復元・再構築で打ち切る。
  void retryPendingSync({
    required SubscriptionRepository repository,
    required SubscriptionServerRepository server,
    required int generation,
  }) {
    final token = ++_pendingRetry;
    bool cancelled() =>
        !ref.mounted ||
        token != _pendingRetry ||
        generation != _generation ||
        _busy;

    unawaited(() async {
      for (var attempt = 0; attempt < retryMaxAttempts - 1; attempt++) {
        await Future<void>.delayed(
          retryBackoffDelay(attempt: attempt, random: _random),
        );
        if (cancelled()) return;
        try {
          await repository.session.validateCredentials();
          final synced = await server.fetch(synchronize: true);
          await repository.session.validateCredentials();
          if (cancelled()) return;
          if (synced.isPendingFailure) continue;
          final previous = state.value ?? const SubscriptionStatus.inactive();
          final status = synced.toSyncedStatus(previous: previous);
          state = AsyncData(status);
          scheduleExpiry(status: status);
          return;
        } catch (_) {
          // 端末 identity の変更は provider の再構築側で扱う。
          return;
        }
      }
    }());
  }

  void cancelPendingRetry() => _pendingRetry++;

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

extension on Result<SubscriptionStatus, SubscriptionApiException> {
  bool get isPendingFailure => switch (this) {
    Failure(
      exception: SubscriptionApiException(
        reason: SubscriptionApiFailure.pending,
      ),
    ) =>
      true,
    _ => false,
  };
}

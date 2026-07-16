import 'dart:async';

import 'package:dio/dio.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/devices/data/exception/device_provisioning_exception.dart';
import 'package:eqmonitor/feature/devices/data/exception/dio_exception_mapper.dart';
import 'package:eqmonitor/feature/devices/data/model/notification_token.dart';
import 'package:eqmonitor/feature/devices/data/model/push_token_sync_snapshot.dart';
import 'package:eqmonitor/feature/devices/data/model/push_token_sync_worker_state.dart';
import 'package:eqmonitor/feature/devices/data/notifier/device_provisioning_notifier.dart';
import 'package:eqmonitor/feature/devices/data/provider/push_token_platform_capabilities.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_provisioning_repository.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_repository.dart';
import 'package:eqmonitor/feature/devices/data/repository/push_token_sync_worker.dart';
import 'package:eqmonitor/feature/devices/data/retry/retry_controller.dart';
import 'package:eqmonitor/feature/telemetry/data/provider/telemetry_recorder_provider.dart';
import 'package:eqmonitor/feature/telemetry/data/provider/telemetry_uploader_provider.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:telemetry_store/telemetry_store.dart';

part 'push_token_sync_notifier.g.dart';

@Riverpod(keepAlive: true)
class PushTokenSyncNotifier extends _$PushTokenSyncNotifier {
  PushTokenSyncWorker? _fcmWorker;
  PushTokenSyncWorker? _apnsWorker;
  PushTokenSyncWorker? _pushToStartWorker;
  final _subscriptions = <StreamSubscription<PushTokenSyncWorkerState>>[];

  @override
  Future<PushTokenSyncSnapshot> build() async {
    final capabilities = ref.watch(pushTokenPlatformCapabilitiesProvider);

    if (capabilities.supportsFcm) {
      _fcmWorker = createWorker(kind: PushTokenKind.fcm);
    }
    if (capabilities.supportsApns) {
      _apnsWorker = createWorker(kind: PushTokenKind.apnsNotification);
    }
    if (capabilities.supportsPushToStart) {
      _pushToStartWorker = createWorker(kind: PushTokenKind.apnsPushToStart);
    }

    ref.onDispose(disposeWorkers);

    return currentSnapshot();
  }

  RetryControllerState get retryState {
    final workers = [_fcmWorker, _apnsWorker, _pushToStartWorker].nonNulls;

    // 失敗ワーカーを最優先
    for (final worker in workers) {
      final s = worker.state;
      if (s is FailedWorkerState) {
        return RetryExhausted(lastError: s.error);
      }
    }

    // 次に待機中ワーカー
    for (final worker in workers) {
      final s = worker.state;
      if (s is WaitingWorkerState) {
        return RetryWaiting(
          attempt: s.attempt,
          resumeAt: s.resumeAt,
          lastError: s.error,
        );
      }
    }

    // 次に同期中ワーカー
    for (final worker in workers) {
      if (worker.state is SyncingWorkerState) {
        return const RetryRunning(attempt: 0);
      }
    }

    return const RetryIdle();
  }

  void reset() {
    // ワーカーが自身の状態を管理するため、ここでは何もしない。
  }

  /// トークンを受け付け、対応するワーカーにルーティングする。
  void accept(NotificationToken token) {
    final fcm = token.fcmToken;
    if (fcm != null && fcm.isNotEmpty) {
      _fcmWorker?.accept(token: fcm);
    }
    final apns = token.apnsToken;
    if (apns != null && apns.isNotEmpty) {
      _apnsWorker?.accept(token: apns);
    }
    final pushToStart = token.apnsPushToStartToken;
    if (pushToStart != null && pushToStart.isNotEmpty) {
      _pushToStartWorker?.accept(token: pushToStart);
    }
  }

  /// 失敗中のワーカーをすべて再試行する。
  void retryFailed() {
    _fcmWorker?.retry();
    _apnsWorker?.retry();
    _pushToStartWorker?.retry();
  }

  /// 全ワーカーを破棄する。
  void disposeWorkers() {
    for (final sub in _subscriptions) {
      sub.cancel();
    }
    _subscriptions.clear();
    _fcmWorker?.dispose();
    _apnsWorker?.dispose();
    _pushToStartWorker?.dispose();
  }

  static final syncMutation = Mutation<void>();

  /// バナーの手動リトライ用。ワーカーの retry を委譲する。
  Future<void> sync() async {
    retryFailed();
  }

  Future<void> handleAuthenticationFailure() async {
    final repo = await ref.read(deviceProvisioningRepositoryProvider.future);
    await repo.clearProvisioned();
    ref.invalidate(deviceProvisioningProvider, asReload: true);
  }

  /// クラス内 private method を追加しない方針のため public。
  /// [build] からのみ呼ばれる。
  PushTokenSyncWorker createWorker({required PushTokenKind kind}) {
    final worker = PushTokenSyncWorker(
      upsert: (token) => upsertToken(kind: kind, token: token),
    );
    _subscriptions.add(worker.states.listen((_) => updateSnapshot()));
    return worker;
  }

  /// クラス内 private method を追加しない方針のため public。
  void updateSnapshot() {
    state = AsyncData(currentSnapshot());
  }

  /// クラス内 private method を追加しない方針のため public。
  PushTokenSyncSnapshot currentSnapshot() {
    return PushTokenSyncSnapshot(
      fcm: mapWorkerState(_fcmWorker?.state),
      apnsNotification: mapWorkerState(_apnsWorker?.state),
      apnsPushToStart: mapWorkerState(_pushToStartWorker?.state),
    );
  }

  /// クラス内 private method を追加しない方針のため public。
  PushTokenKindState mapWorkerState(PushTokenSyncWorkerState? workerState) {
    return switch (workerState) {
      null => const NotApplicableTokenState(),
      AbsentWorkerState() => const AbsentTokenState(),
      SyncingWorkerState() => const SyncingTokenState(),
      WaitingWorkerState() => const PendingTokenState(),
      SyncedWorkerState() => const SyncedTokenState(),
      FailedWorkerState(:final error) => FailedTokenState(error: error),
      DisposedWorkerState() => const NotApplicableTokenState(),
    };
  }

  /// クラス内 private method を追加しない方針のため public。
  Future<void> upsertToken({
    required PushTokenKind kind,
    required String token,
  }) async {
    final deviceRepo = await ref.read(deviceRepositoryProvider.future);
    final result = await deviceRepo.upsertPushToken(
      kind: kind,
      token: token,
    );
    switch (result) {
      case Success():
        return;
      case Failure(:final exception, :final stackTrace):
        final DeviceProvisioningException mapped;
        switch (exception) {
          case DioException():
            mapped = mapDioToProvisioningException(
              exception,
              stackTrace ?? StackTrace.empty,
            );
          case DeviceProvisioningException():
            mapped = exception;
          default:
            mapped = UnexpectedProvisioningException(
              cause: exception,
              stackTrace: stackTrace,
            );
        }

        if (mapped is AuthorizationException &&
            mapped.reason == AuthorizationFailureReason.unauthenticated) {
          await handleAuthenticationFailure();
        }

        _recordSyncFailureTelemetry(kind: kind, error: mapped);

        throw mapped;
    }
  }

  /// テレメトリは観測用の副作用であり、記録失敗（provider 初期化失敗を含む）が
  /// トークン同期やエラー伝播を壊してはならない。
  void _recordSyncFailureTelemetry({
    required PushTokenKind kind,
    required Object error,
  }) async {
    try {
      await ref
          .read(telemetryRecorderProvider)
          .record(
            TelemetryEvent.error(
              errorType: 'push_token_sync_failed',
              message: '${kind.name}: $error',
            ),
          );
      await ref.read(telemetryUploaderProvider).flush();
    } on Exception catch (error) {
      talker.info('Failed to record telemetry', error);
    }
  }
}

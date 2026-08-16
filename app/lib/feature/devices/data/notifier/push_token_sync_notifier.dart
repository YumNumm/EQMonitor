import 'dart:async';

import 'package:dio/dio.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/devices/data/exception/device_provisioning_exception.dart';
import 'package:eqmonitor/feature/devices/data/exception/dio_exception_mapper.dart';
import 'package:eqmonitor/feature/devices/data/model/notification_token.dart';
import 'package:eqmonitor/feature/devices/data/model/push_token_force_resync_result.dart';
import 'package:eqmonitor/feature/devices/data/model/push_token_sync_snapshot.dart';
import 'package:eqmonitor/feature/devices/data/model/push_token_sync_worker_state.dart';
import 'package:eqmonitor/feature/devices/data/notifier/device_provisioning_notifier.dart';
import 'package:eqmonitor/feature/devices/data/provider/notification_token_stream.dart';
import 'package:eqmonitor/feature/devices/data/provider/push_token_platform_capabilities.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_provisioning_repository.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_repository.dart';
import 'package:eqmonitor/feature/devices/data/repository/push_token_sync_worker.dart';
import 'package:eqmonitor/feature/devices/data/retry/interruptible_backoff.dart';
import 'package:eqmonitor/feature/telemetry/data/provider/telemetry_recorder_provider.dart';
import 'package:eqmonitor/feature/telemetry/data/provider/telemetry_uploader_provider.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:telemetry_store/telemetry_store.dart';

part 'push_token_sync_notifier.g.dart';

@Riverpod(keepAlive: true)
class PushTokenSyncNotifier extends _$PushTokenSyncNotifier {
  PushTokenSyncWorker? _fcmWorker;
  PushTokenSyncWorker? _apnsNotificationWorker;
  PushTokenSyncWorker? _apnsPushToStartWorker;
  final _workerSubscriptions = <StreamSubscription<PushTokenSyncWorkerState>>[];
  var _workersDisposed = false;

  @override
  Future<PushTokenSyncSnapshot> build() async {
    ref.onDispose(() => unawaited(disposeWorkers()));
    final repository = await ref.watch(deviceRepositoryProvider.future);
    final provisioningRepository = await ref.watch(
      deviceProvisioningRepositoryProvider.future,
    );
    final telemetryRecorder = ref.watch(telemetryRecorderProvider);
    final telemetryUploader = ref.watch(telemetryUploaderProvider);
    final capabilities = ref.watch(pushTokenPlatformCapabilitiesProvider);

    PushTokenSyncWorker createWorker(PushTokenKind kind) {
      final worker = PushTokenSyncWorker(
        upsert: (token) async {
          final result = await repository.upsertPushToken(
            kind: kind,
            token: token,
          );
          switch (result) {
            case Success():
              return;
            case Failure(:final exception, :final stackTrace):
              final mapped = switch (exception) {
                DeviceProvisioningException() => exception,
                DioException() => DioExceptionMapper.map(
                  exception,
                  stackTrace ?? StackTrace.empty,
                ),
                _ => UnexpectedProvisioningException(
                  cause: exception,
                  stackTrace: stackTrace,
                ),
              };
              if (mapped case AuthorizationException(
                reason: AuthorizationFailureReason.unauthenticated,
              )) {
                await handleAuthenticationFailure(
                  repository: provisioningRepository,
                );
              }
              unawaited(
                recordSyncFailure(
                  kind: kind,
                  error: mapped,
                  recorder: telemetryRecorder,
                  uploader: telemetryUploader,
                ),
              );
              Error.throwWithStackTrace(
                mapped,
                mapped.stackTrace ?? stackTrace ?? StackTrace.empty,
              );
          }
        },
        backoff: InterruptibleBackoff(),
      );
      _workerSubscriptions.add(
        worker.states.listen((workerState) {
          final snapshot = state.value;
          if (snapshot == null || _workersDisposed) {
            return;
          }
          state = AsyncData(
            snapshot.updateKind(
              kind: kind,
              kindState: workerState.toKindState(),
            ),
          );
        }),
      );
      return worker;
    }

    _fcmWorker = capabilities.supportsFcm ? createWorker(.fcm) : null;
    _apnsNotificationWorker = capabilities.supportsApns
        ? createWorker(.apnsNotification)
        : null;
    _apnsPushToStartWorker = capabilities.supportsPushToStart
        ? createWorker(.apnsPushToStart)
        : null;

    return PushTokenSyncSnapshot(
      fcm: capabilities.supportsFcm
          ? const AbsentTokenState()
          : const NotApplicableTokenState(),
      apnsNotification: capabilities.supportsApns
          ? const AbsentTokenState()
          : const NotApplicableTokenState(),
      apnsPushToStart: capabilities.supportsPushToStart
          ? const AbsentTokenState()
          : const NotApplicableTokenState(),
    );
  }

  static final syncMutation = Mutation<void>();
  static final forceResyncMutation = Mutation<PushTokenForceResyncResult>();

  void accept(NotificationToken token) {
    final fcmToken = token.fcmToken;
    if (fcmToken != null) {
      _fcmWorker?.accept(token: fcmToken);
    }
    final apnsToken = token.apnsToken;
    if (apnsToken != null) {
      _apnsNotificationWorker?.accept(token: apnsToken);
    }
    final pushToStartToken = token.apnsPushToStartToken;
    if (pushToStartToken != null) {
      _apnsPushToStartWorker?.accept(token: pushToStartToken);
    }
  }

  void retryFailed() {
    if (_fcmWorker?.state is PushTokenSyncWorkerFailed) {
      _fcmWorker?.retry();
    }
    if (_apnsNotificationWorker?.state is PushTokenSyncWorkerFailed) {
      _apnsNotificationWorker?.retry();
    }
    if (_apnsPushToStartWorker?.state is PushTokenSyncWorkerFailed) {
      _apnsPushToStartWorker?.retry();
    }
  }

  Future<PushTokenForceResyncResult> forceResync({
    required PushTokenKind kind,
  }) async {
    final worker = switch (kind) {
      PushTokenKind.fcm => _fcmWorker,
      PushTokenKind.apnsNotification => _apnsNotificationWorker,
      PushTokenKind.apnsPushToStart => _apnsPushToStartWorker,
    };
    if (worker == null) {
      return PushTokenForceResyncResult.notApplicable;
    }

    final notificationToken = ref.read(notificationTokenStreamProvider).value;
    final streamToken = switch (kind) {
      PushTokenKind.fcm => notificationToken?.fcmToken,
      PushTokenKind.apnsNotification => notificationToken?.apnsToken,
      PushTokenKind.apnsPushToStart => notificationToken?.apnsPushToStartToken,
    };
    if (streamToken != null && streamToken.isNotEmpty) {
      worker.accept(token: streamToken);
      worker.forceResync();
      return PushTokenForceResyncResult.started;
    }

    if (worker.state is PushTokenSyncWorkerAbsent ||
        worker.state is PushTokenSyncWorkerDisposed) {
      return PushTokenForceResyncResult.tokenAbsent;
    }

    worker.forceResync();
    return PushTokenForceResyncResult.started;
  }

  Future<void> sync() async {
    retryFailed();
  }

  Future<void> handleAuthenticationFailure({
    required DeviceProvisioningRepository repository,
  }) async {
    await repository.clearProvisioned();
    if (ref.mounted) {
      ref.invalidate(deviceProvisioningProvider, asReload: true);
    }
  }

  Future<void> recordSyncFailure({
    required PushTokenKind kind,
    required DeviceProvisioningException error,
    required TelemetryRecorder recorder,
    required TelemetryUploader uploader,
  }) async {
    try {
      await recorder.record(
        TelemetryEvent.error(
          errorType: 'push_token_sync_failed',
          message: '${kind.name}: $error',
        ),
      );
      await uploader.flush();
    } on Exception catch (telemetryError) {
      talker.info('Failed to record telemetry', telemetryError);
    }
  }

  Future<void> disposeWorkers() async {
    if (_workersDisposed) {
      return;
    }
    _workersDisposed = true;
    for (final subscription in _workerSubscriptions) {
      await subscription.cancel();
    }
    final disposeFutures = <Future<void>>[];
    final fcmWorker = _fcmWorker;
    if (fcmWorker != null) {
      disposeFutures.add(fcmWorker.dispose());
    }
    final apnsNotificationWorker = _apnsNotificationWorker;
    if (apnsNotificationWorker != null) {
      disposeFutures.add(apnsNotificationWorker.dispose());
    }
    final apnsPushToStartWorker = _apnsPushToStartWorker;
    if (apnsPushToStartWorker != null) {
      disposeFutures.add(apnsPushToStartWorker.dispose());
    }
    await Future.wait(disposeFutures);
  }
}

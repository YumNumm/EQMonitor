import 'dart:io';

import 'package:dio/dio.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/provider/device_id.dart';
import 'package:eqmonitor/feature/devices/data/exception/device_provisioning_exception.dart';
import 'package:eqmonitor/feature/devices/data/exception/dio_exception_mapper.dart';
import 'package:eqmonitor/feature/devices/data/model/notification_token.dart';
import 'package:eqmonitor/feature/devices/data/model/push_token_sync_snapshot.dart';
import 'package:eqmonitor/feature/devices/data/notifier/device_provisioning_notifier.dart';
import 'package:eqmonitor/feature/devices/data/provider/notification_token_stream.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_provisioning_repository.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_repository.dart';
import 'package:eqmonitor/feature/devices/data/retry/retry_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'push_token_sync_notifier.g.dart';

@Riverpod(keepAlive: true)
class PushTokenSyncNotifier extends _$PushTokenSyncNotifier {
  static final syncMutation = Mutation<void>();

  late final _retryController = RetryController();
  RetryControllerState get retryState => _retryController.state;

  void reset() => _retryController.reset();

  Future<void> handleAuthenticationFailure() async {
    final repo = ref.read(deviceProvisioningRepositoryProvider);
    await repo.clearProvisioned();
    ref.invalidate(deviceProvisioningProvider, asReload: true);
  }

  @override
  Future<PushTokenSyncSnapshot> build() async {
    final repo = ref.watch(deviceProvisioningRepositoryProvider);

    // プロビジョニング前は全種 notApplicable
    if (!repo.isProvisioned()) {
      return const PushTokenSyncSnapshot(
        fcm: NotApplicableTokenState(),
        apnsNotification: NotApplicableTokenState(),
        apnsPushToStart: NotApplicableTokenState(),
      );
    }

    final tokenAsync = ref.watch(notificationTokenStreamProvider);
    return repo.computeSnapshot(tokenAsync.value);
  }

  Future<void> sync() async {
    final repo = ref.read(deviceProvisioningRepositoryProvider);
    final deviceRepo = await ref.read(deviceRepositoryProvider.future);
    final deviceId = await ref.read(deviceIdProvider.future);
    final currentState =
        state.value ??
        repo.computeSnapshot(ref.read(notificationTokenStreamProvider).value);

    await _retryController.run(() async {
      final results = <PushTokenKind, PushTokenKindState>{};
      DeviceProvisioningException? lastError;

      for (final entry in currentState.kindEntries) {
        final kind = entry.key;
        final kindState = entry.value;

        if (kindState is! PendingTokenState && kindState is! FailedTokenState) {
          results[kind] = kindState;
          continue;
        }

        final currentToken = ref.read(notificationTokenStreamProvider).value;
        final tokenValue = _tokenFor(kind, currentToken);
        if (tokenValue == null) {
          results[kind] = const AbsentTokenState();
          continue;
        }

        try {
          await _syncKind(
            kind: kind,
            token: tokenValue,
            deviceId: deviceId,
            deviceRepo: deviceRepo,
          );
          await repo.saveTokenHash(kind, tokenValue);
          results[kind] = const SyncedTokenState();
        } on DeviceProvisioningException catch (e) {
          if (e is AuthorizationException &&
              e.reason == AuthorizationFailureReason.unauthenticated) {
            await handleAuthenticationFailure();
          }
          results[kind] = FailedTokenState(error: e);
          lastError = e;
        } on DioException catch (e, st) {
          final mapped = mapDioToProvisioningException(e, st);
          if (mapped is AuthorizationException &&
              mapped.reason == AuthorizationFailureReason.unauthenticated) {
            await handleAuthenticationFailure();
          }
          results[kind] = FailedTokenState(error: mapped);
          lastError = mapped;
        } on Object catch (e, st) {
          final mapped = UnexpectedProvisioningException(
            cause: e,
            stackTrace: st,
          );
          results[kind] = FailedTokenState(error: mapped);
          lastError = mapped;
        }
      }

      state = AsyncData(
        PushTokenSyncSnapshot(
          fcm: results[PushTokenKind.fcm] ?? currentState.fcm,
          apnsNotification:
              results[PushTokenKind.apnsNotification] ??
              currentState.apnsNotification,
          apnsPushToStart:
              results[PushTokenKind.apnsPushToStart] ??
              currentState.apnsPushToStart,
        ),
      );

      if (lastError != null) {
        throw lastError;
      }
    });
  }

  Future<void> _syncKind({
    required PushTokenKind kind,
    required String token,
    required String deviceId,
    required DeviceRepository deviceRepo,
  }) async {
    if (kind != PushTokenKind.fcm &&
        (kIsWeb || !(Platform.isIOS || Platform.isMacOS))) {
      return;
    }

    final notificationToken = switch (kind) {
      PushTokenKind.fcm => NotificationToken(fcmToken: token),
      PushTokenKind.apnsNotification => NotificationToken(apnsToken: token),
      PushTokenKind.apnsPushToStart => NotificationToken(
        apnsPushToStartToken: token,
      ),
    };

    final r = await deviceRepo.syncPushTokens(
      deviceId: deviceId,
      token: notificationToken,
    );
    switch (r) {
      case Success():
        break;
      case Failure(:final exception, :final stackTrace):
        Error.throwWithStackTrace(exception, stackTrace ?? StackTrace.empty);
    }
  }

  String? _tokenFor(PushTokenKind kind, NotificationToken? token) {
    if (token == null) {
      return null;
    }
    return switch (kind) {
      PushTokenKind.fcm => token.fcmToken,
      PushTokenKind.apnsNotification => token.apnsToken,
      PushTokenKind.apnsPushToStart => token.apnsPushToStartToken,
    };
  }
}

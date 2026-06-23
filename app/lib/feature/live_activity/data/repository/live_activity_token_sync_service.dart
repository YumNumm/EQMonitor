import 'dart:async';
import 'dart:io';

import 'package:eqmonitor/core/provider/device_id.dart';
import 'package:eqmonitor/feature/devices/data/notifier/device_provisioning_notifier.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_repository.dart';
import 'package:eqmonitor/feature/live_activity/data/provider/live_activity_token_stream.dart';
import 'package:eqmonitor/feature/telemetry/data/provider/telemetry_recorder_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:telemetry_store/telemetry_store.dart';

part 'live_activity_token_sync_service.g.dart';

@Riverpod(keepAlive: true)
Future<LiveActivityTokenSyncService> liveActivityTokenSyncService(
  Ref ref,
) async {
  final repo = await ref.watch(deviceRepositoryProvider.future);
  return LiveActivityTokenSyncService(deviceRepository: repo);
}

/// iOS のみ: Live Activity update token を監視してサーバへ同期する。
/// main.dart で read することで起動時にリッスンが開始される。
@Riverpod(keepAlive: true)
Future<void> liveActivityTokenSyncWiring(Ref ref) async {
  if (kIsWeb || !Platform.isIOS) {
    return;
  }

  // プロビジョニング完了後のみ Live Activity トークン同期を開始する
  final provisionStatus = await ref.watch(
    deviceProvisioningProvider.future,
  );
  if (provisionStatus != DeviceProvisioningStatus.notRequired) {
    return;
  }

  final service = await ref.watch(liveActivityTokenSyncServiceProvider.future);
  final deviceId = await ref.watch(deviceIdProvider.future);

  ref.listen<AsyncValue<LiveActivityTokenUpdate>>(
    liveActivityPushTokenUpdatesProvider,
    (_, next) => next.whenData(
      (update) {
        unawaited(
          ref.read(telemetryRecorderProvider).record(
            TelemetryEvent.liveActivityUpdated(
              activityType: update.activityType == 'eew'
                  ? LiveActivityType.eew
                  : LiveActivityType.shakeDetection,
              activityId: update.liveActivityId,
            ),
          ),
        );
        unawaited(
          service.syncToken(
            deviceId: deviceId,
            liveActivityId: update.liveActivityId,
            token: update.token,
          ),
        );
      },
    ),
  );
}

class LiveActivityTokenSyncService {
  LiveActivityTokenSyncService({required DeviceRepository deviceRepository})
    : _repo = deviceRepository;

  final DeviceRepository _repo;

  Future<void> syncToken({
    required String deviceId,
    required String liveActivityId,
    required String token,
  }) async {
    await _repo.syncLiveActivityUpdateToken(
      deviceId: deviceId,
      liveActivityId: liveActivityId,
      token: token,
    );
  }
}

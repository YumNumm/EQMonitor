import 'dart:async';
import 'dart:io';

import 'package:eqmonitor/core/provider/device_id.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_repository.dart';
import 'package:eqmonitor/feature/live_activity/data/provider/live_activity_token_stream.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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
  final service = await ref.watch(liveActivityTokenSyncServiceProvider.future);
  final deviceId = await ref.watch(deviceIdProvider.future);

  ref.listen<AsyncValue<LiveActivityTokenUpdate>>(
    liveActivityPushTokenUpdatesProvider,
    (_, next) => next.whenData(
      (update) => unawaited(
        service.syncToken(
          deviceId: deviceId,
          liveActivityId: update.liveActivityId,
          token: update.token,
        ),
      ),
    ),
  );
}

class LiveActivityTokenSyncService {
  LiveActivityTokenSyncService({required DeviceRepository deviceRepository})
    : _repo = deviceRepository;

  final DeviceRepository _repo;
  StreamSubscription<LiveActivityTokenUpdate>? _subscription;

  void startListening({
    required String deviceId,
    required Stream<LiveActivityTokenUpdate> tokenStream,
    bool debugMode = false,
  }) {
    unawaited(_subscription?.cancel());
    _subscription = tokenStream.listen(
      (update) => unawaited(
        _onToken(deviceId: deviceId, update: update, debugMode: debugMode),
      ),
    );
  }

  Future<void> _onToken({
    required String deviceId,
    required LiveActivityTokenUpdate update,
    required bool debugMode,
  }) async {
    await syncToken(
      deviceId: deviceId,
      liveActivityId: update.liveActivityId,
      token: update.token,
    );
    if (debugMode && kDebugMode) {
      await _showDebugNotification(update);
    }
  }

  Future<void> _showDebugNotification(LiveActivityTokenUpdate update) async {
    if (!Platform.isIOS) {
      return;
    }
    const details = NotificationDetails(
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentSound: false,
      ),
    );
    await FlutterLocalNotificationsPlugin().show(
      id: update.liveActivityId.hashCode & 0x7FFFFFFF,
      title: '[Debug] LA Token Updated',
      body: '${update.activityType}: ${update.token.substring(0, 8)}…',
      notificationDetails: details,
    );
  }

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

  void dispose() {
    unawaited(_subscription?.cancel());
    _subscription = null;
  }
}

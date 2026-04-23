import 'dart:async';
import 'dart:io';

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
    _subscription?.cancel();
    _subscription = tokenStream.listen(
      (update) => _onToken(
        deviceId: deviceId,
        update: update,
        debugMode: debugMode,
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
    if (!Platform.isIOS) return;
    const details = NotificationDetails(
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentSound: false,
      ),
    );
    await FlutterLocalNotificationsPlugin().show(
      update.liveActivityId.hashCode & 0x7FFFFFFF,
      '[Debug] LA Token Updated',
      '${update.activityType}: ${update.token.substring(0, 8)}…',
      details,
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
    _subscription?.cancel();
    _subscription = null;
  }
}

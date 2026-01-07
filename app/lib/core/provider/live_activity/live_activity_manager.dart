import 'dart:async';
import 'dart:io';

import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/api/eq_api.dart';
import 'package:eqmonitor/core/provider/device_id.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:live_activities/live_activities.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'live_activity_manager.g.dart';

/// Live Activityのプロバイダー
/// iOS専用機能のため、iOSでのみ初期化される
@Riverpod(keepAlive: true)
LiveActivities liveActivities(Ref ref) {
  return LiveActivities();
}

/// Live Activity管理Provider
/// pushToStartトークンとupdateTokenの管理を行う
@Riverpod(keepAlive: true)
class LiveActivityManager extends _$LiveActivityManager {
  static const _appGroupId = 'group.net.yumnumm.eqmonitor';
  static const _urlScheme = 'eqmonitor';

  static const _nativeMethodChannel = MethodChannel(
    'eqmonitor/live_activity_observer',
  );
  static const _nativeEventChannel = EventChannel(
    'eqmonitor/live_activity_observer/events',
  );

  StreamSubscription<String>? _pushToStartTokenSubscription;
  StreamSubscription<Map<String, dynamic>>? _nativeActivityUpdateSubscription;

  @override
  Future<void> build() async {
    // iOSでのみ有効
    if (kIsWeb || !Platform.isIOS) {
      return;
    }

    final liveActivities = ref.watch(liveActivitiesProvider);

    await liveActivities.init(
      appGroupId: _appGroupId,
      urlScheme: _urlScheme,
    );

    // pushToStartトークンの監視
    await _listenToPushToStartToken(liveActivities);

    // サーバ起点のLive Activity開始/更新（push-to-start）を監視
    await _listenToNativeLiveActivityUpdates();

    ref.onDispose(() {
      _pushToStartTokenSubscription?.cancel();
      _nativeActivityUpdateSubscription?.cancel();
    });
  }

  Future<void> _listenToPushToStartToken(LiveActivities liveActivities) async {
    // iOS 17.2以上でのみpushToStartが利用可能
    final allowsPushStart = await liveActivities.allowsPushStart();
    if (!allowsPushStart) {
      talker.info('pushToStartは利用できません（iOS 17.2未満）');
      return;
    }

    _pushToStartTokenSubscription =
        liveActivities.pushToStartTokenUpdateStream.listen(
      (token) async {
        await _registerPushToStartToken(token);
      },
      onError: (Object error) {
        talker.error('pushToStartTokenの監視でエラーが発生しました', error);
      },
    );
  }

  Future<void> _listenToNativeLiveActivityUpdates() async {
    _nativeActivityUpdateSubscription = _nativeEventChannel
        .receiveBroadcastStream()
        .map((event) => Map<String, dynamic>.from(event as Map))
        .listen(
          (event) async {
            final status = event['status'] as String?;
            final activityId = event['activityId'] as String?;
            if (status == null || activityId == null) {
              talker.warning('Live Activityイベント形式が不正です: $event');
              return;
            }

            switch (status) {
              case 'active':
                final token = event['token'] as String?;
                final eventId = event['eventId'] as String?;
                final type = event['type'] as String?;
                if (token == null || eventId == null || type == null) {
                  talker.warning('Live Activity activeイベントの必須項目が不足: $event');
                  return;
                }

                final startTrigger = _startTriggerFromType(type);
                if (startTrigger == null) {
                  talker.warning('未知のLive Activity typeを受信しました: type=$type');
                  return;
                }

                await _registerUpdateToken(
                  activityId: activityId,
                  updateToken: token,
                  eventId: eventId,
                  startTrigger: startTrigger,
                );
              case 'ended':
                await _notifySessionEnded(activityId);
              case 'stale':
                talker.info('Live ActivityがStaleになりました: $activityId');
              default:
                talker.warning('不明なLive Activity更新イベントを受信しました: $event');
            }
          },
          onError: (Object error, StackTrace st) {
            talker.error('Live Activityネイティブ監視でエラーが発生しました', error, st);
          },
        );

    // 監視開始はEventChannelのonListen側で行うが、
    // 念のため明示的に開始も試みる（実装側で冪等）
    try {
      await _nativeMethodChannel.invokeMethod<void>('start');
    } on PlatformException catch (e, st) {
      talker.error('Live Activityネイティブ監視の開始に失敗しました', e, st);
    }
  }

  /// pushToStartトークンをサーバに登録
  Future<void> _registerPushToStartToken(String token) async {
    try {
      final deviceId = await ref.read(deviceIdProvider.future);
      final eqApi = ref.read(eqApiProvider);

      await eqApi.device.updateApnsToken(
        deviceId: deviceId,
        tokenType: ApnsTokenType.liveActivityStart.value,
        request: ApnsTokenRequest(token: token),
      );

      talker.info('pushToStartトークンを登録しました');
    } on Exception catch (e, st) {
      talker.error('pushToStartトークンの登録に失敗しました', e, st);
    }
  }

  /// updateTokenをサーバに登録
  Future<void> _registerUpdateToken({
    required String activityId,
    required String updateToken,
    required String eventId,
    required LiveActivityStartTrigger startTrigger,
  }) async {
    try {
      talker.info(
        'Live Activity updateToken受信: '
        'activityId=$activityId, token=${updateToken.substring(0, 8)}...',
      );

      final deviceId = await ref.read(deviceIdProvider.future);
      final eqApi = ref.read(eqApiProvider);
      await eqApi.device.registerLiveActivityToken(
        deviceId: deviceId,
        liveActivityId: activityId,
        request: LiveActivityTokenRequest(
          token: updateToken,
          eventId: eventId,
          startTrigger: startTrigger,
        ),
      );
      talker.info(
        'Live Activity updateTokenを登録しました: activityId=$activityId, eventId=$eventId, startTrigger=${startTrigger.value}',
      );
    } on Exception catch (e, st) {
      talker.error('updateTokenの登録に失敗しました', e, st);
    }
  }

  LiveActivityStartTrigger? _startTriggerFromType(String type) {
    switch (type) {
      case 'eew':
        return LiveActivityStartTrigger.eew;
      case 'shake_detection':
        return LiveActivityStartTrigger.shakeDetection;
      default:
        return null;
    }
  }

  /// Live Activityセッション終了を通知
  Future<void> _notifySessionEnded(String activityId) async {
    try {
      final deviceId = await ref.read(deviceIdProvider.future);
      final eqApi = ref.read(eqApiProvider);

      await eqApi.device.deleteLiveActivityToken(
        deviceId: deviceId,
        liveActivityId: activityId,
      );

      talker.info('Live Activityセッション終了を通知しました: $activityId');
    } on Exception catch (e, st) {
      talker.error('Live Activityセッション終了の通知に失敗しました', e, st);
    }
  }
}

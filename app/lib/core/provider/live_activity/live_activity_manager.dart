import 'dart:async';
import 'dart:io';

import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/api/eq_api.dart';
import 'package:eqmonitor/core/provider/device_id.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:flutter/foundation.dart';
import 'package:live_activities/live_activities.dart';
import 'package:live_activities/models/activity_update.dart';
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

  StreamSubscription<String>? _pushToStartTokenSubscription;
  StreamSubscription<ActivityUpdate>? _activityUpdateSubscription;

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

    // Live Activity更新の監視
    _listenToActivityUpdates(liveActivities);

    ref.onDispose(() {
      unawaited(() async {
        await _pushToStartTokenSubscription?.cancel();
        await _activityUpdateSubscription?.cancel();
      }());
    });
  }

  Future<void> _listenToPushToStartToken(LiveActivities liveActivities) async {
    // iOS 17.2以上でのみpushToStartが利用可能
    final allowsPushStart = await liveActivities.allowsPushStart();
    if (!allowsPushStart) {
      talker.info('pushToStartは利用できません（iOS 17.2未満）');
      return;
    }

    _pushToStartTokenSubscription = liveActivities.pushToStartTokenUpdateStream
        .listen(
          (token) async {
            await _registerPushToStartToken(token);
          },
          onError: (Object error) {
            talker.error('pushToStartTokenの監視でエラーが発生しました', error);
          },
        );
  }

  void _listenToActivityUpdates(LiveActivities liveActivities) {
    _activityUpdateSubscription = liveActivities.activityUpdateStream.listen(
      (event) async {
        await event.map(
          active: (activity) async {
            await _registerUpdateToken(
              activityId: activity.activityId,
              updateToken: activity.activityToken,
            );
          },
          ended: (activity) async {
            await _notifySessionEnded(activity.activityId);
          },
          stale: (activity) {
            talker.info(
              'Live ActivityがStaleになりました: ${activity.activityId}',
            );
          },
          unknown: (_) {
            talker.warning('不明なLive Activity更新イベントを受信しました');
          },
        );
      },
      onError: (Object error) {
        talker.error('Live Activity更新の監視でエラーが発生しました', error);
      },
    );
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
  ///
  /// Note: Push-to-Startで開始されたLive Activityの場合、
  /// サーバ側でactivityIdとeventId/triggerの紐付けが完了しているため、
  /// クライアント側ではactivityIdとupdateTokenのみを送信する。
  Future<void> _registerUpdateToken({
    required String activityId,
    required String updateToken,
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
        request: LiveActivityTokenRequest(token: updateToken),
      );

      talker.info('updateTokenを登録しました: activityId=$activityId');
    } on Exception catch (e, st) {
      talker.error('updateTokenの登録に失敗しました', e, st);
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

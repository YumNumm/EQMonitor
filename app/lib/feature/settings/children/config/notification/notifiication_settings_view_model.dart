import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/provider/config/notification/fcm_topic_manager.dart';
import 'package:eqmonitor/core/provider/config/permission/permission_status_provider.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notifiication_settings_view_model.freezed.dart';
part 'notifiication_settings_view_model.g.dart';

@riverpod
class NotificationSettingsViewModel extends _$NotificationSettingsViewModel {
  @override
  NotificationSettingsState build() {
    return _init(
      subscribedFcmTopics: ref.watch(fcmTopicManagerProvider),
      isNotificationPermissionAllowed:
          ref.watch(permissionProvider.select((v) => v.notification)),
    );
  }

  NotificationSettingsState _init({
    required List<String> subscribedFcmTopics,
    required bool isNotificationPermissionAllowed,
  }) {
    final vzse40Topic = FcmBasicTopic(FcmTopics.vzse40);
    final noticeTopic = FcmBasicTopic(FcmTopics.notice);
    return NotificationSettingsState(
      isNotificatioonPermissionAllowed: isNotificationPermissionAllowed,
      isVzse40Subscribed: subscribedFcmTopics.contains(vzse40Topic.topic),
      isNoticeSubscribed: subscribedFcmTopics.contains(noticeTopic.topic),
    );
  }

  Future<Result<void, Exception>> registerToVzse40() async {
    final topicNotifier = ref.read(fcmTopicManagerProvider.notifier);
    // 既に登録済みの場合は何もしない
    if (state.isVzse40Subscribed) {
      return  Result.success(null);
    }
    final result = await topicNotifier.registerToTopic(
      FcmBasicTopic(FcmTopics.vzse40),
    );
    if (result case Success()) {
      state = state.copyWith(isVzse40Subscribed: true);
    }
    return result;
  }

  Future<Result<void, Exception>> unregisterFromVzse40() async {
    final topicNotifier = ref.read(fcmTopicManagerProvider.notifier);
    // 登録されていない場合は何もしない
    if (!state.isVzse40Subscribed) {
      return  Result.success(null);
    }
    final result = await topicNotifier.unregisterFromTopic(
      FcmBasicTopic(FcmTopics.vzse40),
    );
    if (result case Success()) {
      state = state.copyWith(isVzse40Subscribed: false);
    }
    return result;
  }

  Future<Result<void, Exception>> registerToNotice() async {
    final topicNotifier = ref.read(fcmTopicManagerProvider.notifier);
    // 既に登録済みの場合は何もしない
    if (state.isNoticeSubscribed) {
      return  Result.success(null);
    }
    final result = await topicNotifier.registerToTopic(
      FcmBasicTopic(FcmTopics.notice),
    );
    if (result case Success()) {
      state = state.copyWith(isNoticeSubscribed: true);
    }
    return result;
  }

  Future<Result<void, Exception>> unregisterFromNotice() async {
    final topicNotifier = ref.read(fcmTopicManagerProvider.notifier);
    // 登録されていない場合は何もしない
    if (!state.isNoticeSubscribed) {
      return  Result.success(null);
    }
    final result = await topicNotifier.unregisterFromTopic(
      FcmBasicTopic(FcmTopics.notice),
    );
    if (result case Success()) {
      state = state.copyWith(isNoticeSubscribed: false);
    }
    return result;
  }
}

@freezed
class NotificationSettingsState with _$NotificationSettingsState {
   factory NotificationSettingsState({
    required bool isNotificatioonPermissionAllowed,

    /// 地震・津波に関するお知らせ
    required bool isVzse40Subscribed,

    /// お知らせ
    required bool isNoticeSubscribed,
  }) = _NotificationSettingsState;

  factory NotificationSettingsState.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$NotificationSettingsStateFromJson(json);
}

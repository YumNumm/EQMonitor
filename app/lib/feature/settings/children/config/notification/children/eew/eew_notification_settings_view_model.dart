import 'package:collection/collection.dart';
import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/provider/config/notification/fcm_topic_manager.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'eew_notification_settings_view_model.g.dart';

@riverpod
class EewNotificationsSettingsViewModel
    extends _$EewNotificationsSettingsViewModel {
  @override
  FcmEewTopic? build() {
    ref.listen(fcmTopicManagerProvider, (_, next) => _checkTopic(next));

    return _checkTopic(ref.read(fcmTopicManagerProvider));
  }

  FcmEewTopic? _checkTopic(List<String> fcmTopics) {
    final matchedTopic = choices.firstWhereOrNull(
      (e) => fcmTopics.contains(e.topic),
    );
    return matchedTopic;
  }

  Future<Result<void, Exception>> registerToTopic(
    FcmEewTopic topic,
  ) async {
    final result = await (
      ref.read(fcmTopicManagerProvider.notifier).registerToTopic(topic),
      state != null
          ? ref
              .read(fcmTopicManagerProvider.notifier)
              .unregisterFromTopic(state!)
          : Future<void>.value(),
    ).wait;
    if (result.$1 case Success()) {
      state = topic;
    }
    return result.$1;
  }

  Future<Result<void, Exception>> unregisterFromTopic() async {
    if (state == null) {
      return  Result.success(null);
    }
    final result = await ref
        .read(fcmTopicManagerProvider.notifier)
        .unregisterFromTopic(state!);
    if (result case Success()) {
      state = null;
    }
    return result;
  }

  static List<FcmEewTopic> choices = [
    const FcmEewAllTopic(),
    ...([...JmaIntensity.values]..remove(JmaIntensity.fiveUpperNoInput)).map(
      FcmEewIntensityTopic.new,
    ),
  ];
}

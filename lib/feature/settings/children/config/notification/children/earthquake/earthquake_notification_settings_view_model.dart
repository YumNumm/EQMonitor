import 'package:collection/collection.dart';
import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/provider/config/notification/fcm_topic_manager.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'earthquake_notification_settings_view_model.g.dart';

@riverpod
class EarthquakeNotificationSettingsViewModel
    extends _$EarthquakeNotificationSettingsViewModel {
  @override
  FcmEarthquakeTopic? build() {
    ref.listen(fcmTopicManagerProvider, (_, next) => _checkTopic(next));
    return _checkTopic(ref.read(fcmTopicManagerProvider));
  }

  FcmEarthquakeTopic _checkTopic(List<String> fcmTopics) {
    final matchedTopic = choices.firstWhereOrNull(
      (e) => fcmTopics.contains(e.topic),
    );
    return matchedTopic ?? const FcmEarthquakeTopic(null);
  }

  Future<Result<void, Exception>> registerToTopic(
    FcmEarthquakeTopic topic,
  ) async {
    final result = await (
      ref.read(fcmTopicManagerProvider.notifier).registerToTopic(topic),
      state != null
          ? ref
              .read(fcmTopicManagerProvider.notifier)
              .unregisterFromTopic(state!)
          : Future<void>.value(),
    ).wait;
    if (result.$1.isSuccess) {
      state = topic;
    }
    return result.$1;
  }

  Future<Result<void, Exception>> unregisterFromTopic() async {
    if (state == null) {
      return const Result.success(null);
    }
    final result = await ref
        .read(fcmTopicManagerProvider.notifier)
        .unregisterFromTopic(state!);
    if (result.isSuccess) {
      state = null;
    }
    return result;
  }

  static List<FcmEarthquakeTopic> choices = [
    const FcmEarthquakeTopic(null),
    ...([...JmaIntensity.values]..remove(JmaIntensity.fiveUpperNoInput)).map(
      FcmEarthquakeTopic.new,
    ),
  ];
}

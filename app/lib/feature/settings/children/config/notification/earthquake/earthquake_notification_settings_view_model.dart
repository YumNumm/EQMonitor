import 'package:collection/collection.dart';
import 'package:eqapi_types/eqapi_types.dart';
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

  FcmEarthquakeTopic? _checkTopic(List<String> fcmTopics) {
    final matchedTopic = choices.firstWhereOrNull(
      (e) => fcmTopics.contains(e.topic),
    );
    return matchedTopic;
  }

  static List<FcmEarthquakeTopic> choices = [
    const FcmEarthquakeTopic(null),
    ...([...JmaIntensity.values]..remove(JmaIntensity.fiveUpperNoInput)).map(
      FcmEarthquakeTopic.new,
    ),
  ];
}

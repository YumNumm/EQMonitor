import 'package:collection/collection.dart';
import 'package:eqapi_types/eqapi_types.dart';
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

  static List<FcmEewTopic> choices = [
    const FcmEewAllTopic(),
    ...([...JmaIntensity.values]..remove(JmaIntensity.fiveUpperNoInput)).map(
      FcmEewIntensityTopic.new,
    ),
  ];
}

import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_sound.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_sound_selection.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/custom_notification_sounds_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_sound_options.g.dart';

@riverpod
List<NotificationSoundSelection> notificationSoundOptions(Ref ref) => [
  for (final sound in NotificationSound.values)
    NotificationSoundSelection.builtin(sound),
  for (final sound in ref.watch(customNotificationSoundsProvider).value ?? [])
    NotificationSoundSelection.custom(sound),
];

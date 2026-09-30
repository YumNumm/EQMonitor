import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/custom_notification_sound.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_sound.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_sound_selection.freezed.dart';

@freezed
sealed class NotificationSoundSelection with _$NotificationSoundSelection {
  const factory builtin(NotificationSound sound) =
      BuiltinNotificationSoundSelection;
  const factory custom(CustomNotificationSound sound) =
      CustomNotificationSoundSelection;
  const factory unavailable(String apiValue) =
      UnavailableNotificationSoundSelection;
}

extension NotificationSoundSelectionValue on NotificationSoundSelection {
  String get apiValue => switch (this) {
    BuiltinNotificationSoundSelection(:final sound) => sound.apiValue,
    CustomNotificationSoundSelection(:final sound) => sound.fileName,
    UnavailableNotificationSoundSelection(:final apiValue) => apiValue,
  };

  String get displayName => switch (this) {
    BuiltinNotificationSoundSelection(:final sound) => sound.displayName,
    CustomNotificationSoundSelection(:final sound) =>
      sound.isAvailable
          ? sound.displayName
          : '${sound.displayName}（ファイルが見つかりません）',
    UnavailableNotificationSoundSelection() => 'ファイルが見つかりません',
  };

  bool get isAvailable => switch (this) {
    BuiltinNotificationSoundSelection() => true,
    CustomNotificationSoundSelection(:final sound) => sound.isAvailable,
    UnavailableNotificationSoundSelection() => false,
  };
}

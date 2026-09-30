import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_override.dart';

enum NotificationKind {
  eew,
  earthquake;

  String get label => switch (this) {
    .eew => '緊急地震速報(予報)',
    .earthquake => '地震情報',
  };

  List<InterruptionLevel> get interruptionLevels => switch (this) {
    .eew => InterruptionLevel.values,
    .earthquake => const [.passive, .active, .timeSensitive],
  };

  String get collapseNotificationDescription => switch (this) {
    .eew => '緊急地震速報の続報が発表された時に、前の通知を上書きします',
    .earthquake => '同じ地震の新しい地震情報が発表された時に、前の通知を上書きします',
  };
}

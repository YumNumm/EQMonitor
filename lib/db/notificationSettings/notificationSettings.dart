import 'package:get/get.dart';
import 'package:hive/hive.dart';

part 'notificationSettings.g.dart';

@HiveType(typeId: 1)
class NotificationSettingsState {
  /// すべて通知するかどうか
  @HiveField(0)
  final bool notifAll;

  /// 第1報を通知するかどうか
  @HiveField(1)
  final bool notifFirstReport;

  /// 最終報を通知するかどうか;
  @HiveField(2)
  final bool notifLastReport;

  /// マグニチュードもしくは、震度が修正された際に通知
  @HiveField(3)
  final bool notifOnUpdate;

  /// マグニチュードもしくは、震度が上方修正された際に通知
  @HiveField(4)
  final bool notifOnUpwardUpdate;

  NotificationSettingsState({
    required this.notifAll,
    required this.notifFirstReport,
    required this.notifLastReport,
    required this.notifOnUpdate,
    required this.notifOnUpwardUpdate,
  });
}

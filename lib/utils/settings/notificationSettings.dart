import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserNotificationSettings extends GetxController {
  final SharedPreferences prefs = Get.find<SharedPreferences>();
  late NotificationSettingsState state;
  @override
  Future<UserNotificationSettings> onInit() async {
    final all = prefs.getBool('notifAll') ?? false;
    final firstReport = prefs.getBool('notifFirstReport') ?? true;
    final lastReport = prefs.getBool('notifLastReport') ?? true;
    final onUpdate = prefs.getBool('notifOnUpdate') ?? false;
    final onUpwardUpdate = prefs.getBool('notifOnUpwardUpdate') ?? false;
    state = NotificationSettingsState(
      notifAll: all.obs,
      notifFirstReport: firstReport.obs,
      notifLastReport: lastReport.obs,
      notifOnUpdate: onUpdate.obs,
      notifOnUpwardUpdate: onUpwardUpdate.obs,
    );
    await save();
    super.onInit();
    return this;
  }

  Future<void> save() async {
    await prefs.setBool("notifAll", state.notifAll.value);
    await prefs.setBool('notifFirstReport', state.notifFirstReport.value);
    await prefs.setBool('notifLastReport', state.notifLastReport.value);
    await prefs.setBool('notifOnUpdate', state.notifOnUpdate.value);
    await prefs.setBool('notifOnUpwardUpdate', state.notifOnUpwardUpdate.value);
  }
}

class NotificationSettingsState {
  /// すべて通知するかどうか
  final RxBool notifAll;

  /// 第1報を通知するかどうか
  final RxBool notifFirstReport;

  /// 最終報を通知するかどうか;
  final RxBool notifLastReport;

  /// マグニチュードもしくは、震度が修正された際に通知
  final RxBool notifOnUpdate;

  /// マグニチュードもしくは、震度が上方修正された際に通知
  final RxBool notifOnUpwardUpdate;
  NotificationSettingsState({
    required this.notifAll,
    required this.notifFirstReport,
    required this.notifLastReport,
    required this.notifOnUpdate,
    required this.notifOnUpwardUpdate,
  });
}

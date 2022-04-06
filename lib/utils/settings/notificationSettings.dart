import 'package:eqmonitor/db/notificationSettings/notificationSettings.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';

class UserNotificationSettings extends GetxController {
  final box = Get.find<Box<NotificationSettingsState?>>();
  final logger = Get.find<Logger>();
  late NotificationSettingsState state;

  //
  final RxBool notifAll = false.obs;
  final RxBool notifFirstReport = true.obs;
  final RxBool notifLastReport = true.obs;
  final RxBool notifOnUpdate = false.obs;
  final RxBool notifOnUpwardUpdate = false.obs;
  @override
  Future<UserNotificationSettings> onInit() async {
    if (box.isEmpty) {
      // 空っぽなので初期化する
      await box.put(
        'recent',
        NotificationSettingsState(
          notifAll: false,
          notifFirstReport: true,
          notifLastReport: true,
          notifOnUpdate: false,
          notifOnUpwardUpdate: false,
        ),
      );
    }
    state = box.get('recent')!;
    // 更新
    notifAll.value = state.notifAll;
    notifFirstReport.value = state.notifFirstReport;
    notifLastReport.value = state.notifLastReport;
    notifOnUpdate.value = state.notifOnUpdate;
    notifOnUpwardUpdate.value = state.notifOnUpwardUpdate;
    logger.d(
      'Notification Settings: ${notifAll.value},${notifFirstReport.value},${notifLastReport.value},${notifOnUpdate.value},${notifOnUpwardUpdate.value}',
    );
    super.onInit();
    return this;
  }

  Future<void> save() async {
    await box.put(
      'recent',
      NotificationSettingsState(
        notifAll: notifAll.value,
        notifFirstReport: notifFirstReport.value,
        notifLastReport: notifLastReport.value,
        notifOnUpdate: notifOnUpdate.value,
        notifOnUpwardUpdate: notifOnUpwardUpdate.value,
      ),
    );
    logger.d(
      'Notification Settings: ${notifAll.value},${notifFirstReport.value},${notifLastReport.value},${notifOnUpdate.value},${notifOnUpwardUpdate.value}',
    );
  }
}

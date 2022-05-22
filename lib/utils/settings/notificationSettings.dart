import 'package:eqmonitor/db/notificationSettings/notificationSettings.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class UserNotificationSettings extends GetxController {
  final logger = Get.find<Logger>();
  final fss = Get.find<FlutterSecureStorage>();
  late NotificationSettingsState state;

  //
  final RxBool notifAll = false.obs;
  final RxBool notifFirstReport = true.obs;
  final RxBool notifLastReport = true.obs;
  final RxBool notifOnUpdate = false.obs;
  final RxBool notifOnUpwardUpdate = false.obs;
  final RxBool useTTS = true.obs;

  @override
  Future<UserNotificationSettings> onInit() async {
    state = NotificationSettingsState.fromJson(await fss.readAll());
    // 更新
    notifAll.value = state.notifAll;
    notifFirstReport.value = state.notifFirstReport;
    notifLastReport.value = state.notifLastReport;
    notifOnUpdate.value = state.notifOnUpdate;
    notifOnUpwardUpdate.value = state.notifOnUpwardUpdate;
    useTTS.value = state.useTTS;
    //Stream
    notifAll.stream.listen((bool b) {
      if (b) {
        notifFirstReport.value = notifLastReport.value =
            notifOnUpdate.value = notifOnUpwardUpdate.value = true;
      }
    });
    await save();
    super.onInit();
    return this;
  }

  Future<void> save() async {
    await fss.write(key: 'notifAll', value: notifAll.value.toString());
    await fss.write(
      key: 'notifFirstReport',
      value: notifFirstReport.value.toString(),
    );
    await fss.write(
      key: 'notifLastReport',
      value: notifLastReport.value.toString(),
    );
    await fss.write(
      key: 'notifOnUpdate',
      value: notifOnUpdate.value.toString(),
    );
    await fss.write(
      key: 'notifOnUpwardUpdate',
      value: notifOnUpwardUpdate.value.toString(),
    );
    await fss.write(
      key: 'useTTS',
      value: useTTS.value.toString(),
    );
    logger.d(
      'Notification Settings: ${notifAll.value},${notifFirstReport.value},${notifLastReport.value},${notifOnUpdate.value},${notifOnUpwardUpdate.value},${useTTS.value}',
    );
  }
}

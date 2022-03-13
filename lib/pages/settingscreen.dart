import 'package:eqmonitor/pages/settings/notificationSettings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../pages/settings/aboutApp.dart';
import '../utils/auth.dart';
import 'settings/accountSettingPage.dart';
import 'settings/top.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({Key? key}) : super(key: key);
  final par = Get.parameters['page'];
  final AuthStateUtils authStateUtils = Get.find<AuthStateUtils>();
  final Logger logger = Get.find<Logger>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('設定'),
      ),
      body: (par == null)
          ? topSettingPage()
          : IndexedStack(
              index: int.parse(par!),
              children: <Widget>[
                // Account Setting
                const Obx(accountSettingPage),
                // Notification
                notificationSettings(context),
                //About
                aboutThisApp(context),
              ],
            ),
    );
  }
}

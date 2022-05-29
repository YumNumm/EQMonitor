import 'dart:convert';

import 'package:eqmonitor/private/keys.dart';
import 'package:eqmonitor/utils/updater/updateAPI.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppUpdate extends GetxController {
  final PackageInfo packageInfo = Get.find<PackageInfo>();
  final Logger logger = Get.find<Logger>();
  final RxBool hasUpdate = false.obs;
  final RxBool hasError = false.obs;
  late UpdateAPI updateApi;
  @override
  Future<void> onInit() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(hours: 1),
      ),
    );
    await remoteConfig.fetchAndActivate();
    final resData = UpdateAPI.fromJson(
      json.decode(remoteConfig.getString('version')) as Map<String, dynamic>,
    );
    if (int.parse(packageInfo.buildNumber) < resData.buildNum && !kDebugMode) {
      updateApi = resData;
      hasUpdate.value = true;
    }
    super.onInit();
  }
}

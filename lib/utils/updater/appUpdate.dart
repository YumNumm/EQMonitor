import 'dart:convert';

import 'package:eqmonitor/private/keys.dart';
import 'package:eqmonitor/utils/updater/updateAPI.dart';
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
    const url = '$baseUrl/app-status.json';
    final res = await http.get(Uri.parse(url)).onError((error, stackTrace) {
      hasError.value = true;
      logger.e(error, stackTrace);
      throw stackTrace;
    });
    if (res.statusCode != 200) {
      hasError.value = true;
      return;
    }
    logger.i(res.body);
    final resData = UpdateAPI.fromJson(
      json.decode(utf8.decode(res.bodyBytes)) as Map<String, dynamic>,
    );
    if (int.parse(packageInfo.buildNumber) < resData.buildNum && !kDebugMode) {
      updateApi = resData;
      hasUpdate.value = true;
    }
    super.onInit();
  }
}

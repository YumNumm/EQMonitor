import 'dart:convert';

import 'package:eqmonitor/private/keys.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../../schemas/eqmonitor_api/history.dart';
import '../../schemas/eqmonitor_api/history_content.dart';

class HistoryLib extends GetxController {
  final Logger logger = Get.find<Logger>();
  final RxList<HistoryContent> content = <HistoryContent>[].obs;
  final RxBool hasError = false.obs;
  final RxString message = '取得待ち'.obs;

  @override
  Future<void> onInit() async {
    await fetch();
    super.onInit();
  }

  Future<void> fetch() async {
    final res = await http.get(Uri.parse('$baseUrl/history/history.json'));
    if (res.statusCode != 200) {
      logger.i(res.body);
      return;
    }
    final his = History.fromJson(
      jsonDecode(utf8.decode(res.bodyBytes)) as Map<String, dynamic>,
    );
    logger.i(his.contents);
    content.value = his.contents;
  }
}

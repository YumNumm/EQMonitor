import 'dart:convert';

import 'package:eqmonitor/private/keys.dart';
import 'package:eqmonitor/utils/EQMonitorApi/history.dart';
import 'package:eqmonitor/utils/EQMonitorApi/history_content.dart';
import 'package:eqmonitor/utils/eq_history/eq_history_content.dart';
import 'package:get/get.dart';
import 'package:home_widget/home_widget.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

import 'eq_history.dart';

class EqHistoryLib extends GetxController {
  final Logger logger = Get.find<Logger>();
  final RxList<EqHistoryContent> content = <EqHistoryContent>[].obs;
  final RxBool hasError = false.obs;
  final RxString message = '取得待ち'.obs;

  @override
  Future<void> onInit() async {
    await fetch();
    super.onInit();
  }

  Future<void> fetch() async {
    final res = await http.get(Uri.parse('$baseUrl/eqhistory/history.json'));
    if (res.statusCode != 200) {
      logger.i(res.body);
      return;
    }
    final his = EqHistory.fromJson(
      jsonDecode(utf8.decode(res.bodyBytes)) as Map<String, dynamic>,
    );
    content.value = his.contents;

    // Widgetの更新
    final latest = his.contents[0];
    await HomeWidget.saveWidgetData<String>("max_intensity", latest.maxint);
     await HomeWidget.saveWidgetData<String>('place', latest.hypoName);
    await HomeWidget.saveWidgetData<String>(
      'magnitude',
      'M${latest.magnitude}',
    );
    await HomeWidget.saveWidgetData<String>(
      'time',
      DateFormat('yyyy/MM/dd HH:mm頃').format(latest.publishedDate),
    );
    await HomeWidget.updateWidget(
      androidName: 'latestwidget',
    );
  }
}

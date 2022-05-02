import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

/// 強震モニター内での最新時刻を管理
class KyoshinMonitorlibTime extends GetxController {
  final Logger logger = Get.find<Logger>();

  /// NIEDの現在時刻
  Rx<DateTime> now = DateTime(2000).obs;

  /// NIEDと時刻を同期するまでのカウンター
  RxInt timeUpdateCounter = 0.obs;

  /// ## 強震モニタでの最新時刻を取得する。
  Future<DateTime> generateNowTime() async {
    try {
      if (timeUpdateCounter.value <= 0) {
        final res = await http.get(
          Uri.parse(
            'http://www.kmoni.bosai.go.jp/webservice/server/pros/latest.json',
          ),
        );
        if (res.statusCode != 200) {}
        final df = DateFormat('yyyy/MM/dd hh:mm:ss');
        final j =
            json.decode(utf8.decode(res.bodyBytes)) as Map<String, dynamic>;
        final dt = df.parseStrict(j['latest_time'].toString());
        now.value = dt;
        timeUpdateCounter.value = 3;
        return dt;
      } else {
        timeUpdateCounter.value--;
        now.value = now.value.add(const Duration(seconds: 1));
        return now.value;
      }
    } catch (e) {
      logger.w('[${e.toString()}] 最新時刻の取得に失敗しました。');
      return DateTime.now();
    }
  }
}

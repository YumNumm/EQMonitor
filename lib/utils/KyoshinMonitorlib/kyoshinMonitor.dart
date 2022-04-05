// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:eqmonitor/utils/KyoshinMonitorlib/UrlGenerator/LpgmWebApiUrlGenerator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

/// ## 強震モニタ関連のclass

class KyoshinMonitorlib extends GetxController {
  @override
  Future<void> onInit() async {
    super.onInit();
  }
}

/// 強震モニター内での最新時刻を管理
class KyoshinMonitorlibTime extends GetxController {
  Rx<DateTime> now = DateTime(2000).obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    now.value = await generateNowTime();
  }

  /// ## 強震モニタでの最新時刻を取得する。
  Future<DateTime> generateNowTime() async {
    final res = await http.get(
      Uri.parse(
        'http://www.kmoni.bosai.go.jp/webservice/server/pros/latest.json',
      ),
    );
    if (res.statusCode != 200) {
      throw Exception('[${res.statusCode}] 最新時刻の取得に失敗しました。');
    }
    final df = DateFormat('yyyy/MM/dd hh:mm:ss');
    final j = json.decode(utf8.decode(res.bodyBytes)) as Map<String, dynamic>;
    final dt = df.parseStrict(j['latest_time'].toString());
    return dt;
  }
}

/// 強震モニターのURLを生成する
/// [`KyoshinMonitorLib.UrlGenerator`](https://github.com/ingen084/KyoshinMonitorLib/blob/master/src/KyoshinMonitorLib/UrlGenerator/RealTimeDataType.cs)
class KyoshinMonitorlibUrlGenerator {


}


/// ## abgrColor -> argbColorにする
int _abgrToArgb(int argbColor) {
  final r = (argbColor >> 16) & 0xFF;
  final b = argbColor & 0xFF;
  return (argbColor & 0xFF00FF00) | (b << 16) | r;
}

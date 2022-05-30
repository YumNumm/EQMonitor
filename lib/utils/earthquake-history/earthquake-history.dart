import 'dart:convert';

import 'package:eqmonitor/private/keys.dart';
import 'package:eqmonitor/utils/KyoshinMonitorlib/JmaIntensity.dart';
import 'package:eqmonitor/utils/earthquake-history/schema/telegram.dart';
import 'package:get/get.dart';
import 'package:home_widget/home_widget.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

/// 地震履歴を管理・取得する
class EarthQuakeHistory extends GetxController {
  final Logger logger = Get.find<Logger>();
  // 取得した電文のリスト
  final RxList<Schema> telegrams = <Schema>[].obs;
  // 取得した電文のうちVXSE53のリスト
  final RxList<Schema> vxse53Telegrams = <Schema>[].obs;
  // サーバにある電文の総数
  final RxInt maxItemCount = 0.obs;
  // 表示したい震度のリスト
  final RxList<JmaIntensity> selectedMaxIntensity = JmaIntensity.values.obs;

  @override
  Future<EarthQuakeHistory> onInit() async {
    // 電文リストが更新された際に自動で条件を満たしたものをVXSE53Listへ転送する

    // アイテム数を取得
    super.onInit();
    final itemCountResponse =
        await http.get(Uri.parse('$baseUrl/eqhistory/total.txt'));
    maxItemCount.value = int.parse(itemCountResponse.body);

    // 0個目を取得する
    final firstItemsResponse =
        await http.get(Uri.parse('$baseUrl/eqhistory/0.json'));
    final parsedFirstItems =
        jsonDecode(utf8.decode(firstItemsResponse.bodyBytes)) as List<dynamic>;
    telegrams.clear();
    vxse53Telegrams.clear();
    for (final element in parsedFirstItems) {
      final schema = Schema.fromJson(element as Map<String, dynamic>);
      telegrams.add(schema);
      if (selectedMaxIntensity.contains(schema.toMaxIntensity)) {
        vxse53Telegrams.add(schema);
      }
    }

    // HomeWidgetの更新
    final latest = telegrams.firstWhere((element) => element.type == 'VXSE53');
    await HomeWidget.saveWidgetData<String>(
      'max_intensity',
      latest.maxint ?? '不明',
    );
    await HomeWidget.saveWidgetData<String>('place', latest.hypoName ?? '不明');
    await HomeWidget.saveWidgetData<String>(
      'magnitude',
      (latest.magnitude != null)
          ? 'M${latest.magnitude!}'
          : latest.magnitudeCondition ?? '不明',
    );
    await HomeWidget.saveWidgetData(
      'time',
      DateFormat('yyyy/MM/dd HH:mm頃').format(latest.time.toLocal()),
    );

    logger.i('Earthquake-history: GET ${telegrams.length}');
    return this;
  }

  ///次のデータがある場合に読み込む
  Future<void> getMoreData() async {
    final beforeGetdataVXSE53Length = vxse53Telegrams.length;
    final itemCountResponse =
        await http.get(Uri.parse('$baseUrl/eqhistory/total.txt'));
    maxItemCount.value = int.parse(itemCountResponse.body);
    logger.i('${maxItemCount.value}, ${telegrams.length}');
    if (maxItemCount.value != telegrams.length) {
      // 更新可能
      final firstItemsResponse = await http
          .get(Uri.parse('$baseUrl/eqhistory/${telegrams.length ~/ 100}.json'));
      final parsedFirstItems =
          jsonDecode(utf8.decode(firstItemsResponse.bodyBytes))
              as List<dynamic>;
      for (final element in parsedFirstItems) {
        final schema = Schema.fromJson(element as Map<String, dynamic>);
        telegrams.add(schema);
        if (schema.type == 'VXSE53') {
          if (selectedMaxIntensity.contains(schema.toMaxIntensity)) {
            vxse53Telegrams.add(schema);
          }
        }
      }
    } else {
      return;
    }
    if (beforeGetdataVXSE53Length == vxse53Telegrams.length) {
      await getMoreData();
    }
  }

  void setMaxIntensity() {
    final tmp = <Schema>[];
    for (final tel in telegrams) {
      if (tel.type == 'VXSE53') {
        if (selectedMaxIntensity.contains(tel.toMaxIntensity)) {
          tmp.add(tel);
        }
      }
    }
    vxse53Telegrams.value = tmp;
  }
}

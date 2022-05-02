import 'dart:developer' as dev;

import 'package:home_widget/home_widget.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:workmanager/workmanager.dart';

import '../eqlog.dart';

Future<void> updateEQLog() async {
  try {
    const url = 'https://typhoon.yahoo.co.jp/weather/jp/earthquake/list/';
    final res = await http.get(Uri.parse(url));
    if (res.statusCode != 200) {
      return;
    }
    final doc = parse(res.body);
    final result = doc.querySelectorAll(
      '#main > .yjw_main_md > #eqhist > table > tbody > tr',
    );
    final eqTemp = <EQLog>[];
    for (final e in result) {
      final temp = <String>[];
      for (final el in e.children) {
        temp.add(el.text);
      }
      try {
        eqTemp.add(EQLog.fromList(temp));
      } catch (_) {}
    }
    await HomeWidget.saveWidgetData<String>(
      'max_intensity',
      eqTemp[0].maxIntensity,
    );
    await HomeWidget.saveWidgetData<String>('place', eqTemp[0].place);
    await HomeWidget.saveWidgetData<String>(
      'magnitude',
      'M${eqTemp[0].magunitude}',
    );
    await HomeWidget.saveWidgetData<String>(
      'time',
      //DateFormat('yyyy/MM/dd HH:mm頃').format(eqTemp[0].time),
      DateFormat('yyyy/MM/dd HH:mm頃').format(DateTime.now()),
    );
    await HomeWidget.updateWidget(
      androidName: 'latestwidget',
    );
  } catch (e) {
    dev.log('', error: e);
  }
}

void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    if (taskName == 'updateWidget') {
      await updateEQLog();
      return true;
    }
    return false;
  });
}

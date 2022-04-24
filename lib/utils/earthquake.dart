// ignore_for_file: library_prefixes

import 'dart:async';
import 'dart:convert';

import 'package:eqmonitor/const/obspoints.dart';
import 'package:eqmonitor/utils/KyoshinMonitorlib/ApiResult/EEW.dart';
import 'package:eqmonitor/utils/KyoshinMonitorlib/UrlGenerator/RealTimeDataType.dart';
import 'package:eqmonitor/utils/KyoshinMonitorlib/UrlGenerator/WebApiUrlGenerators.dart';
import 'package:eqmonitor/utils/KyoshinMonitorlib/imageParser/jmaParser.dart';
import 'package:eqmonitor/utils/KyoshinMonitorlib/kyoshinMonitorlibTime.dart';
import 'package:eqmonitor/utils/map/customZoomPanBehavior.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_widget/home_widget.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:ntp/ntp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

import './eqlog.dart';
import 'analyzedpoints.dart';

class EarthQuake extends GetxController {
  final Logger logger = Get.find<Logger>();
  final SharedPreferences prefs = Get.find<SharedPreferences>();
  final WebApiUrlGenerator webApiUrlGenerator = WebApiUrlGenerator();
  final KyoshinMonitorlibTime kyoshinMonitorlibTime =
      Get.find<KyoshinMonitorlibTime>();
  final JmaImageParser jmaImageParser = JmaImageParser();

  final RxInt offset = 0.obs;
  final RxInt numberOfAnalyzedPoint = 0.obs;
  final RxString url = ''.obs;
  late Timer timer;
  late Timer timer2;
  late Timer timer3;
  final RxList<AnalyzedPoint> analyzedPoint = <AnalyzedPoint>[].obs;
  final RxDouble zoomLevel = 1.0.obs;
  final RxList<EQLog> eqLog = <EQLog>[].obs;
  final RxDouble iconSize = 3.6.obs;
  final RxString lastUpdateTimeString = '更新待ち'.obs;
  final MapShapeLayerController mapShapeLayerController =
      MapShapeLayerController();
  final MapZoomPanBehavior mapZoomPanBehavior = CustomZoomPanBehavior()
    ..enableDoubleTapZooming
    ..maxZoomLevel = 50;
  final RxString msg = '緊急地震速報は発表されていません'.obs;
  final df = DateFormat('yyyyMMdd/yyyyMMddHHmmss');

  @override
  Future<void> onInit() async {
    super.onInit();
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) async => await kyoshinMonitorlibTime.generateNowTime(),
    );
    // 仮で空っぽの観測点を配置しておく
    for (final obsPoint in OBSPoints) {
      analyzedPoint.add(
        AnalyzedPoint(
          code: obsPoint.code,
          name: obsPoint.name,
          pref: obsPoint.pref,
          lat: obsPoint.lat,
          lon: obsPoint.lon,
          x: obsPoint.x,
          y: obsPoint.y,
          color: const Color(0x00FFFFFF),
          shindo: null,
          zoomLevel: zoomLevel.value,
        ),
      );
    }
    // NTPから正しい時間を取得する
    final startDate = DateTime.now().toLocal();
    try {
      offset.value = await NTP.getNtpOffset(localTime: startDate);
    } catch (e) {
      logger.w(e.toString());
    }

    Timer.periodic(
      const Duration(milliseconds: 1000),
      (_) async => updateEQData(),
    );
    Timer.periodic(const Duration(milliseconds: 250), (_) async {
      iconSize.value = mapZoomPanBehavior.zoomLevel * 0.6 + 3;
      jmaImageParser.zoomLevel.value =
          zoomLevel.value = mapZoomPanBehavior.zoomLevel;
    });
    timer3 = Timer.periodic(
      const Duration(
        seconds: 30,
      ),
      (_) => updateEQLog(),
    );
    await updateEQLog();
    await Get.offAllNamed<void>('/');

    await updateEQData();
  }

  Future<void> updateEQData() async {
    try {
      final res = await http.get(
        Uri.parse(
          webApiUrlGenerator.JsonEewBase(kyoshinMonitorlibTime.now.value),
        ),
      );
      final kyoshinEEW =
          KyoshinEEW.fromJson(jsonDecode(res.body) as Map<String, dynamic>);
      if (kyoshinEEW.result.hasData) {
        msg.value =
            '緊急地震速報(第${kyoshinEEW.reportNum})報 ${(kyoshinEEW.reportTime != null) ? df.format(kyoshinEEW.reportTime!) : ""}\n'
            'マグニチュード${kyoshinEEW.magnitude}\n'
            '深さ${kyoshinEEW.depth}\n'
            '${kyoshinEEW.regionName}で地震';

        logger.i(msg.value);
      } else {}
    } catch (e) {
      logger.e(e);
    }
    // PGA Update
    try {
      final res = await http.get(
        Uri.parse(
          webApiUrlGenerator.RealtimeBase(
            dt: kyoshinMonitorlibTime.now.value,
            type: RealtimeDataType.Shindo,
            sorb: 's',
          ),
        ),
      );
      if (res.statusCode != 200) {
        logger.wtf('リアルタイム震度の画像を取得できませんでした。(status: ${res.statusCode})');
      }
      analyzedPoint.value =
          jmaImageParser.imageParser(bodyBytes: res.bodyBytes);
      mapShapeLayerController.updateMarkers(
        List<int>.generate(analyzedPoint.length, (i) => i),
      );
      lastUpdateTimeString.value = DateFormat('yyyy/MM/dd HH:mm:ss')
          .format(kyoshinMonitorlibTime.now.value);
      numberOfAnalyzedPoint.value =
          analyzedPoint.where((p0) => p0.shindo != null).length;
    } catch (e) {
      logger.w(e);
      analyzedPoint.value = jmaImageParser.imageParser(bodyBytes: []);
      mapShapeLayerController.updateMarkers(
        List<int>.generate(analyzedPoint.length, (i) => i),
      );
      lastUpdateTimeString.value = DateFormat('yyyy/MM/dd HH:mm:ss')
          .format(kyoshinMonitorlibTime.now.value);
      numberOfAnalyzedPoint.value = 0;
    }
  }

  Future<void> updateEQLog() async {
    try {
      const url = 'https://typhoon.yahoo.co.jp/weather/jp/earthquake/list/';
      final res = await http.get(Uri.parse(url));
      if (res.statusCode != 200) {
        print('ERROR');
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
        DateFormat('yyyy/MM/dd HH:mm頃').format(eqTemp[0].time),
      );
      await HomeWidget.updateWidget(
        androidName: 'latestwidget',
      );
      eqLog.value = eqTemp;
    } catch (e) {
      logger.e(e);
    }
  }
}

class OBSPoint {
  final String code;
  final String name;
  final String pref;
  final double lat;
  final double lon;
  final int x;
  final int y;
  OBSPoint({
    required this.code,
    required this.name,
    required this.pref,
    required this.lat,
    required this.lon,
    required this.x,
    required this.y,
  });

  OBSPoint.fromList(List<dynamic> lis)
      : code = lis[0].toString(),
        name = lis[1].toString(),
        pref = lis[2].toString(),
        lat = double.parse(lis[3].toString()),
        lon = double.parse(lis[4].toString()),
        x = int.parse(lis[5].toString()),
        y = int.parse(lis[6].toString());
}

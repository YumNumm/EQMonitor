// ignore_for_file: library_prefixes

import 'dart:async';

import 'package:eqmonitor/const/obspoints.dart';
import 'package:eqmonitor/utils/KyoshinMonitorlib/UrlGenerator/RealTimeDataType.dart';
import 'package:eqmonitor/utils/KyoshinMonitorlib/UrlGenerator/WebApiUrlGenerators.dart';
import 'package:eqmonitor/utils/KyoshinMonitorlib/imageParser/jmaParser.dart';
import 'package:eqmonitor/utils/KyoshinMonitorlib/kyoshinMonitorlibTime.dart';
import 'package:eqmonitor/utils/map/customZoomPanBehavior.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

import 'analyzedpoints.dart';

class EarthQuake extends GetxController {
  final Logger logger = Get.find<Logger>();
  final SharedPreferences prefs = Get.find<SharedPreferences>();
  final WebApiUrlGenerator webApiUrlGenerator = WebApiUrlGenerator();
  final KyoshinMonitorlibTime kyoshinMonitorlibTime =
      Get.find<KyoshinMonitorlibTime>();

  final JmaImageParser jmaImageParser = JmaImageParser();

  final RxInt numberOfAnalyzedPoint = 0.obs;
  final RxString url = ''.obs;
  final RxList<AnalyzedPoint> analyzedPoint = <AnalyzedPoint>[].obs;
  final RxDouble zoomLevel = 1.0.obs;
  final RxDouble iconSize = 3.6.obs;
  final RxString lastUpdateTimeString = '更新待ち'.obs;
  final MapShapeLayerController mapShapeLayerController =
      MapShapeLayerController();
  final MapZoomPanBehavior mapZoomPanBehavior = CustomZoomPanBehavior()
    ..enableDoubleTapZooming
    ..maxZoomLevel = 50;
  final df = DateFormat('yyyyMMdd/yyyyMMddHHmmss');

  /// 震度かPGAか
  final showShindo = true.obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    Timer.periodic(
      const Duration(milliseconds: 1000),
      (timer) async => kyoshinMonitorlibTime.generateNowTime(),
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
          shindoColor: const Color(0x00FFFFFF),
          pgaColor: const Color(0x00FFFFFF),
          shindo: null,
          zoomLevel: zoomLevel.value,
          pga: null,
        ),
      );
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
    await Future<void>.delayed(const Duration(milliseconds: 1000));
    await Get.offAllNamed<void>('/');

    await updateEQData();
  }

  Future<void> updateEQData() async {
    // PGA Update
    try {
      final shindoPic = await http.get(
        Uri.parse(
          webApiUrlGenerator.RealtimeBase(
            dt: kyoshinMonitorlibTime.now.value,
            type: RealtimeDataType.Shindo,
            sorb: 's',
          ),
        ),
      );
      final pgaPic = await http.get(
        Uri.parse(
          webApiUrlGenerator.RealtimeBase(
            dt: kyoshinMonitorlibTime.now.value,
            type: RealtimeDataType.Pga,
            sorb: 's',
          ),
        ),
      );
      if (shindoPic.statusCode != 200) {
        logger.wtf('リアルタイム震度の画像を取得できませんでした。(status: ${shindoPic.statusCode})');
      }
      if (pgaPic.statusCode != 200) {
        logger.wtf('PGAの取得に失敗');
      }
      analyzedPoint.value = jmaImageParser.imageParser(
        shindoPic: shindoPic.bodyBytes,
        pgaPic: pgaPic.bodyBytes,
      );
      mapShapeLayerController.updateMarkers(
        List<int>.generate(analyzedPoint.length, (i) => i),
      );
      lastUpdateTimeString.value = DateFormat('yyyy/MM/dd HH:mm:ss')
          .format(kyoshinMonitorlibTime.now.value);
      numberOfAnalyzedPoint.value =
          analyzedPoint.where((p0) => p0.shindo != null).length;
    } catch (e) {
      logger.w(e);
      analyzedPoint.value =
          jmaImageParser.imageParser(pgaPic: [], shindoPic: []);
      mapShapeLayerController.updateMarkers(
        List<int>.generate(analyzedPoint.length, (i) => i),
      );
      lastUpdateTimeString.value = DateFormat('yyyy/MM/dd HH:mm:ss')
          .format(kyoshinMonitorlibTime.now.value);
      numberOfAnalyzedPoint.value = 0;
    }
  }

  /*Future<void> updateEQLog() async {
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
  }*/
}

class OBSPoint {
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

  final String code;
  final String name;
  final String pref;
  final double lat;
  final double lon;
  final int x;
  final int y;
}

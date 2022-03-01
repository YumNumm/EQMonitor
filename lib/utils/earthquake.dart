// ignore_for_file: library_prefixes

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as Image;
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:ntp/ntp.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

import './eqlog.dart';
import '../const/const.dart';
import '../const/obspoints.dart';
import '../utils/jsonParser/APIResponse.dart';
import 'analyzedpoints.dart';
import 'map.dart';

class EarthQuake extends GetxController {
  final Logger logger = Get.find<Logger>();
  final MapData mapData = Get.find<MapData>();
  final RxInt offset = 0.obs;
  final RxString url = ''.obs;
  late Timer timer;
  late Timer timer2;
  late Timer timer3;
  final RxInt diffSec = 0.obs;
  final RxList<AnalyzedPoint> analyzedPoint = <AnalyzedPoint>[].obs;
  final RxBool widgetLoaded = false.obs;
  final RxDouble zoomLevel = 1.0.obs;
  final RxList<EQLog> eqLog = <EQLog>[].obs;
  double iconSize = 10;
  final RxString lastUpdateTimeString = '更新待ち'.obs;
  final MapShapeLayerController mapShapeLayerController =
      MapShapeLayerController();
  final SolidController solidController = SolidController();
  final MapZoomPanBehavior mapZoomPanBehavior = MapZoomPanBehavior(
    maxZoomLevel: 60,
    enablePanning: true,
    enablePinching: true,
  );
  @override
  Future<void> onInit() async {
    super.onInit();
    mapZoomPanBehavior.zoomLevel = zoomLevel.value;
    // NTPから正しい時間を取得する
    final startDate = DateTime.now().toLocal();
    offset.value = await NTP.getNtpOffset(localTime: startDate);

    timer = Timer.periodic(const Duration(milliseconds: 1000), (_) async {
      await updateEQData();
    });
    timer3 = Timer.periodic(
      const Duration(
        seconds: 30,
      ),
      (_) => updateEQLog(),
    );
    await updateEQLog();
    await updateEQData();
    //! 気持ち待機(これ待ち時間調節しないとね)
    //await Future<void>.delayed(const Duration(milliseconds: 3500));
    timer2 = Timer.periodic(const Duration(milliseconds: 250), (_) async {
      iconSize = mapZoomPanBehavior.zoomLevel * 0.6 + 3;
      zoomLevel.value = mapZoomPanBehavior.zoomLevel;
    });

    await Get.offAllNamed<void>('/');
  }

  int _abgrToArgb(int argbColor) {
    final r = (argbColor >> 16) & 0xFF;
    final b = argbColor & 0xFF;
    return (argbColor & 0xFF00FF00) | (b << 16) | r;
  }

  Future<void> updateEQData() async {
    final now = DateTime.now().toLocal().add(
          Duration(
            milliseconds: offset.value,
            seconds: -2,
          ),
        );
    {
      final df = DateFormat('yyyyMMddHHmmss');

      final res = await http.get(
        Uri.parse(
          'http://www.kmoni.bosai.go.jp/webservice/hypo/eew/${df.format(now)}.json',
        ),
      );
      //'http://www.kmoni.bosai.go.jp/webservice/hypo/eew/20220220195006.json'));

      final jsonres = jsonDecode(res.body) as Map<String, dynamic>;
      if (jsonres['result']['message'] == 'データがありません') {
        // 平常運転なり
        //final parsedResponse = NormalApiResponse.fromJson(jsonres);
        //logger.i(parsedResponse.result.message);
      } else {
        //なんかあった
        final pres = EEWApiResponse.fromJson(jsonres); //? Parsed Response
        final msg =
            '[これはテスト!!!]\n緊急地震速報(${pres.alertFlg}) ${pres.reportTime}\nマグニチュード${pres.magunitude}\n深さ${pres.depth}\n${pres.regionName}で地震';
        logger.i(msg);
      }
    }
    // PGA Update
    {
      final df = DateFormat('yyyyMMdd/yyyyMMddHHmmss');
      final res = await http.get(
        Uri.parse(
          'http://www.kmoni.bosai.go.jp/data/map_img/RealTimeImg/jma_s/${df.format(now)}.jma_s.gif',
        ),
      );
      if (res.statusCode != 200) {
        logger.wtf('*Web API Error* ${res.statusCode}');
        return;
      }
      final image = Image.decodeGif(res.bodyBytes);
      if (image == null) {
        logger.wtf('Image was Null!!');
        return;
      }
      //画像解析開始
      // 仮に入れておくAnalyzedPointたち
      final temp = <AnalyzedPoint>[];
      //logger.w(OBSPoints.length);
      zoomLevel.value = mapZoomPanBehavior.zoomLevel;
      //logger.d(zoomLevel.value);
      for (final OBSPoint in OBSPoints) {
        //logger.d('${OBSPoint.x},${OBSPoint.y}');
        final pixel32 = image.getPixelSafe(OBSPoint.x, OBSPoint.y);
        //print(pixel32);
        // 16進数のカラーコード
        final hex = _abgrToArgb(pixel32).toRadixString(16);
        // hex[0,1] = a, [2,3] = r, [4,5] = g, [6.7] =b
        if (hex == '0') {
          continue;
        } else {
          final r = int.parse(hex[2] + hex[3], radix: 16);
          final g = int.parse(hex[4] + hex[5], radix: 16);
          final b = int.parse(hex[6] + hex[7], radix: 16);
          //logger.d('$r,$g,$b');
          final tofind = <int>[r, g, b];
          //? 色を探索
          colorMap.forEach((key, value) {
            if (key[0] == tofind[0] &&
                key[1] == tofind[1] &&
                key[2] == tofind[2]) {
              //logger.d('FIND! $value');
              //OBSPoint.shindo = value;
              temp.add(
                AnalyzedPoint(
                  code: OBSPoint.code,
                  name: OBSPoint.name,
                  pref: OBSPoint.pref,
                  lat: OBSPoint.lat,
                  lon: OBSPoint.lon,
                  x: OBSPoint.x,
                  y: OBSPoint.y,
                  color: Color.fromRGBO(r, g, b, 1),
                  shindo: value,
                  zoomLevel: zoomLevel.value,
                ),
              );
            }
          });
        }
      }
      analyzedPoint.value = temp;
      // Widgetは読み込み終わってるかを確認してから更新!
      try {
        mapShapeLayerController.updateMarkers(
          List<int>.generate(analyzedPoint.length - 1, (i) => i + 1),
        );
      } catch (e) {}
      lastUpdateTimeString.value =
          '最終更新: ${DateFormat('yyyy/MM/dd HH:mm:ss').format(now)}';
    }
  }

  Future<void> updateEQLog() async {
    const url = 'https://typhoon.yahoo.co.jp/weather/jp/earthquake/list/';
    final target = Uri.parse(url);

    final res = await http.get(target);
    if (res.statusCode != 200) {
      print('ERROR');
      return;
    }
    final doc = parse(res.body);
    final result = doc.querySelectorAll(
      '#main > .yjw_main_md > #eqhist > table > tbody > tr',
    );
    var counter = 0;
    var eqTemp = <EQLog>[];
    for (final e in result) {
      if (counter == 0) {
        counter++;
        continue;
      }
      final temp = <String>[];
      for (final el in e.children) {
        temp.add(el.text);
      }
      eqTemp.add(EQLog.fromList(temp));
    }
    eqLog.value = eqTemp;
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

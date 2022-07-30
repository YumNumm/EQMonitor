import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:csv/csv.dart';
import 'package:eqmonitor/api/kmoni.dart';
import 'package:eqmonitor/api/kmoni/kmoni_image_parser.dart';
import 'package:eqmonitor/api/kmoni/kmoni_web_api_url_generators.dart';
import 'package:eqmonitor/const/kmoni/real_time_data_type.dart';
import 'package:eqmonitor/const/obspoint.dart';
import 'package:eqmonitor/model/kmoni_model.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../model/analyzed_point_model.dart';

class KmoniController extends StateNotifier<KmoniModel> {
  KmoniController()
      : super(
          KmoniModel(
            analyzedPoint: [],
            lastUpdated: null,
            lastUpdateAttempt: DateTime.now(),
            updateFrequency: const Duration(seconds: 1),
            obsPoints: [],
            isKansokutenLoaded: false,
            updateTimer: null,
            isUpdating: false,
          ),
        );

  final logger = Logger();
  late Timer updateTimer;

  final KyoshinMonitorApi kyoshinMonitorApi = KyoshinMonitorApi();
  final KyoshinWebApiUrlGenerator kyoshinWebApiUrlGenerator =
      KyoshinWebApiUrlGenerator();
  final KyoshinImageParser kyoshinImageParser = KyoshinImageParser();

  // Kmoniからデータを取得するタイマーを開始
  void onInit() {
    if (!state.isKansokutenLoaded) {
      /// 観測点CSVの読み込み
      _loadKansokuten();
      // タイマーを開始

        state = state.copyWith(
          updateTimer: Timer.periodic(state.updateFrequency, (timer) {
            if (mounted) {
              _onTimer(timer);
            }
          }),
        );
      
    }
  }

  Future<void> _onTimer(Timer timer) async {
    // 更新中でないことを確認
    if (state.isUpdating) {
      log('Kmoni is updating. skip.', name: 'KMoniTimer');
      return;
    }
    // 更新中フラグを立てる
    state = state.copyWith(isUpdating: true);
    // Kmoniの最新時刻を取得
    final dt = await kyoshinMonitorApi.getLatestDateTime();
    await updateShindo(dt);
    // 更新中フラグを下ろす
    state = state.copyWith(isUpdating: false);
  }

  Future<void> updateShindo(DateTime dt) async {
    // Shindo画像を取得する
    final shindoUrl = kyoshinWebApiUrlGenerator.realtimeBase(
      dt: dt,
      type: RealtimeDataType.Shindo,
      sorb: 's',
    );
    final imageResponse = await kyoshinMonitorApi
        .getRawData(shindoUrl.replaceAll('http://www.kmoni.bosai.go.jp', ''));
    // log(imageResponse.realUri.toString(), name: "KmoniController");
    if (imageResponse.statusCode != 200 || imageResponse.data == null) {
      throw Exception(
        'リアルタイム震度画像の取得に失敗しました\n'
        'StatusCode: ${imageResponse.statusCode}',
      );
    }
    final parsedAnalyzedPoint = kyoshinImageParser.imageParse(
      picture: imageResponse.data!,
      obsPoints: state.obsPoints,
      type: RealtimeDataType.Shindo,
    );
    final analyzedPoint = state.analyzedPoint;
    final newAnalyzedPoint = <AnalyzedPoint>[];
    for (var i = 0; i < analyzedPoint.length; i++) {
      newAnalyzedPoint.add(
        analyzedPoint[i].copyWith(
          shindo: parsedAnalyzedPoint[i].shindo,
          shindoColor: parsedAnalyzedPoint[i].shindoColor,
          hadValue:
              parsedAnalyzedPoint[i].hadValue || analyzedPoint[i].hadValue,
        ),
      );
    }
    state = state.copyWith(
      analyzedPoint: newAnalyzedPoint,
      lastUpdated: dt,
      lastUpdateAttempt: DateTime.now(),
    );
  }

  /// 観測点CSVを読み込む
  Future<void> _loadKansokuten() async {
    final kansokutenFile = await rootBundle.load('assets/kmoni/kansokuten.csv');
    final rowsAsListOfValues = const CsvToListConverter().convert(
      utf8.decode(kansokutenFile.buffer.asUint8List()),
    );
    final obsPoints = <ObsPoint>[];
    for (final row in rowsAsListOfValues) {
      if (row[7].toString() == '') {
        continue;
      }
      obsPoints.add(ObsPoint.fromList(row));
    }
    if (mounted) {
      state = state.copyWith(
        obsPoints: obsPoints,
        isKansokutenLoaded: true,
        analyzedPoint: obsPoints
            .map(
              (e) => AnalyzedPoint(
                code: e.code,
                name: e.name,
                hadValue: false,
                intensity: null,
                lat: e.lat,
                lon: e.lon,
                pga: null,
                pgaColor: null,
                prefectureName: e.pref,
                shindo: null,
                shindoColor: null,
              ),
            )
            .toList(),
      );
      logger.i('観測点データを読み込みました: ${state.obsPoints.length}');
    }
  }
}

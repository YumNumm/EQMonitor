import 'dart:async';
import 'dart:convert';

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
            loadDuration: null,
          ),
        ) {
    onInit();
  }

  final logger = Logger(
    printer: PrettyPrinter(
      methodCount: 1,
      printTime: true,
    ),
  );

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
        updateTimer: Timer.periodic(state.updateFrequency, _onTimer),
      );
    }
  }

  Future<void> _onTimer(Timer timer) async {
    if (!mounted) {
      return;
    }
    // 更新中でないことを確認
    if (state.isUpdating) {
      logger.v(
        '現在読み込み中の強震モニタ画像があるため、新規取得をスキップします。',
      );
      return;
    }
    // 更新中フラグを立てる
    state = state.copyWith(isUpdating: true);
    try {
      // Kmoniの最新時刻を取得
      final dt = await kyoshinMonitorApi.getLatestDateTime();
      await updateShindo(dt);
    } on Exception catch (e) {
      logger.e(e);
    } finally {
      // 更新中フラグを下ろす
      state = state.copyWith(
        isUpdating: false,
        lastUpdateAttempt: DateTime.now(),
      );
    }
  }

  Future<void> updateShindo(DateTime dt) async {
    try {
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
      );
    } on Exception {}
  }

  /// 観測点CSVを読み込む
  Future<void> _loadKansokuten() async {
    final stopwatch = Stopwatch()..start();
    final kansokutenFile = await rootBundle.load('assets/kmoni/kansokuten.csv');
    final rowsAsListOfValues = const CsvToListConverter().convert(
      utf8.decode(kansokutenFile.buffer.asUint8List()),
    );
    final obsPoints = <ObsPoint>[];
    for (final row in rowsAsListOfValues) {
      obsPoints.add(ObsPoint.fromList(row));
    }
    stopwatch.stop();
    logger.d('観測点データを読み込みました: ${stopwatch.elapsedMicroseconds / 1000}ms');

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
        loadDuration: stopwatch.elapsed,
      );
    }
  }
}

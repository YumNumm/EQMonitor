import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../api/kmoni.dart';
import '../api/kmoni/kmoni_image_parser.dart';
import '../api/kmoni/kmoni_web_api_url_generators.dart';
import '../const/kmoni/real_time_data_type.dart';
import '../model/kmoni_model.dart';
import 'app_lifecycle.dart';
import 'init/kyoshin_kansokuten.dart';

final kmoniProvider = StateNotifierProvider<KmoniProvider, KmoniModel>(
  KmoniProvider.new,
);

class KmoniProvider extends StateNotifier<KmoniModel> {
  KmoniProvider(this.ref)
      : super(
          KmoniModel(
            analyzedPoint: [],
            lastUpdated: null,
            lastUpdateAttempt: DateTime.now(),
            updateFrequency: const Duration(seconds: 1),
            updateTimer: null,
            isUpdating: false,
            testCaseStartTime: null,
          ),
        ) {
    onInit();
  }

  final Ref ref;

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
    state = state.copyWith(
      updateTimer: Timer.periodic(state.updateFrequency, _onTimer),
    );
  }

  Future<void> _onTimer(Timer timer) async {
    if (!mounted) {
      return;
    }
    // バックグラウンドの場合処理しない
    if (ref.read(appLifecycleProvider) == AppLifecycleState.paused) {
      return;
    }
    // テストケースの場合の処理
    if (state.testCaseStartTime != null) {
      try {
        // 開始時刻と現在時刻の差分 + 2022/06/20 10:31:10
        final dt = DateTime.parse('2022-06-20T10:31:35')
            .add(DateTime.now().difference(state.testCaseStartTime!));
        final assetUrl = KyoshinWebApiUrlGenerator.realtimeBase(
          dt: dt,
          type: RealtimeDataType.Shindo,
          sorb: 's',
        ).replaceAll(
          'http://www.kmoni.bosai.go.jp/data/map_img/RealTimeImg/jma_s/20220620/',
          'assets/develop/06301031/jma_s/',
        );

        final data = (await rootBundle.load(assetUrl)).buffer.asUint8List();
        final parsedAnalyzedPoint = kyoshinImageParser.imageParse(
          picture: data,
          obsPoints: ref.read(kyoshinKansokutenProvider),
          type: RealtimeDataType.Shindo,
        );
        state = state.copyWith(
          analyzedPoint: parsedAnalyzedPoint,
          lastUpdated: dt,
        );
      } catch (_) {
        // テストケースを終了する
        state = state.copyWith(
          testCaseStartTime: null,
        );
      }
      return;
    }
    // 更新中でないことを確認
    if (state.isUpdating) {
      // logger.v(
      //   '現在読み込み中の強震モニタ画像があるため、新規取得をスキップします。',
      // );
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
      final shindoUrl = KyoshinWebApiUrlGenerator.realtimeBase(
        dt: dt,
        type: RealtimeDataType.Shindo,
        sorb: 's',
      );
      final imageResponse = await kyoshinMonitorApi
          .getRawData(shindoUrl.replaceAll('http://www.kmoni.bosai.go.jp', ''));
      if (imageResponse.statusCode != 200 || imageResponse.data == null) {
        throw Exception(
          'リアルタイム震度画像の取得に失敗しました\n'
          'StatusCode: ${imageResponse.statusCode}',
        );
      }
      final parsedAnalyzedPoint = kyoshinImageParser.imageParse(
        picture: imageResponse.data!,
        obsPoints: ref.read(kyoshinKansokutenProvider),
        type: RealtimeDataType.Shindo,
      );

      state = state.copyWith(
        analyzedPoint: parsedAnalyzedPoint,
        lastUpdated: dt,
      );
    } on Exception {
      logger.e(
        'リアルタイム震度画像の取得に失敗しました',
      );
    }
  }

  void startTestCase() {
    // 時刻設定
    state = state.copyWith(
      testCaseStartTime: DateTime.now(),
    );
  }
}

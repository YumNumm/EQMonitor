import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../api/kmoni.dart';
import '../api/kmoni/kmoni_image_parser.dart';
import '../api/kmoni/kmoni_web_api_url_generators.dart';
import '../const/kmoni/real_time_data_type.dart';
import '../model/kmoni_model.dart';
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
      // log(imageResponse.realUri.toString(), name: "KmoniProvider");
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
}

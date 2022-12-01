import 'dart:async';
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:dmdata_telegram_json/dmdata_telegram_json.dart';
import '../../api/remote/supabase/eew.dart';
import '../init/talker.dart';
import '../telegram_service.dart';
import '../../schema/remote/kmoni/EEW.dart';
import '../../utils/talker_log/log_types.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../model/earthquake/eew_history_model.dart';

final eewProvider =
    StateNotifierProvider<EewProvider, EewHistoryModel>(EewProvider.new);

class EewProvider extends StateNotifier<EewHistoryModel> {
  EewProvider(this.ref)
      : super(
          const EewHistoryModel(
            showEews: <EewTelegram>[],
          ),
        ) {
    talker = ref.watch(talkerProvider);
    eewStream = ref.watch(eewTelegramStreamProvider);
    _onInit();
  }

  final Ref ref;
  late Talker talker;
  late AsyncValue<EewTelegram> eewStream;
  final EewApi api = EewApi();

  final Map<int, List<EewTelegram>> _eews = <int, List<EewTelegram>>{};

  DateTime? _onTestCaseStarted;

  Future<void> _onInit() async {
    // eewStreamのlistenを開始
    eewStream.whenData(_addEewTelegram);

    // 過去の緊急地震速報を取得
    final pastEews = await api.getEewTelegrams(limit: 5);

    // _eewsに追加
    // keyはEventID
    // 既にListがある場合はそれに追加
    // ない場合は新規作成
    pastEews.forEach(_addEewTelegram);

    // デバッグモードの場合はテスト電文を読み込む
    if (kDebugMode) {
      await loadDmdataEewTestPayload();
    }

    // 表示電文更新タイマーを開始
    Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateShowEews();
    });
  }

  void _addEewTelegram(EewTelegram eew) {
    final eventId = int.parse(eew.head.eventId.toString());
    if (_eews.containsKey(eventId)) {
      _eews[eventId]!.add(eew);
    } else {
      _eews[eventId] = <EewTelegram>[eew];
      // 情報の発表時刻が新しい順に並び変える
      _eews[eventId]!.sort(
        (a, b) => a.head.reportDateTime.compareTo(b.head.reportDateTime),
      );
    }

    // 緊急地震速報の表示リストを更新
    _updateShowEews();
  }

  /// 緊急地震速報の表示リストを更新
  void _updateShowEews() {
    final now = DateTime.now();
    final showEews = <EewTelegram>[];
    for (final eews in _eews.values) {
      final eew = eews.first;
      final originTime = eew.eew.earthquake?.originTime ??
          eew.eew.earthquake?.arrivalTime ??
          eew.head.reportDateTime;
      // 深発地震かどうか(深さが150km以上かどうか)
      final isDeep = (eew.eew.earthquake?.hypocenter.depth.value ?? 0) > 150;
      // 深発地震の場合は200秒、それ以外は150秒以内のものを表示リストにする
      final diff = now.difference(originTime).inSeconds;
      if (isDeep && diff < 200 ||
          !isDeep && diff < 150 ||
          eew.head.originalId == 'TELEGRAM_ID') {
        showEews.add(eew);
      }
    }
    if (!state.showEews.equals(showEews)) {
      state = state.copyWith(showEews: showEews);
      talker.logTyped(
        EewProviderLog(
          '緊急地震速報表示リストを更新しました。'
          '${state.showEews.length}件 '
          '${state.showEews.hashCode}',
        ),
      );
    }
  }

  /// DMDATAのEEWテスト電文を読み込む
  Future<void> loadDmdataEewTestPayload() async {
    const url = 'https://sample.dmdata.jp/eew/tech566/vxse45_1105_2.json';

    final payload = await Dio().get<dynamic>(url);
    final data =
        TelegramJsonMain.fromJson(payload.data as Map<String, dynamic>);
    final tmp = EewTelegram(
      data,
      EewInformation.fromJson(data.body),
    );

    _addEewTelegram(tmp);
  }

  void startTestcase() {
    // 時刻設定
    _onTestCaseStarted = DateTime.now();
    clearTelegrams();

    // Handlerを開始
    Timer.periodic(
      const Duration(milliseconds: 1000),
      (timer) async {
        if (_onTestCaseStarted == null) {
          timer.cancel();
        }
        final dt = DateTime.parse('2022-06-20T10:31:35')
            .add(DateTime.now().difference(_onTestCaseStarted!));
        final assetUrl =
            "assets/develop/06301031/eew/${DateFormat('yyyyMMddHHmmss').format(dt)}.json";
        try {
          final data = jsonDecode(await rootBundle.loadString(assetUrl));
          final eew = KyoshinEEW.fromJson(data).toDmdataEew(isTesting: true);
          if (eew != null) {
            _addEewTelegram(
              EewTelegram(eew, EewInformation.fromJson(eew.body)),
            );
          }
          // ignore: avoid_catches_without_on_clauses
        } catch (e) {
          talker.info('強震モニタのテストを終了しました');
          // テストケースを終了する
          clearTelegrams();
          timer.cancel();
        }
      },
    );
  }

  /// テスト用のEEWを新規作成
  int addTestEew({
    DateTime? arrivalTime,
    EewAccuracy? accuracy,
    required EewIntensityForecastMaxInt maxint,
    bool isLastInfo = false,
    bool isCanceled = false,
    bool isWarning = false,
    DateTime? originTime,
    bool isAssuming = false,
    String hypoName = 'テスト震源地',
    double lat = 35,
    double lon = 135,
    int? depth,
    EewDepthCondition? depthCondition,
    double? magnitude,
    EarthquakeComponentMagnitudeCondition? magnitudeCondition,
    int eventId = 0,
    int serialNo = 1,
  }) {
    throw UnimplementedError();
    //final eew = EEWInformation(
    //  isLastInfo: isLastInfo,
    //  isCanceled: isCanceled,
    //  isWarning: isWarning,
    //  zones: [],
    //  prefectures: [],
    //  regions: [],
    //  earthQuake: EarthQuake(
    //    originTime: originTime ?? DateTime.now(),
    //    arrivalTime: arrivalTime ?? DateTime.now(),
    //    isAssuming: isAssuming,
    //    hypoCenter: HypoCenter(
    //      name: hypoName,
    //      code: 100,
    //      coordinateComponent: CoordinateComponent(
    //        latitude: Latitude(text: lat.toString(), value: lat),
    //        longitude: Longitude(text: lon.toString(), value: lon),
    //        height: Height(type: '高さ', unit: 'm', value: 0),
    //        geodeticSystem: GeodeticSystem.japaneseGeodeticSystem,
    //        condition: null,
    //      ),
    //      depth: Depth(
    //        type: '深さ',
    //        unit: 'km',
    //        value: depth,
    //        condition: depthCondition,
    //      ),
    //      reduce: Reduce(code: 0, name: ''),
    //      landOrSea: '内陸',
    //      accuracy: accuracy ??
    //          Accuracy(
    //            depthCalculation: DepthCalculation.f1,
    //            epicCenterAccuracy: EpicCenters(
    //              epicCenterAccuracy: EpicCenterAccuracy.f1,
    //              hypoCenterAccuracy: HypoCenterAccuracy.f1,
    //            ),
    //            magnitudeCalculation: MagnitudeCalculation.f2,
    //            numberOfMagnitudeCalculation: NumberOfMagnitudeCalculation.f1,
    //          ),
    //    ),
    //    magnitude: Magnitude(
    //      type: 'マグニチュード',
    //      unit: 'M',
    //      value: magnitude,
    //      condition: magnitudeCondition,
    //    ),
    //  ),
    //  intensity: Intensity(
    //    maxint: maxint,
    //    forecastMaxLpgmInt: null,
    //    appendix: null,
    //    region: [],
    //  ),
    //  text: null,
    //  comments: Comments(
    //    free: 'これはアプリ内で生成されたテスト電文です',
    //    warning: Warning(
    //      codes: [],
    //      text: 'これはアプリ内で生成されたテスト電文です',
    //    ),
    //  ),
    //);
    //final commonHead = CommonHead(
    //  body: eew.toJson(),
    //  editoralOffice: 'テスト',
    //  eventId: eventId.toString(),
    //  headline: 'テスト電文',
    //  infoKind: 'eew-test',
    //  infoKindVersion: '1.0',
    //  infoType: CommonHeadInfoType.announcement,
    //  originalId: 'TELEGRAM_ID',
    //  pressDateTime: DateTime.now(),
    //  publishingOffice: ['テスト'],
    //  reportDateTime: DateTime.now(),
    //  schema: CommonHeadSchema(type: 'eew-test', version: '1.0'),
    //  serialNo: serialNo.toString(),
    //  status: CommonHeadStatus.training,
    //  targetDateTime: DateTime.now(),
    //  targetDateTimeDubious: '',
    //  targetDuration: null,
    //  title: '緊急地震速報テスト',
    //  type: '',
    //  validDateTime: null,
    //);
    //addTelegram(commonHead);
    //return commonHead.hashCode;
  }

  void clearTelegrams() => _eews.clear();
}

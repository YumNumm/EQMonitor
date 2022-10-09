import 'dart:async';
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:eqmonitor/api/remote/supabase/eew.dart';
import 'package:eqmonitor/schema/remote/dmdata/commonHeader.dart';
import 'package:eqmonitor/schema/remote/dmdata/eew-information/comments.dart';
import 'package:eqmonitor/schema/remote/dmdata/eew-information/earthquake.dart';
import 'package:eqmonitor/schema/remote/dmdata/eew-information/earthquake/accuracy.dart';
import 'package:eqmonitor/schema/remote/dmdata/eew-information/earthquake/accuracy/depth_calculation.dart';
import 'package:eqmonitor/schema/remote/dmdata/eew-information/earthquake/accuracy/epicCenterAccuracy.dart';
import 'package:eqmonitor/schema/remote/dmdata/eew-information/earthquake/accuracy/magnitude_calculation.dart';
import 'package:eqmonitor/schema/remote/dmdata/eew-information/earthquake/accuracy/number_of_magnitude_calculation.dart';
import 'package:eqmonitor/schema/remote/dmdata/eew-information/earthquake/depth.dart';
import 'package:eqmonitor/schema/remote/dmdata/eew-information/earthquake/hypocenter.dart';
import 'package:eqmonitor/schema/remote/dmdata/eew-information/earthquake/reduce.dart';
import 'package:eqmonitor/schema/remote/dmdata/eew-information/eew-infomation.dart';
import 'package:eqmonitor/schema/remote/dmdata/eew-information/intensity/forecast_max_int.dart';
import 'package:eqmonitor/schema/remote/dmdata/eew-information/intensity/intensity.dart';
import 'package:eqmonitor/schema/remote/dmdata/eq-information/earthquake-information/hypocenter/coordinate_component.dart';
import 'package:eqmonitor/schema/remote/dmdata/eq-information/earthquake-information/hypocenter/coordinate_component/geodetic_system.dart';
import 'package:eqmonitor/schema/remote/dmdata/eq-information/earthquake-information/hypocenter/coordinate_component/height.dart';
import 'package:eqmonitor/schema/remote/dmdata/eq-information/earthquake-information/hypocenter/coordinate_component/latitude.dart';
import 'package:eqmonitor/schema/remote/dmdata/eq-information/earthquake-information/hypocenter/coordinate_component/longitude.dart';
import 'package:eqmonitor/schema/remote/dmdata/eq-information/earthquake-information/hypocenter/depth/depth_condition.dart';
import 'package:eqmonitor/schema/remote/dmdata/eq-information/earthquake-information/magnitude.dart';
import 'package:eqmonitor/schema/remote/dmdata/eq-information/earthquake-information/magnitude/magnitude_condition.dart';
import 'package:eqmonitor/schema/remote/kmoni/EEW.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../model/earthquake/eew_history_model.dart';
import '../../private/keys.dart';

final eewHistoryProvider =
    StateNotifierProvider<EewHistoryProvider, EewHistoryModel>((ref) {
  return EewHistoryProvider();
});

class EewHistoryProvider extends StateNotifier<EewHistoryModel> {
  EewHistoryProvider()
      : super(
          EewHistoryModel(
            supabase: SupabaseClient(supabaseS2Url, supabaseS2AnonKey),
            subscription: null,
            eewTelegrams: <CommonHead>[],
            eewTelegramsGroupByEventId: <int, List<CommonHead>>{},
            showEews: [],
            testCaseStartTime: null,
          ),
        ) {
    onInit();
  }

  final eewApi = EewApi();

  final logger = Logger(
    printer: PrettyPrinter(
      methodCount: 1,
      printTime: true,
    ),
  );

  void onInit() {
    startEewStreaming();
    Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        checkTelegrams();
      }
    });
  }

  Future<void> startEewStreaming() async {
    // EEWのストリーミングを開始
    final subscription = state.supabase.from('eew').on(
      SupabaseEventTypes.all,
      (payload) async {
        logger.i('EEW STREAM: ${payload.newRecord}', payload.commitTimestamp);
        final commonHead = CommonHead.fromJson(
          payload.newRecord!['data'] as Map<String, dynamic>,
        );
        addTelegram(commonHead);
      },
    ).subscribe()
      ..onError((e) => logger.e('EEW STREAM: error', e))
      ..socket.onOpen(() => logger.v('Socket Opened'))
      ..socket.onMessage((p0) => logger.v(p0.toString()));
    subscription.onClose(() {
      logger.e('EEW STREAM: close');
      subscription.rejoinUntilConnected();
    });

    state = state.copyWith(subscription: subscription);

    /// 再接続タイマー
    // Timer.periodic(
    //   const Duration(seconds: 5),
    //   (_) {
    //     if (state.subscription?.joinedOnce != true) {
    //       logger.i('EEW STREAM: reconnect');
    //       state.subscription?.rejoinUntilConnected();
    //     }
    //   },
    // );

    // 直近のEEW電文10件を追加しておく
    final telegrams = await eewApi.getEewTelegrams();
    telegrams.forEach(addTelegram);

    // もし、デバッグモードならテスト電文を追加
    if (kDebugMode) {
      final res = await http.get(
        Uri.parse(
          'https://sample.dmdata.jp/eew/20171213b/json/vxse44_rjtd_20171213112257.json',
        ),
      );
      addTelegram(
        CommonHead.fromJson(
          jsonDecode(utf8.decode(res.bodyBytes)) as Map<String, dynamic>,
        ),
      );
    }
  }

  void addTelegram(CommonHead commonHead) {
    // eewTelegramsに追加
    final eewTelegrams = state.eewTelegrams;

    final toUpdateTelegrams = [...eewTelegrams, commonHead];
    final toUpdateTelegramsGroupBy = toUpdateTelegrams
        .toList()
        .groupListsBy((element) => int.parse(element.eventId.toString()));

    // 180秒以内に発表されていて
    // 最新のものを取得する
    // eventIdが大きい順
    final showEews = <CommonHead>[];
    toUpdateTelegramsGroupBy.forEach((key, value) {
      // valueをpressDateTimeが一番新しい順に並び変える
      value.sort((a, b) => b.pressDateTime.compareTo(a.pressDateTime));
      // 任意の電文が180秒以内に発表されている場合に
      // valueの最初のものをshowEewsに追加する

      if (value.any(
        (element) =>
            element.pressDateTime.difference(DateTime.now()).inSeconds > -180 ||
            element.originalId == 'TELEGRAM_ID',
      )) {
        showEews.add(value.first);
      }
    });

    state = state.copyWith(
      eewTelegrams: [...state.eewTelegrams, commonHead],
      eewTelegramsGroupByEventId: toUpdateTelegramsGroupBy,
      showEews: showEews
          .map((eew) => MapEntry(eew, EEWInformation.fromJson(eew.body))),
    );
  }

  /// 表示する電文を更新
  void checkTelegrams() {
    // eewTelegramsに追加
    final eewTelegrams = state.eewTelegrams;

    final telegramsGroupBy = eewTelegrams
        .toList()
        .groupListsBy((element) => int.parse(element.eventId.toString()));

    // 180秒以内に発表されていて
    // 最新のものを取得する
    // eventIdが大きい順
    final showEews = <CommonHead>[];
    telegramsGroupBy.forEach((key, value) {
      // valueをpressDateTimeが一番新しい順に並び変える
      value.sort((a, b) => b.pressDateTime.compareTo(a.pressDateTime));
      // 任意の電文が180秒以内に発表されている場合に
      // valueの最初のものをshowEewsに追加する

      if (value.any(
        (element) =>
            element.pressDateTime.difference(DateTime.now()).inSeconds > -180 ||
            element.originalId == 'TELEGRAM_ID',
      )) {
        showEews.add(value.first);
      }
    });
    if (state.showEews !=
        showEews
            .map((eew) => MapEntry(eew, EEWInformation.fromJson(eew.body)))) {
      state = state.copyWith(
        showEews: showEews
            .map((eew) => MapEntry(eew, EEWInformation.fromJson(eew.body))),
      );
    }
  }

  void startTestcase() {
    // 時刻設定
    state = state.copyWith(
      testCaseStartTime: DateTime.now(),
      eewTelegrams: [],
      eewTelegramsGroupByEventId: {},
      showEews: [],
    );
    // Handlerを開始
    Timer.periodic(
      const Duration(milliseconds: 1000),
      (timer) async {
        if (state.testCaseStartTime == null) {
          timer.cancel();
        }
        final dt = DateTime.parse('2022-06-20T10:31:35')
            .add(DateTime.now().difference(state.testCaseStartTime!));
        final assetUrl =
            "assets/develop/06301031/eew/${DateFormat('yyyyMMddHHmmss').format(dt)}.json";
        try {
          final data = jsonDecode(await rootBundle.loadString(assetUrl));
          final eew = KyoshinEEW.fromJson(data).toDmdataEew(isTesting: true);
          if (eew != null) {
            addTelegram(eew);
          }
        } catch (e) {
          logger.e('NIED EEW STREAM(TEST): $e');
          // テストケースを終了する
          state = state.copyWith(
            testCaseStartTime: null,
            eewTelegrams: [],
            eewTelegramsGroupByEventId: {},
            showEews: [],
          );

          timer.cancel();
        }
      },
    );
  }

  /// 保持しているEEW電文を全クリア
  void clearTelegrams() {
    state = state.copyWith(
      eewTelegrams: [],
      eewTelegramsGroupByEventId: {},
      showEews: [],
    );
  }

  /// テスト用のEEWを新規作成
  int addTestEew({
    DateTime? arrivalTime,
    Accuracy? accuracy,
    required ForecastMaxInt maxint,
    bool isLastInfo = false,
    bool isCanceled = false,
    bool isWarning = false,
    DateTime? originTime,
    bool isAssuming = false,
    String hypoName = 'テスト震源地',
    double lat = 35,
    double lon = 135,
    int? depth,
    DepthCondition? depthCondition,
    double? magnitude,
    MagnitudeCondition? magnitudeCondition,
    int eventId = 0,
    int serialNo = 1,
  }) {
    final eew = EEWInformation(
      isLastInfo: isLastInfo,
      isCanceled: isCanceled,
      isWarning: isWarning,
      zones: [],
      prefectures: [],
      regions: [],
      earthQuake: EarthQuake(
        originTime: originTime,
        arrivalTime: arrivalTime ?? DateTime.now(),
        isAssuming: isAssuming,
        hypoCenter: HypoCenter(
          name: hypoName,
          code: 100,
          coordinateComponent: CoordinateComponent(
            latitude: Latitude(text: lat.toString(), value: lat),
            longitude: Longitude(text: lon.toString(), value: lon),
            height: Height(type: '高さ', unit: 'm', value: 0),
            geodeticSystem: GeodeticSystem.japaneseGeodeticSystem,
            condition: null,
          ),
          depth: Depth(
            type: '深さ',
            unit: 'km',
            value: depth,
            condition: depthCondition,
          ),
          reduce: Reduce(code: 0, name: ''),
          landOrSea: '内陸',
          accuracy: accuracy ??
              Accuracy(
                depthCalculation: DepthCalculation.f1,
                epicCenterAccuracy: EpicCenters(
                  epicCenterAccuracy: EpicCenterAccuracy.f1,
                  hypoCenterAccuracy: HypoCenterAccuracy.f1,
                ),
                magnitudeCalculation: MagnitudeCalculation.f2,
                numberOfMagnitudeCalculation: NumberOfMagnitudeCalculation.f1,
              ),
        ),
        magnitude: Magnitude(
          type: 'マグニチュード',
          unit: 'M',
          value: magnitude,
          condition: magnitudeCondition,
        ),
      ),
      intensity: Intensity(
        maxint: maxint,
        forecastMaxLpgmInt: null,
        appendix: null,
        region: [],
      ),
      text: null,
      comments: Comments(
        free: 'これはアプリ内で生成されたテスト電文です',
        warning: Warning(
          codes: [],
          text: 'これはアプリ内で生成されたテスト電文です',
        ),
      ),
    );
    final commonHead = CommonHead(
      body: eew.toJson(),
      editoralOffice: 'テスト',
      eventId: eventId.toString(),
      headline: 'テスト電文',
      infoKind: 'eew-test',
      infoKindVersion: '1.0',
      infoType: CommonHeadInfoType.announcement,
      originalId: 'TELEGRAM_ID',
      pressDateTime: DateTime.now(),
      publishingOffice: ['テスト'],
      reportDateTime: DateTime.now(),
      schema: CommonHeadSchema(type: 'eew-test', version: '1.0'),
      serialNo: serialNo.toString(),
      status: CommonHeadStatus.training,
      targetDateTime: DateTime.now(),
      targetDateTimeDubious: '',
      targetDuration: null,
      title: '緊急地震速報テスト',
      type: '',
      validDateTime: null,
    );
    addTelegram(commonHead);
    return commonHead.hashCode;
  }
}

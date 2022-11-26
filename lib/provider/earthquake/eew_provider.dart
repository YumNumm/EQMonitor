import 'dart:async';
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:eqmonitor/provider/init/talker.dart';
import 'package:eqmonitor/utils/talker_log/log_types.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../api/remote/supabase/eew.dart';
import '../../env/env.dart';
import '../../model/earthquake/eew_history_model.dart';
import '../../schema/remote/dmdata/commonHeader.dart';
import '../../schema/remote/dmdata/eew-information/comments.dart';
import '../../schema/remote/dmdata/eew-information/earthquake.dart';
import '../../schema/remote/dmdata/eew-information/earthquake/accuracy.dart';
import '../../schema/remote/dmdata/eew-information/earthquake/accuracy/depth_calculation.dart';
import '../../schema/remote/dmdata/eew-information/earthquake/accuracy/epicCenterAccuracy.dart';
import '../../schema/remote/dmdata/eew-information/earthquake/accuracy/magnitude_calculation.dart';
import '../../schema/remote/dmdata/eew-information/earthquake/accuracy/number_of_magnitude_calculation.dart';
import '../../schema/remote/dmdata/eew-information/earthquake/depth.dart';
import '../../schema/remote/dmdata/eew-information/earthquake/hypocenter.dart';
import '../../schema/remote/dmdata/eew-information/earthquake/reduce.dart';
import '../../schema/remote/dmdata/eew-information/eew-infomation.dart';
import '../../schema/remote/dmdata/eew-information/intensity/forecast_max_int.dart';
import '../../schema/remote/dmdata/eew-information/intensity/intensity.dart';
import '../../schema/remote/dmdata/eq-information/earthquake-information/hypocenter/coordinate_component.dart';
import '../../schema/remote/dmdata/eq-information/earthquake-information/hypocenter/coordinate_component/geodetic_system.dart';
import '../../schema/remote/dmdata/eq-information/earthquake-information/hypocenter/coordinate_component/height.dart';
import '../../schema/remote/dmdata/eq-information/earthquake-information/hypocenter/coordinate_component/latitude.dart';
import '../../schema/remote/dmdata/eq-information/earthquake-information/hypocenter/coordinate_component/longitude.dart';
import '../../schema/remote/dmdata/eq-information/earthquake-information/hypocenter/depth/depth_condition.dart';
import '../../schema/remote/dmdata/eq-information/earthquake-information/magnitude.dart';
import '../../schema/remote/dmdata/eq-information/earthquake-information/magnitude/magnitude_condition.dart';
import '../../schema/remote/kmoni/EEW.dart';

final eewProvider =
    StateNotifierProvider<EewProvider, EewHistoryModel>(EewProvider.new);

class EewProvider extends StateNotifier<EewHistoryModel> {
  EewProvider(this.ref)
      : super(
          EewHistoryModel(
            supabase: SupabaseClient(Env.supabaseS2Url, Env.supabaseS2AnonKey),
            channel: null,
            showEews: [],
            testCaseStartTime: null,
          ),
        ) {
    talker = ref.watch(talkerProvider);
    onInit();
  }

  final Ref ref;
  final eewApi = EewApi();

  late Talker talker;

  /// 取得したEEW電文
  List<CommonHead> eewTelegrams = [];

  /// `eewTelegrams`のうち、`event_id`でグルーピングしたもの
  Map<int, List<CommonHead>> eewTelegramsGroupByEventId = {};

  void onInit() => startEewStreaming();

  Future<void> startEewStreaming() async {
    // EEWのストリーミングを開始
    final channel = state.supabase.channel('eew')
      ..on(
        RealtimeListenTypes.postgresChanges,
        ChannelFilter(
          event: '*',
          schema: 'public',
          table: 'eew',
        ),
        (payload, [ref]) {
          talker.logTyped(EewProviderLog('EEW STREAM: $payload'));
          final commonHead = CommonHead.fromJson(
            ((payload as Map<String, dynamic>)['new']
                as Map<String, dynamic>)['data'],
          );
          addTelegram(commonHead);
        },
      )
      ..onClose(() {
        talker.handleException(
          Exception('緊急地震速報サーバとの接続が切断されました'),
          StackTrace.current,
          '緊急地震速報サーバとの接続が切断されました',
        );
      })
      ..on(RealtimeListenTypes.broadcast, ChannelFilter(), (payload, [ref]) {
        talker.logTyped(EewProviderLog('EEW STREAM: $payload'));
      });
    state = state.copyWith(
      channel: channel,
    );

    /// WS再接続タイマー
    Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        if (state.channel?.joinedOnce == false) {
          talker.logTyped(EewProviderLog('EEW STREAM: reconnect'));
        }
      },
    );

    // 表示するEEWの更新タイマー
    Timer.periodic(
      const Duration(seconds: 1),
      (_) => checkTelegrams(),
    );

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
    talker.logTyped(
      EewProviderLog(
        'EEW電文追加: Event ${commonHead.eventId} ${commonHead.originalId} ${commonHead.pressDateTime}',
      ),
    );

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
    eewTelegrams.add(commonHead);
    eewTelegramsGroupByEventId = toUpdateTelegramsGroupBy;

    state = state.copyWith(
      showEews: showEews
          .map((eew) => MapEntry(eew, EEWInformation.fromJson(eew.body))),
    );
  }

  /// 表示する電文を更新
  void checkTelegrams() {
    final showEews = state.showEews;
    // showEewsが空の場合は何もしない
    if (showEews.isEmpty) {
      return;
    }
    // 深さが150km未満のものは180秒経過していたら削除
    // それ以外は300秒経過していたら削除
    final now = DateTime.now();
    final toUpdateShowEews = showEews
        .where(
          (eew) => (eew.value.earthQuake?.hypoCenter.depth.value ?? 0) < 150
              ? now.difference(eew.key.pressDateTime).inSeconds < 180
              : now.difference(eew.key.pressDateTime).inSeconds < 300,
        )
        .toList();
    if (toUpdateShowEews == showEews) {
      return;
    }

    // キャッシュしているEEW電文のうち上記条件を満たさないものを削除
    eewTelegrams.forEachIndexed((index, e) {
      final eew = EEWInformation.fromJson(e.body);
      if ((eew.earthQuake?.hypoCenter.depth.value ?? 0) < 150) {
        if (now.difference(e.pressDateTime).inSeconds > 180) {
          eewTelegrams.removeAt(index);
          talker.logTyped(
            EewProviderLog(
              'EEW電文削除: Event ${e.eventId} ${e.originalId} ${e.pressDateTime}',
            ),
          );
        }
      } else {
        if (now.difference(e.pressDateTime).inSeconds > 300) {
          eewTelegrams.removeAt(index);
          talker.logTyped(
            EewProviderLog(
              'EEW電文削除(深発): Event ${e.eventId} ${e.originalId} ${e.pressDateTime}',
            ),
          );
        }
      }
    });

    state = state.copyWith(
      showEews: toUpdateShowEews,
    );
  }

  void startTestcase() {
    // 時刻設定
    state = state.copyWith(
      testCaseStartTime: DateTime.now(),
      showEews: [],
    );
    // 既存のEEW電文を削除
    eewTelegrams.clear();
    eewTelegramsGroupByEventId.clear();
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
          // ignore: avoid_catches_without_on_clauses
        } catch (e) {
          talker.info('強震モニタのテストを終了しました');
          // テストケースを終了する
          state = state.copyWith(
            testCaseStartTime: null,
            showEews: [],
          );
          // EEW電文を削除
          eewTelegrams.clear();
          eewTelegramsGroupByEventId.clear();

          timer.cancel();
        }
      },
    );
  }

  /// 保持しているEEW電文を全クリア
  void clearTelegrams() {
    state = state.copyWith(
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

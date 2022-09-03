import 'dart:async';
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:eqmonitor/schema/dmdata/eew-information/eew-infomation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../api/remote_db/eew.dart';
import '../../model/earthquake/eew_history_model.dart';
import '../../private/keys.dart';
import '../../schema/dmdata/commonHeader.dart';
import '../../schema/kmoni/EEW.dart';

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
    final subscription = state.supabase
        .from('eew')
        .on(SupabaseEventTypes.insert, (payload) async {
      logger.i('EEW STREAM: ${payload.newRecord}', payload.commitTimestamp);
      if (payload.newRecord == null) {
        return;
      }
      final commonHead = CommonHead.fromJson(
        payload.newRecord!['data'] as Map<String, dynamic>,
      );
      addTelegram(commonHead);
    }).subscribe()
      ..onClose(() => logger.i('EEW STREAM: close'))
      ..onError((e) => logger.e('EEW STREAM: error', e));

    state = state.copyWith(subscription: subscription);
    // final eewStream = state.supabase
    //     .from('eew')
    //     .stream(['id']).execute()
    //   ..listen((events) async {
    //     for (final event in events) {
    //       logger.i('EEW STREAM: $event');
    //       final commonHead = CommonHead.fromJson(jsonDecode(event['data']));
    //       addTelegram(commonHead);
    //     }
    //   });

    // 直近のEEW電文10件を追加しておく
    final telegrams = await eewApi.getEewTelegrams();
    telegrams.forEach(addTelegram);
    Logger().i('Start Eew Streaming');

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

    state = state.copyWith(
      showEews: showEews
          .map((eew) => MapEntry(eew, EEWInformation.fromJson(eew.body))),
    );
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
}

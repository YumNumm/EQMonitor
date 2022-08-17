import 'dart:async';
import 'dart:convert';

import 'package:collection/collection.dart';
import '../../api/remote_db/eew.dart';
import '../../model/earthquake/eew_history_model.dart';
import '../../private/keys.dart';
import '../../schema/dmdata/commonHeader.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
    Timer.periodic(const Duration(seconds: 2), (_) {
      if (mounted) {
        checkTelegrams();
      }
    });
  }

  Future<void> startEewStreaming() async {
    // 直近のEEW電文10件を追加しておく
    final telegrams = await eewApi.getEewTelegrams();
    for (final e in telegrams) {
      print(e.eventId);
      addTelegram(e);
    }
    Logger().i('Start Eew Streaming');
    // EEW STREAMを開始する
    final subscription =
        state.supabase.from('eew').on(SupabaseEventTypes.insert, (payload) {
      logger.i('EEW STREAM: ${payload.newRecord}', payload.commitTimestamp);
      if (payload.newRecord == null) {
        return;
      }
      final commonHead =
          CommonHead.fromJson(jsonDecode(payload.newRecord!['data']));
      addTelegram(commonHead);
    }).subscribe();
    subscription.socket.onMessage((p0) => logger.i('EEW WebSocket: $p0'));
    logger.i(subscription.socket.connState?.toString());
    // もし、デバッグモードならテスト電文を追加
    if (kDebugMode && false) {
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
    logger.d('addTelegram: ${commonHead.originalId}');
    // eewTelegramsに追加
    // ただし、同じ電文(originalIdで判別)があれば追加しない
    final eewTelegrams = state.eewTelegrams;
    if (eewTelegrams.any(
      (eewTelegram) => eewTelegram.originalId == commonHead.originalId,
    )) {
      return;
    }
    final toUpdateTelegrams = [...eewTelegrams, commonHead];
    final toUpdateTelegramsGroupBy = toUpdateTelegrams
        .toList()
        .groupListsBy((element) => int.parse(element.eventId.toString()));

    // 180秒以内に発表されていて
    // 取り消しされていない電文のうち
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
            element.pressDateTime.difference(DateTime.now()).inSeconds >
                -18000 ||
            element.originalId == 'TELEGRAM_ID',
      )) {
        showEews.add(value.first);
      }
    });

    state = state.copyWith(
      eewTelegrams: [...eewTelegrams, commonHead],
      eewTelegramsGroupByEventId: toUpdateTelegramsGroupBy,
      showEews: showEews,
    );
  }

  /// 表示する電文を更新
  void checkTelegrams() {
    final toUpdateTelegramsGroupBy = state.eewTelegrams
        .toList()
        .groupListsBy((element) => int.parse(element.eventId.toString()));

    // 180秒以内に発表されていて
    // 取り消しされていない電文のうち
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
            element.pressDateTime.difference(DateTime.now()).inSeconds >
                (kDebugMode ? -18000 : -180) ||
            element.originalId == 'TELEGRAM_ID',
      )) {
        showEews.add(value.first);
      }
    });

    if (mounted) {
      state = state.copyWith(
        eewTelegramsGroupByEventId: toUpdateTelegramsGroupBy,
        showEews: showEews,
      );
    }
  }
}

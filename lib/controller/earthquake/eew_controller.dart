import 'dart:async';

import 'package:collection/collection.dart';
import 'package:eqmonitor/api/db/eew.dart';
import 'package:eqmonitor/model/earthquake/eew_history_model.dart';
import 'package:eqmonitor/schema/dmdata/commonHeader.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../../utils/logger/filter.dart';

class EewHistoryController extends StateNotifier<EewHistoryModel> {
  EewHistoryController()
      : super(
          const EewHistoryModel(),
        );

  final EewApi eewApi = EewApi();
  final logger = Logger(
    filter: MyFilter(),
    output: MyOutput(),
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

  void startEewStreaming() {
    eewApi.eewStream().listen(
      (eewTelegram) {
        if (mounted) {
          addTelegram(eewTelegram);
        }
      },
    );
  }

  void addTelegram(CommonHead commonHead) {
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
            element.pressDateTime.difference(DateTime.now()).inSeconds > 180,
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
    final eewTelegrams = state.eewTelegrams;

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
            element.pressDateTime.difference(DateTime.now()).inSeconds > 180 ||
            kDebugMode,
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

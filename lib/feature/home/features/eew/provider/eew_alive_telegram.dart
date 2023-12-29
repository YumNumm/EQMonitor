import 'package:eqapi_types/model/telegram_v3.dart';
import 'package:eqmonitor/core/provider/time_ticker.dart';
import 'package:eqmonitor/feature/earthquake_history/model/state/earthquake_history_item.dart';
import 'package:eqmonitor/feature/home/features/eew/provider/eew_telegram.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'eew_alive_telegram.g.dart';

/// イベント終了していないEEW
@riverpod
List<EarthquakeHistoryItem>? eewAliveTelegram(EewAliveTelegramRef ref) {
  final state = ref.watch(eewTelegramProvider);
  final value = state.valueOrNull;
  if (value == null) {
    return null;
  }
  final tickerTime = ref.watch(timeTickerProvider);
  final now = (tickerTime.value ?? DateTime.now()).toUtc();

  final checker = ref.read(eewAliveCheckerProvider);
  return value
      .where((e) => !checker.checkMarkAsEventEnded(item: e, now: now))
      .toList();
}

@riverpod
EewAliveChecker eewAliveChecker(EewAliveCheckerRef ref) => EewAliveChecker();

class EewAliveChecker {
  /// イベント終了の判定
  bool checkMarkAsEventEnded({
    required EarthquakeHistoryItem item,
    required DateTime now,
  }) {
    final latestEew = item.latestEewTelegram;
    final latestEewBody = item.latestEew;
    // 発表から1時間以上経過している場合、イベント終了と判定する
    final reportTime = latestEew?.reportTime?.toUtc();
    if (reportTime == null) {
      return true;
    }
    if (now.toUtc().difference(reportTime).inHours > 1) {
      return true;
    }
    // 最新のEEWがない場合、イベント終了と判定する
    if (latestEew == null || latestEewBody == null) {
      return true;
    }
    // 既に、VXSE53が発表済みの場合、イベント終了と判定する
    if (item.telegrams
        .any((telegram) => telegram.type == TelegramType.vxse53)) {
      return true;
    }
    // 最新のEEWが取消の場合、発表から180秒を経過している場合、イベント終了と判定する
    if (latestEewBody is TelegramVxse45Cancel) {
      final reportTime = latestEew.reportTime?.toUtc();
      if (reportTime == null) {
        return true;
      }
      return now.toUtc().difference(reportTime).inSeconds > 180;
    }
    // 最新のEEWが通常の場合
    if (latestEewBody is TelegramVxse45Body) {
      final originTime = latestEewBody.originTime?.toUtc();
      final arrivalTime = latestEewBody.arrivalTime.toUtc();
      final targetTime = originTime ?? arrivalTime;
      final depth = latestEewBody.depth;
      // 深さ不明/150km未満の場合、地震発生/検知から250秒でイベント終了と判定する
      if (depth == null || depth < 150) {
        return now.toUtc().difference(targetTime).inSeconds > 250;
      } else {
        // 深さ150km以上の場合、地震発生/検知から400秒でイベント終了と判定する
        return now.toUtc().difference(targetTime).inSeconds > 400;
      }
    }
    throw UnimplementedError('Unknown EEW type');
  }
}

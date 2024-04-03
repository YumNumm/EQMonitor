import 'package:collection/collection.dart';
import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/provider/eew/eew_telegram.dart';
import 'package:eqmonitor/core/provider/time_ticker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'eew_alive_telegram.g.dart';

// TODO(YumNumm): EEWの結合
/// イベント終了していないEEWのうち、精度が低いものを除外したもの
@riverpod
List<EewV1> eewAliveNormalTelegram(
  EewAliveNormalTelegramRef ref,
) {
  final state = ref.watch(eewAliveTelegramProvider) ?? [];
  return state.where((e) {
    if (e.isPlum ?? false || e.isLevelEew || e.isIpfOnePoint) {
      return false;
    }
    return true;
  }).toList();
}

/// イベント終了していないEEW
@riverpod
class EewAliveTelegram extends _$EewAliveTelegram {
  @override
  List<EewV1>? build() {
    final state = ref.watch(eewProvider);
    final value = state.valueOrNull;
    final tickerTime = ref.watch(timeTickerProvider);
    final checker = ref.watch(eewAliveCheckerProvider);
    if (value == null) {
      return null;
    }
    final now = (tickerTime.value ?? DateTime.now()).toUtc();

    return value
        .where((e) => !checker.checkMarkAsEventEnded(eew: e, now: now))
        .toList();
  }

  @override
  bool updateShouldNotify(
    List<EewV1>? previous,
    List<EewV1>? next,
  ) {
    return !const ListEquality<EewV1>().equals(previous, next);
  }
}

@Riverpod(keepAlive: true)
EewAliveChecker eewAliveChecker(EewAliveCheckerRef ref) => EewAliveChecker();

class EewAliveChecker {
  /// イベント終了の判定
  bool checkMarkAsEventEnded({
    required EewV1 eew,
    required DateTime now,
  }) {
    // 発生時刻から1時間以上経過している場合、イベント終了と判定する(早期return)
    final reportTime = eew.reportTime.toUtc();
    if (now.toUtc().difference(reportTime).inHours > 1) {
      return true;
    }
    // 最新のEEWが取消の場合、発表から180秒を経過している場合、イベント終了と判定する
    if (eew.isCanceled) {
      final reportTime = eew.reportTime.toUtc();
      return now.toUtc().difference(reportTime).inSeconds > 180;
    }
    // 最新のEEWが通常の場合
    final originTime = eew.originTime?.toUtc();
    final arrivalTime = eew.arrivalTime?.toUtc();
    final targetTime = originTime ?? arrivalTime;
    if (targetTime == null) {
      return false;
    }
    final depth = eew.depth;

    // EEW警報の場合、420秒でイベント終了と判定する
    final isWarning = (eew.headline ?? '').contains('強い揺れ');
    if (isWarning) {
      return now.toUtc().difference(targetTime).inSeconds > 420;
    }
    // M6.0以上の場合、360秒でイベント終了と判定する
    final magnitude = eew.magnitude;
    if (magnitude != null && magnitude >= 6.0) {
      return now.toUtc().difference(targetTime).inSeconds > 360;
    }
    // 深さ不明/150km未満の場合、地震発生/検知から250秒でイベント終了と判定する
    if (depth == null || depth < 150) {
      return now.toUtc().difference(targetTime).inSeconds > 250;
    } else {
      // 深さ150km以上の場合、地震発生/検知から400秒でイベント終了と判定する
      return now.toUtc().difference(targetTime).inSeconds > 400;
    }
  }
}

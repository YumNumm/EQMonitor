import 'package:collection/collection.dart';
import 'package:eqmonitor/core/provider/time_ticker.dart';
import 'package:eqmonitor/feature/eew/data/eew_telegram.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'eew_alive_telegram.g.dart';

/// イベント終了していないEEWのうち、精度が低いものを除外したもの
@Riverpod(keepAlive: true)
List<EewTelegramItem> eewAliveNormalTelegram(Ref ref) {
  final state = ref.watch(eewAliveTelegramProvider) ?? [];
  return state.where((e) {
    if (e.isPlum) {
      return false;
    }
    return true;
  }).toList();
}

/// イベント終了していないEEW
@Riverpod(keepAlive: true)
class EewAliveTelegram extends _$EewAliveTelegram {
  @override
  List<EewTelegramItem>? build() {
    final state = ref.watch(eewProvider);
    final value = state.value;
    final tickerTime = ref.watch(timeTickerProvider());
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
    List<EewTelegramItem>? previous,
    List<EewTelegramItem>? next,
  ) {
    return !const ListEquality<EewTelegramItem>().equals(previous, next);
  }
}

@Riverpod(keepAlive: true)
EewAliveChecker eewAliveChecker(Ref ref) => EewAliveChecker();

class EewAliveChecker {
  bool checkMarkAsEventEnded({
    required EewTelegramItem eew,
    required DateTime now,
  }) {
    final reportTime = eew.reportTime.toUtc();
    if (now.toUtc().difference(reportTime).inHours > 1) {
      return true;
    }
    if (eew.isCanceled) {
      return now.toUtc().difference(reportTime).inSeconds > 180;
    }
    final originTime = eew.originTime?.toUtc();
    final arrivalTime = eew.arrivalTime?.toUtc();
    final happenedTime = originTime ?? arrivalTime;
    if (happenedTime == null) {
      return false;
    }
    final happenedDiff = now.toUtc().difference(happenedTime).inSeconds;
    final depth = eew.hypocenter?.depth;

    final isWarning = eew.isWarning ?? false;
    final magnitude = eew.hypocenter?.magnitude;
    if ((magnitude != null && magnitude >= 6.0) || isWarning) {
      return happenedDiff > 360;
    }
    if (depth == null || depth < 150) {
      return happenedDiff > 250;
    } else {
      return happenedDiff > 400;
    }
  }
}

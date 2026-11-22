import 'package:clock/clock.dart';
import 'package:eqmonitor/core/provider/ntp/ntp_provider.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/model/replay_creation_request.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'replay_creation_range_resolver.g.dart';

// リプレイ中の AppClock は再生時刻を返すため、取得可能な範囲は実時刻で求める。
@Riverpod(keepAlive: true)
ReplayCreationRangeResolver replayCreationRangeResolver(Ref ref) =>
    ReplayCreationRangeResolver(
      now: () => clock.now().toUtc().add(
        ref.read(ntpProvider).value?.offset ?? Duration.zero,
      ),
    );

typedef ReplayCreationRange = ({DateTime earliest, DateTime latest});

class const ReplayCreationRangeResolver({
  required final DateTime Function() now,
}) {
  // 強震モニタ・長周期地震動モニタは約3時間40分前までの画像を配信する（2026-11-23 実測）。
  // 取得中に古い側が配信終了へ掛からないよう、余裕を持たせる。
  static const retention = Duration(hours: 3);
  static const publishMargin = Duration(seconds: 30);
  static const maxDuration = Duration(minutes: 30);
  // 揺れ検知の平常値は最大180秒前の画像を使う。
  static const preRoll = Duration(seconds: 180);

  ReplayCreationRange selectableRange() {
    final now = this.now();
    final truncated = DateTime.fromMillisecondsSinceEpoch(
      now.millisecondsSinceEpoch -
          now.millisecondsSinceEpoch % Duration.millisecondsPerSecond,
      isUtc: true,
    );
    return (
      earliest: truncated.subtract(retention),
      latest: truncated.subtract(publishMargin),
    );
  }

  bool isSelectable({required ReplayCreationRequest request}) {
    final range = selectableRange();
    return request.duration > Duration.zero &&
        request.duration <= maxDuration &&
        !request.startTime.isBefore(range.earliest) &&
        !request.endTime.isAfter(range.latest);
  }

  DateTime fetchStartTime({required ReplayCreationRequest request}) {
    final earliest = selectableRange().earliest;
    final start = request.includePreRoll
        ? request.startTime.subtract(preRoll)
        : request.startTime;
    return start.isBefore(earliest) ? earliest : start;
  }

  List<DateTime> frameTimes({required ReplayCreationRequest request}) {
    final start = fetchStartTime(request: request);
    final seconds = request.endTime.difference(start).inSeconds;
    return [
      for (var offset = 0; offset <= seconds; offset++)
        start.add(Duration(seconds: offset)),
    ];
  }
}

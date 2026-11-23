import 'package:eqmonitor/feature/earthquake_history/data/model/origin_time_precision.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/model/replay_kyoshin_archive_window.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'replay_kyoshin_archive_window_resolver.g.dart';

@riverpod
ReplayKyoshinArchiveWindowResolver replayKyoshinArchiveWindowResolver(
  Ref ref,
) => const ReplayKyoshinArchiveWindowResolver();

class const ReplayKyoshinArchiveWindowResolver({
  /// 強震モニタの過去画像は1時間ごとに、その時点の3時間前までがまとめて削除される
  /// （2026-11-23 の実測。lmoni は毎時15分頃、kmoni は毎時45分頃）。
  final Duration retention = const Duration(hours: 3),

  /// これより古い時刻の 404 は、一時的な失敗ではなく削除済みとして扱う。
  final Duration purgedAge = const Duration(hours: 2),
  final Duration lead = const Duration(seconds: 10),
  final Duration tail = const Duration(minutes: 3),
  final Duration publishMargin = const Duration(seconds: 10),
}) {
  ReplayKyoshinArchiveWindow? resolve({
    required DateTime? originTime,
    required OriginTimePrecision precision,
    required DateTime now,
  }) {
    // 分単位の発生時刻は、実際の発生がその1分間のどこかにある。
    final uncertainty = switch (precision) {
      .millisecond || .second => Duration.zero,
      .minute => const Duration(minutes: 1),
      .hour || .day || .month => null,
    };
    if (originTime == null || uncertainty == null) {
      return null;
    }
    final origin = originTime.toUtc();
    final latest = now.toUtc().subtract(publishMargin);
    final tailEnd = origin.add(uncertainty + tail);
    final end = tailEnd.isAfter(latest) ? latest : tailEnd;
    final start = origin
        .subtract(lead)
        .copyWith(millisecond: 0, microsecond: 0);
    // 0.5 倍速では、再生し終えるまでに画像が区間の長さだけ古くなる。
    // その間に削除が走っても残るよう、区間の長さを余裕として取る。
    final purgeMargin = end.difference(start);
    if (now.toUtc().difference(start) > retention - purgeMargin ||
        !end.isAfter(origin)) {
      return null;
    }
    return ReplayKyoshinArchiveWindow(
      startTime: start,
      endTime: end.copyWith(millisecond: 0, microsecond: 0),
      originTime: origin,
      isOriginTimeApproximate: uncertainty > Duration.zero,
    );
  }

  bool isExpired({required DateTime frameTime, required DateTime now}) =>
      now.difference(frameTime) > purgedAge;
}

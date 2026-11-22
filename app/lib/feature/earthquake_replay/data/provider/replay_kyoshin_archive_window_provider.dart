import 'package:eqmonitor/core/provider/clock/app_clock.dart';
import 'package:eqmonitor/core/provider/time_ticker.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/origin_time_precision.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/logic/replay_kyoshin_archive_window_resolver.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/model/replay_kyoshin_archive_window.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'replay_kyoshin_archive_window_provider.g.dart';

@riverpod
ReplayKyoshinArchiveWindow? replayKyoshinArchiveWindow(
  Ref ref, {
  required DateTime? originTime,
  required OriginTimePrecision precision,
}) {
  ref.watch(timeTickerProvider(const Duration(seconds: 30)));
  return ref
      .watch(replayKyoshinArchiveWindowResolverProvider)
      .resolve(
        originTime: originTime,
        precision: precision,
        now: ref.read(appClockProvider.notifier).realtimeNow(),
      );
}

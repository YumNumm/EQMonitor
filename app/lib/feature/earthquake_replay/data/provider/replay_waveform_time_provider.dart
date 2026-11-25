import 'package:eqmonitor/core/provider/clock/app_clock.dart';
import 'package:eqmonitor/core/provider/clock/time_mode.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/notifier/replay_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'replay_waveform_time_provider.g.dart';

// 再生位置は進行のたびにしか届かないため、波形から求めたリアルタイム震度の計算周期（0.1 秒）で補間した時刻を配る。
@riverpod
Stream<DateTime> replayWaveformTime(Ref ref) async* {
  const step = Duration(milliseconds: 100);
  final mode = ref.watch(appClockProvider);
  final isPlaying = ref.watch(
    replayProvider.select((state) => state?.isPlaying ?? false),
  );
  if (mode is! ReplayTimeMode) {
    return;
  }
  final clock = ref.read(appClockProvider.notifier);
  DateTime quantized() {
    final micros = clock.now().microsecondsSinceEpoch;
    return DateTime.fromMicrosecondsSinceEpoch(
      micros - micros % step.inMicroseconds,
      isUtc: true,
    );
  }

  yield quantized();
  if (!isPlaying) {
    return;
  }
  yield* Stream.periodic(step, (_) => quantized()).distinct();
}

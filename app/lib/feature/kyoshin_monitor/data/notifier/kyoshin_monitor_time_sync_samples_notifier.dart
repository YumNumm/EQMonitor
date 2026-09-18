import 'package:eqmonitor/feature/kyoshin_monitor/data/logic/kyoshin_monitor_trimmed_mean_calculator.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_time_sync_samples.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'kyoshin_monitor_time_sync_samples_notifier.g.dart';

@Riverpod(keepAlive: true)
class KyoshinMonitorTimeSyncSamplesNotifier
    extends _$KyoshinMonitorTimeSyncSamplesNotifier {
  @override
  KyoshinMonitorTimeSyncSamples build() =>
      const KyoshinMonitorTimeSyncSamples();

  void clear() {
    state = const KyoshinMonitorTimeSyncSamples();
  }

  void add({required Duration roundTripTime, required Duration shift}) {
    final calculator = ref.read(kyoshinMonitorTrimmedMeanCalculatorProvider);
    state = KyoshinMonitorTimeSyncSamples(
      roundTripTimes: calculator.append(
        samples: state.roundTripTimes,
        value: roundTripTime,
      ),
      shifts: calculator.append(samples: state.shifts, value: shift),
    );
  }
}

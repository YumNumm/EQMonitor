import 'package:eqmonitor/core/provider/clock/app_clock.dart';
import 'package:eqmonitor/core/provider/environment/environment.dart';
import 'package:eqmonitor/core/provider/kmoni_observation_points/provider/kyoshin_observation_points_provider.dart';
import 'package:eqmonitor/feature/eew/data/eew.dart';
import 'package:eqmonitor/feature/shake_detection/data/logic/shake_correlation_eew_factory.dart';
import 'package:eqmonitor/feature/shake_detection/data/logic/shake_detection_event_assembler.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:eqmonitor/feature/shake_detection/data/notifier/device_shake_detection.dart';
import 'package:eqmonitor/feature/shake_detection/data/provider/shake_eew_correlator_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shake_detection_provider.g.dart';

/// 端末内で検知した揺れのうち確定したもの。EEW と結合できたイベントには
/// `correlatedEewEventId` が入る。
@Riverpod(keepAlive: true)
List<ShakeDetectionEvent> shakeDetection(Ref ref) {
  if (!ref.watch(buildConfigProvider).isShakeDetectionAvailable) {
    return const [];
  }
  // リプレイ再生中は、現在発生している揺れを再生中の時刻基準に混在させない。
  if (!ref.watch(isRealtimeModeProvider)) {
    return const [];
  }
  final frame = ref.watch(deviceShakeDetectionProvider);
  final stations = ref.watch(kyoshinImageObservationPointsProvider).value;
  if (frame == null || stations == null) {
    return const [];
  }
  return ref
      .watch(shakeDetectionEventAssemblerProvider)
      .assemble(
        snapshots: frame.events,
        stations: stations,
        correlator: ref.watch(shakeEewCorrelatorProvider).value,
        eews: ref
            .watch(shakeCorrelationEewFactoryProvider)
            .create(ref.watch(eewProvider).value ?? const []),
        now: ref.read(appClockProvider.notifier).now(),
      );
}

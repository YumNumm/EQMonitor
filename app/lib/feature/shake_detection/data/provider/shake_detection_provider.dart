import 'package:eqmonitor/core/provider/kmoni_observation_points/provider/kyoshin_observation_points_provider.dart';
import 'package:eqmonitor/feature/eew/data/eew_alive_telegram.dart';
import 'package:eqmonitor/feature/shake_detection/data/logic/shake_correlation_eew_factory.dart';
import 'package:eqmonitor/feature/shake_detection/data/logic/shake_detection_event_assembler.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:eqmonitor/feature/shake_detection/data/notifier/device_shake_detection.dart';
import 'package:eqmonitor/feature/shake_detection/data/provider/shake_detection_tuning_provider.dart';
import 'package:eqmonitor/feature/shake_detection/data/provider/shake_eew_correlator_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shake_detection_provider.g.dart';

/// 端末内で検知した揺れのうち確定したもの。表示中の EEW と結合できたイベントには
/// `correlatedEewEventId` が入る。
@Riverpod(keepAlive: true)
List<ShakeDetectionEvent> shakeDetection(Ref ref) {
  if (!ref.watch(isDeviceShakeDetectionEnabledProvider)) {
    return const [];
  }
  final frame = ref.watch(deviceShakeDetectionProvider);
  final stations = ref.watch(kyoshinImageObservationPointsProvider).value;
  if (frame == null || stations == null) {
    return const [];
  }
  final events = ref
      .watch(shakeDetectionEventAssemblerProvider)
      .assemble(
        snapshots: frame.events,
        stations: stations,
        correlator: ref.watch(shakeEewCorrelatorProvider).value,
        // 最終報の後も、EEW を表示している間は同じ地震の揺れとして扱う。
        eews: ref
            .watch(shakeCorrelationEewFactoryProvider)
            .create(ref.watch(eewAliveTelegramProvider) ?? const []),
      );
  // 毎フレーム再計算されるため、検知が無い間は同一の値を返して通知を抑える。
  return events.isEmpty ? const [] : events;
}

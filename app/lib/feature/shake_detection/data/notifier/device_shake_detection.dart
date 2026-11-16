import 'package:eqmonitor/feature/shake_detection/data/model/device_shake_detection_frame.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shake_detection_engine/shake_detection_engine.dart';

part 'device_shake_detection.g.dart';

/// 強震モニタの画像から端末内で検知した揺れの、最新フレームの結果。
@Riverpod(keepAlive: true)
class DeviceShakeDetection extends _$DeviceShakeDetection {
  @override
  DeviceShakeDetectionFrame? build() => null;

  void apply({
    required DateTime observedAt,
    required List<ShakeEventSnapshot> events,
  }) {
    state = DeviceShakeDetectionFrame(observedAt: observedAt, events: events);
  }

  void clear() {
    state = null;
  }
}

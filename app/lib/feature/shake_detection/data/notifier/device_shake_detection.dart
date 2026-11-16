import 'package:eqmonitor/feature/shake_detection/data/model/device_shake_detection_frame.dart';
import 'package:eqmonitor/feature/shake_detection/data/provider/shake_detection_tuning_provider.dart';
import 'package:kyoshin_monitor_image_parser/kyoshin_monitor_image_parser.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shake_detection_engine/shake_detection_engine.dart';

part 'device_shake_detection.g.dart';

/// 強震モニタの画像から端末内で検知した揺れの、最新フレームの結果。
@Riverpod(keepAlive: true)
class DeviceShakeDetection extends _$DeviceShakeDetection {
  @override
  DeviceShakeDetectionFrame? build() {
    // 設定を変えた後は、次のフレームで平常値の取得から検知をやり直す。
    ref.listen(shakeDetectionCurrentSettingsProvider, (_, _) => state = null);
    return null;
  }

  void apply({
    required DateTime observedAt,
    required List<ShakeEventSnapshot> events,
    required ShakeDetectionStatus? status,
  }) {
    final previous = state;
    state = DeviceShakeDetectionFrame(
      observedAt: observedAt,
      events: events,
      status: status,
      isHistoryRebuilt:
          previous != null &&
          previous.isHistoryRebuilt &&
          previous.status?.coldStartAt == status?.coldStartAt,
    );
  }

  /// 履歴を作り直した結果で、最新フレームのイベントだけを置き換える。
  void replaceEvents(List<ShakeEventSnapshot> events) {
    final current = state;
    if (current == null) {
      return;
    }
    state = DeviceShakeDetectionFrame(
      observedAt: current.observedAt,
      events: events,
      status: current.status,
      isHistoryRebuilt: true,
    );
  }

  void clear() {
    state = null;
  }
}

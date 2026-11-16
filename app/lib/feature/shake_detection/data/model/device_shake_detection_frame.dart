import 'package:kyoshin_monitor_image_parser/kyoshin_monitor_image_parser.dart';
import 'package:shake_detection_engine/shake_detection_engine.dart';

final class const DeviceShakeDetectionFrame({
  required final DateTime observedAt,
  required final List<ShakeEventSnapshot> events,
  required final ShakeDetectionStatus? status,

  /// 直近のコールドスタートの後、直前のフレームで履歴を作り直したかどうか。
  required final bool isHistoryRebuilt,
});

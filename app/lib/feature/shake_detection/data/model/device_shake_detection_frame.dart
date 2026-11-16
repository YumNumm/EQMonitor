import 'package:shake_detection_engine/shake_detection_engine.dart';

final class const DeviceShakeDetectionFrame({
  required final DateTime observedAt,
  required final List<ShakeEventSnapshot> events,
});

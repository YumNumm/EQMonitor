import 'package:eqmonitor/core/provider/clock/app_clock.dart';
import 'package:eqmonitor/feature/shake_detection/data/logic/shake_detection_debug_preset_factory.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shake_detection_debug_overlay.g.dart';

@Riverpod(keepAlive: true)
class ShakeDetectionDebugOverlay extends _$ShakeDetectionDebugOverlay {
  final _factory = ShakeDetectionDebugPresetFactory();

  @override
  List<ShakeDetectionEvent> build() => const [];

  void insertPreset({required ShakeDetectionDebugPresetId id}) {
    final now = ref.read(appClockProvider.notifier).now();
    final event = _factory.create(id: id, now: now);
    state = [...state, event];
  }

  void clear() {
    state = const [];
  }
}

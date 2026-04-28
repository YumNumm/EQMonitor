import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:eqmonitor/feature/shake_detection/data/provider/shake_detection_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shake_detection_history_provider.g.dart';

/// セッション中に受信したすべての揺れ検知イベントを蓄積するプロバイダー。
/// shakeDetectionProvider（5分で削除）と異なり、クリーンアップしない。
@Riverpod(keepAlive: true)
class ShakeDetectionHistory extends _$ShakeDetectionHistory {
  @override
  List<ShakeDetectionEvent> build() {
    ref.listen(shakeDetectionProvider, (_, next) {
      final current = [...state];
      var changed = false;
      for (final event in next) {
        final idx = current.indexWhere((e) => e.eventId == event.eventId);
        if (idx == -1) {
          current.insert(0, event);
          changed = true;
        } else if (current[idx] != event) {
          current[idx] = event;
          changed = true;
        }
      }
      if (changed) {
        state = current;
      }
    });
    return [];
  }
}

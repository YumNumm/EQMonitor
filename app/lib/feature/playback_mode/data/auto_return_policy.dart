import 'package:eqmonitor/core/realtime/model/realtime_event.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auto_return_policy.g.dart';

@Riverpod(keepAlive: true)
AutoReturnPolicy autoReturnPolicy(Ref ref) => const AutoReturnPolicy();

/// リアルタイムイベントが「通常再生へ自動復帰すべき新規アラート」かを判定する。
class AutoReturnPolicy {
  const AutoReturnPolicy();

  /// 復帰トリガーとなるのはリアルタイムの EEW 更新。
  /// snapshot や地震情報・推定震度などは対象外。
  bool shouldReturnToRealtime(RealtimeEvent event) => switch (event) {
    RealtimeEewUpsertEvent() => true,
    _ => false,
  };
}

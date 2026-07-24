import 'package:eqmonitor/core/realtime/model/realtime_event.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_snapshot.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auto_return_policy.g.dart';

@Riverpod(keepAlive: true)
AutoReturnPolicy autoReturnPolicy(Ref ref) => AutoReturnPolicy();

/// リアルタイムイベントが「通常再生へ自動復帰すべき新規アラート」かを判定する。
class AutoReturnPolicy {
  ShakeSnapshotBaseline? _shakeBaseline;

  /// EEW 更新と、baseline 後に新しい eventId が追加された
  /// 揺れ検知 snapshot を復帰トリガーとする。
  bool shouldReturnToRealtime(RealtimeEvent event) => switch (event) {
    RealtimeEewUpsertEvent() => true,
    RealtimeShakeSnapshotEvent(:final record) => observeShakeSnapshot(record),
    _ => false,
  };

  bool observeShakeSnapshot(api.ShakeDetectionActiveSnapshot snapshot) {
    final eventIds = snapshot.events.map((event) => event.eventId).toSet();
    final baseline = _shakeBaseline;
    if (baseline == null) {
      _shakeBaseline = ShakeSnapshotBaseline(
        revision: snapshot.revision,
        eventIds: eventIds,
      );
      return false;
    }
    if (snapshot.revision <= baseline.revision) {
      return false;
    }

    final hasNewEvent = eventIds.any(
      (eventId) => !baseline.eventIds.contains(eventId),
    );
    _shakeBaseline = ShakeSnapshotBaseline(
      revision: snapshot.revision,
      eventIds: {...baseline.eventIds, ...eventIds},
    );
    return hasNewEvent;
  }

  void acceptShakeSnapshot(ShakeDetectionSnapshot snapshot) {
    final baseline = _shakeBaseline;
    if (baseline != null && snapshot.revision <= baseline.revision) {
      return;
    }
    final eventIds = snapshot.events.map((event) => event.eventId);
    _shakeBaseline = ShakeSnapshotBaseline(
      revision: snapshot.revision,
      eventIds: {...?baseline?.eventIds, ...eventIds},
    );
  }

  void resetShakeBaseline() {
    _shakeBaseline = null;
  }
}

final class ShakeSnapshotBaseline {
  ShakeSnapshotBaseline({required this.revision, required Set<String> eventIds})
    : eventIds = Set.unmodifiable(eventIds);

  final int revision;
  final Set<String> eventIds;
}

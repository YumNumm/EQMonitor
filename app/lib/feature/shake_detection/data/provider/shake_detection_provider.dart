import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/provider/clock/app_clock.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/realtime/data_source/eqmonitor/eqmonitor_ws_status_notifier.dart';
import 'package:eqmonitor/core/realtime/data_source/eqmonitor/eqmonitor_ws_status_state.dart';
import 'package:eqmonitor/core/realtime/model/realtime_event.dart';
import 'package:eqmonitor/core/realtime/realtime_event_provider.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_model_converter.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_snapshot.dart';
import 'package:eqmonitor/feature/shake_detection/data/notifier/shake_detection_snapshot_reducer.dart';
import 'package:eqmonitor/feature/shake_detection/data/repository/shake_detection_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shake_detection_provider.g.dart';

@Riverpod(keepAlive: true)
class ShakeDetectionAcceptedSnapshot extends _$ShakeDetectionAcceptedSnapshot {
  bool _readySeen = false;
  int _synchronizationGeneration = 0;

  @override
  ShakeDetectionSnapshot? build() {
    ref.onDispose(invalidateSynchronization);

    ref.listen(eqMonitorWsStatusProvider, (_, next) {
      if (next.phase != WsPhase.connected) {
        _readySeen = false;
        invalidateSynchronization();
      }
    });

    ref.listen(isRealtimeModeProvider, (previous, next) async {
      if (!next) {
        invalidateSynchronization();
        state = null;
        return;
      }
      if (next && previous == false && _readySeen) {
        await synchronizeFromRest();
      }
    });

    ref.listen(realtimeEventsProvider, (_, next) async {
      final event = next.value;
      if (event == null) {
        return;
      }
      switch (event) {
        case RealtimeReadyEvent():
          _readySeen = true;
          if (ref.read(isRealtimeModeProvider)) {
            await synchronizeFromRest();
          }
        case RealtimeShakeSnapshotEvent(:final record):
          if (!ref.read(isRealtimeModeProvider)) {
            return;
          }
          applySnapshot(record.toShakeDetectionSnapshot());
        default:
          return;
      }
    });

    if (!ref.read(isRealtimeModeProvider)) {
      invalidateSynchronization();
      return null;
    }
    return null;
  }

  Future<void> synchronizeFromRest() async {
    _synchronizationGeneration += 1;
    final generation = _synchronizationGeneration;
    final repository = await ref.read(shakeDetectionRepositoryProvider.future);
    if (!ref.mounted || generation != _synchronizationGeneration) {
      return;
    }
    final result = await repository.fetchActive();
    if (!ref.mounted || generation != _synchronizationGeneration) {
      return;
    }
    if (!ref.read(isRealtimeModeProvider)) {
      return;
    }
    switch (result) {
      case Success(:final value):
        applySnapshot(value);
      case Failure(:final exception, :final stackTrace):
        talker.error(
          'Failed to synchronize active shake detection snapshot',
          exception,
          stackTrace,
        );
    }
  }

  void invalidateSynchronization() {
    _synchronizationGeneration += 1;
  }

  void applySnapshot(ShakeDetectionSnapshot incoming) {
    final reducer = ref.read(shakeDetectionSnapshotReducerProvider);
    final current = state;
    final selected = reducer.selectNewer(current: current, incoming: incoming);
    if (identical(selected, current)) {
      return;
    }
    state = selected;
  }
}

@Riverpod(keepAlive: true)
class ShakeDetection extends _$ShakeDetection {
  @override
  List<ShakeDetectionEvent> build() {
    return ref.watch(shakeDetectionAcceptedSnapshotProvider)?.events ??
        const <ShakeDetectionEvent>[];
  }
}

import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/provider/clock/app_clock.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/realtime/data_source/eqmonitor/eqmonitor_ws_status_notifier.dart';
import 'package:eqmonitor/core/realtime/data_source/eqmonitor/eqmonitor_ws_status_state.dart';
import 'package:eqmonitor/core/realtime/model/realtime_event.dart';
import 'package:eqmonitor/core/realtime/realtime_event_provider.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_level_parser.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_snapshot.dart';
import 'package:eqmonitor/feature/shake_detection/data/notifier/shake_detection_snapshot_reducer.dart';
import 'package:eqmonitor/feature/shake_detection/data/repository/shake_detection_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shake_detection_provider.g.dart';

@Riverpod(keepAlive: true)
class ShakeDetection extends _$ShakeDetection {
  ShakeDetectionSnapshot? _snapshot;
  bool _readySeen = false;

  @override
  List<ShakeDetectionEvent> build() {
    ref.listen(eqMonitorWsStatusProvider, (_, next) {
      if (next.phase != WsPhase.connected) {
        _readySeen = false;
      }
    });

    ref.listen(isRealtimeModeProvider, (previous, next) async {
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
        case RealtimeShakeSnapshotEvent(:final data):
          if (!ref.read(isRealtimeModeProvider)) {
            return;
          }
          applySnapshot(
            ShakeDetectionSnapshot(
              revision: data.revision,
              responseAt: data.responseAt,
              events: data.events
                  .map(
                    (event) => ShakeDetectionEvent(
                      eventId: event.eventId,
                      serialNo: event.serialNo,
                      createdAt: event.createdAt,
                      updatedAt: event.updatedAt,
                      expiresAt: event.expiresAt,
                      level: event.level.toShakeDetectionLevel(),
                      pointCount: event.pointCount,
                      minLat: event.minLat,
                      maxLat: event.maxLat,
                      minLng: event.minLng,
                      maxLng: event.maxLng,
                      changeReasons: event.changeReasons,
                      correlatedEewEventId: event.correlatedEewEventId,
                    ),
                  )
                  .toList(growable: false),
            ),
          );
        default:
          return;
      }
    });

    if (!ref.watch(isRealtimeModeProvider)) {
      _snapshot = null;
      return [];
    }
    return _snapshot?.events ?? [];
  }

  Future<void> synchronizeFromRest() async {
    final repository = await ref.read(shakeDetectionRepositoryProvider.future);
    final result = await repository.fetchActive();
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

  void applySnapshot(ShakeDetectionSnapshot incoming) {
    final reducer = ref.read(shakeDetectionSnapshotReducerProvider);
    final selected = reducer.selectNewer(
      current: _snapshot,
      incoming: incoming,
    );
    if (identical(selected, _snapshot)) {
      return;
    }
    _snapshot = selected;
    state = selected.events;
  }
}

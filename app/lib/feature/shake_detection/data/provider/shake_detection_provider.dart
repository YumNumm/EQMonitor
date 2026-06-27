import 'dart:async';

import 'package:eqmonitor/core/provider/clock/app_clock.dart';
import 'package:eqmonitor/core/realtime/model/realtime_event.dart';
import 'package:eqmonitor/core/realtime/model/realtime_shake_data.dart';
import 'package:eqmonitor/core/realtime/realtime_event_provider.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shake_detection_provider.g.dart';

/// 揺れ検知が有効とみなす時間
const _eventTtl = Duration(minutes: 5);

@Riverpod(keepAlive: true)
class ShakeDetection extends _$ShakeDetection {
  @override
  List<ShakeDetectionEvent> build() {
    if (!ref.watch(isRealtimeModeProvider)) {
      return [];
    }

    ref.listen(realtimeEventsProvider, (_, next) {
      next.whenData(_onRealtimeEvent);
    });

    final timer = Timer.periodic(
      const Duration(minutes: 1),
      (_) => _cleanup(),
    );
    ref.onDispose(timer.cancel);
    return [];
  }

  void _onRealtimeEvent(RealtimeEvent event) {
    switch (event) {
      case RealtimeShakeDetectedEvent(:final data):
        _upsert(_fromShakeData(data));
      default:
        return;
    }
  }

  ShakeDetectionEvent _fromShakeData(RealtimeShakeData d) {
    final level = ShakeDetectionLevel.values.firstWhere(
      (e) => e.json == d.level,
      orElse: () => ShakeDetectionLevel.weaker,
    );
    return ShakeDetectionEvent(
      eventId: d.eventId,
      createdAt: d.createdAt,
      level: level,
      isReplay: d.isReplay,
      pointCount: d.pointCount,
      minLat: d.minLat,
      maxLat: d.maxLat,
      minLng: d.minLng,
      maxLng: d.maxLng,
    );
  }

  void _upsert(ShakeDetectionEvent event) {
    final current = [...state];
    final index = current.indexWhere((e) => e.eventId == event.eventId);
    if (index == -1) {
      current.add(event);
    } else {
      current[index] = event;
    }
    state = current;
  }

  void _cleanup() {
    final now = ref.read(appClockProvider.notifier).now().toUtc();
    state = state
        .where((e) => now.difference(e.createdAt.toUtc()) < _eventTtl)
        .toList();
  }
}

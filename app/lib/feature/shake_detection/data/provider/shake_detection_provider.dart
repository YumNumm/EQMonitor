import 'dart:async';

import 'package:eqmonitor/core/provider/websocket/websocket_connection_provider.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:eqmonitor_websocket/eqmonitor_websocket.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shake_detection_provider.g.dart';

/// 揺れ検知が有効とみなす時間
const _eventTtl = Duration(minutes: 5);

@Riverpod(keepAlive: true)
class ShakeDetection extends _$ShakeDetection {
  @override
  List<ShakeDetectionEvent> build() {
    ref.listen(wsConnectionProvider, (_, next) {
      next.whenData(_onWsMessage);
    });

    final timer = Timer.periodic(
      const Duration(minutes: 1),
      (_) => _cleanup(),
    );
    ref.onDispose(timer.cancel);
    return [];
  }

  void _onWsMessage(WsMessage msg) {
    if (msg case WsRealtimeMessage(:final data)) {
      if (data is WsShakeDetectedRealtimeEvent) {
        _upsert(data);
      }
    }
  }

  void _upsert(WsShakeDetectedRealtimeEvent ws) {
    final level = ShakeDetectionLevel.values.firstWhere(
      (e) => e.json == ws.level,
      orElse: () => ShakeDetectionLevel.weaker,
    );
    final event = ShakeDetectionEvent(
      eventId: ws.eventId,
      createdAt: ws.createdAt,
      level: level,
      isReplay: ws.isReplay,
      pointCount: ws.pointCount,
      minLat: ws.minLat,
      maxLat: ws.maxLat,
      minLng: ws.minLng,
      maxLng: ws.maxLng,
    );

    final current = [...state];
    final index = current.indexWhere((e) => e.eventId == ws.eventId);
    if (index == -1) {
      current.add(event);
    } else {
      current[index] = event;
    }
    state = current;
  }

  void _cleanup() {
    final now = DateTime.now().toUtc();
    state = state
        .where((e) => now.difference(e.createdAt.toUtc()) < _eventTtl)
        .toList();
  }
}

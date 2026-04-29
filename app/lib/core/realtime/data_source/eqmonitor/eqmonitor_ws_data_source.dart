import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/core/provider/app_lifecycle.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/realtime/data_source/eqmonitor/eqmonitor_ws_status_notifier.dart';
import 'package:eqmonitor/core/realtime/model/realtime_event.dart';
import 'package:eqmonitor/core/realtime/model/realtime_shake_data.dart';
import 'package:eqmonitor_websocket/eqmonitor_websocket.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'eqmonitor_ws_data_source.g.dart';

@Riverpod(keepAlive: true)
class EqMonitorWsDataSource extends _$EqMonitorWsDataSource {
  WebSocket? _ws;
  var _disposed = false;

  @override
  Stream<RealtimeEvent> build() async* {
    final controller = StreamController<RealtimeEvent>();
    _disposed = false;
    _ws = null;

    ref.onDispose(() {
      _disposed = true;
      unawaited(
        _ws?.close(WebSocketStatus.normalClosure, 'disposed') ??
            Future<void>.value(),
      );
      unawaited(controller.close());
    });

    ref.listen(appLifecycleProvider, (_, next) {
      if (next == AppLifecycleState.paused) {
        unawaited(
          _ws?.close(WebSocketStatus.normalClosure, 'paused') ??
              Future<void>.value(),
        );
        talker.debug('EqMonitorWS: closed (paused)');
      }
      if (next == AppLifecycleState.resumed) {
        ref.invalidateSelf();
      }
    });

    unawaited(_connectWithRetry(controller));
    yield* controller.stream;
  }

  Future<void> _connectWithRetry(
    StreamController<RealtimeEvent> controller,
  ) async {
    var retryCount = 0;
    while (!_disposed && !controller.isClosed) {
      try {
        await _connect(controller);
        retryCount = 0;
      } on Exception catch (e, st) {
        if (_disposed || controller.isClosed) break;
        final delay = min(pow(2, retryCount).toInt(), 60);
        retryCount = min(retryCount + 1, 6);
        talker.warning(
          'EqMonitorWS: reconnect in ${delay}s (attempt $retryCount)\n$e\n$st',
        );
        ref.read(eqMonitorWsStatusProvider.notifier).setDisconnected();
        await Future<void>.delayed(Duration(seconds: delay));
      }
    }
    if (!controller.isClosed) unawaited(controller.close());
  }

  Future<void> _connect(StreamController<RealtimeEvent> controller) async {
    final statusNotifier = ref.read(eqMonitorWsStatusProvider.notifier);
    statusNotifier.setConnecting();

    final api = await ref.read(apiClientProvider.future);
    final ticketResponse = await api.realtime.getV2RealtimeTicket();
    final url = ticketResponse.data.url;

    talker.debug('EqMonitorWS: connecting');
    _ws = await WebSocket.connect(url);
    statusNotifier.setConnected(url: url);
    talker.info('EqMonitorWS: connected');

    try {
      await for (final rawMessage in _ws!) {
        if (_disposed || controller.isClosed) break;
        if (rawMessage is! String) continue;

        Map<String, dynamic> decoded;
        try {
          decoded = jsonDecode(rawMessage) as Map<String, dynamic>;
        } on FormatException catch (e) {
          talker.warning('EqMonitorWS: invalid JSON: $e');
          continue;
        }

        final type = decoded['type'] as String?;
        if (type == 'ping') {
          statusNotifier.recordPing();
          _ws?.add(jsonEncode({'type': 'pong'}));
          continue;
        }

        WsMessage message;
        try {
          message = WsMessage.fromJson(decoded);
        } on Exception catch (e) {
          talker.warning(
            'EqMonitorWS: failed to parse message (type=$type): $e',
          );
          continue;
        }

        talker.log('EqMonitorWS message ($type)');
        for (final event in _toRealtimeEvents(message)) {
          controller.add(event);
        }
      }
    } finally {
      statusNotifier.setDisconnected();
    }
  }

  List<RealtimeEvent> _toRealtimeEvents(WsMessage msg) {
    return switch (msg) {
      WsSnapshotMessage(:final data) => [
        RealtimeEvent.snapshot(
          eews: data.eews,
          earthquakes: data.earthquakes,
          shakes: data.shakes.map(_toRealtimeShakeData).toList(),
          source: RealtimeSource.eqmonitor,
        ),
      ],
      WsRealtimeMessage(:final data) => switch (data) {
        WsEewRealtimeEvent(:final item) => [
          RealtimeEvent.eewUpsert(
            item: item,
            source: RealtimeSource.eqmonitor,
          ),
        ],
        WsEarthquakeRealtimeEvent(
          :final operation,
          :final eventId,
          :final record,
        ) =>
          switch (operation) {
            'upsert' when record != null => [
              RealtimeEvent.earthquakeUpsert(
                record: record,
                source: RealtimeSource.eqmonitor,
              ),
            ],
            'delete' => [
              RealtimeEvent.earthquakeDelete(
                eventId: eventId,
                source: RealtimeSource.eqmonitor,
              ),
            ],
            _ => const <RealtimeEvent>[],
          },
        WsShakeDetectedRealtimeEvent(
          :final eventId,
          :final createdAt,
          :final level,
          :final changeReasons,
          :final isReplay,
          :final pointCount,
          :final region,
        ) =>
          [
            RealtimeEvent.shakeDetected(
              data: RealtimeShakeData(
                eventId: eventId,
                createdAt: createdAt,
                level: level,
                isReplay: isReplay,
                pointCount: pointCount,
                minLat: region.bottomRight.latitude,
                maxLat: region.topLeft.latitude,
                minLng: region.topLeft.longitude,
                maxLng: region.bottomRight.longitude,
                changeReasons: changeReasons,
              ),
              source: RealtimeSource.eqmonitor,
            ),
          ],
        _ => const <RealtimeEvent>[],
      },
    };
  }

  RealtimeShakeData _toRealtimeShakeData(WsSnapshotShakeEntry e) =>
      RealtimeShakeData(
        eventId: e.eventId,
        createdAt: e.createdAt,
        level: e.level,
        isReplay: e.isReplay,
        pointCount: e.pointCount,
        minLat: e.region.bottomRight.latitude,
        maxLat: e.region.topLeft.latitude,
        minLng: e.region.topLeft.longitude,
        maxLng: e.region.bottomRight.longitude,
        changeReasons: e.changeReasons,
      );
}

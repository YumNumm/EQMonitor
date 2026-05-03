import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/core/provider/app_lifecycle.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/realtime/data_source/eqmonitor/eqmonitor_ws_status_state.dart';
import 'package:eqmonitor/core/realtime/model/realtime_event.dart';
import 'package:eqmonitor/core/realtime/model/realtime_shake_data.dart';
import 'package:eqmonitor_websocket/eqmonitor_websocket.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'eqmonitor_ws_status_notifier.g.dart';

@Riverpod(keepAlive: true)
class EqMonitorWsStatus extends _$EqMonitorWsStatus {
  WebSocket? _ws;
  var _buildVersion = 0;

  // broadcast controller persists across rebuilds for the lifetime of the notifier
  final _eventController = StreamController<RealtimeEvent>.broadcast();

  Stream<RealtimeEvent> get eventStream => _eventController.stream;

  @override
  EqMonitorWsStatusState build() {
    final version = ++_buildVersion;
    bool isActive() => _buildVersion == version && !_eventController.isClosed;
    _ws = null;

    ref.onDispose(() {
      unawaited(
        _ws?.close(WebSocketStatus.normalClosure, 'disposed') ??
            Future<void>.value(),
      );
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

    unawaited(_connectWithRetry(isActive));
    return const EqMonitorWsStatusState();
  }

  Future<void> _connectWithRetry(bool Function() isActive) async {
    var retryCount = 0;
    while (isActive()) {
      try {
        await _connect(isActive);
        retryCount = 0;
      } on Exception catch (e, st) {
        if (!isActive()) {
          break;
        }
        final delay = min(pow(2, retryCount).toInt(), 60);
        retryCount = min(retryCount + 1, 6);
        talker.warning(
          'EqMonitorWS: reconnect in ${delay}s (attempt $retryCount)\n$e\n$st',
        );
        _setDisconnected();
        await Future<void>.delayed(Duration(seconds: delay));
      }
    }
  }

  Future<void> _connect(bool Function() isActive) async {
    _setConnecting();

    final api = await ref.read(apiClientProvider.future);
    final ticketResponse = await api.realtime.getV2RealtimeTicket();
    final url = ticketResponse.data.url;

    talker.debug('EqMonitorWS: connecting');
    _ws = await WebSocket.connect(url);
    _setConnected(url);
    talker.info('EqMonitorWS: connected');

    try {
      await for (final rawMessage in _ws!) {
        if (!isActive() || _eventController.isClosed) {
          break;
        }
        if (rawMessage is! String) {
          continue;
        }

        Map<String, dynamic> decoded;
        try {
          decoded = jsonDecode(rawMessage) as Map<String, dynamic>;
        } on FormatException catch (e) {
          talker.warning('EqMonitorWS: invalid JSON: $e');
          continue;
        }

        WsMessage message;
        try {
          message = WsMessage.fromJson(decoded);
        } on Exception catch (e) {
          talker.warning('EqMonitorWS: failed to parse message: $e');
          continue;
        }

        if (message is WsPingMessage) {
          _recordPing();
          _ws?.add(jsonEncode(const WsPongMessage().toJson()));
          continue;
        }

        talker.log('EqMonitorWS message (${message.runtimeType})');
        for (final event in _toRealtimeEvents(message)) {
          if (!_eventController.isClosed) {
            _eventController.add(event);
          }
        }
      }
    } finally {
      _setDisconnected();
    }
  }

  void _setConnecting() {
    state = state.copyWith(phase: WsPhase.connecting);
  }

  void _setConnected(String url) {
    state = state.copyWith(
      phase: WsPhase.connected,
      currentUrl: _maskTicket(url),
    );
  }

  void _setDisconnected() {
    state = state.copyWith(phase: WsPhase.disconnected);
  }

  void _recordPing() {
    final now = DateTime.now();
    final prev = state.lastPingAt;
    state = state.copyWith(
      lastPingAt: now,
      pingRtt: prev != null ? now.difference(prev) : state.pingRtt,
    );
  }

  String _maskTicket(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null) {
      return url;
    }
    final params = Map<String, String>.from(uri.queryParameters);
    if (params.containsKey('ticket')) {
      params['ticket'] = '<masked>';
    }
    return uri.replace(queryParameters: params).toString();
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
            WsRealtimeOperation.upsert when record != null => [
              RealtimeEvent.earthquakeUpsert(
                record: record,
                source: RealtimeSource.eqmonitor,
              ),
            ],
            WsRealtimeOperation.delete => [
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
        WsEstimatedIntensityRealtimeEvent(:final estimatedIntensity) => [
          RealtimeEvent.estimatedIntensityUpsert(
            eventId: estimatedIntensity.eventId,
            estimatedIntensityTile:
                '$_tilesBaseUrl/${estimatedIntensity.estimatedIntensityKey}',
            source: RealtimeSource.eqmonitor,
          ),
        ],
        _ => const <RealtimeEvent>[],
      },
      WsPingMessage() => const <RealtimeEvent>[],
    };
  }

  static const _tilesBaseUrl = 'https://tiles.eqmonitor.app';

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

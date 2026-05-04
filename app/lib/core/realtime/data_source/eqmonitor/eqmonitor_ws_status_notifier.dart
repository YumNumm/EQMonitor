import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/core/provider/app_lifecycle.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/realtime/data_source/eqmonitor/eqmonitor_realtime_event_mapper.dart';
import 'package:eqmonitor/core/realtime/data_source/eqmonitor/eqmonitor_ws_status_state.dart';
import 'package:eqmonitor/core/realtime/model/realtime_event.dart';
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
    final realtimeEventMapper = ref.watch(eqMonitorRealtimeEventMapperProvider);
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

    unawaited(_connectWithRetry(isActive, realtimeEventMapper));
    return const EqMonitorWsStatusState();
  }

  Future<void> _connectWithRetry(
    bool Function() isActive,
    EqMonitorRealtimeEventMapper realtimeEventMapper,
  ) async {
    var retryCount = 0;
    while (isActive()) {
      try {
        await _connect(isActive, realtimeEventMapper);
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

  Future<void> _connect(
    bool Function() isActive,
    EqMonitorRealtimeEventMapper realtimeEventMapper,
  ) async {
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
        for (final event in realtimeEventMapper.map(message)) {
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
}

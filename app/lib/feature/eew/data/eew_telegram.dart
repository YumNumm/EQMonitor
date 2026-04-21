import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/core/model/websocket/realtime_event_envelope.dart';
import 'package:eqmonitor/core/model/websocket/ws_message.dart';
import 'package:eqmonitor/core/provider/app_lifecycle.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/provider/websocket/websocket_connection_provider.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'eew_telegram.g.dart';

@Riverpod(keepAlive: true)
class Eew extends _$Eew {
  @override
  AsyncValue<List<EewTelegramItem>> build() {
    final restResult = ref.watch(_eewRestProvider);

    ref.listen(appLifecycleProvider, (_, next) {
      if (next == AppLifecycleState.resumed) {
        log('AppLifecycleState.resumed: Refetch EEW');
        _refetchRestApi();
      }
    });

    ref.listen(wsConnectionProvider, (_, next) {
      next.whenData(_onWsMessage);
    });

    final refreshTimer = Timer.periodic(
      const Duration(seconds: 10),
      (_) => _refetchRestApi(),
    );
    ref.onDispose(refreshTimer.cancel);
    return restResult;
  }

  void _refetchRestApi() {
    if (ref.read(appLifecycleProvider) != AppLifecycleState.resumed) {
      return;
    }
    talker.log('Refetch EEW');
    ref.invalidate(_eewRestProvider);
  }

  void _onWsMessage(WsMessage msg) {
    switch (msg) {
      case WsSnapshotMessage(:final data):
        // スナップショットの eews を直接反映
        final items = data.eews.map((e) => e.toEewTelegramItem()).toList();
        state = AsyncData(items);
      case WsRealtimeMessage(:final data):
        if (data is WsEewRealtimeEvent) {
          _upsert(data.item.toEewTelegramItem());
        }
    }
  }

  void _upsert(EewTelegramItem item) {
    final dataView = state.value ?? [];
    final data = [...dataView];
    final rawIndex = data.indexWhere((e) => e.eventId == item.eventId);
    final index = rawIndex == -1 ? null : rawIndex;
    if (index != null) {
      final previous = data[index];
      if (previous.serialNo <= item.serialNo) {
        data[index] = item;
      }
    } else {
      data.add(item);
    }
    state = AsyncData(data);
  }

  void upsert(EewTelegramItem eew) {
    _upsert(eew);
  }
}

@Riverpod(keepAlive: true)
Future<List<EewTelegramItem>> _eewRest(Ref ref) async {
  final api = await ref.watch(apiClientProvider.future);
  final response = await api.eew.getV2EewLatest();
  return response.data.items
      .map((e) => e.toEewTelegramItem())
      .toList();
}

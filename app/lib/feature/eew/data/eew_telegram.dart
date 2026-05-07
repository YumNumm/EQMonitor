import 'dart:async';
import 'dart:ui';

import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/core/provider/app_lifecycle.dart';
import 'package:eqmonitor/core/realtime/data_source/eqmonitor/eqmonitor_ws_status_notifier.dart';
import 'package:eqmonitor/core/realtime/data_source/eqmonitor/eqmonitor_ws_status_state.dart';
import 'package:eqmonitor/core/realtime/model/realtime_event.dart';
import 'package:eqmonitor/core/realtime/realtime_event_provider.dart';
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
        ref.invalidate(_eewRestProvider);
      }
    });

    ref.listen(realtimeEventsProvider, (_, next) {
      next.whenData((event) {
        switch (event) {
          case RealtimeSnapshotEvent(:final eews):
            state = AsyncData(eews.map((e) => e.toEewTelegramItem()).toList());
          case RealtimeEewUpsertEvent(:final item):
            _upsert(item.toEewTelegramItem());
          default:
            return;
        }
      });
    });

    final refreshTimer = Timer.periodic(
      const Duration(seconds: 10),
      (_) {
        final wsPhase = ref.read(eqMonitorWsStatusProvider).phase;
        if (wsPhase != WsPhase.connected) {
          ref.invalidate(_eewRestProvider);
        }
      },
    );
    ref.onDispose(refreshTimer.cancel);
    return restResult;
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
  return response.data.items.map((e) => e.toEewTelegramItem()).toList();
}

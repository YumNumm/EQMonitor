import 'dart:developer';

import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/api/eq_api.dart';
import 'package:eqmonitor/core/provider/websocket/websocket_provider.dart';
import 'package:extensions/extensions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shake_detection_provider.g.dart';

@Riverpod(keepAlive: true)
class ShakeDetection extends _$ShakeDetection {
  @override
  Future<List<ShakeDetectionEvent>> build() async {
    final apiResult =
        await ref.watch(_fetchShakeDetectionEventsProvider.future);
    ref.listen(
      websocketTableMessagesProvider<ShakeDetectionWebSocketTelegram>(),
      (_, next) {
        if (next case AsyncData(value: final value)) {
          if (value
              case RealtimePostgresInsertPayload<
                  ShakeDetectionWebSocketTelegram>()) {
            for (final event in value.newData.events) {
              _upsertShakeDetectionEvents([event]);
            }
          } else if (value
              case RealtimePostgresDeletePayload<
                  ShakeDetectionWebSocketTelegram>()) {
            state = const AsyncData([]);
          } else {
            log('unknown value: $value');
          }
        }
      },
    );
    return apiResult;
  }

  void _upsertShakeDetectionEvents(
    List<ShakeDetectionEvent> events,
  ) {
    final currentEvents = state.valueOrNull ?? [];
    final data = [...currentEvents];
    for (final event in events) {
      final index = data.indexWhereOrNull((e) => e.eventId == event.eventId);
      if (index == null) {
        data.add(event);
      } else {
        data[index] = event;
      }
    }
    state = AsyncData(data);
  }
}

@Riverpod(keepAlive: true)
Future<List<ShakeDetectionEvent>> _fetchShakeDetectionEvents(
  _FetchShakeDetectionEventsRef ref,
) async =>
    ref.watch(eqApiProvider).v1.getLatestShakeDetectionEvents();

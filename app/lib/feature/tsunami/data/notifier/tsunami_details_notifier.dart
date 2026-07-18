import 'dart:async';

import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/core/realtime/model/realtime_event.dart';
import 'package:eqmonitor/core/realtime/realtime_event_provider.dart';
import 'package:eqmonitor/feature/tsunami/data/notifier/tsunami_telegrams_provider.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tsunami_details_notifier.g.dart';

bool isTsunamiRealtimeEventForId({
  required RealtimeEvent event,
  required String tsunamiId,
}) => switch (event) {
  RealtimeReadyEvent() => true,
  RealtimeTsunamiUpsertEvent(:final eventId, :final groupId) ||
  RealtimeTsunamiDeleteEvent(
    :final eventId,
    :final groupId,
  ) => eventId == tsunamiId || groupId == tsunamiId,
  _ => false,
};

@riverpod
class TsunamiDetailsNotifier extends _$TsunamiDetailsNotifier {
  Timer? _refreshTimer;

  @override
  Future<TsunamiState> build(String tsunamiId) async {
    ref.onDispose(() => _refreshTimer?.cancel());
    ref.listen(realtimeEventsProvider, (_, next) {
      next.whenData((event) {
        if (!isTsunamiRealtimeEventForId(event: event, tsunamiId: tsunamiId)) {
          return;
        }
        ref
          ..invalidate(tsunamiTelegramsProvider(tsunamiId), asReload: true)
          ..invalidate(tsunamiDetailsProvider(tsunamiId), asReload: true);
      });
    });
    final result = await _fetch();
    if (result.isActive) {
      _startPolling();
    }
    return result;
  }

  Future<TsunamiState> _fetch() async {
    final client = await ref.read(apiClientProvider.future);
    final response = await client.tsunami.getV2TsunamiTsunamiId(
      tsunamiId: tsunamiId,
    );
    return response.data;
  }

  void _startPolling() {
    _refreshTimer?.cancel();
    _refreshTimer = Timer.periodic(const Duration(seconds: 30), (_) async {
      state = await AsyncValue.guard(_fetch);
      if (state case AsyncData(value: final tsunami) when !tsunami.isActive) {
        _refreshTimer?.cancel();
      }
    });
  }
}

import 'package:eqmonitor/core/provider/cached_notifier.dart';
import 'package:eqmonitor/core/realtime/model/realtime_event.dart';
import 'package:eqmonitor/core/realtime/realtime_event_provider.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart'
    hide RealtimeEarthquakeUpsertEvent, TelegramStatus, TelegramType;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'telegram_details_notifier.g.dart';

@riverpod
class TelegramDetails extends _$TelegramDetails
    with CachedNotifier<Map<String, TelegramDetailResponse>> {
  @override
  Future<Map<String, TelegramDetailResponse>> build(String eventId) {
    ref.listen(realtimeEventsProvider, (_, next) {
      if (next case AsyncData(
        value: RealtimeEarthquakeUpsertEvent(:final record),
      ) when record.eventId == eventId) {
        ref.invalidateSelf();
      }
    });
    return cachedBuild();
  }

  @override
  Future<Map<String, TelegramDetailResponse>> fetch(ApiClient client) async {
    final response = await client.telegram.getV2TelegramEventIdEventIdDetails(
      eventId: eventId,
    );

    return {for (final item in response.data.items) item.telegram.id: item};
  }
}

import 'package:eqmonitor/core/provider/cached_notifier.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart'
    hide TelegramStatus, TelegramType;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'telegram_details_notifier.g.dart';

@riverpod
class TelegramDetails extends _$TelegramDetails
    with CachedNotifier<Map<String, TelegramDetailResponse>> {
  @override
  Future<Map<String, TelegramDetailResponse>> build(String eventId) =>
      cachedBuild();

  @override
  Future<Map<String, TelegramDetailResponse>> fetch(ApiClient client) async {
    final response = await client.telegram.getV2TelegramEventIdEventIdDetails(
      eventId: eventId,
    );

    return {for (final item in response.data.items) item.telegram.id: item};
  }
}

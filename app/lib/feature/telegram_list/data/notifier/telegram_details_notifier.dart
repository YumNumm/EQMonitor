import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart'
    hide TelegramStatus, TelegramType;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'telegram_details_notifier.g.dart';

@riverpod
Future<Map<String, TelegramDetailResponse>> telegramDetails(
  Ref ref,
  String eventId,
) async {
  final client = await ref.read(apiClientProvider.future);
  final response =
      await client.telegram.getV2TelegramEventIdEventIdDetails(
    eventId: eventId,
  );

  return {
    for (final item in response.data.items)
      item.telegram.id: item,
  };
}

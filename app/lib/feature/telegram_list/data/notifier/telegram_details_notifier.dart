import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/core/model/telegram/telegram_type.dart';
import 'package:eqmonitor/feature/telegram_list/data/notifier/telegram_list_by_event_id_notifier.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart'
    hide TelegramStatus, TelegramType;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'telegram_details_notifier.g.dart';

const Set<TelegramType> _targetTypes = {
  TelegramType.vxse51,
  TelegramType.vxse52,
  TelegramType.vxse53,
  TelegramType.vxse61,
  TelegramType.vxse62,
};

@riverpod
Future<Map<String, TelegramDetailResponse>> telegramDetails(
  Ref ref,
  String eventId,
) async {
  final listState = await ref.watch(
    telegramListByEventIdProvider(eventId).future,
  );
  final targets = listState.items
      .where((t) => _targetTypes.contains(t.type))
      .toList();

  if (targets.isEmpty) {
    return {};
  }

  final client = await ref.read(apiClientProvider.future);
  final responses = await Future.wait(
    targets.map(
      (t) => client.telegram.getV2TelegramId(id: t.id),
    ),
  );

  return {
    for (var i = 0; i < targets.length; i++)
      targets[i].id: responses[i].data,
  };
}

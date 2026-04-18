import 'dart:developer';

import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/feature/eew/data/eew_telegram.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'eew_by_event_id.g.dart';

@riverpod
class EewsByEventId extends _$EewsByEventId {
  @override
  Future<List<EewTelegramItem>> build(String eventId) async {
    final client = await ref.watch(apiClientProvider.future);
    final response = await client.eew.getV2EewEventId(eventId: eventId);

    ref.listen(eewProvider, (_, next) {
      if (state is! AsyncData) {
        log('EewsByEventId Provider is not AsyncData state so ignore.');
        return;
      }
      if (next case AsyncData(:final value)) {
        final eews = value.where((e) => e.eventId == eventId).toList();
        final currentEews = state.value ?? <EewTelegramItem>[];
        for (final eew in eews) {
          if (!currentEews.any((e) => e.serialNo == eew.serialNo)) {
            state = AsyncData([...currentEews, eew]);
          }
        }
      }
    });

    return response.data.items.map((e) => e.toEewTelegramItem()).toList();
  }
}

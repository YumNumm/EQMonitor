import 'dart:developer';

import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/feature/eew/data/eew_telegram.dart';
import 'package:eqmonitor_api/export.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'eew_by_event_id.g.dart';

@riverpod
class EewsByEventId extends _$EewsByEventId {
  @override
  Future<List<EewItemWithRelations>> build(String eventId) async {
    final client = ref.watch(apiClientProvider);
    final response = await client.eew.getV2EewEventId(eventId: eventId);

    ref.listen(eewProvider, (_, next) {
      if (state is! AsyncData) {
        log('EewsByEventId Provider is not AsyncData state so ignore.');
        return;
      }
      if (next case AsyncData(value: final value)) {
        final eews = value.where((e) => e.eventId == eventId).toList();
        final currentEews = state.value ?? <EewItemWithRelations>[];
        for (final eew in eews) {
          if (!currentEews.any((e) => e.serialNo == eew.serialNo)) {
            state = AsyncData([...currentEews, eew]);
          }
        }
      }
    });

    return response.data.items;
  }
}

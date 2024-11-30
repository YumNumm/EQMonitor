import 'dart:developer';

import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/api/eq_api.dart';
import 'package:eqmonitor/feature/eew/data/eew_telegram.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'eew_by_event_id.g.dart';

@riverpod
class EewsByEventId extends _$EewsByEventId {
  @override
  Future<List<EewV1>> build(String eventId) async {
    final client = ref.watch(eqApiProvider);
    final response = await client.v1.getEewByEventId(
      eventId: eventId,
    );

    // Start Listening Eew
    // to update the list
    ref.listen(eewProvider, (_, next) {
      if (state is! AsyncData) {
        log('EewsByEventId Provider is not AsyncData state so ignore.');
        return;
      }
      if (next case AsyncData(value: final value)) {
        final eews =
            value.where((e) => e.eventId.toString() == eventId).toList();
        final currentEews = state.valueOrNull ?? <EewV1>[];
        for (final eew in eews) {
          if (!currentEews.contains(eew)) {
            state = AsyncData(currentEews + [eew]);
          }
        }
      }
    });

    return response.data;
  }
}

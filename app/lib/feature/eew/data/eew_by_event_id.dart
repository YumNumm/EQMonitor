import 'package:collection/collection.dart';
import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/eew/data/eew.dart';
import 'package:eqmonitor/feature/eew/data/logic/eew_report_history_merger.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/subscription/data/provider/is_pro_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'eew_by_event_id.g.dart';

@riverpod
class EewsByEventId extends _$EewsByEventId {
  @override
  Future<List<EewTelegramItem>> build(String eventId) async {
    if (!ref.watch(isProProvider)) return const [];
    final merger = ref.watch(eewReportHistoryMergerProvider);
    final initialReports = switch (ref.read(eewProvider)) {
      AsyncData(:final value) =>
        value.where((eew) => eew.eventId == eventId).toList(),
      _ => <EewTelegramItem>[],
    };
    var receivedReports = <EewTelegramItem>[];
    var lastRealtimeReports = initialReports;

    ref.listen(
      eewProvider,
      (_, next) {
        if (next case AsyncData(:final value)) {
          final updates = value.where((eew) => eew.eventId == eventId).toList();
          if (const ListEquality<EewTelegramItem>().equals(
            lastRealtimeReports,
            updates,
          )) {
            return;
          }
          lastRealtimeReports = updates;
          if (updates.isEmpty) {
            return;
          }
          if (state case AsyncData(:final value, isLoading: false)) {
            final merged = merger.merge(
              eventId: eventId,
              reports: [...value, ...updates],
            );
            if (!const ListEquality<EewTelegramItem>().equals(value, merged)) {
              state = AsyncData(merged);
            }
          } else {
            receivedReports = merger.merge(
              eventId: eventId,
              reports: [...receivedReports, ...updates],
            );
          }
        }
      },
      onError: (error, stackTrace) => talker.handle(error, stackTrace),
    );

    final client = await ref.watch(apiClientProvider.future);
    if (!ref.mounted || !ref.read(isProProvider)) return const [];
    final response = await client.eew.getV2EewEventId(eventId: eventId);

    if (!ref.mounted || !ref.read(isProProvider)) return const [];

    // 同時刻の報はAPI応答を既存値より優先し、取得中に届いた更新を最後に適用する。
    return merger.merge(
      eventId: eventId,
      reports: [
        ...initialReports,
        ...response.data.items.map((e) => e.toEewTelegramItem),
        ...receivedReports,
      ],
    );
  }
}

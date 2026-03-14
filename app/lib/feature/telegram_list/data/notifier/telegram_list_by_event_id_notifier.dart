import 'package:collection/collection.dart';
import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/core/extension/async_value.dart';
import 'package:eqmonitor/feature/telegram_list/data/model/telegram_item.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'telegram_list_by_event_id_notifier.g.dart';

typedef TelegramListByEventIdState = ({
  List<TelegramItem> items,
  String? nextToken,
});

@riverpod
class TelegramListByEventId extends _$TelegramListByEventId {
  @override
  Future<TelegramListByEventIdState> build(String eventId) async {
    return _fetchInitialData();
  }

  Future<TelegramListByEventIdState> _fetchInitialData() async {
    final client = ref.read(apiClientProvider);
    final response = await client.telegram.getV2TelegramEventIdEventId(
      eventId: eventId,
      limit: '50',
    );
    final data = response.data;
    return (
      items: data.items.map((e) => e.toTelegramItem).toList(),
      nextToken: data.nextToken,
    );
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard<TelegramListByEventIdState>(
      _fetchInitialData,
    );
  }

  Future<void> fetchNextData() async {
    if (state.isRefreshing || state.isReloading) {
      return;
    }
    final currentState = state.value;
    if (currentState == null || currentState.nextToken == null) {
      return;
    }

    state = await state.guardPlus(() async {
      final client = ref.read(apiClientProvider);
      final response = await client.telegram.getV2TelegramEventIdEventId(
        eventId: eventId,
        limit: '50',
      );
      final data = response.data;
      final mergedItems = <TelegramItem>[
        ...currentState.items,
        ...data.items.map((e) => e.toTelegramItem),
      ].sorted((a, b) => b.pressAt.compareTo(a.pressAt));
      return (
        items: mergedItems,
        nextToken: data.nextToken,
      );
    });
  }
}

extension TelegramListByEventIdStateEx on TelegramListByEventIdState {
  bool get hasNext => nextToken != null;
}

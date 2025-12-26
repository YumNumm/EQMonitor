import 'package:collection/collection.dart';
import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/api/eq_api.dart';
import 'package:eqmonitor/core/extension/async_value.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'telegram_list_by_event_id_notifier.g.dart';

typedef TelegramListByEventIdState = ({
  List<Telegram> items,
  String? nextToken,
});

@riverpod
class TelegramListByEventId extends _$TelegramListByEventId {
  @override
  Future<TelegramListByEventIdState> build(String eventId) async {
    return _fetchInitialData();
  }

  Future<TelegramListByEventIdState> _fetchInitialData() async {
    final client = ref.read(eqApiProvider);
    final response = await client.telegram.getListByEventId(
      eventId: eventId,
      limit: 50,
    );
    return (
      items: response.items,
      nextToken: response.nextToken,
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
      final client = ref.read(eqApiProvider);
      final response = await client.telegram.getListByEventId(
        eventId: eventId,
        cursor: currentState.nextToken,
        limit: 50,
      );
      final mergedItems = <Telegram>[
        ...currentState.items,
        ...response.items,
      ].sorted((a, b) => b.pressAt.compareTo(a.pressAt));
      return (
        items: mergedItems,
        nextToken: response.nextToken,
      );
    });
  }
}

extension TelegramListByEventIdStateEx on TelegramListByEventIdState {
  bool get hasNext => nextToken != null;
}

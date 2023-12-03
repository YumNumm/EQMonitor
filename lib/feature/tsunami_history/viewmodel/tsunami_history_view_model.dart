import 'package:eqmonitor/core/extension/async_value.dart';
import 'package:eqmonitor/feature/tsunami_history/model/tsunami_history_model.dart';
import 'package:eqmonitor/feature/tsunami_history/use_case/tsunami_history_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tsunami_history_view_model.g.dart';

@Riverpod(keepAlive: true)
class TsunamiHistoryViewModel extends _$TsunamiHistoryViewModel {
  @override
  AsyncValue<List<TsunamiHistoryItem>>? build() {
    return null;
  }

  Future<void> loadIfNull() async {
    if (state == null) {
      return fetch();
    }
  }

  Future<void> fetch({
    bool isLoadMore = false,
  }) async {
    if (state is AsyncLoading) {
      return;
    }

    if (isLoadMore && state != null) {
      state = const AsyncLoading<List<TsunamiHistoryItem>>()
          .copyWithPrevious(state!);
    } else {
      state = const AsyncLoading<List<TsunamiHistoryItem>>();
    }

    state = await state!.guardPlus(() async {
      final offset = state?.value?.length ?? 0;
      final result =
          await ref.read(tsunamiHistoryUseCaseProvider).getTsunamiHistory(
                limit: 2,
                offset: offset,
              );
      return result.entries
          .map((e) => TsunamiHistoryItem.fromTelegramV3s(e.value))
          .toList();
    });
  }
}

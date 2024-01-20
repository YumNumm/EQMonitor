import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/feature/information_history/repository/information_repository.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'information_history_view_model.g.dart';

@Riverpod(keepAlive: true)
class InformationHistoryViewModel extends _$InformationHistoryViewModel {
  @override
  AsyncValue<List<InformationV3>>? build() => null;

  Future<void> update({
    required bool loadMore,
  }) async {
    if (state?.isLoading ?? false) {
      return;
    }
    if (state != null) {
      state =
          const AsyncLoading<List<InformationV3>>().copyWithPrevious(state!);
    } else {
      state = const AsyncLoading<List<InformationV3>>();
    }
    final offset = state?.valueOrNull?.length ?? 0;
    final res = await ref
        .read(informationRepositoryProvider)
        .fetchInformation(limit: offset == 0 ? 10 : 50, offset: offset);
    final _ = switch (res) {
      Success(:final value) => state = AsyncData([
          ...state?.valueOrNull ?? [],
          ...value.items,
        ]),
      Failure(:final exception, :final stackTrace) => state =
            AsyncError<List<InformationV3>>(
          exception,
          stackTrace ?? StackTrace.current,
        ).copyWithPrevious(state!),
    };
  }

  Future<void> updateIfNull() async {
    if (state == null) {
      await update(loadMore: false);
    }
  }

  void onScrollPositionChanged(ScrollController controller) {
    // エラー発生時・リロード中は何もしない
    if (state == null) {
      return;
    }
    if (state!.hasError || state!.isRefreshing || state!.isReloading) {
      return;
    }
    if (controller.position.maxScrollExtent - controller.position.pixels < 20) {
      update(loadMore: true);
    }
  }
}

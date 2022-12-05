import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../api/remote/supabase/information.dart';
import '../../../model/database/information/information.dart';

final informationViewModel =
    StateNotifierProvider<InformationViewModel, AsyncValue<List<Information>>>(
  InformationViewModel.new,
);

class InformationViewModel
    extends StateNotifier<AsyncValue<List<Information>>> {
  InformationViewModel(this.ref) : super(const AsyncValue.loading());

  final Ref ref;

  /// Informationの総数を管理
  int? _totalInformationsCount;

  /// 追加読み込み
  Future<void> fetch() async {
    state = const AsyncLoading<List<Information>>().copyWithPrevious(state);

    // Informationの総数を取得できていない場合は、先に取得する
    if (_totalInformationsCount == null) {
      await getTotalCount();
    }

    state = await AsyncValue.guard(() async {
      // Informationを取得
      final information = await SupabaseInformationApi.getInformation(
        offset: state.value?.length ?? 0,
      );

      return [...state.value ?? [], ...information];
    });
  }

  /// stateをリセットして再取得
  Future<void> refresh() async {
    state = const AsyncLoading<List<Information>>();
    await fetch();
  }

  Future<void> getTotalCount() async {
    final count = await SupabaseInformationApi.getAllInformationsCount();
    _totalInformationsCount = count;
  }

  /// Informationの総数を取得できていない場合は`false`となります
  bool get canLoadMore {
    final totalCount = _totalInformationsCount;
    return totalCount != null && totalCount > (state.value?.length ?? 0);
  }

  int? get totalInformationsCount => _totalInformationsCount;
}

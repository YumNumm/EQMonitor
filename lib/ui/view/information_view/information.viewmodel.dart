import 'package:eqmonitor/api/remote/supabase/information.dart';
import 'package:eqmonitor/model/database/information/information.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final informationViewModel =
    StateNotifierProvider<InformationViewModel, AsyncValue<List<Information>>>(
  InformationViewModel.new,
);

class InformationViewModel
    extends StateNotifier<AsyncValue<List<Information>>> {
  InformationViewModel(this.ref) : super(const AsyncValue.loading());

  final Ref ref;

  /// 追加読み込み
  Future<void> fetch() async {
    state = const AsyncLoading<List<Information>>().copyWithPrevious(state);

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
}

import 'package:eqapi_types/model/v1/earthquake_early.dart';
import 'package:eqmonitor/core/extension/async_value.dart';
import 'package:eqmonitor/feature/earthquake_history_early/data/earthquake_history_early_repository.dart';
import 'package:eqmonitor/feature/earthquake_history_early/data/model/earthquake_history_early_parameter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'earthquake_history_early_notifier.g.dart';

typedef EarthquakeHistoryEarlyNotifierState = (
  List<EarthquakeEarly>,
  int totalCount
);

extension EarthquakeHistoryEarlyNotifierStateEx
    on EarthquakeHistoryEarlyNotifierState {
  bool get hasNext => $1.length < $2;
}

@riverpod
class EarthquakeHistoryEarlyNotifier extends _$EarthquakeHistoryEarlyNotifier {
  @override
  Future<EarthquakeHistoryEarlyNotifierState> build(
    EarthquakeHistoryEarlyParameter parameter,
  ) =>
      _fetchInitialData(parameter: parameter);

  Future<EarthquakeHistoryEarlyNotifierState> _fetchInitialData({
    required EarthquakeHistoryEarlyParameter parameter,
  }) async {
    final repository = ref.read(earthquakeHistoryEarlyRepositoryProvider);
    final response = await repository.fetchEarthquakeEarlyLists(
      magnitudeLte: parameter.magnitudeLte,
      magnitudeGte: parameter.magnitudeGte,
      depthLte: parameter.depthLte,
      depthGte: parameter.depthGte,
      intensityLte: parameter.intensityLte,
      intensityGte: parameter.intensityGte,
      originTimeLte: parameter.originTimeLte,
      originTimeGte: parameter.originTimeGte,
      sort: parameter.sort,
      ascending: parameter.ascending,
    );

    return (
      response.items,
      response.count,
    );
  }

  Future<void> fetchNextData() async {
    // 読み込み中の場合は何もしない
    if (state.isRefreshing || state.isReloading) {
      return;
    }
    // すでに全件取得済みの場合は何もしない
    if (!(state.valueOrNull?.hasNext ?? false)) {
      return;
    }
    state = const AsyncLoading<(List<EarthquakeEarly>, int totalCount)>()
        .copyWithPrevious(state);
    state = await state.guardPlus(
      () async {
        final repository = ref.read(earthquakeHistoryEarlyRepositoryProvider);
        final currentData = state.valueOrNull;
        final result = await repository.fetchEarthquakeEarlyLists(
          depthGte: parameter.depthGte,
          depthLte: parameter.depthLte,
          intensityGte: parameter.intensityGte,
          intensityLte: parameter.intensityLte,
          magnitudeGte: parameter.magnitudeGte,
          magnitudeLte: parameter.magnitudeLte,
          originTimeLte: parameter.originTimeLte,
          originTimeGte: parameter.originTimeGte,
          offset: currentData?.$1.length ?? 0,
          sort: parameter.sort,
          ascending: parameter.ascending,
        );
        return (
          <EarthquakeEarly>[
            ...currentData?.$1 ?? [],
            ...result.items,
          ],
          result.count,
        );
      },
    );
  }
}

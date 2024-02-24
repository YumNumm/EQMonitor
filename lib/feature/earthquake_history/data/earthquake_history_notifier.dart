import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/extension/async_value.dart';
import 'package:eqmonitor/feature/earthquake_history/data/earthquake_history_repository.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'earthquake_history_notifier.g.dart';

// TODO(YumNumm): テスト書く
@Riverpod(keepAlive: true)
class EarthquakeHistoryNotifier extends _$EarthquakeHistoryNotifier {
  @override
  Future<List<EarthquakeV1>> build() {
    final parameter = ref.watch(earthquakeHistoryParameterNotifierProvider);
    // TODO(YumNumm): WebSocketからの情報を引き込む
    return _fetchInitialData(parameter);
  }

  Future<List<EarthquakeV1>> _fetchInitialData(
    EarthquakeHistoryParameter param,
  ) async {
    final result = await ref
        .read(earthquakeHistoryRepositoryProvider)
        .fetchEarthquakeLists(
          depthGte: param.depthGte,
          depthLte: param.depthLte,
          intensityGte: param.intensityGte,
          intensityLte: param.intensityLte,
          magnitudeGte: param.magnitudeGte,
          magnitudeLte: param.magnitudeLte,
        );
    return result.items;
  }

  Future<void> fetchNextData() async {
    // 読み込み中の場合は何もしない
    if (state.isRefreshing || state.isReloading) {
      return;
    }
    // すでに全件取得済みの場合は何もしない
    final hasNext = ref.read(earthquakeHistoryHasNextFetchProvider);
    if (!hasNext) {
      return;
    }

    state = const AsyncLoading<List<EarthquakeV1>>().copyWithPrevious(state);
    final parameter = ref.read(earthquakeHistoryParameterNotifierProvider);
    state = await state.guardPlus(
      () async {
        final repository = ref.read(earthquakeHistoryRepositoryProvider);
        final currentData = state.valueOrNull;
        final result = await repository.fetchEarthquakeLists(
          depthGte: parameter.depthGte,
          depthLte: parameter.depthLte,
          intensityGte: parameter.intensityGte,
          intensityLte: parameter.intensityLte,
          magnitudeGte: parameter.magnitudeGte,
          magnitudeLte: parameter.magnitudeLte,
          offset: currentData?.length ?? 0,
        );
        ref
            .read(earthquakeHistoryTotalCountProvider.notifier)
            .update(result.count);
        return [
          ...result.items,
          ...currentData ?? [],
        ];
      },
    );
  }
}

@Riverpod(keepAlive: true)
class EarthquakeHistoryTotalCount extends _$EarthquakeHistoryTotalCount {
  @override
  int? build() => null;

  // ignore: use_setters_to_change_properties
  void update(int? count) => state = count;
}

@riverpod
bool earthquakeHistoryHasNextFetch(EarthquakeHistoryHasNextFetchRef ref) {
  final totalCount = ref.watch(earthquakeHistoryTotalCountProvider);
  final currentData = ref.watch(earthquakeHistoryNotifierProvider).valueOrNull;
  if (totalCount == null || currentData == null) {
    return false;
  }
  if (currentData.length <= totalCount) {
    return false;
  }
  return true;
}

@Riverpod(keepAlive: true)
class EarthquakeHistoryParameterNotifier
    extends _$EarthquakeHistoryParameterNotifier {
  @override
  EarthquakeHistoryParameter build() => const EarthquakeHistoryParameter();

  // ignore: use_setters_to_change_properties
  void update(EarthquakeHistoryParameter parameter) => state = parameter;
}

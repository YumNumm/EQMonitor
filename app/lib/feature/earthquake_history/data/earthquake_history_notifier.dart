import 'package:collection/collection.dart';
import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/extension/async_value.dart';
import 'package:eqmonitor/core/provider/jma_parameter/jma_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/earthquake_history_repository.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_v1_extended.dart';
import 'package:flutter/foundation.dart';
import 'package:jma_parameter_api_client/jma_parameter_api_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'earthquake_history_notifier.g.dart';

// TODO(YumNumm): テスト書く
@Riverpod(keepAlive: true)
class EarthquakeHistoryNotifier extends _$EarthquakeHistoryNotifier {
  @override
  Future<List<EarthquakeV1Extended>> build() {
    final earthquakeParameter =
        ref.watch(jmaParameterProvider).valueOrNull?.earthquake;
    if (earthquakeParameter == null) {
      throw EarthquakeParameterHasNotInitializedException();
    }
    final parameter = ref.watch(earthquakeHistoryParameterNotifierProvider);
    return _fetchInitialData(
      param: parameter,
      regions: earthquakeParameter.regions,
    );
  }

  Future<List<EarthquakeV1Extended>> _fetchInitialData({
    required EarthquakeHistoryParameter param,
    required List<EarthquakeParameterRegionItem> regions,
  }) async {
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
    return _v1ToV1Extended(
      data: result.items,
      regions: regions,
    );
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
    final jmaEarthquakeParameter =
        ref.read(jmaParameterProvider).valueOrNull?.earthquake;
    if (jmaEarthquakeParameter == null) {
      throw EarthquakeParameterHasNotInitializedException();
    }

    state = const AsyncLoading<List<EarthquakeV1Extended>>()
        .copyWithPrevious(state);
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
        final extendedResult = await _v1ToV1Extended(
          data: result.items,
          regions: jmaEarthquakeParameter.regions,
        );
        ref
            .read(earthquakeHistoryTotalCountProvider.notifier)
            .update(result.count);
        return [
          ...extendedResult,
          ...currentData ?? [],
        ];
      },
    );
  }

  Future<List<EarthquakeV1Extended>> _v1ToV1Extended({
    required List<EarthquakeV1> data,
    required List<EarthquakeParameterRegionItem> regions,
  }) async =>
      compute(
        (param) async {
          final data = param.$1;
          final regions = param.$2;

          return <EarthquakeV1Extended>[
            for (final e in data)
              EarthquakeV1Extended(
                earthquake: e,
                maxIntensityRegionNames: e.maxIntensityRegionIds
                    ?.map(
                      (region) => regions
                          .firstWhereOrNull(
                            (paramRegion) =>
                                int.parse(paramRegion.$1) == region,
                          )
                          ?.$2,
                    )
                    .whereNotNull()
                    .toList(),
              ),
          ];
        },
        (
          data,
          regions.map(
            (e) => (e.code, e.name),
          )
        ),
      );
}

class EarthquakeParameterHasNotInitializedException implements Exception {}

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

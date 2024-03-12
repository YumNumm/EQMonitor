import 'package:collection/collection.dart';
import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/extension/async_value.dart';
import 'package:eqmonitor/core/provider/jma_parameter/jma_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/earthquake_history_repository.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_v1_extended.dart';
import 'package:jma_parameter_api_client/jma_parameter_api_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'earthquake_history_notifier.g.dart';

typedef EarthquakeHistoryNotifierStaet = (
  List<EarthquakeV1Extended>,
  int totalCount
);

@riverpod
class EarthquakeHistoryNotifier extends _$EarthquakeHistoryNotifier {
  @override
  Future<EarthquakeHistoryNotifierStaet> build(
    EarthquakeHistoryParameter parameter,
  ) async {
    // ensure earthquakeParameter has been initialized.
    await ref.read(jmaParameterProvider.future);
    final earthquakeParameter =
        ref.watch(jmaParameterProvider).valueOrNull?.earthquake;

    if (earthquakeParameter == null) {
      throw EarthquakeParameterHasNotInitializedException();
    }
    return _fetchInitialData(
      param: parameter,
      regions: earthquakeParameter.regions,
    );
  }

  Future<(List<EarthquakeV1Extended>, int totalCount)> _fetchInitialData({
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
    return (
      await _v1ToV1Extended(
        data: result.items,
        regions: regions,
      ),
      result.count,
    );
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state =
        await AsyncValue.guard<(List<EarthquakeV1Extended>, int totalCount)>(
            () async {
      // ensure earthquakeParameter has been initialized.
      await ref.read(jmaParameterProvider.future);
      final earthquakeParameter =
          ref.watch(jmaParameterProvider).valueOrNull!.earthquake;

      return _fetchInitialData(
        param: parameter,
        regions: earthquakeParameter.regions,
      );
    });
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
    final jmaEarthquakeParameter =
        ref.read(jmaParameterProvider).valueOrNull?.earthquake;
    if (jmaEarthquakeParameter == null) {
      throw EarthquakeParameterHasNotInitializedException();
    }

    state = const AsyncLoading<(List<EarthquakeV1Extended>, int totalCount)>()
        .copyWithPrevious(state);
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
          offset: currentData?.$1.length ?? 0,
          limit: 50,
        );
        final extendedResult = await _v1ToV1Extended(
          data: result.items,
          regions: jmaEarthquakeParameter.regions,
        );
        return (
          <EarthquakeV1Extended>[
            ...currentData?.$1 ?? [],
            ...extendedResult,
          ].sorted(
            (a, b) => b.eventId.compareTo(a.eventId),
          ),
          result.count
        );
      },
    );
  }

  Future<List<EarthquakeV1Extended>> _v1ToV1Extended({
    required List<EarthquakeV1> data,
    required List<EarthquakeParameterRegionItem> regions,
  }) async {
    return <EarthquakeV1Extended>[
      for (final e in data)
        EarthquakeV1Extended(
          earthquake: e,
          maxIntensityRegionNames: e.maxIntensityRegionIds
              ?.map(
                (region) => regions
                    .firstWhereOrNull(
                      (paramRegion) => int.parse(paramRegion.code) == region,
                    )
                    ?.name,
              )
              .whereNotNull()
              .toList(),
        ),
    ];
    /* 別Isolateで処理させるならコッチ
    final stopWatch = Stopwatch()..start();
    final result = await compute(
      (param) async {
        final data = param.$1;
        final regions = param.$2;


      },
      (
        data,
        regions.map(
          (e) => (e.code, e.name),
        )
      ),
    );
    stopWatch.stop();
    log('compute time: ${stopWatch.elapsedMilliseconds}ms');
    return result;*/
  }
}

class EarthquakeParameterHasNotInitializedException implements Exception {}

extension EarthquakeHistoryState on (
  List<EarthquakeV1Extended>,
  int totalCount
) {
  bool get hasNext => $1.length < $2;
}

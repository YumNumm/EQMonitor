import 'package:collection/collection.dart';
import 'package:eqmonitor/core/extension/async_value.dart';
import 'package:eqmonitor/feature/earthquake_history/data/repository/earthquake_history_repository.dart';
import 'package:eqmonitor/feature/earthquake_search/data/model/earthquake_search_parameter.dart';
import 'package:eqmonitor/feature/earthquake_search/data/model/earthquake_search_result.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'earthquake_search_notifier.g.dart';

typedef EarthquakeSearchNotifierState = ({
  List<EarthquakeSearchResultItem> items,
  String? nextToken,
});

@riverpod
class EarthquakeSearchNotifier extends _$EarthquakeSearchNotifier {
  @override
  Future<EarthquakeSearchNotifierState> build(
    EarthquakeSearchParameter parameter,
  ) async {
    return _fetchInitialData(limit: 50);
  }

  Future<EarthquakeSearchNotifierState> _fetchInitialData({
    required int limit,
  }) async {
    final repository = ref.read(earthquakeHistoryRepositoryProvider);
    final param = parameter;

    return switch (param.type) {
      EarthquakeSearchType.region => () async {
        final result = await repository.searchByRegion(
          code: param.code,
          limit: limit,
        );
        return (
          items: result.items
              .map(
                (e) => EarthquakeSearchResultItem.region(
                  eventId: e.eventId,
                  region: e.region,
                  earthquake: e.earthquake,
                ),
              )
              .toList(),
          nextToken: result.nextToken,
        );
      }(),
      EarthquakeSearchType.prefecture => () async {
        final result = await repository.searchByPrefecture(
          code: param.code,
          limit: limit,
        );
        return (
          items: result.items
              .map(
                (e) => EarthquakeSearchResultItem.prefecture(
                  eventId: e.eventId,
                  prefecture: e.prefecture,
                  earthquake: e.earthquake,
                ),
              )
              .toList(),
          nextToken: result.nextToken,
        );
      }(),
      EarthquakeSearchType.city => () async {
        final result = await repository.searchByCity(
          code: param.code,
          limit: limit,
        );
        return (
          items: result.items
              .map(
                (e) => EarthquakeSearchResultItem.city(
                  eventId: e.eventId,
                  city: e.city,
                  earthquake: e.earthquake,
                ),
              )
              .toList(),
          nextToken: result.nextToken,
        );
      }(),
      EarthquakeSearchType.station => () async {
        final result = await repository.searchByStation(
          code: param.code,
          limit: limit,
        );
        return (
          items: result.items
              .map(
                (e) => EarthquakeSearchResultItem.station(
                  eventId: e.eventId,
                  station: e.station,
                  earthquake: e.earthquake,
                ),
              )
              .toList(),
          nextToken: result.nextToken,
        );
      }(),
    };
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard<EarthquakeSearchNotifierState>(
      () => _fetchInitialData(limit: 50),
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
      final repository = ref.read(earthquakeHistoryRepositoryProvider);
      final param = parameter;

      final (items, nextToken) = await switch (param.type) {
        EarthquakeSearchType.region => () async {
          final result = await repository.searchByRegion(
            code: param.code,
            limit: 50,
          );
          return (
            result.items
                .map(
                  (e) => EarthquakeSearchResultItem.region(
                    eventId: e.eventId,
                    region: e.region,
                    earthquake: e.earthquake,
                  ),
                )
                .toList(),
            result.nextToken,
          );
        }(),
        EarthquakeSearchType.prefecture => () async {
          final result = await repository.searchByPrefecture(
            code: param.code,
            limit: 50,
          );
          return (
            result.items
                .map(
                  (e) => EarthquakeSearchResultItem.prefecture(
                    eventId: e.eventId,
                    prefecture: e.prefecture,
                    earthquake: e.earthquake,
                  ),
                )
                .toList(),
            result.nextToken,
          );
        }(),
        EarthquakeSearchType.city => () async {
          final result = await repository.searchByCity(
            code: param.code,
            limit: 50,
          );
          return (
            result.items
                .map(
                  (e) => EarthquakeSearchResultItem.city(
                    eventId: e.eventId,
                    city: e.city,
                    earthquake: e.earthquake,
                  ),
                )
                .toList(),
            result.nextToken,
          );
        }(),
        EarthquakeSearchType.station => () async {
          final result = await repository.searchByStation(
            code: param.code,
            limit: 50,
          );
          return (
            result.items
                .map(
                  (e) => EarthquakeSearchResultItem.station(
                    eventId: e.eventId,
                    station: e.station,
                    earthquake: e.earthquake,
                  ),
                )
                .toList(),
            result.nextToken,
          );
        }(),
      };

      final mergedItems = <EarthquakeSearchResultItem>[
        ...currentState.items,
        ...items,
      ].sortedBy<String>((a) => a.eventId).reversed.toList();

      return (items: mergedItems, nextToken: nextToken);
    });
  }
}

extension EarthquakeSearchStateEx on EarthquakeSearchNotifierState {
  bool get hasNext => nextToken != null;
}

import 'dart:async';
import 'dart:developer';

import 'package:eqmonitor/core/provider/app_lifecycle.dart';
import 'package:eqmonitor/core/provider/sse/sse_connection_provider.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_details_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/data/repository/earthquake_history_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:paging_view/paging_view.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'earthquake_history_data_source.g.dart';

@riverpod
Future<EarthquakeHistoryDataSource> earthquakeHistoryDataSource(
  Ref ref,
  EarthquakeHistoryParameter parameter,
) async {
  final repository = await ref.watch(
    earthquakeHistoryRepositoryProvider.future,
  );

  final dataSource = EarthquakeHistoryDataSource(
    repository: repository,
    parameter: parameter,
    onRefreshStarted: () => ref.invalidate(earthquakeHistoryDetailsProvider),
  );

  ref.onDispose(dataSource.dispose);

  if (parameter == const EarthquakeHistoryParameter()) {
    final timer = Timer.periodic(
      const Duration(minutes: 5),
      (_) async {
        final sseState = ref.read(sseConnectionStatusProvider);
        if (sseState == SseConnectionState.connected) {
          log('SSE is connected, skip refresh');
          return;
        }
        if (ref.read(appLifecycleProvider) != AppLifecycleState.resumed) {
          log('app is not resumed, skip refresh');
          return;
        }
        log('refreshing earthquake history data source');
        final result = await repository.fetchEarthquakeList(limit: 10);
        dataSource.upsertItems(result.items);
      },
    );
    ref.onDispose(timer.cancel);

    ref.listen(appLifecycleProvider, (_, next) async {
      if (next != AppLifecycleState.resumed) {
        return;
      }
      final result = await repository.fetchEarthquakeList(limit: 10);
      dataSource.upsertItems(result.items);
    });
  }

  return dataSource;
}

class EarthquakeHistoryDataSource
    extends GroupedDataSource<String?, String, EarthquakePartial> {
  EarthquakeHistoryDataSource({
    required EarthquakeHistoryRepository repository,
    required EarthquakeHistoryParameter parameter,
    VoidCallback? onRefreshStarted,
  }) : _repository = repository,
       _parameter = parameter {
    onLoadStarted = (action) {
      if (action is Refresh) {
        onRefreshStarted?.call();
      }
    };
  }

  final EarthquakeHistoryRepository _repository;
  final EarthquakeHistoryParameter _parameter;

  static final _dateFormatter = DateFormat('yyyy/MM/dd');

  @override
  String groupBy(EarthquakePartial value) {
    final dateTime = value.originTime ?? value.arrivalTime;
    return dateTime != null ? _dateFormatter.format(dateTime.toLocal()) : '不明';
  }

  @override
  Future<LoadResult<String?, EarthquakePartial>> load(
    LoadAction<String?> action,
  ) async => switch (action) {
    Refresh() => await _fetch(null),
    Append(:final key) => await _fetch(key),
    Prepend() => const None(),
  };

  Future<LoadResult<String?, EarthquakePartial>> _fetch(
    String? cursor,
  ) async {
    try {
      final limit = cursor != null
          ? 100
          : _parameter == const EarthquakeHistoryParameter()
          ? 10
          : 50;

      if (_parameter.epicenterCode != null) {
        final result = await _repository.searchByEpicenter(
          code: _parameter.epicenterCode!,
          limit: limit,
          cursor: cursor,
        );
        return Success(
          page: PageData(
            data: result.items.map((e) => e.earthquake).toList(),
            appendKey: result.nextToken,
          ),
        );
      }

      if (_parameter.regionCode != null &&
          _parameter.regionCode != null &&
          _parameter.regionSearchType == RegionSearchType.prefecture) {
        final result = await _repository.searchByPrefecture(
          code: _parameter.regionCode!,
          limit: limit,
          cursor: cursor,
        );
        return Success(
          page: PageData(
            data: result.items.map((e) => e.earthquake).toList(),
            appendKey: result.nextToken,
          ),
        );
      }

      if (_parameter.regionCode != null &&
          _parameter.regionCode != null &&
          _parameter.regionSearchType == RegionSearchType.city) {
        final result = await _repository.searchByCity(
          code: _parameter.regionCode!,
          limit: limit,
          cursor: cursor,
        );
        return Success(
          page: PageData(
            data: result.items.map((e) => e.earthquake).toList(),
            appendKey: result.nextToken,
          ),
        );
      }

      final result = await _repository.fetchEarthquakeList(
        limit: limit,
        cursor: cursor,
      );
      return Success(
        page: PageData(
          data: result.items,
          appendKey: result.nextToken,
        ),
      );
    } on Exception catch (e, st) {
      return Failure(error: e, stackTrace: st);
    }
  }

  /// SSEやライフサイクルからのリアルタイム更新を反映する
  void upsertItems(List<EarthquakePartial> newItems) {
    final currentItems = [...notifier.values];
    for (final item in newItems) {
      final index = currentItems.indexWhere((e) => e.eventId == item.eventId);
      if (index == -1) {
        insertItem(0, item);
        currentItems.insert(0, item);
      } else {
        updateItem(index, (_) => item);
        currentItems[index] = item;
      }
    }
  }
}

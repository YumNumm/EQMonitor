import 'dart:async';
import 'dart:developer';

import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/core/provider/app_lifecycle.dart';
import 'package:eqmonitor/core/realtime/data_source/eqmonitor/eqmonitor_ws_status_notifier.dart';
import 'package:eqmonitor/core/realtime/data_source/eqmonitor/eqmonitor_ws_status_state.dart';
import 'package:eqmonitor/core/realtime/model/realtime_event.dart';
import 'package:eqmonitor/core/realtime/realtime_event_provider.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_item.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_sort_by.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/sort_order.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_details_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/data/repository/earthquake_history_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
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
    onRefreshStarted: () =>
        ref.invalidate(earthquakeHistoryDetailsProvider, asReload: true),
  );

  ref.onDispose(dataSource.dispose);

  if (parameter == const EarthquakeHistoryParameter()) {
    final timer = Timer.periodic(
      const Duration(minutes: 5),
      (_) async {
        final wsPhase = ref.read(eqMonitorWsStatusProvider).phase;
        if (wsPhase == WsPhase.connected) {
          log('WS is connected, skip refresh');
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

    ref.listen(realtimeEventsProvider, (_, next) async {
      if (next case AsyncData(:final value)) {
        switch (value) {
          case RealtimeReadyEvent():
            final result = await repository.fetchEarthquakeList(limit: 10);
            dataSource.upsertItems(result.items);
          case RealtimeEarthquakeUpsertEvent():
            final result = await repository.fetchEarthquakeList(limit: 10);
            dataSource.upsertItems(result.items);
          case RealtimeEarthquakeDeleteEvent(:final eventId):
            dataSource.removeItemByEventId(eventId);
          default:
            return;
        }
      }
    });
  }

  return dataSource;
}

class EarthquakeHistoryDataSource
    extends GroupedDataSource<String?, String, EarthquakeHistoryItem> {
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
  String groupBy(EarthquakeHistoryItem value) {
    final dateTime =
        value.earthquake.originTime ?? value.earthquake.arrivalTime;
    return dateTime != null ? _dateFormatter.format(dateTime.toLocal()) : '不明';
  }

  @override
  Future<LoadResult<String?, EarthquakeHistoryItem>> load(
    LoadAction<String?> action,
  ) async => switch (action) {
    Refresh() => await _fetch(null),
    Append(:final key) => await _fetch(key),
    Prepend() => const None(),
  };

  api.EarthquakeType? get _apiEarthquakeType =>
      _parameter.earthquakeType?.toApiEarthquakeType;

  api.EarthquakeSortBy? get _apiSortBy =>
      _parameter.sortBy?.toApiEarthquakeSortBy;

  api.SortOrder? get _apiSortOrder => _parameter.sortOrder?.toApiSortOrder;

  List<int>? get _epicenterCodes =>
      _parameter.epicenterCode != null ? [_parameter.epicenterCode!] : null;

  Future<LoadResult<String?, EarthquakeHistoryItem>> _fetch(
    String? cursor,
  ) async {
    try {
      final limit = cursor != null
          ? 100
          : _parameter == const EarthquakeHistoryParameter()
          ? 10
          : 50;

      if (_parameter.regionCode != null &&
          _parameter.regionSearchType == RegionSearchType.prefecture) {
        final result = await _repository.searchByPrefecture(
          code: _parameter.regionCode!,
          limit: limit,
          cursor: cursor,
          magnitudeGte: _parameter.magnitudeGte,
          magnitudeLte: _parameter.magnitudeLte,
          depthGte: _parameter.depthGte,
          depthLte: _parameter.depthLte,
          intensityGte:
              _parameter.regionIntensityGte ?? _parameter.intensityGte,
          intensityLte:
              _parameter.regionIntensityLte ?? _parameter.intensityLte,
          statuses: _parameter.statuses?.cast<api.TelegramStatus>(),
          epicenterCodes: _epicenterCodes,
          earthquakeType: _apiEarthquakeType,
          originTimeGte: _parameter.originTimeGte,
          originTimeLte: _parameter.originTimeLte,
          maxLpgmIntensityGte:
              _parameter.maxLpgmIntensityGte?.toApiJmaLpgmIntensity,
          maxLpgmIntensityLte:
              _parameter.maxLpgmIntensityLte?.toApiJmaLpgmIntensity,
          sortBy: _apiSortBy,
          sortOrder: _apiSortOrder,
        );
        return Success(
          page: PageData(
            data: result.items
                .map(
                  (e) => EarthquakeHistoryItem(
                    earthquake: e.earthquake,
                    areaInfo: e.area,
                  ),
                )
                .toList(),
            appendKey: result.nextToken,
          ),
        );
      }

      if (_parameter.regionCode != null &&
          _parameter.regionSearchType == RegionSearchType.city) {
        final result = await _repository.searchByCity(
          code: _parameter.regionCode!,
          limit: limit,
          cursor: cursor,
          magnitudeGte: _parameter.magnitudeGte,
          magnitudeLte: _parameter.magnitudeLte,
          depthGte: _parameter.depthGte,
          depthLte: _parameter.depthLte,
          intensityGte:
              _parameter.regionIntensityGte ?? _parameter.intensityGte,
          intensityLte:
              _parameter.regionIntensityLte ?? _parameter.intensityLte,
          statuses: _parameter.statuses?.cast<api.TelegramStatus>(),
          epicenterCodes: _epicenterCodes,
          earthquakeType: _apiEarthquakeType,
          originTimeGte: _parameter.originTimeGte,
          originTimeLte: _parameter.originTimeLte,
          maxLpgmIntensityGte:
              _parameter.maxLpgmIntensityGte?.toApiJmaLpgmIntensity,
          maxLpgmIntensityLte:
              _parameter.maxLpgmIntensityLte?.toApiJmaLpgmIntensity,
          sortBy: _apiSortBy,
          sortOrder: _apiSortOrder,
        );
        return Success(
          page: PageData(
            data: result.items
                .map(
                  (e) => EarthquakeHistoryItem(
                    earthquake: e.earthquake,
                    areaInfo: e.area,
                  ),
                )
                .toList(),
            appendKey: result.nextToken,
          ),
        );
      }

      final result = await _repository.fetchEarthquakeList(
        limit: limit,
        cursor: cursor,
        magnitudeGte: _parameter.magnitudeGte,
        magnitudeLte: _parameter.magnitudeLte,
        depthGte: _parameter.depthGte,
        depthLte: _parameter.depthLte,
        intensityGte: _parameter.intensityGte,
        intensityLte: _parameter.intensityLte,
        statuses: _parameter.statuses?.cast<api.TelegramStatus>(),
        epicenterCodes: _epicenterCodes,
        earthquakeType: _apiEarthquakeType,
        datasource: _parameter.datasource,
        telegramTypes: _parameter.telegramTypes
            ?.cast<api.EarthquakeTelegramType>(),
        originTimeGte: _parameter.originTimeGte,
        originTimeLte: _parameter.originTimeLte,
        maxLpgmIntensityGte:
            _parameter.maxLpgmIntensityGte?.toApiJmaLpgmIntensity,
        maxLpgmIntensityLte:
            _parameter.maxLpgmIntensityLte?.toApiJmaLpgmIntensity,
        latitudeGte: _parameter.latitudeGte,
        latitudeLte: _parameter.latitudeLte,
        longitudeGte: _parameter.longitudeGte,
        longitudeLte: _parameter.longitudeLte,
        sortBy: _apiSortBy,
        sortOrder: _apiSortOrder,
      );
      return Success(
        page: PageData(
          data: result.items
              .map(
                (e) => EarthquakeHistoryItem(earthquake: e),
              )
              .toList(),
          appendKey: result.nextToken,
        ),
      );
    } on Exception catch (e, st) {
      return Failure(error: e, stackTrace: st);
    }
  }

  void upsertItems(List<EarthquakePartial> newItems) {
    final currentItems = [...notifier.values];
    for (final item in newItems) {
      final index = currentItems.indexWhere(
        (e) => e.earthquake.eventId == item.eventId,
      );
      if (index == -1) {
        insertItem(0, EarthquakeHistoryItem(earthquake: item));
        currentItems.insert(0, EarthquakeHistoryItem(earthquake: item));
      } else {
        updateItem(
          index,
          (prev) => EarthquakeHistoryItem(
            earthquake: item,
            areaInfo: prev.areaInfo,
          ),
        );
        currentItems[index] = EarthquakeHistoryItem(
          earthquake: item,
          areaInfo: currentItems[index].areaInfo,
        );
      }
    }
  }

  void removeItemByEventId(String eventId) {
    removeItems((_, item) => item.earthquake.eventId == eventId);
  }
}

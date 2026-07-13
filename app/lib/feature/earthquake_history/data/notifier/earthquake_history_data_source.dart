import 'dart:async';

import 'package:eqmonitor/core/provider/app_lifecycle.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/realtime/model/realtime_event.dart';
import 'package:eqmonitor/core/realtime/realtime_event_provider.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_search_response.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_sort_by.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/sort_order.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_details_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/data/repository/earthquake_history_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:paging_view/paging_view.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'earthquake_history_data_source.g.dart';

/// デフォルトの「全て」パラメータかどうかを判定する。
/// フィルタや並び替えが変更されていない初期状態と一致する場合のみ true。
bool isDefaultAllParameter(EarthquakeHistoryParameter p) =>
    p ==
    const EarthquakeHistoryParameter.all(
      sortBy: EarthquakeSortBy.eventId,
      sortOrder: SortOrder.desc,
    );

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

  if (parameter is EarthquakeHistoryParameterAll) {
    final refetchTimer = Timer.periodic(
      const Duration(minutes: 5),
      (_) => ref.invalidateSelf(),
    );
    ref
      ..onDispose(refetchTimer.cancel)
      ..listen(appLifecycleProvider, (_, next) async {
        if (next == AppLifecycleState.resumed) {
          await dataSource.revalidateLatest();
        }
      })
      ..listen(realtimeEventsProvider, (_, next) async {
        if (next case AsyncData(:final value)) {
          switch (value) {
            case RealtimeEarthquakeUpsertEvent(:final record):
              dataSource.upsertItems([
                repository.toEarthquakePartial(item: record),
              ]);
            case _:
              {}
          }
        }
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

  final ValueNotifier<bool> isRevalidating = ValueNotifier(false);
  @override
  void dispose() {
    isRevalidating.dispose();
    super.dispose();
  }

  static final _dateFormatter = DateFormat('yyyy/MM/dd');

  @override
  String groupBy(EarthquakePartial value) {
    final dateTime =
        value.earthquake.originTime ?? value.earthquake.arrivalTime;
    return dateTime != null ? _dateFormatter.format(dateTime.toLocal()) : '不明';
  }

  @override
  Future<LoadResult<String?, EarthquakePartial>> load(
    LoadAction<String?> action,
  ) async => switch (action) {
    Refresh() when isDefaultAllParameter(_parameter) => await _load(
      limit: 10,
      cursor: null,
    ),
    Refresh() => await _load(
      limit: _parameter is EarthquakeHistoryParameterAll ? 10 : 50,
      cursor: null,
    ),
    Append(:final key) => await _load(limit: 50, cursor: key),
    Prepend() => const None(),
  };

  Future<void> revalidateLatest() async {
    talker.debug('revalidateLatest');
    final latest = await _fetch(limit: 10, cursor: null);
    if (latest.items.isNotEmpty) {
      upsertItems(latest.items);
    }
  }

  Future<LoadResult<String?, EarthquakePartial>> _load({
    required int limit,
    required String? cursor,
  }) async {
    try {
      final page = await _fetch(limit: limit, cursor: cursor);
      return Success(
        page: PageData(data: page.items, appendKey: page.nextToken),
      );
    } on Exception catch (e, st) {
      return Failure(error: e, stackTrace: st);
    }
  }

  Future<PaginatedResponse<EarthquakePartial>> _fetch({
    required int limit,
    required String? cursor,
  }) async {
    final parameter = _parameter;

    return switch (parameter) {
      EarthquakeHistoryParameterAll() => _repository.fetchEarthquakeList(
        limit: limit,
        cursor: cursor,
        magnitudeGte: parameter.magnitudeGte,
        magnitudeLte: parameter.magnitudeLte,
        depthGte: parameter.depthGte,
        depthLte: parameter.depthLte,
        intensityGte: parameter.intensityGte,
        intensityLte: parameter.intensityLte,
        statuses: parameter.statuses,
        epicenterCodes: parameter.epicenterCodes,
        earthquakeType: parameter.earthquakeType,
        datasource: parameter.datasource,
        telegramTypes: parameter.telegramTypes,
        originTimeGte: parameter.originTimeGte,
        originTimeLte: parameter.originTimeLte,
        maxLpgmIntensityGte: parameter.maxLpgmIntensityGte,
        maxLpgmIntensityLte: parameter.maxLpgmIntensityLte,
        latitudeGte: parameter.latitudeGte,
        latitudeLte: parameter.latitudeLte,
        longitudeGte: parameter.longitudeGte,
        longitudeLte: parameter.longitudeLte,
        sortBy: parameter.sortBy,
        sortOrder: parameter.sortOrder,
        client: client,
      ),
      EarthquakeHistoryParameterRegion(:final String regionCode) =>
        _repository.searchByRegion(
          code: regionCode,
          limit: limit,
          cursor: cursor,
          magnitudeGte: parameter.magnitudeGte,
          magnitudeLte: parameter.magnitudeLte,
          depthGte: parameter.depthGte,
          depthLte: parameter.depthLte,
          intensityGte: parameter.intensityGte,
          intensityLte: parameter.intensityLte,
          statuses: parameter.statuses,
          epicenterCodes: parameter.epicenterCodes,
          earthquakeType: parameter.earthquakeType,
          originTimeGte: parameter.originTimeGte,
          originTimeLte: parameter.originTimeLte,
          maxLpgmIntensityGte: parameter.maxLpgmIntensityGte,
          maxLpgmIntensityLte: parameter.maxLpgmIntensityLte,
          sortBy: parameter.sortBy,
          sortOrder: parameter.sortOrder,
        ),
      EarthquakeHistoryParameterPrefecture(:final String prefectureCode) =>
        _repository.searchByPrefecture(
          code: prefectureCode,
          limit: limit,
          cursor: cursor,
          magnitudeGte: parameter.magnitudeGte,
          magnitudeLte: parameter.magnitudeLte,
          depthGte: parameter.depthGte,
          depthLte: parameter.depthLte,
          intensityGte: parameter.intensityGte,
          intensityLte: parameter.intensityLte,
          statuses: parameter.statuses,
          epicenterCodes: parameter.epicenterCodes,
          earthquakeType: parameter.earthquakeType,
          originTimeGte: parameter.originTimeGte,
          originTimeLte: parameter.originTimeLte,
          maxLpgmIntensityGte: parameter.maxLpgmIntensityGte,
          maxLpgmIntensityLte: parameter.maxLpgmIntensityLte,
          sortBy: parameter.sortBy,
          sortOrder: parameter.sortOrder,
        ),
      EarthquakeHistoryParameterCity(:final String cityCode) =>
        _repository.searchByCity(
          code: cityCode,
          limit: limit,
          cursor: cursor,
          magnitudeGte: parameter.magnitudeGte,
          magnitudeLte: parameter.magnitudeLte,
          depthGte: parameter.depthGte,
          depthLte: parameter.depthLte,
          intensityGte: parameter.intensityGte,
          intensityLte: parameter.intensityLte,
          statuses: parameter.statuses,
          epicenterCodes: parameter.epicenterCodes,
          earthquakeType: parameter.earthquakeType,
          originTimeGte: parameter.originTimeGte,
          originTimeLte: parameter.originTimeLte,
          maxLpgmIntensityGte: parameter.maxLpgmIntensityGte,
          maxLpgmIntensityLte: parameter.maxLpgmIntensityLte,
          sortBy: parameter.sortBy,
          sortOrder: parameter.sortOrder,
        ),
      EarthquakeHistoryParameterStation(:final String stationCode) =>
        _repository.searchByStation(
          code: stationCode,
          limit: limit,
          cursor: cursor,
          magnitudeGte: parameter.magnitudeGte,
          magnitudeLte: parameter.magnitudeLte,
          depthGte: parameter.depthGte,
          depthLte: parameter.depthLte,
          intensityGte: parameter.intensityGte,
          intensityLte: parameter.intensityLte,
          statuses: parameter.statuses,
          epicenterCodes: parameter.epicenterCodes,
          earthquakeType: parameter.earthquakeType,
          originTimeGte: parameter.originTimeGte,
          originTimeLte: parameter.originTimeLte,
          maxLpgmIntensityGte: parameter.maxLpgmIntensityGte,
          maxLpgmIntensityLte: parameter.maxLpgmIntensityLte,
          sortBy: parameter.sortBy,
          sortOrder: parameter.sortOrder,
        ),
    };
  }

  void upsertItems(List<EarthquakePartial> newItems) {
    if (_parameter.sortBy != .eventId) {
      // eventId 以外のソートでは挿入位置が確定できないため反映しない
      return;
    }
    final isDesc = _parameter.sortOrder == .desc;
    for (final item in newItems) {
      final currentItems = [...notifier.values];
      final index = currentItems.indexWhere(
        (e) => e.earthquake.eventId == item.earthquake.eventId,
      );
      if (index != -1) {
        updateItem(index, (_) => item);
        continue;
      }
      // eventId 比較で挿入位置を決める(desc: 大きい順 / asc: 小さい順)
      final insertAt = currentItems.indexWhere(
        (e) => isDesc
            ? e.earthquake.eventId.compareTo(item.earthquake.eventId) < 0
            : e.earthquake.eventId.compareTo(item.earthquake.eventId) > 0,
      );
      insertItem(insertAt == -1 ? currentItems.length : insertAt, item);
    }
  }
}

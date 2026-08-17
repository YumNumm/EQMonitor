import 'dart:async';
import 'dart:developer';

import 'package:eqmonitor/core/provider/app_lifecycle.dart';
import 'package:eqmonitor/core/realtime/data_source/eqmonitor/eqmonitor_ws_status_notifier.dart';
import 'package:eqmonitor/core/realtime/data_source/eqmonitor/eqmonitor_ws_status_state.dart';
import 'package:eqmonitor/core/realtime/model/realtime_event.dart';
import 'package:eqmonitor/core/realtime/realtime_event_provider.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/eew_history/data/model/eew_list_parameter.dart';
import 'package:eqmonitor/feature/eew_history/data/repository/eew_list_repository.dart';
import 'package:material_ui/material_ui.dart';
import 'package:intl/intl.dart';
import 'package:paging_view/paging_view.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'eew_list_data_source.g.dart';

@riverpod
Future<EewListDataSource> eewListDataSource(
  Ref ref,
  EewListParameter parameter,
) async {
  final repository = await ref.watch(eewListRepositoryProvider.future);
  final dataSource = EewListDataSource(
    repository: repository,
    parameter: parameter,
  );
  ref.onDispose(dataSource.dispose);

  // フィルタ未適用時のみリアルタイム連携を張る(地震履歴に倣う)。
  if (!parameter.isFiltering) {
    Future<void> refresh() async {
      final result = await repository.fetchEewList(
        parameter: parameter,
        cursor: null,
        limit: 10,
      );
      dataSource.upsertItems(result.items);
    }

    final timer = Timer.periodic(const Duration(seconds: 30), (_) async {
      final wsPhase = ref.read(eqMonitorWsStatusProvider).phase;
      if (wsPhase == WsPhase.connected) {
        log('WS connected, skip eew history refresh');
        return;
      }
      if (ref.read(appLifecycleProvider) != AppLifecycleState.resumed) {
        return;
      }
      await refresh();
    });
    ref.onDispose(timer.cancel);

    ref.listen(realtimeEventsProvider, (_, next) async {
      if (next case AsyncData(:final value)) {
        if (value is RealtimeEewUpsertEvent) {
          dataSource.upsertItems([value.record.toEewTelegramItem]);
        }
      }
    });
  }

  return dataSource;
}

class EewListDataSource
    extends GroupedDataSource<String?, String, EewTelegramItem> {
  new({
    required EewListRepository repository,
    required EewListParameter parameter,
  }) : _repository = repository,
       _parameter = parameter;

  final EewListRepository _repository;
  final EewListParameter _parameter;

  static final _dateFormatter = DateFormat('yyyy/MM/dd');

  @override
  String groupBy(EewTelegramItem value) {
    final dateTime = value.originTime ?? value.reportTime;
    return _dateFormatter.format(dateTime.toLocal());
  }

  @override
  Future<LoadResult<String?, EewTelegramItem>> load(
    LoadAction<String?> action,
  ) async => switch (action) {
    Refresh() => await _fetch(null),
    Append(:final key) => await _fetch(key),
    Prepend() => const None(),
  };

  Future<LoadResult<String?, EewTelegramItem>> _fetch(String? cursor) async {
    try {
      final limit = cursor != null
          ? 100
          : _parameter.isFiltering
          ? 50
          : 10;
      final page = await _repository.fetchEewList(
        parameter: _parameter,
        cursor: cursor,
        limit: limit,
      );
      return Success(
        page: PageData(data: page.items, appendKey: page.nextToken),
      );
    } on Exception catch (e, st) {
      return Failure(error: e, stackTrace: st);
    }
  }

  void upsertItems(List<EewTelegramItem> newItems) {
    final currentItems = [...notifier.values];
    for (final item in newItems.reversed) {
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

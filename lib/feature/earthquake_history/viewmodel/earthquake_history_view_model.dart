import 'package:collection/collection.dart';
import 'package:eqapi_schema/model/components/comments.dart';
import 'package:eqapi_schema/model/components/earthquake.dart';
import 'package:eqapi_schema/model/components/intensity.dart';
import 'package:eqapi_schema/model/components/tsunami-information/comments.dart';
import 'package:eqapi_schema/model/components/tsunami-information/tsunami_estimation.dart';
import 'package:eqapi_schema/model/components/tsunami-information/tsunami_forecast.dart';
import 'package:eqapi_schema/model/components/tsunami-information/tsunami_observations.dart';
import 'package:eqapi_schema/model/telegram_v3.dart';
import 'package:eqmonitor/common/extension/async_value.dart';
import 'package:eqmonitor/feature/earthquake_history/model/state/earthquake_history_item.dart';
import 'package:eqmonitor/feature/earthquake_history/use_case/earthquake_history_use_case.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'earthquake_history_view_model.g.dart';

@Riverpod(keepAlive: true)
class EarthquakeHistoryViewModel extends _$EarthquakeHistoryViewModel {
  @override
  AsyncValue<List<EarthquakeHistoryItem>> build() {
    _useCase = ref.watch(earthquakeHistoryUseCaseProvider);
    return const AsyncData([]);
  }

  late final EarthquakeHistoryUseCase _useCase;
  // state
  final bool _includeTestTelegrams = false;

  Future<void> reload() async {
    await fetch();
  }

  Future<void> loadIfNull() async {
    // stateがnullなら、loadMoreを呼ぶ
    if ((state.value ?? []).isEmpty) {
      return fetch(isLoadMore: true);
    }
  }

  Future<void> forceRefresh() async {
    state = const AsyncLoading<List<EarthquakeHistoryItem>>();
    await fetch();
  }

  void onScrollPositionChanged(ScrollController controller) {
    // エラー発生時・リロード中は何もしない
    if (state.hasError || state.isRefreshing || state.isReloading) {
      return;
    }
    if (controller.position.maxScrollExtent - controller.position.pixels < 20) {
      fetch(isLoadMore: true);
    }
  }

  Future<void> fetch({
    bool isLoadMore = false,
    int limit = 50,
  }) async {
    if (state.isLoading || state.isRefreshing || state.isReloading) {
      return;
    }
    if (isLoadMore) {
      state = const AsyncLoading<List<EarthquakeHistoryItem>>()
          .copyWithPrevious(state);
    } else {
      state = const AsyncLoading<List<EarthquakeHistoryItem>>();
    }
    // 処理開始
    state = await state.guardPlus(() async {
      final offset = state.asData?.value.length ?? 0;
      final result = await _useCase.getEarthquakeHistory(
        limit: limit,
        offset: offset,
        includeEew: false,
      );
      final items = _toEarthquakeHistoryItem(
        result,
        includeTestTelegrams: _includeTestTelegrams,
      );
      return <EarthquakeHistoryItem>[
        ...state.asData?.value ?? [],
        ...items,
      ];
    });
  }

  List<EarthquakeHistoryItem> _toEarthquakeHistoryItem(
    Map<String, List<TelegramV3>> data, {
    bool includeTestTelegrams = false,
  }) {
    final result = <EarthquakeHistoryItem>[];
    data.forEach((eventId, telegrams) {
      //! EarthquakeData !
      // 震度速報
      final vxse51 = telegrams.firstWhereOrNull(
        (e) =>
            e.type == TelegramType.vxse51 &&
            (_includeTestTelegrams || e.status == TelegramStatus.normal),
      );
      final vxse52 = telegrams.firstWhereOrNull(
        (e) =>
            e.type == TelegramType.vxse52 &&
            (_includeTestTelegrams || e.status == TelegramStatus.normal),
      );
      final vxse53 = telegrams.firstWhereOrNull(
        (e) =>
            e.type == TelegramType.vxse53 &&
            (_includeTestTelegrams || e.status == TelegramStatus.normal),
      );
      // 顕著な地震の震源要素更新のお知らせ
      final vxse61 = telegrams.firstWhereOrNull(
        (e) =>
            e.type == TelegramType.vxse61 &&
            (_includeTestTelegrams || e.status == TelegramStatus.normal),
      );
      // 長周期地震動に関する観測情報
      final vxse62 = telegrams.firstWhereOrNull(
        (e) =>
            e.type == TelegramType.vxse62 &&
            (_includeTestTelegrams || e.status == TelegramStatus.normal),
      );
      Earthquake? earthquake;
      if (vxse61 != null) {
        earthquake = (vxse61.body as TelegramVxse61Body).earthquake;
      } else if (vxse53 != null) {
        earthquake = (vxse53.body as TelegramVxse53Body).earthquake;
      } else if (vxse52 != null) {
        earthquake = (vxse52.body as TelegramVxse52Body).earthquake;
      }
      Intensity? intensity;
      if (vxse53 != null) {
        intensity = (vxse53.body as TelegramVxse53Body).intensity;
      } else if (vxse51 != null) {
        intensity = (vxse51.body as TelegramVxse51Body).intensity;
      }
      CommentsOmitVar? comment;
      var isVolcano = false;
      bool isVolcanoCheck(CommentsOmitVar comment) =>
          (comment.free?.contains('大規模な噴火が発生しました') ?? false) &&
          (comment.free?.contains('実際には、規模の大きな地震は発生していない点に留意') ?? false);
      if (vxse62 != null) {
        comment = (vxse62.body as TelegramVxse62Body).comment;
        if (!isVolcano) {
          isVolcano = isVolcanoCheck(comment);
        }
      } else if (vxse53 != null) {
        comment = (vxse53.body as TelegramVxse53Body).comment;
        if (!isVolcano) {
          isVolcano = isVolcanoCheck(comment);
        }
      } else if (vxse52 != null) {
        comment = (vxse52.body as TelegramVxse52Body).comment;
        if (!isVolcano) {
          isVolcano = isVolcanoCheck(comment);
        }
      } else if (vxse51 != null) {
        comment = (vxse51.body as TelegramVxse51Body).comment;
        if (!isVolcano) {
          isVolcano = isVolcanoCheck(comment);
        }
      }

      final earthquakeData = EarthquakeData(
        earthquake: earthquake,
        intensity: intensity,
        lgIntensity: vxse62 != null
            ? (vxse62.body as TelegramVxse62Body).intensity
            : null,
        comment: comment,
        isVolcano: isVolcano,
      );
      //! EarthquakeData !
      final vtse41 = telegrams.firstWhereOrNull(
        (e) =>
            e.type == TelegramType.vtse41 &&
            (_includeTestTelegrams || e.status == TelegramStatus.normal),
      );
      final vtse51 = telegrams.firstWhereOrNull(
        (e) =>
            e.type == TelegramType.vtse51 &&
            (_includeTestTelegrams || e.status == TelegramStatus.normal),
      );
      final vtse52 = telegrams.firstWhereOrNull(
        (e) =>
            e.type == TelegramType.vtse52 &&
            (_includeTestTelegrams || e.status == TelegramStatus.normal),
      );
      List<TsunamiForecast>? forecasts;
      if (vtse51 != null) {
        forecasts = (vtse51.body as TelegramVtse51Body).tsunami.forecasts;
      } else if (vtse41 != null) {
        forecasts = (vtse41.body as TelegramVtse41Body).tsunami.forecasts;
      }
      List<TsunamiEstimation>? estimations;
      if (vtse52 != null) {
        estimations = (vtse52.body as TelegramVtse52Body).tsunami.estimations;
      }
      List<TsunamiObservation>? observations;
      if (vtse52 != null) {
        observations = (vtse52.body as TelegramVtse52Body).tsunami.observations;
      }
      // observationsが入っていない もしくは vtse52よりも後に来ている場合
      if (vtse51 != null) {
        if (observations == null ||
            (vtse52?.pressTime ?? (DateTime(1900))).isAfter(vtse51.pressTime)) {
          observations = (vtse51 as TelegramVtse51Body).tsunami.observations;
        }
      }
      TsunamiComments? comments;
      if (vtse52 != null) {
        comments = (vtse52.body as TelegramVtse52Body).comments;
      } else if (vtse51 != null) {
        comments = (vtse51.body as TelegramVtse51Body).comments;
      } else if (vtse41 != null) {
        comments = (vtse41.body as TelegramVtse41Body).comments;
      }
      final tsunamiData = TsunamiData(
        forecasts: forecasts,
        estimations: estimations,
        observations: observations,
        comments: comments,
      );

      result.add(
        EarthquakeHistoryItem(
          eventId: int.parse(eventId),
          telegrams: telegrams,
          earthquake: earthquakeData,
          tsunami: tsunamiData,
        ),
      );
    });
    return result;
  }
}

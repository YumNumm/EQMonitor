import 'dart:async';
import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:eqapi_types/extension/telegram_v3.dart';
import 'package:eqapi_types/model/components/eew_intensity.dart';
import 'package:eqapi_types/model/telegram_v3.dart';
import 'package:eqmonitor/feature/earthquake_history/model/state/earthquake_history_item.dart';
import 'package:eqmonitor/feature/earthquake_history/viewmodel/earthquake_history_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'eew_provider.g.dart';

@Riverpod(
  keepAlive: true,
  dependencies: [EarthquakeHistoryViewModel],
)
class EewTelegram extends _$EewTelegram {
  @override
  List<EarthquakeHistoryItem> build() {
    ref.listen(earthquakeHistoryViewModelProvider, (previous, next) {
      for (final item in (next.value ?? <EarthquakeHistoryItem>[])
          .where((e) => e.latestEew != null)) {
        if (_shouldShow(item)) {
          upsert(item);
        }
      }
    });

    /// 古くなったEEWを棄却するタイマー
    Timer.periodic(const Duration(seconds: 2), (_) {
      final result = state.where(_shouldShow).toList();
      if (result.length != state.length) {
        log('UPDATE EEW LIST(${result.length})');

        state = result;
      }
    });

    ref.listenSelf((previous, next) {
      log(next.toString());
    });

    return [];
  }

  void upsert(EarthquakeHistoryItem item) {
    // EventIdが同じものがあれば、置き換える
    final index = state.indexWhere((e) => e.eventId == item.eventId);

    if (index >= 0) {
      state[index] = item;
      final data = state;
      data[index] = item;
      state = data;
      return;
    } else {
      state = [item, ...state];
    }
  }

  /// EEWを表示するかどうかの判定
  /// 地震発生から210秒以内のものは表示する
  /// ただし、M6.0以上の場合は300秒以内
  bool _shouldShow(EarthquakeHistoryItem item) {
    final eew = item.latestEew;
    if (eew == null) {
      return false;
    }
    if (eew is TelegramVxse45Body) {
      log('eew is TelegramVxse45Body');
      final time = eew.originTime ?? eew.arrivalTime;
      if (!item.eventId.toString().startsWith('2023')) {
        return true;
      }

      return DateTime.now().difference(time).inSeconds <=
          switch (eew.magnitude) {
            null => 210,
            >= 6.0 => 300,
            _ => 210,
          };
    }
    if (eew is TelegramVxse45Cancel) {
      log('eew is TelegramVxse45Cancel');
      final eews = item.telegrams.where((e) => e.type == TelegramType.vxse45);
      // serialNoが最大のTelegram
      final latest = eews
          .where((e) => e.infoType != TelegramInfoType.cancel)
          .sorted((a, b) => (b.serialNo ?? 0).compareTo(a.serialNo ?? 0))
          .firstOrNull;
      if (latest == null) {
        return false;
      }
      return DateTime.now().difference(latest.pressTime).inSeconds <= 210;
    }
    log('eew is unknown');
    return true;
  }

  @override
  bool updateShouldNotify(
    List<EarthquakeHistoryItem> previous,
    List<EarthquakeHistoryItem> next,
  ) =>
      true;
}

@Riverpod(keepAlive: true)
class EewEstimatedIntensity extends _$EewEstimatedIntensity {
  @override
  List<(int code, JmaForecastIntensity intensity)> build() {
    return [];
  }
}

/// キャンセル報を除いた最新のEEW
@Riverpod(dependencies: [EewTelegram, EewTelegram])
class EewNormalTelegram extends _$EewNormalTelegram {
  @override
  List<
      (
        TelegramVxse45Body body,
        TelegramV3 telegram,
      )> build() {
    ref.listen(eewTelegramProvider, (_, next) => state = _build(next));

    return _build(ref.read(eewTelegramProvider));
  }

  List<
      (
        TelegramVxse45Body body,
        TelegramV3 telegram,
      )> _build(List<EarthquakeHistoryItem> data) => data
      .where(
        (e) => e.latestEew != null && e.latestEew is TelegramVxse45Body,
      )
      .map(
        (e) => (e.latestEew! as TelegramVxse45Body, e.latestEewTelegram!),
      )
      .toList();
}

/// レベル法・PLUM法・IPF1点のEEWを 除いた最新のEEW
@Riverpod(dependencies: [EewNormalTelegram, EewNormalTelegram])
class EewFilteredTelegram extends _$EewFilteredTelegram {
  @override
  List<
      (
        TelegramVxse45Body body,
        TelegramV3 telegram,
      )> build() {
    ref.listen(eewNormalTelegramProvider, (_, next) => state = _build(next));

    return _build(ref.read(eewNormalTelegramProvider));
  }

  List<
      (
        TelegramVxse45Body body,
        TelegramV3 telegram,
      )> _build(
    List<
            (
              TelegramVxse45Body body,
              TelegramV3 telegram,
            )>
        data,
  ) =>
      data.where(
        (e) {
          final eew = e.$1;
          return eew.magnitude != null &&
              eew.magnitude != null &&
              eew.hypocenter != null &&
              !(eew.isLevelEew && eew.isPlum && eew.isIpfOnePoint);
        },
      ).toList();
}

/// EEWの予想震度のリスト
@Riverpod(dependencies: [EewNormalTelegram, EewNormalTelegram])
class EewEstimatedIntensityList extends _$EewEstimatedIntensityList {
  @override
  List<(int code, JmaForecastIntensity intensity)> build() {
    ref.listen(eewNormalTelegramProvider, (_, next) => state = _build(next));
    return _build(ref.read(eewNormalTelegramProvider));
  }

  List<(int code, JmaForecastIntensity intensity)> _build(
    List<
            (
              TelegramVxse45Body body,
              TelegramV3 telegram,
            )>
        eews,
  ) {
    final regions = eews.map((e) => e.$1.regions ?? []).flattened;
    final result = <(int, JmaForecastIntensity)>[];
    regions
        .groupListsBy((e) => int.tryParse(e.code) ?? 0)
        .forEach((key, value) {
      final maxIntensity = value
          .map((e) => e.forecastMaxInt.toDisplayMaxInt())
          .sorted((a, b) => b.maxInt.compareTo(a.maxInt))
          .firstOrNull;
      if (maxIntensity != null) {
        result.add((key, maxIntensity.maxInt));
      }
    });
    return result;
  }
}

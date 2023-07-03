import 'dart:async';
import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:eqapi_schema/model/telegram_v3.dart';
import 'package:eqmonitor/feature/earthquake_history/model/state/earthquake_history_item.dart';
import 'package:eqmonitor/feature/earthquake_history/viewmodel/earthquake_history_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'eew_provider.g.dart';

@Riverpod(keepAlive: true)
class EewTelegram extends _$EewTelegram {
  @override
  List<EarthquakeHistoryItem> build() {
    ref.listen(earthquakeHistoryViewModelProvider, (previous, next) {
      print('EEW PROVIDER NEW DATA');
      for (final item in (next.value ?? <EarthquakeHistoryItem>[])
          .where((e) => e.latestEew != null)) {
        if (item.eventId.toString().contains('203')) {
        }
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

    return [];
  }

  void upsert(EarthquakeHistoryItem item) {
    final data = state;
    // EventIdが同じものがあれば、置き換える
    final index = data.indexWhere((e) => e.eventId == item.eventId);
    if (index >= 0) {
      data[index] = item;
      state = data;
    } else {
      state = [...data, item];
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
}

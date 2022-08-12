import 'package:collection/collection.dart';
import 'package:eqmonitor/api/remote_db/telegram.dart';
import 'package:eqmonitor/model/earthquake/earthquake_log_model.dart';
import 'package:eqmonitor/schema/supabase/telegram.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// ref: https://github.com/ingen084/KyoshinEewViewerIngen/blob/2801ad7959f99abe7ac81c2ff3a7d1974716a786/src/KyoshinEewViewer/Series/Earthquake/Services/EarthquakeWatchService.cs
class EarthquakeHistoryController
    extends StateNotifier<EarthquakeHistoryModel> {
  EarthquakeHistoryController()
      : super(
          const EarthquakeHistoryModel(
            telegrams: <Telegram>[],
            telegramsGroupByEventId: {},
          ),
        ) {
    onInit();
  }
  final TelegramApi telegramApi = TelegramApi();

  /// 電文を追加します
  void addTelegram(Telegram telegram) {
    final toUpdateTelegrams = [...state.telegrams, telegram];
    final toUpdateTelegramsGroupBy = toUpdateTelegrams
        .where(
          (element) => <String>['VXSE51', 'VXSE52', 'VXSE53', 'VXSE61']
              .contains(element.type),
        )
        .toList()
        .groupListsBy((element) => int.parse(element.eventId.toString()));
    // EventIdと
    state = state.copyWith(
      telegrams: toUpdateTelegrams,
      telegramsGroupByEventId: toUpdateTelegramsGroupBy,
    );
  }

  void addTelegrams(List<Telegram> telegrams) {
    final toUpdateTelegrams = [...state.telegrams, ...telegrams];
    final toUpdateTelegramsGroupBy = toUpdateTelegrams
        .where(
          (element) => <String>['VXSE51', 'VXSE52', 'VXSE53', 'VXSE61']
              .contains(element.type),
        )
        .toList()
        .groupListsBy((element) => int.parse(element.eventId.toString()));
    // EventIdと
    state = state.copyWith(
      telegrams: toUpdateTelegrams,
      telegramsGroupByEventId: toUpdateTelegramsGroupBy,
    );
  }

  /// 電文を100件読み込みます
  void onInit() {
    getTelegrams().then(addTelegrams);
  }

  Future<List<Telegram>> getTelegrams({int limit = 100}) async {
    return telegramApi.getTelegramsWithLimit(limit: limit);
  }

  Future<bool> refreshTelegrams({int limit = 100}) async {
    try{
      final res = await telegramApi.getTelegramsWithLimit(limit: limit);
      res.forEach(addTelegram);
      return true;
    }on Exception catch(e){
      return false;
    }
  }
}

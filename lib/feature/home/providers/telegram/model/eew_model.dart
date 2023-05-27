import 'package:eqapi_schema/model/telegram_v3.dart';
import 'package:eqmonitor/feature/earthquake_history/model/state/earthquake_history_item.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'eew_model.freezed.dart';
part 'eew_model.g.dart';

@freezed
class EewHistoryItem with _$EewHistoryItem {
  const factory EewHistoryItem({
    required EarthquakeData earthquake,
    required TsunamiData tsunami,
    required List<TelegramV3> telegrams,
    required int eventId,
  }) = _EewHistoryItem;

  factory EewHistoryItem.fromJson(Map<String, dynamic> json) =>
      _$EewHistoryItemFromJson(json);
}

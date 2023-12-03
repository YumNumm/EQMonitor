import 'package:collection/collection.dart';
import 'package:eqapi_types/model/telegram_v3.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tsunami_history_model.freezed.dart';
part 'tsunami_history_model.g.dart';

@freezed
class TsunamiHistoryItem with _$TsunamiHistoryItem {
  const factory TsunamiHistoryItem({
    required Vtse41Data? vtse41,
    required Vtse51Data? vtse51,
    required Vtse52Data? vtse52,
  }) = _TsunamiHisotryItem;

  factory TsunamiHistoryItem.fromJson(Map<String, dynamic> json) =>
      _$TsunamiHistoryItemFromJson(json);

  factory TsunamiHistoryItem.fromTelegramV3s(List<TelegramV3> telegrams) {
    // 発表されたのが新しい順に並べる
    final sortedTelegrams =
        telegrams.sorted((a, b) => b.pressTime.compareTo(a.pressTime));
    final latestVtse41 = sortedTelegrams.firstWhereOrNull(
      (element) => element.type == TelegramType.vtse41,
    );
    final latestVtse41Body = latestVtse41?.body;
    final latestVtse51 = sortedTelegrams.firstWhereOrNull(
      (element) => element.type == TelegramType.vtse51,
    );
    final latestVtse51Body = latestVtse51?.body;
    final latestVtse52 = sortedTelegrams.firstWhereOrNull(
      (element) => element.type == TelegramType.vtse52,
    );
    final latestVtse52Body = latestVtse52?.body;
    return TsunamiHistoryItem(
      vtse41: latestVtse41 != null
          ? Vtse41Data(
              telegram: latestVtse41,
              body: latestVtse41Body is TelegramVtse41Body
                  ? latestVtse41Body
                  : null,
              cancel: latestVtse41Body is TelegramCancelBody
                  ? latestVtse41Body
                  : null,
            )
          : null,
      vtse51: latestVtse51 != null
          ? Vtse51Data(
              telegram: latestVtse51,
              body: latestVtse51Body is TelegramVtse51Body
                  ? latestVtse51Body
                  : null,
              cancel: latestVtse51Body is TelegramCancelBody
                  ? latestVtse51Body
                  : null,
            )
          : null,
      vtse52: latestVtse52 != null
          ? Vtse52Data(
              telegram: latestVtse52,
              body: latestVtse52Body is TelegramVtse52Body
                  ? latestVtse52Body
                  : null,
              cancel: latestVtse52Body is TelegramCancelBody
                  ? latestVtse52Body
                  : null,
            )
          : null,
    );
  }
}

@freezed
class Vtse41Data with _$Vtse41Data {
  const factory Vtse41Data({
    required TelegramV3 telegram,
    required TelegramVtse41Body? body,
    required TelegramCancelBody? cancel,
  }) = _Vtse41Data;

  factory Vtse41Data.fromJson(Map<String, dynamic> json) =>
      _$Vtse41DataFromJson(json);
}

@freezed
class Vtse51Data with _$Vtse51Data {
  const factory Vtse51Data({
    required TelegramV3 telegram,
    required TelegramVtse51Body? body,
    required TelegramCancelBody? cancel,
  }) = _Vtse51Data;

  factory Vtse51Data.fromJson(Map<String, dynamic> json) =>
      _$Vtse51DataFromJson(json);
}

@freezed
class Vtse52Data with _$Vtse52Data {
  const factory Vtse52Data({
    required TelegramV3 telegram,
    required TelegramVtse52Body? body,
    required TelegramCancelBody? cancel,
  }) = _Vtse52Data;

  factory Vtse52Data.fromJson(Map<String, dynamic> json) =>
      _$Vtse52DataFromJson(json);
}

import 'package:eqapi_schema/model/telegram_v3.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'telegram_ws_model.freezed.dart';
part 'telegram_ws_model.g.dart';

@freezed
class TelegramWsModel with _$TelegramWsModel {
  const factory TelegramWsModel({
    @JsonKey(fromJson: telegramWsModelFromJson, toJson: telegramWsModelToJson)
        required Stream<TelegramV3> telegramStream,
  }) = _TelegramWsModel;

  factory TelegramWsModel.fromJson(Map<String, dynamic> json) =>
      _$TelegramWsModelFromJson(json);
}

Map<String, dynamic> telegramWsModelToJson(Stream<TelegramV3> instance) =>
    <String, dynamic>{};

Stream<TelegramV3> telegramWsModelFromJson(Map<String, dynamic> json) =>
    const Stream.empty();

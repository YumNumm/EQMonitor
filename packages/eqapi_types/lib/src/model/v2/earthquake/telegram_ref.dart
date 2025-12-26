import 'package:eqapi_types/src/model/v2/telegram/telegram.dart';
import 'package:eqapi_types/src/model/v2/telegram/telegram_comments.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'telegram_ref.freezed.dart';
part 'telegram_ref.g.dart';

/// 地震に関連する電文情報
@freezed
abstract class EarthquakeTelegramRef with _$EarthquakeTelegramRef {
  const factory EarthquakeTelegramRef({
    required Telegram telegram,
    TelegramComments? comments,
  }) = _EarthquakeTelegramRef;

  factory EarthquakeTelegramRef.fromJson(Map<String, dynamic> json) =>
      _$EarthquakeTelegramRefFromJson(json);
}

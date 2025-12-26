import 'package:eqapi_types/src/model/v2/enum/telegram_info_type.dart';
import 'package:eqapi_types/src/model/v2/enum/telegram_status.dart';
import 'package:eqapi_types/src/model/v2/enum/telegram_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'telegram.freezed.dart';
part 'telegram.g.dart';

/// 電文情報（基本）
@freezed
abstract class Telegram with _$Telegram {
  const factory Telegram({
    required String id,
    required String eventId,
    int? serialNo,
    required TelegramType type,
    required String title,
    required TelegramStatus status,
    required TelegramInfoType infoType,
    required String editorialOffice,
    required List<String> publishingOffice,
    required DateTime pressAt,
    required DateTime reportAt,
    DateTime? targetAt,
    DateTime? revokeAt,
    String? headline,
    required String infoKind,
    required String infoKindVersion,
    required String hash,
    required DateTime createdAt,
  }) = _Telegram;

  factory Telegram.fromJson(Map<String, dynamic> json) =>
      _$TelegramFromJson(json);
}

/// 電文情報（一覧用、bodyなし）
typedef TelegramPartial = Telegram;

/// 電文情報（詳細用、body含む）
@freezed
abstract class TelegramDetail with _$TelegramDetail {
  const factory TelegramDetail({
    required String id,
    required String eventId,
    int? serialNo,
    required TelegramType type,
    required String title,
    required TelegramStatus status,
    required TelegramInfoType infoType,
    required String editorialOffice,
    required List<String> publishingOffice,
    required DateTime pressAt,
    required DateTime reportAt,
    DateTime? targetAt,
    DateTime? revokeAt,
    String? headline,
    required String infoKind,
    required String infoKindVersion,
    required String hash,
    required DateTime createdAt,
    Object? body,
  }) = _TelegramDetail;

  factory TelegramDetail.fromJson(Map<String, dynamic> json) =>
      _$TelegramDetailFromJson(json);
}

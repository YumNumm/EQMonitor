import 'package:eqapi_types/src/model/v2/telegram/telegram.dart';
import 'package:eqapi_types/src/model/v2/telegram/telegram_comments.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'responses.freezed.dart';
part 'responses.g.dart';

/// 電文一覧レスポンス
@freezed
abstract class TelegramListResponse with _$TelegramListResponse {
  const factory TelegramListResponse({
    required List<Telegram> items,
    String? nextToken,
    String? nextPooling,
  }) = _TelegramListResponse;

  factory TelegramListResponse.fromJson(Map<String, dynamic> json) =>
      _$TelegramListResponseFromJson(json);
}

/// 電文詳細レスポンス
@freezed
abstract class TelegramDetailResponse with _$TelegramDetailResponse {
  const factory TelegramDetailResponse({
    required TelegramDetail telegram,
    TelegramComments? comments,
  }) = _TelegramDetailResponse;

  factory TelegramDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$TelegramDetailResponseFromJson(json);
}

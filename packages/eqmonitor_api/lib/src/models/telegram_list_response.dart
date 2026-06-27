// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'telegram_partial.dart';

part 'telegram_list_response.freezed.dart';
part 'telegram_list_response.g.dart';

@Freezed()
abstract class TelegramListResponse with _$TelegramListResponse {
  const factory TelegramListResponse({
    required List<TelegramPartial> items,

    /// カーソル情報（base64エンコード）
    @JsonKey(includeIfNull: false,name: 'next_token')
    String? nextToken,

    /// カーソル情報（base64エンコード）
    @JsonKey(includeIfNull: false,name: 'next_pooling')
    String? nextPooling,
  }) = _TelegramListResponse;
  
  factory TelegramListResponse.fromJson(Map<String, Object?> json) => _$TelegramListResponseFromJson(json);
}

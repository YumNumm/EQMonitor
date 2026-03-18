// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'telegram_comments.dart';
import 'telegram_detail.dart';

part 'telegram_detail_response.freezed.dart';
part 'telegram_detail_response.g.dart';

@Freezed()
abstract class TelegramDetailResponse with _$TelegramDetailResponse {
  const factory TelegramDetailResponse({
    required TelegramDetail telegram,
    @JsonKey(includeIfNull: true) required TelegramComments? comments,
  }) = _TelegramDetailResponse;

  factory TelegramDetailResponse.fromJson(Map<String, Object?> json) =>
      _$TelegramDetailResponseFromJson(json);
}

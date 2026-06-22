// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'telegram_detail_response.dart';

part 'telegram_event_details_response.freezed.dart';
part 'telegram_event_details_response.g.dart';

@Freezed()
abstract class TelegramEventDetailsResponse
    with _$TelegramEventDetailsResponse {
  const factory TelegramEventDetailsResponse({
    required List<TelegramDetailResponse> items,
  }) = _TelegramEventDetailsResponse;

  factory TelegramEventDetailsResponse.fromJson(Map<String, Object?> json) =>
      _$TelegramEventDetailsResponseFromJson(json);
}

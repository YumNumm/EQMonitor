// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'tsunami_telegram_with_state.dart';

part 'tsunami_telegrams_response.freezed.dart';
part 'tsunami_telegrams_response.g.dart';

@Freezed()
abstract class TsunamiTelegramsResponse with _$TsunamiTelegramsResponse {
  const factory TsunamiTelegramsResponse({
    required List<TsunamiTelegramWithState> telegrams,
  }) = _TsunamiTelegramsResponse;

  factory TsunamiTelegramsResponse.fromJson(Map<String, Object?> json) =>
      _$TsunamiTelegramsResponseFromJson(json);
}

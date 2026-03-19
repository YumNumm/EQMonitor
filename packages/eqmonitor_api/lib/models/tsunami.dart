// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'tsunami_telegram_item.dart';

part 'tsunami.freezed.dart';
part 'tsunami.g.dart';

@Freezed()
abstract class Tsunami with _$Tsunami {
  const factory Tsunami({
    required String id,
    @JsonKey(name: 'event_ids') required List<String> eventIds,
    required List<TsunamiTelegramItem> telegrams,
  }) = _Tsunami;

  factory Tsunami.fromJson(Map<String, Object?> json) =>
      _$TsunamiFromJson(json);
}

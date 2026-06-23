// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'comments3.dart';
import 'telegram_type.dart';

part 'latest_telegram.freezed.dart';
part 'latest_telegram.g.dart';

@Freezed()
abstract class LatestTelegram with _$LatestTelegram {
  const factory LatestTelegram({
    required String id,
    required TelegramType type,
    required String title,
    @JsonKey(name: 'editorial_office') required String editorialOffice,
    @JsonKey(name: 'publishing_office') required List<String> publishingOffice,
    @JsonKey(name: 'pressed_at') required DateTime pressedAt,
    @JsonKey(name: 'reported_at') required DateTime reportedAt,
    @JsonKey(name: 'info_kind') required String infoKind,
    @JsonKey(includeIfNull: false, name: 'serial_no') num? serialNo,
    @JsonKey(includeIfNull: false, name: 'targeted_at') DateTime? targetedAt,
    @JsonKey(includeIfNull: false, name: 'revoked_at') DateTime? revokedAt,
    @JsonKey(includeIfNull: false) String? headline,
    @JsonKey(includeIfNull: false) Comments3? comments,
  }) = _LatestTelegram;

  factory LatestTelegram.fromJson(Map<String, Object?> json) =>
      _$LatestTelegramFromJson(json);
}

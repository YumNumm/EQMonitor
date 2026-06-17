// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'telegram_type.dart';
import 'tsunami_comments.dart';

part 'latest_telegram.freezed.dart';
part 'latest_telegram.g.dart';

@Freezed()
abstract class LatestTelegram with _$LatestTelegram {
  const factory LatestTelegram({
    required TelegramType type,
    required String title,
    @JsonKey(name: 'press_at')
    required DateTime pressAt,
    @JsonKey(name: 'report_at')
    required DateTime reportAt,
    @JsonKey(name: 'info_kind')
    required String infoKind,
    @JsonKey(includeIfNull: false,name: 'serial_no')
    num? serialNo,
    @JsonKey(includeIfNull: false,name: 'target_at')
    DateTime? targetAt,
    @JsonKey(includeIfNull: false,name: 'revoke_at')
    DateTime? revokeAt,
    @JsonKey(includeIfNull: false)
    String? headline,
    @JsonKey(includeIfNull: false)
    TsunamiComments? comments,
    @JsonKey(includeIfNull: false)
    String? text,
  }) = _LatestTelegram;
  
  factory LatestTelegram.fromJson(Map<String, Object?> json) => _$LatestTelegramFromJson(json);
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'info_type.dart';
import 'telegram_body_union.dart';
import 'telegram_status.dart';
import 'telegram_type.dart';

part 'telegram_detail.freezed.dart';
part 'telegram_detail.g.dart';

@Freezed()
abstract class TelegramDetail with _$TelegramDetail {
  const factory TelegramDetail({
    required String id,
    @JsonKey(name: 'event_id')
    required String eventId,
    required TelegramType type,
    required String title,
    required TelegramStatus status,
    @JsonKey(name: 'info_type')
    required InfoType infoType,
    @JsonKey(name: 'editorial_office')
    required String editorialOffice,
    @JsonKey(name: 'publishing_office')
    required List<String> publishingOffice,
    @JsonKey(name: 'pressed_at')
    required DateTime pressedAt,
    @JsonKey(name: 'reported_at')
    required DateTime reportedAt,
    @JsonKey(name: 'info_kind')
    required String infoKind,
    @JsonKey(name: 'info_kind_version')
    required String infoKindVersion,
    required String hash,
    @JsonKey(name: 'created_at')
    required DateTime createdAt,
    required TelegramBodyUnion body,
    @JsonKey(includeIfNull: false,name: 'serial_no')
    num? serialNo,
    @JsonKey(includeIfNull: false,name: 'targeted_at')
    DateTime? targetedAt,
    @JsonKey(includeIfNull: false,name: 'revoked_at')
    DateTime? revokedAt,
    @JsonKey(includeIfNull: false)
    String? headline,
  }) = _TelegramDetail;
  
  factory TelegramDetail.fromJson(Map<String, Object?> json) => _$TelegramDetailFromJson(json);
}

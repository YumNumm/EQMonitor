// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'info_type.dart';
import 'status.dart';
import 'type4.dart';

part 'tsunami_telegram_header.freezed.dart';
part 'tsunami_telegram_header.g.dart';

@Freezed()
abstract class TsunamiTelegramHeader with _$TsunamiTelegramHeader {
  const factory TsunamiTelegramHeader({
    required String hash,
    @JsonKey(name: 'event_id') required String eventId,
    required Type4 type,
    required String title,
    required Status status,
    @JsonKey(name: 'info_type') required InfoType infoType,
    @JsonKey(name: 'editorial_office') required String editorialOffice,
    @JsonKey(name: 'publishing_office') required List<String> publishingOffice,
    @JsonKey(name: 'press_at') required DateTime pressAt,
    @JsonKey(name: 'report_at') required DateTime reportAt,
    @JsonKey(name: 'info_kind') required String infoKind,
    @JsonKey(name: 'info_kind_version') required String infoKindVersion,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(includeIfNull: false, name: 'serial_no') num? serialNo,
    @JsonKey(includeIfNull: false, name: 'target_at') DateTime? targetAt,
    @JsonKey(includeIfNull: false, name: 'revoke_at') DateTime? revokeAt,
    @JsonKey(includeIfNull: false) String? headline,
  }) = _TsunamiTelegramHeader;

  factory TsunamiTelegramHeader.fromJson(Map<String, Object?> json) =>
      _$TsunamiTelegramHeaderFromJson(json);
}

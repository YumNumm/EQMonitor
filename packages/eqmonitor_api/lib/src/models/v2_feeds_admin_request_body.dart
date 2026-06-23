// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'data.dart';
import 'translations.dart';

part 'v2_feeds_admin_request_body.freezed.dart';
part 'v2_feeds_admin_request_body.g.dart';

@Freezed()
abstract class V2FeedsAdminRequestBody with _$V2FeedsAdminRequestBody {
  const factory V2FeedsAdminRequestBody({
    required dynamic feedType,
    required dynamic priority,
    required bool isImportant,
    required String publishedAt,
    required Data data,
    required List<Translations> translations,
    @JsonKey(includeIfNull: false) String? expiresAt,
  }) = _V2FeedsAdminRequestBody;

  factory V2FeedsAdminRequestBody.fromJson(Map<String, Object?> json) =>
      _$V2FeedsAdminRequestBodyFromJson(json);
}

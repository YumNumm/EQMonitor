// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'earthquake_archive.dart';

part 'admin_earthquake_archive_list_response.freezed.dart';
part 'admin_earthquake_archive_list_response.g.dart';

@Freezed()
abstract class AdminEarthquakeArchiveListResponse with _$AdminEarthquakeArchiveListResponse {
  const factory AdminEarthquakeArchiveListResponse({
    required List<EarthquakeArchive> items,

    /// カーソル情報（base64エンコード）
    @JsonKey(includeIfNull: false,name: 'next_token')
    String? nextToken,

    /// カーソル情報（base64エンコード）
    @JsonKey(includeIfNull: false,name: 'next_pooling')
    String? nextPooling,
  }) = _AdminEarthquakeArchiveListResponse;
  
  factory AdminEarthquakeArchiveListResponse.fromJson(Map<String, Object?> json) => _$AdminEarthquakeArchiveListResponseFromJson(json);
}

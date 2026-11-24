// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin_earthquake_archive_download_url_response.freezed.dart';
part 'admin_earthquake_archive_download_url_response.g.dart';

@Freezed()
abstract class AdminEarthquakeArchiveDownloadUrlResponse with _$AdminEarthquakeArchiveDownloadUrlResponse {
  const factory AdminEarthquakeArchiveDownloadUrlResponse({
    required String url,
  }) = _AdminEarthquakeArchiveDownloadUrlResponse;
  
  factory AdminEarthquakeArchiveDownloadUrlResponse.fromJson(Map<String, Object?> json) => _$AdminEarthquakeArchiveDownloadUrlResponseFromJson(json);
}

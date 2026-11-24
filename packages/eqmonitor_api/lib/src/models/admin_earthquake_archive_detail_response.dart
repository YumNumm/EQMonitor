// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'earthquake_archive.dart';

part 'admin_earthquake_archive_detail_response.freezed.dart';
part 'admin_earthquake_archive_detail_response.g.dart';

@Freezed()
abstract class AdminEarthquakeArchiveDetailResponse with _$AdminEarthquakeArchiveDetailResponse {
  const factory AdminEarthquakeArchiveDetailResponse({
    required EarthquakeArchive item,
  }) = _AdminEarthquakeArchiveDetailResponse;
  
  factory AdminEarthquakeArchiveDetailResponse.fromJson(Map<String, Object?> json) => _$AdminEarthquakeArchiveDetailResponseFromJson(json);
}

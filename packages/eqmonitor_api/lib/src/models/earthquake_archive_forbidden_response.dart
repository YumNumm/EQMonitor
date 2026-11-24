// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'earthquake_archive_forbidden_response.freezed.dart';
part 'earthquake_archive_forbidden_response.g.dart';

@Freezed()
abstract class EarthquakeArchiveForbiddenResponse with _$EarthquakeArchiveForbiddenResponse {
  const factory EarthquakeArchiveForbiddenResponse({
    /// const: "FORBIDDEN"
    required String code,
    required String message,
  }) = _EarthquakeArchiveForbiddenResponse;
  
  factory EarthquakeArchiveForbiddenResponse.fromJson(Map<String, Object?> json) => _$EarthquakeArchiveForbiddenResponseFromJson(json);
}

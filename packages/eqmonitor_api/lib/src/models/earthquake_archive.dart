// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'earthquake_archive_frame.dart';
import 'earthquake_archive_type.dart';
import 'earthquake_archive_waveform_status.dart';

part 'earthquake_archive.freezed.dart';
part 'earthquake_archive.g.dart';

@Freezed()
abstract class EarthquakeArchive with _$EarthquakeArchive {
  const factory EarthquakeArchive({
    required String eventId,
    required EarthquakeArchiveType type,
    required String objectKey,
    required String originTime,
    required String startTime,
    required String endTime,
    @JsonKey(includeIfNull: true)
    required num? magnitude,
    @JsonKey(includeIfNull: true)
    required String? hypocenterName,
    required num fileSizeBytes,
    required EarthquakeArchiveWaveformStatus waveformStatus,
    @JsonKey(includeIfNull: true)
    required String? waveformCheckedAt,
    required String createdAt,
    required String updatedAt,
    required List<EarthquakeArchiveFrame> frames,
  }) = _EarthquakeArchive;
  
  factory EarthquakeArchive.fromJson(Map<String, Object?> json) => _$EarthquakeArchiveFromJson(json);
}

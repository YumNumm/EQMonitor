// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'earthquake_archive_frame.freezed.dart';
part 'earthquake_archive_frame.g.dart';

@Freezed()
abstract class EarthquakeArchiveFrame with _$EarthquakeArchiveFrame {
  const factory EarthquakeArchiveFrame({
    required num frameType,
    required String frameTypeName,
    required num frameCount,
    required num totalBytes,
    required String firstTime,
    required String lastTime,
  }) = _EarthquakeArchiveFrame;
  
  factory EarthquakeArchiveFrame.fromJson(Map<String, Object?> json) => _$EarthquakeArchiveFrameFromJson(json);
}

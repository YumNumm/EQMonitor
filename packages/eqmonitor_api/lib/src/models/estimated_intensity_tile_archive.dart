// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'estimated_intensity_tile_archive.freezed.dart';
part 'estimated_intensity_tile_archive.g.dart';

@Freezed()
abstract class EstimatedIntensityTileArchive
    with _$EstimatedIntensityTileArchive {
  const factory EstimatedIntensityTileArchive({
    /// 推計震度PMTilesのHTTPSフルURL
    required String url,

    /// 推計震度PMTilesのバイト数
    @JsonKey(name: 'size_bytes') required int sizeBytes,

    /// 推計震度PMTilesのSHA-256
    required String sha256,
  }) = _EstimatedIntensityTileArchive;

  factory EstimatedIntensityTileArchive.fromJson(Map<String, Object?> json) =>
      _$EstimatedIntensityTileArchiveFromJson(json);
}

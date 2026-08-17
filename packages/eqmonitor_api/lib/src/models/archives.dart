// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'partition.dart';
import 'hypocenter_coverage.dart';
import 'bounds.dart';

part 'archives.freezed.dart';
part 'archives.g.dart';

@Freezed()
abstract class Archives with _$Archives {
  const factory Archives({
    required Partition partition,
    required HypocenterCoverage period,
    @JsonKey(name: 'query_revision')
    required String queryRevision,
    @JsonKey(name: 'archive_revision')
    required String archiveRevision,
    required String url,
    @JsonKey(name: 'feature_count')
    required int featureCount,
    @JsonKey(name: 'size_bytes')
    required int sizeBytes,

    /// const: 14
    @JsonKey(includeIfNull: false,name: 'data_zoom')
    int? dataZoom,
    @JsonKey(includeIfNull: false)
    Bounds? bounds,
  }) = _Archives;

  factory Archives.fromJson(Map<String, Object?> json) => _$ArchivesFromJson(json);
}

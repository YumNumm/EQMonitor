// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'partition.dart';
import 'hypocenter_coverage.dart';

part 'archives.freezed.dart';
part 'archives.g.dart';

@Freezed()
abstract class Archives with _$Archives {
  const factory Archives({
    required Partition partition,
    required HypocenterCoverage period,
    @JsonKey(name: 'query_revision')
    required String queryRevision,
    required String url,
    @JsonKey(name: 'feature_count')
    required int featureCount,
    @JsonKey(name: 'size_bytes')
    required int sizeBytes,
  }) = _Archives;

  factory Archives.fromJson(Map<String, Object?> json) => _$ArchivesFromJson(json);
}

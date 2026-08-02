// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'hypocenter_coverage.dart';

part 'hypocenter_meta.freezed.dart';
part 'hypocenter_meta.g.dart';

@Freezed()
abstract class HypocenterMeta with _$HypocenterMeta {
  const factory HypocenterMeta({
    @JsonKey(name: 'dataset_revision')
    required String datasetRevision,
    @JsonKey(name: 'data_updated_at')
    required DateTime dataUpdatedAt,
    required HypocenterCoverage coverage,
  }) = _HypocenterMeta;

  factory HypocenterMeta.fromJson(Map<String, Object?> json) => _$HypocenterMetaFromJson(json);
}

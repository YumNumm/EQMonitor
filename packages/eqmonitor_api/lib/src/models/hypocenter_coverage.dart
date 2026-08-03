// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'hypocenter_coverage.freezed.dart';
part 'hypocenter_coverage.g.dart';

@Freezed()
abstract class HypocenterCoverage with _$HypocenterCoverage {
  const factory HypocenterCoverage({
    required DateTime from,
    required DateTime to,
  }) = _HypocenterCoverage;

  factory HypocenterCoverage.fromJson(Map<String, Object?> json) => _$HypocenterCoverageFromJson(json);
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'target_time.dart';
import 'values.dart';

part 'earthquake_counts.freezed.dart';
part 'earthquake_counts.g.dart';

@Freezed()
abstract class EarthquakeCounts with _$EarthquakeCounts {
  const factory EarthquakeCounts({
    required dynamic type,
    required TargetTime targetTime,
    required Values values,
  }) = _EarthquakeCounts;

  factory EarthquakeCounts.fromJson(Map<String, Object?> json) =>
      _$EarthquakeCountsFromJson(json);
}

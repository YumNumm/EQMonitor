// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'type.dart';
import 'target_time.dart';
import 'values.dart';

part 'earthquake_counts.freezed.dart';
part 'earthquake_counts.g.dart';

@Freezed()
abstract class EarthquakeCounts with _$EarthquakeCounts {
  const factory EarthquakeCounts({
    /// const: "１時間地震回数" | const: "累積地震回数" | const: "地震回数"
    required Type type,
    required TargetTime targetTime,
    required Values values,
  }) = _EarthquakeCounts;
  
  factory EarthquakeCounts.fromJson(Map<String, Object?> json) => _$EarthquakeCountsFromJson(json);
}

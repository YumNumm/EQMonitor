// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'feed_nankai_earthquake_info_kind.freezed.dart';
part 'feed_nankai_earthquake_info_kind.g.dart';

@Freezed()
abstract class FeedNankaiEarthquakeInfoKind with _$FeedNankaiEarthquakeInfoKind {
  const factory FeedNankaiEarthquakeInfoKind({
    required String code,
    required String name,
  }) = _FeedNankaiEarthquakeInfoKind;
  
  factory FeedNankaiEarthquakeInfoKind.fromJson(Map<String, Object?> json) => _$FeedNankaiEarthquakeInfoKindFromJson(json);
}

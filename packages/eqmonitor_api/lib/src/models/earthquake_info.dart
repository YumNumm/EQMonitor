// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'kind.dart';

part 'earthquake_info.freezed.dart';
part 'earthquake_info.g.dart';

@Freezed()
abstract class EarthquakeInfo with _$EarthquakeInfo {
  const factory EarthquakeInfo({
    required String text,
    @JsonKey(includeIfNull: false)
    Kind? kind,
    @JsonKey(includeIfNull: false)
    String? appendix,
  }) = _EarthquakeInfo;
  
  factory EarthquakeInfo.fromJson(Map<String, Object?> json) => _$EarthquakeInfoFromJson(json);
}

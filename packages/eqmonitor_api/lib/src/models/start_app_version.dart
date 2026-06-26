// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'latest_version.dart';
import 'required_version.dart';

part 'start_app_version.freezed.dart';
part 'start_app_version.g.dart';

@Freezed()
abstract class StartAppVersion with _$StartAppVersion {
  const factory StartAppVersion({
    @JsonKey(name: 'required_versions')
    required List<RequiredVersion> requiredVersions,
    @JsonKey(includeIfNull: false)
    LatestVersion? latest,
  }) = _StartAppVersion;
  
  factory StartAppVersion.fromJson(Map<String, Object?> json) => _$StartAppVersionFromJson(json);
}

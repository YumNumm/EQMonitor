// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'latest_version.dart';
import 'required_version.dart';

part 'version.freezed.dart';
part 'version.g.dart';

@Freezed()
abstract class Version with _$Version {
  const factory Version({
    @JsonKey(name: 'required_versions')
    required List<RequiredVersion> requiredVersions,
    @JsonKey(includeIfNull: false)
    LatestVersion? latest,
  }) = _Version;
  
  factory Version.fromJson(Map<String, Object?> json) => _$VersionFromJson(json);
}

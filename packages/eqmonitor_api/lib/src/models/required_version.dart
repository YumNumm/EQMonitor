// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'required_version.freezed.dart';
part 'required_version.g.dart';

@Freezed()
abstract class RequiredVersion with _$RequiredVersion {
  const factory RequiredVersion({
    @JsonKey(includeIfNull: false)
    String? version,
    @JsonKey(includeIfNull: false,name: 'build_number')
    int? buildNumber,
    @JsonKey(includeIfNull: false)
    String? message,
  }) = _RequiredVersion;
  
  factory RequiredVersion.fromJson(Map<String, Object?> json) => _$RequiredVersionFromJson(json);
}

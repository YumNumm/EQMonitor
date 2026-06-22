// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'whats_new.dart';

part 'latest_version.freezed.dart';
part 'latest_version.g.dart';

@Freezed()
abstract class LatestVersion with _$LatestVersion {
  const factory LatestVersion({
    required String version,
    required DateTime date,
    @JsonKey(name: 'show_whats_new') required bool showWhatsNew,
    @JsonKey(includeIfNull: false, name: 'whats_new') WhatsNew? whatsNew,
  }) = _LatestVersion;

  factory LatestVersion.fromJson(Map<String, Object?> json) =>
      _$LatestVersionFromJson(json);
}

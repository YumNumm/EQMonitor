// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'changelog_entry.dart';

part 'changelog_response.freezed.dart';
part 'changelog_response.g.dart';

@Freezed()
abstract class ChangelogResponse with _$ChangelogResponse {
  const factory ChangelogResponse({
    required List<ChangelogEntry> entries,
  }) = _ChangelogResponse;
  
  factory ChangelogResponse.fromJson(Map<String, Object?> json) => _$ChangelogResponseFromJson(json);
}

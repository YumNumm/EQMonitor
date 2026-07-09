// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'changelog_section.dart';

part 'changelog_entry.freezed.dart';
part 'changelog_entry.g.dart';

@Freezed()
abstract class ChangelogEntry with _$ChangelogEntry {
  const factory ChangelogEntry({
    required String version,
    required DateTime date,
    required String url,
    required List<ChangelogSection> sections,
    @JsonKey(includeIfNull: false)
    String? content,
  }) = _ChangelogEntry;
  
  factory ChangelogEntry.fromJson(Map<String, Object?> json) => _$ChangelogEntryFromJson(json);
}

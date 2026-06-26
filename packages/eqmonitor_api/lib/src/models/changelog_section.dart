// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'changelog_section.freezed.dart';
part 'changelog_section.g.dart';

@Freezed()
abstract class ChangelogSection with _$ChangelogSection {
  const factory ChangelogSection({
    required String title,
    required List<String> items,
  }) = _ChangelogSection;
  
  factory ChangelogSection.fromJson(Map<String, Object?> json) => _$ChangelogSectionFromJson(json);
}

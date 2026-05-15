// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'changelog_section.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChangelogSection _$ChangelogSectionFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_ChangelogSection', json, ($checkedConvert) {
      final val = _ChangelogSection(
        title: $checkedConvert('title', (v) => v as String),
        items: $checkedConvert(
          'items',
          (v) => (v as List<dynamic>).map((e) => e as String).toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$ChangelogSectionToJson(_ChangelogSection instance) =>
    <String, dynamic>{'title': instance.title, 'items': instance.items};

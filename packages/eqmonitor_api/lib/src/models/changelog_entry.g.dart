// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'changelog_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChangelogEntry _$ChangelogEntryFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_ChangelogEntry', json, ($checkedConvert) {
      final val = _ChangelogEntry(
        version: $checkedConvert('version', (v) => v as String),
        date: $checkedConvert('date', (v) => DateTime.parse(v as String)),
        sections: $checkedConvert(
          'sections',
          (v) => (v as List<dynamic>)
              .map((e) => ChangelogSection.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$ChangelogEntryToJson(_ChangelogEntry instance) =>
    <String, dynamic>{
      'version': instance.version,
      'date': instance.date.toIso8601String(),
      'sections': instance.sections,
    };

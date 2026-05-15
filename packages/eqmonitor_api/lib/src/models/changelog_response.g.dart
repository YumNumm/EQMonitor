// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'changelog_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChangelogResponse _$ChangelogResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_ChangelogResponse', json, ($checkedConvert) {
      final val = _ChangelogResponse(
        entries: $checkedConvert(
          'entries',
          (v) => (v as List<dynamic>)
              .map((e) => ChangelogEntry.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$ChangelogResponseToJson(_ChangelogResponse instance) =>
    <String, dynamic>{'entries': instance.entries};

// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'latest_version.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LatestVersion _$LatestVersionFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_LatestVersion',
      json,
      ($checkedConvert) {
        final val = _LatestVersion(
          version: $checkedConvert('version', (v) => v as String),
          date: $checkedConvert('date', (v) => DateTime.parse(v as String)),
          showWhatsNew: $checkedConvert('show_whats_new', (v) => v as bool),
          whatsNew: $checkedConvert(
            'whats_new',
            (v) =>
                v == null ? null : WhatsNew.fromJson(v as Map<String, dynamic>),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'showWhatsNew': 'show_whats_new',
        'whatsNew': 'whats_new',
      },
    );

Map<String, dynamic> _$LatestVersionToJson(_LatestVersion instance) =>
    <String, dynamic>{
      'version': instance.version,
      'date': instance.date.toIso8601String(),
      'show_whats_new': instance.showWhatsNew,
      'whats_new': ?instance.whatsNew,
    };

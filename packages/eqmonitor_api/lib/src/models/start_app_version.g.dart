// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'start_app_version.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StartAppVersion _$StartAppVersionFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_StartAppVersion',
      json,
      ($checkedConvert) {
        final val = _StartAppVersion(
          requiredVersions: $checkedConvert(
            'required_versions',
            (v) => (v as List<dynamic>)
                .map((e) => RequiredVersion.fromJson(e as Map<String, dynamic>))
                .toList(),
          ),
          latest: $checkedConvert(
            'latest',
            (v) => v == null
                ? null
                : LatestVersion.fromJson(v as Map<String, dynamic>),
          ),
        );
        return val;
      },
      fieldKeyMap: const {'requiredVersions': 'required_versions'},
    );

Map<String, dynamic> _$StartAppVersionToJson(_StartAppVersion instance) =>
    <String, dynamic>{
      'required_versions': instance.requiredVersions,
      'latest': ?instance.latest,
    };

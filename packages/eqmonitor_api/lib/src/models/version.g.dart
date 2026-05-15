// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'version.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Version _$VersionFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_Version', json, ($checkedConvert) {
      final val = _Version(
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
    }, fieldKeyMap: const {'requiredVersions': 'required_versions'});

Map<String, dynamic> _$VersionToJson(_Version instance) => <String, dynamic>{
  'required_versions': instance.requiredVersions,
  'latest': ?instance.latest,
};

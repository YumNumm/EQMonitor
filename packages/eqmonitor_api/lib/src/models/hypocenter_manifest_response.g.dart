// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'hypocenter_manifest_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HypocenterManifestResponse _$HypocenterManifestResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_HypocenterManifestResponse', json, ($checkedConvert) {
  final val = _HypocenterManifestResponse(
    data: $checkedConvert(
      'data',
      (v) => Data2.fromJson(v as Map<String, dynamic>),
    ),
    meta: $checkedConvert(
      'meta',
      (v) => HypocenterMeta.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$HypocenterManifestResponseToJson(
  _HypocenterManifestResponse instance,
) => <String, dynamic>{'data': instance.data, 'meta': instance.meta};

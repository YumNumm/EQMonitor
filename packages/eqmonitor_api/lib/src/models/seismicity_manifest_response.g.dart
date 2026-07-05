// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'seismicity_manifest_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SeismicityManifestResponse _$SeismicityManifestResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_SeismicityManifestResponse', json, ($checkedConvert) {
  final val = _SeismicityManifestResponse(
    layers: $checkedConvert(
      'layers',
      (v) => (v as List<dynamic>)
          .map(
            (e) => SeismicityManifestLayer.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$SeismicityManifestResponseToJson(
  _SeismicityManifestResponse instance,
) => <String, dynamic>{'layers': instance.layers};

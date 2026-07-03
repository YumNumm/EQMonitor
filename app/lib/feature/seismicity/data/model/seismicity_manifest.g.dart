// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'seismicity_manifest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SeismicityManifest _$SeismicityManifestFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_SeismicityManifest', json, ($checkedConvert) {
      final val = _SeismicityManifest(
        layers: $checkedConvert(
          'layers',
          (v) => (v as List<dynamic>)
              .map(
                (e) =>
                    SeismicityManifestLayer.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$SeismicityManifestToJson(_SeismicityManifest instance) =>
    <String, dynamic>{'layers': instance.layers};

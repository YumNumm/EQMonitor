// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'seismicity_manifest_layer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SeismicityManifestLayer _$SeismicityManifestLayerFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_SeismicityManifestLayer',
  json,
  ($checkedConvert) {
    final val = _SeismicityManifestLayer(
      type: $checkedConvert('type', (v) => v as String),
      span: $checkedConvert(
        'span',
        (v) => $enumDecode(_$SeismicityLayerSpanEnumMap, v),
      ),
      url: $checkedConvert('url', (v) => v as String),
      generatedAt: $checkedConvert('generated_at', (v) => v as String),
      count: $checkedConvert('count', (v) => (v as num).toInt()),
    );
    return val;
  },
  fieldKeyMap: const {'generatedAt': 'generated_at'},
);

Map<String, dynamic> _$SeismicityManifestLayerToJson(
  _SeismicityManifestLayer instance,
) => <String, dynamic>{
  'type': instance.type,
  'span': instance.span,
  'url': instance.url,
  'generated_at': instance.generatedAt,
  'count': instance.count,
};

const _$SeismicityLayerSpanEnumMap = {
  SeismicityLayerSpan.p1M: 'P1M',
  SeismicityLayerSpan.p3M: 'P3M',
  SeismicityLayerSpan.p12M: 'P12M',
};

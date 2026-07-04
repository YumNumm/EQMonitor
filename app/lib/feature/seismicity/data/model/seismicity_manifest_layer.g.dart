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
        (v) => $enumDecode(_$SeismicitySpanEnumMap, v),
      ),
      url: $checkedConvert('url', (v) => v as String),
      generatedAt: $checkedConvert(
        'generated_at',
        (v) => DateTime.parse(v as String),
      ),
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
  'span': _$SeismicitySpanEnumMap[instance.span]!,
  'url': instance.url,
  'generated_at': instance.generatedAt.toIso8601String(),
  'count': instance.count,
};

const _$SeismicitySpanEnumMap = {
  SeismicitySpan.p1m: 'P1M',
  SeismicitySpan.p3m: 'P3M',
  SeismicitySpan.p12m: 'P12M',
};

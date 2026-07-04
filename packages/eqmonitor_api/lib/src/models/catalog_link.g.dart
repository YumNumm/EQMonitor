// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'catalog_link.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CatalogLink _$CatalogLinkFromJson(Map<String, dynamic> json) => $checkedCreate(
  '_CatalogLink',
  json,
  ($checkedConvert) {
    final val = _CatalogLink(
      matchConfidence: $checkedConvert('match_confidence', (v) => v as num),
      matchMethod: $checkedConvert(
        'match_method',
        (v) => $enumDecode(_$CatalogLinkMatchMethodEnumMap, v),
      ),
      timeDiffSeconds: $checkedConvert('time_diff_seconds', (v) => v as num),
      distanceKm: $checkedConvert('distance_km', (v) => v as num?),
    );
    return val;
  },
  fieldKeyMap: const {
    'matchConfidence': 'match_confidence',
    'matchMethod': 'match_method',
    'timeDiffSeconds': 'time_diff_seconds',
    'distanceKm': 'distance_km',
  },
);

Map<String, dynamic> _$CatalogLinkToJson(_CatalogLink instance) =>
    <String, dynamic>{
      'match_confidence': instance.matchConfidence,
      'match_method': instance.matchMethod,
      'time_diff_seconds': instance.timeDiffSeconds,
      'distance_km': instance.distanceKm,
    };

const _$CatalogLinkMatchMethodEnumMap = {
  CatalogLinkMatchMethod.auto: 'auto',
  CatalogLinkMatchMethod.manual: 'manual',
};

// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'topology_map.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TopologyMap _$$_TopologyMapFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$_TopologyMap',
      json,
      ($checkedConvert) {
        final val = _$_TopologyMap(
          scale: $checkedConvert(
              'scale', (v) => DoubleVector.fromJson(v as Map<String, dynamic>)),
          translate: $checkedConvert('translate',
              (v) => DoubleVector.fromJson(v as Map<String, dynamic>)),
          polygons: $checkedConvert(
              'polygons',
              (v) => (v as List<dynamic>)
                  .map((e) =>
                      TopologyPolygon.fromJson(e as Map<String, dynamic>))
                  .toList()),
          arcs: $checkedConvert(
              'arcs',
              (v) => (v as List<dynamic>)
                  .map((e) => TopologyArc.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_TopologyMapToJson(_$_TopologyMap instance) =>
    <String, dynamic>{
      'scale': instance.scale,
      'translate': instance.translate,
      'polygons': instance.polygons,
      'arcs': instance.arcs,
    };

_$_TopologyArc _$$_TopologyArcFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$_TopologyArc',
      json,
      ($checkedConvert) {
        final val = _$_TopologyArc(
          arc: $checkedConvert(
              'arc',
              (v) => (v as List<dynamic>)
                  .map((e) => IntVector.fromJson(e as Map<String, dynamic>))
                  .toList()),
          type: $checkedConvert(
              'type', (v) => $enumDecode(_$TopologyArcTypeEnumMap, v)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_TopologyArcToJson(_$_TopologyArc instance) =>
    <String, dynamic>{
      'arc': instance.arc,
      'type': _$TopologyArcTypeEnumMap[instance.type]!,
    };

const _$TopologyArcTypeEnumMap = {
  TopologyArcType.coastline: 'coastline',
  TopologyArcType.admin: 'admin',
  TopologyArcType.area: 'area',
};

_$_TopologyPolygon _$$_TopologyPolygonFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$_TopologyPolygon',
      json,
      ($checkedConvert) {
        final val = _$_TopologyPolygon(
          arcs: $checkedConvert(
              'arcs',
              (v) => (v as List<dynamic>)
                  .map(
                      (e) => (e as List<dynamic>).map((e) => e as int).toList())
                  .toList()),
          areaCode: $checkedConvert('areaCode', (v) => v as int?),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_TopologyPolygonToJson(_$_TopologyPolygon instance) =>
    <String, dynamic>{
      'arcs': instance.arcs,
      'areaCode': instance.areaCode,
    };

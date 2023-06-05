// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topology_map.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TopologyMap _$$_TopologyMapFromJson(Map<String, dynamic> json) =>
    _$_TopologyMap(
      scale: DoubleVector.fromJson(json['scale'] as Map<String, dynamic>),
      translate:
          DoubleVector.fromJson(json['translate'] as Map<String, dynamic>),
      polygons: (json['polygons'] as List<dynamic>)
          .map((e) => TopologyPolygon.fromJson(e as Map<String, dynamic>))
          .toList(),
      arcs: (json['arcs'] as List<dynamic>)
          .map((e) => TopologyArc.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_TopologyMapToJson(_$_TopologyMap instance) =>
    <String, dynamic>{
      'scale': instance.scale,
      'translate': instance.translate,
      'polygons': instance.polygons,
      'arcs': instance.arcs,
    };

_$_TopologyArc _$$_TopologyArcFromJson(Map<String, dynamic> json) =>
    _$_TopologyArc(
      arc: (json['arc'] as List<dynamic>)
          .map((e) => IntVector.fromJson(e as Map<String, dynamic>))
          .toList(),
      type: $enumDecode(_$TopologyArcTypeEnumMap, json['type']),
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
    _$_TopologyPolygon(
      arcs: (json['arcs'] as List<dynamic>)
          .map((e) => (e as List<dynamic>).map((e) => e as int).toList())
          .toList(),
      areaCode: json['areaCode'] as int?,
    );

Map<String, dynamic> _$$_TopologyPolygonToJson(_$_TopologyPolygon instance) =>
    <String, dynamic>{
      'arcs': instance.arcs,
      'areaCode': instance.areaCode,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'topology_map.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TopologyMapImpl _$$TopologyMapImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$TopologyMapImpl',
      json,
      ($checkedConvert) {
        final val = _$TopologyMapImpl(
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

Map<String, dynamic> _$$TopologyMapImplToJson(_$TopologyMapImpl instance) =>
    <String, dynamic>{
      'scale': instance.scale,
      'translate': instance.translate,
      'polygons': instance.polygons,
      'arcs': instance.arcs,
    };

_$TopologyArcImpl _$$TopologyArcImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$TopologyArcImpl',
      json,
      ($checkedConvert) {
        final val = _$TopologyArcImpl(
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

Map<String, dynamic> _$$TopologyArcImplToJson(_$TopologyArcImpl instance) =>
    <String, dynamic>{
      'arc': instance.arc,
      'type': _$TopologyArcTypeEnumMap[instance.type]!,
    };

const _$TopologyArcTypeEnumMap = {
  TopologyArcType.coastline: 'coastline',
  TopologyArcType.admin: 'admin',
  TopologyArcType.area: 'area',
};

_$TopologyPolygonImpl _$$TopologyPolygonImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$TopologyPolygonImpl',
      json,
      ($checkedConvert) {
        final val = _$TopologyPolygonImpl(
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

Map<String, dynamic> _$$TopologyPolygonImplToJson(
        _$TopologyPolygonImpl instance) =>
    <String, dynamic>{
      'arcs': instance.arcs,
      'areaCode': instance.areaCode,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topo_json_geometry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_LineString _$$_LineStringFromJson(Map<String, dynamic> json) =>
    _$_LineString(
      type: $enumDecode(_$TopoJsonGeometryTypeEnumMap, json['type']),
      arcs: (json['arcs'] as List<dynamic>).map((e) => e as int).toList(),
      properties: (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
    );

Map<String, dynamic> _$$_LineStringToJson(_$_LineString instance) =>
    <String, dynamic>{
      'type': _$TopoJsonGeometryTypeEnumMap[instance.type]!,
      'arcs': instance.arcs,
      'properties': instance.properties,
    };

const _$TopoJsonGeometryTypeEnumMap = {
  TopoJsonGeometryType.polygon: 'Polygon',
  TopoJsonGeometryType.multiPolygon: 'MultiPolygon',
  TopoJsonGeometryType.geometryCollection: 'GeometryCollection',
  TopoJsonGeometryType.lineString: 'LineString',
  TopoJsonGeometryType.multiLineString: 'MultiLineString',
};

_$_MultiLineString _$$_MultiLineStringFromJson(Map<String, dynamic> json) =>
    _$_MultiLineString(
      type: $enumDecode(_$TopoJsonGeometryTypeEnumMap, json['type']),
      arcs: (json['arcs'] as List<dynamic>)
          .map((e) => (e as List<dynamic>).map((e) => e as int).toList())
          .toList(),
      properties: (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
    );

Map<String, dynamic> _$$_MultiLineStringToJson(_$_MultiLineString instance) =>
    <String, dynamic>{
      'type': _$TopoJsonGeometryTypeEnumMap[instance.type]!,
      'arcs': instance.arcs,
      'properties': instance.properties,
    };

_$_Polygon _$$_PolygonFromJson(Map<String, dynamic> json) => _$_Polygon(
      type: $enumDecode(_$TopoJsonGeometryTypeEnumMap, json['type']),
      arcs: (json['arcs'] as List<dynamic>)
          .map((e) => (e as List<dynamic>).map((e) => e as int).toList())
          .toList(),
      properties: (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
    );

Map<String, dynamic> _$$_PolygonToJson(_$_Polygon instance) =>
    <String, dynamic>{
      'type': _$TopoJsonGeometryTypeEnumMap[instance.type]!,
      'arcs': instance.arcs,
      'properties': instance.properties,
    };

_$_MultiPolygon _$$_MultiPolygonFromJson(Map<String, dynamic> json) =>
    _$_MultiPolygon(
      type: $enumDecode(_$TopoJsonGeometryTypeEnumMap, json['type']),
      arcs: (json['arcs'] as List<dynamic>)
          .map((e) => (e as List<dynamic>)
              .map((e) => (e as List<dynamic>).map((e) => e as int).toList())
              .toList())
          .toList(),
      properties: (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
    );

Map<String, dynamic> _$$_MultiPolygonToJson(_$_MultiPolygon instance) =>
    <String, dynamic>{
      'type': _$TopoJsonGeometryTypeEnumMap[instance.type]!,
      'arcs': instance.arcs,
      'properties': instance.properties,
    };

_$_GeometryCollection _$$_GeometryCollectionFromJson(
        Map<String, dynamic> json) =>
    _$_GeometryCollection(
      type: $enumDecode(_$TopoJsonGeometryTypeEnumMap, json['type']),
      geometries: (json['geometries'] as List<dynamic>)
          .map(
              (e) => TopoJsonGeometryObject.fromJson(e as Map<String, dynamic>))
          .toList(),
      properties: (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
    );

Map<String, dynamic> _$$_GeometryCollectionToJson(
        _$_GeometryCollection instance) =>
    <String, dynamic>{
      'type': _$TopoJsonGeometryTypeEnumMap[instance.type]!,
      'geometries': instance.geometries,
      'properties': instance.properties,
    };

_$_NullGeometryObject _$$_NullGeometryObjectFromJson(
        Map<String, dynamic> json) =>
    _$_NullGeometryObject(
      type: $enumDecodeNullable(_$TopoJsonGeometryTypeEnumMap, json['type']),
      properties: (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
    );

Map<String, dynamic> _$$_NullGeometryObjectToJson(
        _$_NullGeometryObject instance) =>
    <String, dynamic>{
      'type': _$TopoJsonGeometryTypeEnumMap[instance.type],
      'properties': instance.properties,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'topo_json_geometry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_LineString _$$_LineStringFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$_LineString',
      json,
      ($checkedConvert) {
        final val = _$_LineString(
          type: $checkedConvert(
              'type', (v) => $enumDecode(_$TopoJsonGeometryTypeEnumMap, v)),
          arcs: $checkedConvert('arcs',
              (v) => (v as List<dynamic>).map((e) => e as int).toList()),
          properties: $checkedConvert(
              'properties',
              (v) => (v as Map<String, dynamic>?)?.map(
                    (k, e) => MapEntry(k, e as String?),
                  )),
        );
        return val;
      },
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
    $checkedCreate(
      r'_$_MultiLineString',
      json,
      ($checkedConvert) {
        final val = _$_MultiLineString(
          type: $checkedConvert(
              'type', (v) => $enumDecode(_$TopoJsonGeometryTypeEnumMap, v)),
          arcs: $checkedConvert(
              'arcs',
              (v) => (v as List<dynamic>)
                  .map(
                      (e) => (e as List<dynamic>).map((e) => e as int).toList())
                  .toList()),
          properties: $checkedConvert(
              'properties',
              (v) => (v as Map<String, dynamic>?)?.map(
                    (k, e) => MapEntry(k, e as String?),
                  )),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_MultiLineStringToJson(_$_MultiLineString instance) =>
    <String, dynamic>{
      'type': _$TopoJsonGeometryTypeEnumMap[instance.type]!,
      'arcs': instance.arcs,
      'properties': instance.properties,
    };

_$_Polygon _$$_PolygonFromJson(Map<String, dynamic> json) => $checkedCreate(
      r'_$_Polygon',
      json,
      ($checkedConvert) {
        final val = _$_Polygon(
          type: $checkedConvert(
              'type', (v) => $enumDecode(_$TopoJsonGeometryTypeEnumMap, v)),
          arcs: $checkedConvert(
              'arcs',
              (v) => (v as List<dynamic>)
                  .map(
                      (e) => (e as List<dynamic>).map((e) => e as int).toList())
                  .toList()),
          properties: $checkedConvert(
              'properties',
              (v) => (v as Map<String, dynamic>?)?.map(
                    (k, e) => MapEntry(k, e as String?),
                  )),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_PolygonToJson(_$_Polygon instance) =>
    <String, dynamic>{
      'type': _$TopoJsonGeometryTypeEnumMap[instance.type]!,
      'arcs': instance.arcs,
      'properties': instance.properties,
    };

_$_MultiPolygon _$$_MultiPolygonFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$_MultiPolygon',
      json,
      ($checkedConvert) {
        final val = _$_MultiPolygon(
          type: $checkedConvert(
              'type', (v) => $enumDecode(_$TopoJsonGeometryTypeEnumMap, v)),
          arcs: $checkedConvert(
              'arcs',
              (v) => (v as List<dynamic>)
                  .map((e) => (e as List<dynamic>)
                      .map((e) =>
                          (e as List<dynamic>).map((e) => e as int).toList())
                      .toList())
                  .toList()),
          properties: $checkedConvert(
              'properties',
              (v) => (v as Map<String, dynamic>?)?.map(
                    (k, e) => MapEntry(k, e as String?),
                  )),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_MultiPolygonToJson(_$_MultiPolygon instance) =>
    <String, dynamic>{
      'type': _$TopoJsonGeometryTypeEnumMap[instance.type]!,
      'arcs': instance.arcs,
      'properties': instance.properties,
    };

_$_GeometryCollection _$$_GeometryCollectionFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$_GeometryCollection',
      json,
      ($checkedConvert) {
        final val = _$_GeometryCollection(
          type: $checkedConvert(
              'type', (v) => $enumDecode(_$TopoJsonGeometryTypeEnumMap, v)),
          geometries: $checkedConvert(
              'geometries',
              (v) => (v as List<dynamic>)
                  .map((e) => TopoJsonGeometryObject.fromJson(
                      e as Map<String, dynamic>))
                  .toList()),
          properties: $checkedConvert(
              'properties',
              (v) => (v as Map<String, dynamic>?)?.map(
                    (k, e) => MapEntry(k, e as String?),
                  )),
        );
        return val;
      },
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
    $checkedCreate(
      r'_$_NullGeometryObject',
      json,
      ($checkedConvert) {
        final val = _$_NullGeometryObject(
          type: $checkedConvert('type',
              (v) => $enumDecodeNullable(_$TopoJsonGeometryTypeEnumMap, v)),
          properties: $checkedConvert(
              'properties',
              (v) => (v as Map<String, dynamic>?)?.map(
                    (k, e) => MapEntry(k, e as String?),
                  )),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_NullGeometryObjectToJson(
        _$_NullGeometryObject instance) =>
    <String, dynamic>{
      'type': _$TopoJsonGeometryTypeEnumMap[instance.type],
      'properties': instance.properties,
    };

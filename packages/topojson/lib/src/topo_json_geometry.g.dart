// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'topo_json_geometry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LineStringImpl _$$LineStringImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$LineStringImpl',
      json,
      ($checkedConvert) {
        final val = _$LineStringImpl(
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

Map<String, dynamic> _$$LineStringImplToJson(_$LineStringImpl instance) =>
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

_$MultiLineStringImpl _$$MultiLineStringImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$MultiLineStringImpl',
      json,
      ($checkedConvert) {
        final val = _$MultiLineStringImpl(
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

Map<String, dynamic> _$$MultiLineStringImplToJson(
        _$MultiLineStringImpl instance) =>
    <String, dynamic>{
      'type': _$TopoJsonGeometryTypeEnumMap[instance.type]!,
      'arcs': instance.arcs,
      'properties': instance.properties,
    };

_$PolygonImpl _$$PolygonImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$PolygonImpl',
      json,
      ($checkedConvert) {
        final val = _$PolygonImpl(
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

Map<String, dynamic> _$$PolygonImplToJson(_$PolygonImpl instance) =>
    <String, dynamic>{
      'type': _$TopoJsonGeometryTypeEnumMap[instance.type]!,
      'arcs': instance.arcs,
      'properties': instance.properties,
    };

_$MultiPolygonImpl _$$MultiPolygonImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$MultiPolygonImpl',
      json,
      ($checkedConvert) {
        final val = _$MultiPolygonImpl(
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

Map<String, dynamic> _$$MultiPolygonImplToJson(_$MultiPolygonImpl instance) =>
    <String, dynamic>{
      'type': _$TopoJsonGeometryTypeEnumMap[instance.type]!,
      'arcs': instance.arcs,
      'properties': instance.properties,
    };

_$GeometryCollectionImpl _$$GeometryCollectionImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$GeometryCollectionImpl',
      json,
      ($checkedConvert) {
        final val = _$GeometryCollectionImpl(
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

Map<String, dynamic> _$$GeometryCollectionImplToJson(
        _$GeometryCollectionImpl instance) =>
    <String, dynamic>{
      'type': _$TopoJsonGeometryTypeEnumMap[instance.type]!,
      'geometries': instance.geometries,
      'properties': instance.properties,
    };

_$NullGeometryObjectImpl _$$NullGeometryObjectImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$NullGeometryObjectImpl',
      json,
      ($checkedConvert) {
        final val = _$NullGeometryObjectImpl(
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

Map<String, dynamic> _$$NullGeometryObjectImplToJson(
        _$NullGeometryObjectImpl instance) =>
    <String, dynamic>{
      'type': _$TopoJsonGeometryTypeEnumMap[instance.type],
      'properties': instance.properties,
    };

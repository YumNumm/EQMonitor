// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topo_json.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TopoJson _$$_TopoJsonFromJson(Map<String, dynamic> json) => _$_TopoJson(
      type: json['type'] as String,
      transform: json['transform'] == null
          ? null
          : TopoJsonTransform.fromJson(
              json['transform'] as Map<String, dynamic>),
      objects: (json['objects'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            k, TopoJsonGeometryObject.fromJson(e as Map<String, dynamic>)),
      ),
      arcs: (json['arcs'] as List<dynamic>)
          .map((e) => (e as List<dynamic>)
              .map((e) => (e as List<dynamic>).map((e) => e as int).toList())
              .toList())
          .toList(),
    );

Map<String, dynamic> _$$_TopoJsonToJson(_$_TopoJson instance) =>
    <String, dynamic>{
      'type': instance.type,
      'transform': instance.transform,
      'objects': instance.objects,
      'arcs': instance.arcs,
    };

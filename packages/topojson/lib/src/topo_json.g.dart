// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'topo_json.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TopoJson _$$_TopoJsonFromJson(Map<String, dynamic> json) => $checkedCreate(
      r'_$_TopoJson',
      json,
      ($checkedConvert) {
        final val = _$_TopoJson(
          type: $checkedConvert('type', (v) => v as String),
          transform: $checkedConvert(
              'transform',
              (v) => v == null
                  ? null
                  : TopoJsonTransform.fromJson(v as Map<String, dynamic>)),
          objects: $checkedConvert(
              'objects',
              (v) => (v as Map<String, dynamic>).map(
                    (k, e) => MapEntry(
                        k,
                        TopoJsonGeometryObject.fromJson(
                            e as Map<String, dynamic>)),
                  )),
          arcs: $checkedConvert(
              'arcs',
              (v) => (v as List<dynamic>)
                  .map((e) => (e as List<dynamic>)
                      .map((e) =>
                          (e as List<dynamic>).map((e) => e as int).toList())
                      .toList())
                  .toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_TopoJsonToJson(_$_TopoJson instance) =>
    <String, dynamic>{
      'type': instance.type,
      'transform': instance.transform,
      'objects': instance.objects,
      'arcs': instance.arcs,
    };

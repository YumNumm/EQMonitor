// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topo_json_transform.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TopoJsonTransform _$$_TopoJsonTransformFromJson(Map<String, dynamic> json) =>
    _$_TopoJsonTransform(
      scale: (json['scale'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      translate: (json['translate'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
    );

Map<String, dynamic> _$$_TopoJsonTransformToJson(
        _$_TopoJsonTransform instance) =>
    <String, dynamic>{
      'scale': instance.scale,
      'translate': instance.translate,
    };

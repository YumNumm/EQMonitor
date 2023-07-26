// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'topo_json_transform.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TopoJsonTransform _$$_TopoJsonTransformFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$_TopoJsonTransform',
      json,
      ($checkedConvert) {
        final val = _$_TopoJsonTransform(
          scale: $checkedConvert(
              'scale',
              (v) => (v as List<dynamic>)
                  .map((e) => (e as num).toDouble())
                  .toList()),
          translate: $checkedConvert(
              'translate',
              (v) => (v as List<dynamic>)
                  .map((e) => (e as num).toDouble())
                  .toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_TopoJsonTransformToJson(
        _$_TopoJsonTransform instance) =>
    <String, dynamic>{
      'scale': instance.scale,
      'translate': instance.translate,
    };

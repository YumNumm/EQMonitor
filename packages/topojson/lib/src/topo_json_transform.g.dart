// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'topo_json_transform.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TopoJsonTransformImpl _$$TopoJsonTransformImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$TopoJsonTransformImpl',
      json,
      ($checkedConvert) {
        final val = _$TopoJsonTransformImpl(
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

Map<String, dynamic> _$$TopoJsonTransformImplToJson(
        _$TopoJsonTransformImpl instance) =>
    <String, dynamic>{
      'scale': instance.scale,
      'translate': instance.translate,
    };

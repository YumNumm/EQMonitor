// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'map_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MapStateImpl _$$MapStateImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$MapStateImpl',
      json,
      ($checkedConvert) {
        final val = _$MapStateImpl(
          offset: $checkedConvert(
              'offset', (v) => _offsetFromJson(v as Map<String, dynamic>)),
          zoomLevel: $checkedConvert('zoomLevel', (v) => (v as num).toDouble()),
        );
        return val;
      },
    );

Map<String, dynamic> _$$MapStateImplToJson(_$MapStateImpl instance) =>
    <String, dynamic>{
      'offset': _offsetToJson(instance.offset),
      'zoomLevel': instance.zoomLevel,
    };

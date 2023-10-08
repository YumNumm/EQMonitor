// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'map_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MapState _$$_MapStateFromJson(Map<String, dynamic> json) => $checkedCreate(
      r'_$_MapState',
      json,
      ($checkedConvert) {
        final val = _$_MapState(
          offset: $checkedConvert(
              'offset', (v) => _offsetFromJson(v as Map<String, dynamic>)),
          zoomLevel: $checkedConvert('zoomLevel', (v) => (v as num).toDouble()),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_MapStateToJson(_$_MapState instance) =>
    <String, dynamic>{
      'offset': _offsetToJson(instance.offset),
      'zoomLevel': instance.zoomLevel,
    };

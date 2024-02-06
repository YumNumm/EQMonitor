// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'main_map_viewmodel_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MainMapViewmodelStateImpl _$$MainMapViewmodelStateImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$MainMapViewmodelStateImpl',
      json,
      ($checkedConvert) {
        final val = _$MainMapViewmodelStateImpl(
          isHomePosition: $checkedConvert('isHomePosition', (v) => v as bool),
          homeBoundary: $checkedConvert('homeBoundary',
              (v) => _latLngBoundsFromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$MainMapViewmodelStateImplToJson(
        _$MainMapViewmodelStateImpl instance) =>
    <String, dynamic>{
      'isHomePosition': instance.isHomePosition,
      'homeBoundary': _latLngBoundsToJson(instance.homeBoundary),
    };

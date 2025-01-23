// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

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
          isHomePosition: $checkedConvert('is_home_position', (v) => v as bool),
          homeBoundary: $checkedConvert('home_boundary',
              (v) => _latLngBoundsFromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
      fieldKeyMap: const {
        'isHomePosition': 'is_home_position',
        'homeBoundary': 'home_boundary'
      },
    );

Map<String, dynamic> _$$MainMapViewmodelStateImplToJson(
        _$MainMapViewmodelStateImpl instance) =>
    <String, dynamic>{
      'is_home_position': instance.isHomePosition,
      'home_boundary': _latLngBoundsToJson(instance.homeBoundary),
    };

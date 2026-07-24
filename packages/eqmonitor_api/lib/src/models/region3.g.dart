// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'region3.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Region3 _$Region3FromJson(Map<String, dynamic> json) =>
    $checkedCreate('_Region3', json, ($checkedConvert) {
      final val = _Region3(
        topLeft: $checkedConvert(
          'topLeft',
          (v) => TopLeft3.fromJson(v as Map<String, dynamic>),
        ),
        bottomRight: $checkedConvert(
          'bottomRight',
          (v) => BottomRight3.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$Region3ToJson(_Region3 instance) => <String, dynamic>{
  'topLeft': instance.topLeft,
  'bottomRight': instance.bottomRight,
};

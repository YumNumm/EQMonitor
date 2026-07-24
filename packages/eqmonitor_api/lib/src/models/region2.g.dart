// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'region2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Region2 _$Region2FromJson(Map<String, dynamic> json) =>
    $checkedCreate('_Region2', json, ($checkedConvert) {
      final val = _Region2(
        topLeft: $checkedConvert(
          'topLeft',
          (v) => TopLeft2.fromJson(v as Map<String, dynamic>),
        ),
        bottomRight: $checkedConvert(
          'bottomRight',
          (v) => BottomRight2.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$Region2ToJson(_Region2 instance) => <String, dynamic>{
  'topLeft': instance.topLeft,
  'bottomRight': instance.bottomRight,
};

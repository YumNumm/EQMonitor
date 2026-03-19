// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'tsunami_comments.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TsunamiComments _$TsunamiCommentsFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_TsunamiComments', json, ($checkedConvert) {
      final val = _TsunamiComments(
        free: $checkedConvert('free', (v) => v as String),
        warning: $checkedConvert(
          'warning',
          (v) => Warning.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$TsunamiCommentsToJson(_TsunamiComments instance) =>
    <String, dynamic>{'free': instance.free, 'warning': instance.warning};

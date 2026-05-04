// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'comments.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Comments _$CommentsFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_Comments', json, ($checkedConvert) {
      final val = _Comments(free: $checkedConvert('free', (v) => v as String));
      return val;
    });

Map<String, dynamic> _$CommentsToJson(_Comments instance) => <String, dynamic>{
  'free': instance.free,
};

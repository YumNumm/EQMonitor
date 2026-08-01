// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'data2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Data2 _$Data2FromJson(Map<String, dynamic> json) =>
    $checkedCreate('_Data2', json, ($checkedConvert) {
      final val = _Data2(
        archives: $checkedConvert(
          'archives',
          (v) => (v as List<dynamic>)
              .map((e) => Archives.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$Data2ToJson(_Data2 instance) => <String, dynamic>{
  'archives': instance.archives,
};

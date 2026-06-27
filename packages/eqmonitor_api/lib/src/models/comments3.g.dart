// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'comments3.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Comments3 _$Comments3FromJson(Map<String, dynamic> json) =>
    $checkedCreate('_Comments3', json, ($checkedConvert) {
      final val = _Comments3(
        free: $checkedConvert('free', (v) => v as String?),
        warning: $checkedConvert(
          'warning',
          (v) => v == null ? null : Warning.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$Comments3ToJson(_Comments3 instance) =>
    <String, dynamic>{'free': ?instance.free, 'warning': ?instance.warning};

// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'start_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StartResponse _$StartResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_StartResponse', json, ($checkedConvert) {
      final val = _StartResponse(
        flags: $checkedConvert(
          'flags',
          (v) => StartFlags.fromJson(v as Map<String, dynamic>),
        ),
        app: $checkedConvert(
          'app',
          (v) => App.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$StartResponseToJson(_StartResponse instance) =>
    <String, dynamic>{'flags': instance.flags, 'app': instance.app};

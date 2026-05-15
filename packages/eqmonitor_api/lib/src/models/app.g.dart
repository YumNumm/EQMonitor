// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'app.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_App _$AppFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_App', json, ($checkedConvert) {
      final val = _App(
        version: $checkedConvert(
          'version',
          (v) => Version.fromJson(v as Map<String, dynamic>),
        ),
        storeUrl: $checkedConvert(
          'store_url',
          (v) => StoreUrl.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    }, fieldKeyMap: const {'storeUrl': 'store_url'});

Map<String, dynamic> _$AppToJson(_App instance) => <String, dynamic>{
  'version': instance.version,
  'store_url': instance.storeUrl,
};

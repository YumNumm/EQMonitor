// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'start_app.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StartApp _$StartAppFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_StartApp', json, ($checkedConvert) {
      final val = _StartApp(
        version: $checkedConvert(
          'version',
          (v) => StartAppVersion.fromJson(v as Map<String, dynamic>),
        ),
        storeUrl: $checkedConvert(
          'store_url',
          (v) => StoreUrl.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    }, fieldKeyMap: const {'storeUrl': 'store_url'});

Map<String, dynamic> _$StartAppToJson(_StartApp instance) => <String, dynamic>{
  'version': instance.version,
  'store_url': instance.storeUrl,
};

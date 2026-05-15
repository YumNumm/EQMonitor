// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'store_url.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StoreUrl _$StoreUrlFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_StoreUrl', json, ($checkedConvert) {
      final val = _StoreUrl(
        ios: $checkedConvert('ios', (v) => v as String),
        android: $checkedConvert('android', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$StoreUrlToJson(_StoreUrl instance) => <String, dynamic>{
  'ios': instance.ios,
  'android': instance.android,
};

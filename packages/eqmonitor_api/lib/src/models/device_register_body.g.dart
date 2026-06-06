// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'device_register_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DeviceRegisterBody _$DeviceRegisterBodyFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_DeviceRegisterBody', json, ($checkedConvert) {
      final val = _DeviceRegisterBody(
        type: $checkedConvert('type', (v) => v),
        locale: $checkedConvert('locale', (v) => v as String? ?? 'ja'),
      );
      return val;
    });

Map<String, dynamic> _$DeviceRegisterBodyToJson(_DeviceRegisterBody instance) =>
    <String, dynamic>{'type': instance.type, 'locale': instance.locale};

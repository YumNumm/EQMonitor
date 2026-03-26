// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'eew_warning_zone_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EewWarningZoneItem _$EewWarningZoneItemFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_EewWarningZoneItem', json, ($checkedConvert) {
      final val = _EewWarningZoneItem(
        value: $checkedConvert(
          'value',
          (v) => CodeName.fromJson(v as Map<String, dynamic>),
        ),
        hadWarning: $checkedConvert('had_warning', (v) => v as bool),
      );
      return val;
    }, fieldKeyMap: const {'hadWarning': 'had_warning'});

Map<String, dynamic> _$EewWarningZoneItemToJson(_EewWarningZoneItem instance) =>
    <String, dynamic>{
      'value': instance.value,
      'had_warning': instance.hadWarning,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'start_flags.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StartFlags _$StartFlagsFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_StartFlags', json, ($checkedConvert) {
      final val = _StartFlags(
        adsEnabled: $checkedConvert('ads_enabled', (v) => v as bool),
        maintenance: $checkedConvert(
          'maintenance',
          (v) => MaintenanceInfo.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    }, fieldKeyMap: const {'adsEnabled': 'ads_enabled'});

Map<String, dynamic> _$StartFlagsToJson(_StartFlags instance) =>
    <String, dynamic>{
      'ads_enabled': instance.adsEnabled,
      'maintenance': instance.maintenance,
    };

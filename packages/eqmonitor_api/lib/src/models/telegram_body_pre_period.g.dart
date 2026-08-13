// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'telegram_body_pre_period.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TelegramBodyPrePeriod _$TelegramBodyPrePeriodFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_TelegramBodyPrePeriod', json, ($checkedConvert) {
  final val = _TelegramBodyPrePeriod(
    band: $checkedConvert('band', (v) => v as num),
    lpgmIntensity: $checkedConvert('lpgm_intensity', (v) => v as String?),
    sva: $checkedConvert('sva', (v) => v as num?),
  );
  return val;
}, fieldKeyMap: const {'lpgmIntensity': 'lpgm_intensity'});

Map<String, dynamic> _$TelegramBodyPrePeriodToJson(
  _TelegramBodyPrePeriod instance,
) => <String, dynamic>{
  'band': instance.band,
  'lpgm_intensity': ?instance.lpgmIntensity,
  'sva': ?instance.sva,
};

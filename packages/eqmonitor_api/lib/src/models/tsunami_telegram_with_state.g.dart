// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'tsunami_telegram_with_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TsunamiTelegramWithState _$TsunamiTelegramWithStateFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_TsunamiTelegramWithState', json, ($checkedConvert) {
  final val = _TsunamiTelegramWithState(
    type: $checkedConvert('type', (v) => $enumDecode(_$TelegramTypeEnumMap, v)),
    telegram: $checkedConvert(
      'telegram',
      (v) => LatestTelegram.fromJson(v as Map<String, dynamic>),
    ),
    state: $checkedConvert(
      'state',
      (v) => TsunamiState.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$TsunamiTelegramWithStateToJson(
  _TsunamiTelegramWithState instance,
) => <String, dynamic>{
  'type': instance.type,
  'telegram': instance.telegram,
  'state': instance.state,
};

const _$TelegramTypeEnumMap = {
  TelegramType.vzse40: 'VZSE40',
  TelegramType.vxse42: 'VXSE42',
  TelegramType.vxse43: 'VXSE43',
  TelegramType.vxse44: 'VXSE44',
  TelegramType.vxse45: 'VXSE45',
  TelegramType.vxse47: 'VXSE47',
  TelegramType.vtse41: 'VTSE41',
  TelegramType.vtse51: 'VTSE51',
  TelegramType.vtse52: 'VTSE52',
  TelegramType.vxse51: 'VXSE51',
  TelegramType.vxse52: 'VXSE52',
  TelegramType.vxse53: 'VXSE53',
  TelegramType.vxse56: 'VXSE56',
  TelegramType.vxse60: 'VXSE60',
  TelegramType.vxse61: 'VXSE61',
  TelegramType.vxse62: 'VXSE62',
  TelegramType.nankai: 'NANKAI',
  TelegramType.vyse60: 'VYSE60',
  TelegramType.shindoDb: 'SHINDO_DB',
};

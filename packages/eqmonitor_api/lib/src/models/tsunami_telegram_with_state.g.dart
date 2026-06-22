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
) => <String, dynamic>{'telegram': instance.telegram, 'state': instance.state};

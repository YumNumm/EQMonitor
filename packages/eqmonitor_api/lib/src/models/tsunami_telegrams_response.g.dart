// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'tsunami_telegrams_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TsunamiTelegramsResponse _$TsunamiTelegramsResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_TsunamiTelegramsResponse', json, ($checkedConvert) {
  final val = _TsunamiTelegramsResponse(
    telegrams: $checkedConvert(
      'telegrams',
      (v) => (v as List<dynamic>)
          .map(
            (e) => TsunamiTelegramWithState.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$TsunamiTelegramsResponseToJson(
  _TsunamiTelegramsResponse instance,
) => <String, dynamic>{'telegrams': instance.telegrams};

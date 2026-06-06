// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'telegram_event_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TelegramEventDetailsResponse _$TelegramEventDetailsResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_TelegramEventDetailsResponse', json, ($checkedConvert) {
  final val = _TelegramEventDetailsResponse(
    items: $checkedConvert(
      'items',
      (v) => (v as List<dynamic>)
          .map(
            (e) => TelegramDetailResponse.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$TelegramEventDetailsResponseToJson(
  _TelegramEventDetailsResponse instance,
) => <String, dynamic>{'items': instance.items};

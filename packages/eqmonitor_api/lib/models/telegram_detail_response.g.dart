// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'telegram_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TelegramDetailResponse _$TelegramDetailResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_TelegramDetailResponse', json, ($checkedConvert) {
  final val = _TelegramDetailResponse(
    telegram: $checkedConvert(
      'telegram',
      (v) => TelegramDetail.fromJson(v as Map<String, dynamic>),
    ),
    comments: $checkedConvert(
      'comments',
      (v) => v == null
          ? null
          : TelegramComments.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$TelegramDetailResponseToJson(
  _TelegramDetailResponse instance,
) => <String, dynamic>{
  'telegram': instance.telegram,
  'comments': instance.comments,
};

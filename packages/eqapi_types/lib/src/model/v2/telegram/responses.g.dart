// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TelegramListResponse _$TelegramListResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_TelegramListResponse',
  json,
  ($checkedConvert) {
    final val = _TelegramListResponse(
      items: $checkedConvert(
        'items',
        (v) => (v as List<dynamic>)
            .map((e) => Telegram.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
      nextToken: $checkedConvert('next_token', (v) => v as String?),
      nextPooling: $checkedConvert('next_pooling', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {'nextToken': 'next_token', 'nextPooling': 'next_pooling'},
);

Map<String, dynamic> _$TelegramListResponseToJson(
  _TelegramListResponse instance,
) => <String, dynamic>{
  'items': instance.items,
  'next_token': instance.nextToken,
  'next_pooling': instance.nextPooling,
};

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

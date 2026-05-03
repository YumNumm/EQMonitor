// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'v2_feeds_admin_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_V2FeedsAdminRequestBody _$V2FeedsAdminRequestBodyFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_V2FeedsAdminRequestBody', json, ($checkedConvert) {
  final val = _V2FeedsAdminRequestBody(
    feedType: $checkedConvert('feedType', (v) => v),
    priority: $checkedConvert('priority', (v) => v),
    isImportant: $checkedConvert('isImportant', (v) => v as bool),
    publishedAt: $checkedConvert('publishedAt', (v) => v as String),
    data: $checkedConvert(
      'data',
      (v) => Data.fromJson(v as Map<String, dynamic>),
    ),
    translations: $checkedConvert(
      'translations',
      (v) => (v as List<dynamic>)
          .map((e) => Translations.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
    expiresAt: $checkedConvert('expiresAt', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$V2FeedsAdminRequestBodyToJson(
  _V2FeedsAdminRequestBody instance,
) => <String, dynamic>{
  'feedType': instance.feedType,
  'priority': instance.priority,
  'isImportant': instance.isImportant,
  'publishedAt': instance.publishedAt,
  'data': instance.data,
  'translations': instance.translations,
  'expiresAt': ?instance.expiresAt,
};

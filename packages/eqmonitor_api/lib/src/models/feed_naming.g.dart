// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'feed_naming.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FeedNaming _$FeedNamingFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_FeedNaming', json, ($checkedConvert) {
      final val = _FeedNaming(
        text: $checkedConvert('text', (v) => v as String),
        en: $checkedConvert('en', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$FeedNamingToJson(_FeedNaming instance) =>
    <String, dynamic>{'text': instance.text, 'en': ?instance.en};

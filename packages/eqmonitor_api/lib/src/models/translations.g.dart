// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'translations.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Translations _$TranslationsFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_Translations', json, ($checkedConvert) {
      final val = _Translations(
        locale: $checkedConvert('locale', (v) => v as String),
        title: $checkedConvert('title', (v) => v as String?),
        summary: $checkedConvert('summary', (v) => v as String?),
        body: $checkedConvert('body', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$TranslationsToJson(_Translations instance) =>
    <String, dynamic>{
      'locale': instance.locale,
      'title': ?instance.title,
      'summary': ?instance.summary,
      'body': ?instance.body,
    };

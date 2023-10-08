// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'naming.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NamingImpl _$$NamingImplFromJson(Map<String, dynamic> json) => $checkedCreate(
      r'_$NamingImpl',
      json,
      ($checkedConvert) {
        final val = _$NamingImpl(
          text: $checkedConvert('text', (v) => v as String),
          en: $checkedConvert('en', (v) => v as String?),
        );
        return val;
      },
    );

Map<String, dynamic> _$$NamingImplToJson(_$NamingImpl instance) =>
    <String, dynamic>{
      'text': instance.text,
      'en': instance.en,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'naming.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Naming _$$_NamingFromJson(Map<String, dynamic> json) => $checkedCreate(
      r'_$_Naming',
      json,
      ($checkedConvert) {
        final val = _$_Naming(
          text: $checkedConvert('text', (v) => v as String),
          en: $checkedConvert('en', (v) => v as String?),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_NamingToJson(_$_Naming instance) => <String, dynamic>{
      'text': instance.text,
      'en': instance.en,
    };

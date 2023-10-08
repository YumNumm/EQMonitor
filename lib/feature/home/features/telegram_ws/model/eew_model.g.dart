// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'eew_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_EewWsItem _$$_EewWsItemFromJson(Map<String, dynamic> json) => $checkedCreate(
      r'_$_EewWsItem',
      json,
      ($checkedConvert) {
        final val = _$_EewWsItem(
          telegram: $checkedConvert('telegram',
              (v) => TelegramV3.fromJson(v as Map<String, dynamic>)),
          body: $checkedConvert(
              'body', (v) => Vxse45.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_EewWsItemToJson(_$_EewWsItem instance) =>
    <String, dynamic>{
      'telegram': instance.telegram,
      'body': instance.body,
    };

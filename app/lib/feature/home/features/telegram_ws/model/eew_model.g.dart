// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'eew_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EewWsItemImpl _$$EewWsItemImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$EewWsItemImpl',
      json,
      ($checkedConvert) {
        final val = _$EewWsItemImpl(
          telegram: $checkedConvert('telegram',
              (v) => TelegramV3.fromJson(v as Map<String, dynamic>)),
          body: $checkedConvert(
              'body', (v) => Vxse45.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$EewWsItemImplToJson(_$EewWsItemImpl instance) =>
    <String, dynamic>{
      'telegram': instance.telegram,
      'body': instance.body,
    };

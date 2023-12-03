// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'tsunami_history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TsunamiHisotryItemImpl _$$TsunamiHisotryItemImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$TsunamiHisotryItemImpl',
      json,
      ($checkedConvert) {
        final val = _$TsunamiHisotryItemImpl(
          vtse41: $checkedConvert(
              'vtse41',
              (v) => v == null
                  ? null
                  : Vtse41Data.fromJson(v as Map<String, dynamic>)),
          vtse51: $checkedConvert(
              'vtse51',
              (v) => v == null
                  ? null
                  : Vtse51Data.fromJson(v as Map<String, dynamic>)),
          vtse52: $checkedConvert(
              'vtse52',
              (v) => v == null
                  ? null
                  : Vtse52Data.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$TsunamiHisotryItemImplToJson(
        _$TsunamiHisotryItemImpl instance) =>
    <String, dynamic>{
      'vtse41': instance.vtse41,
      'vtse51': instance.vtse51,
      'vtse52': instance.vtse52,
    };

_$Vtse41DataImpl _$$Vtse41DataImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$Vtse41DataImpl',
      json,
      ($checkedConvert) {
        final val = _$Vtse41DataImpl(
          telegram: $checkedConvert('telegram',
              (v) => TelegramV3.fromJson(v as Map<String, dynamic>)),
          body: $checkedConvert(
              'body',
              (v) => v == null
                  ? null
                  : TelegramVtse41Body.fromJson(v as Map<String, dynamic>)),
          cancel: $checkedConvert(
              'cancel',
              (v) => v == null
                  ? null
                  : TelegramCancelBody.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$Vtse41DataImplToJson(_$Vtse41DataImpl instance) =>
    <String, dynamic>{
      'telegram': instance.telegram,
      'body': instance.body,
      'cancel': instance.cancel,
    };

_$Vtse51DataImpl _$$Vtse51DataImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$Vtse51DataImpl',
      json,
      ($checkedConvert) {
        final val = _$Vtse51DataImpl(
          telegram: $checkedConvert('telegram',
              (v) => TelegramV3.fromJson(v as Map<String, dynamic>)),
          body: $checkedConvert(
              'body',
              (v) => v == null
                  ? null
                  : TelegramVtse51Body.fromJson(v as Map<String, dynamic>)),
          cancel: $checkedConvert(
              'cancel',
              (v) => v == null
                  ? null
                  : TelegramCancelBody.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$Vtse51DataImplToJson(_$Vtse51DataImpl instance) =>
    <String, dynamic>{
      'telegram': instance.telegram,
      'body': instance.body,
      'cancel': instance.cancel,
    };

_$Vtse52DataImpl _$$Vtse52DataImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$Vtse52DataImpl',
      json,
      ($checkedConvert) {
        final val = _$Vtse52DataImpl(
          telegram: $checkedConvert('telegram',
              (v) => TelegramV3.fromJson(v as Map<String, dynamic>)),
          body: $checkedConvert(
              'body',
              (v) => v == null
                  ? null
                  : TelegramVtse52Body.fromJson(v as Map<String, dynamic>)),
          cancel: $checkedConvert(
              'cancel',
              (v) => v == null
                  ? null
                  : TelegramCancelBody.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$Vtse52DataImplToJson(_$Vtse52DataImpl instance) =>
    <String, dynamic>{
      'telegram': instance.telegram,
      'body': instance.body,
      'cancel': instance.cancel,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'earthquake_history_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EarthquakeHistoryItemImpl _$$EarthquakeHistoryItemImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$EarthquakeHistoryItemImpl',
      json,
      ($checkedConvert) {
        final val = _$EarthquakeHistoryItemImpl(
          earthquake: $checkedConvert('earthquake',
              (v) => EarthquakeData.fromJson(v as Map<String, dynamic>)),
          tsunami: $checkedConvert(
              'tsunami',
              (v) => v == null
                  ? null
                  : TsunamiData.fromJson(v as Map<String, dynamic>)),
          telegrams: $checkedConvert(
              'telegrams',
              (v) => (v as List<dynamic>)
                  .map((e) => TelegramV3.fromJson(e as Map<String, dynamic>))
                  .toList()),
          eventId: $checkedConvert('eventId', (v) => v as int),
          latestEew: $checkedConvert(
              'latestEew',
              (v) => v == null
                  ? null
                  : Vxse45.fromJson(v as Map<String, dynamic>)),
          latestEewTelegram: $checkedConvert(
              'latestEewTelegram',
              (v) => v == null
                  ? null
                  : TelegramV3.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$EarthquakeHistoryItemImplToJson(
        _$EarthquakeHistoryItemImpl instance) =>
    <String, dynamic>{
      'earthquake': instance.earthquake,
      'tsunami': instance.tsunami,
      'telegrams': instance.telegrams,
      'eventId': instance.eventId,
      'latestEew': instance.latestEew,
      'latestEewTelegram': instance.latestEewTelegram,
    };

_$EarthquakeDataImpl _$$EarthquakeDataImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$EarthquakeDataImpl',
      json,
      ($checkedConvert) {
        final val = _$EarthquakeDataImpl(
          earthquake: $checkedConvert(
              'earthquake',
              (v) => v == null
                  ? null
                  : Earthquake.fromJson(v as Map<String, dynamic>)),
          intensity: $checkedConvert(
              'intensity',
              (v) => v == null
                  ? null
                  : Intensity.fromJson(v as Map<String, dynamic>)),
          lgIntensity: $checkedConvert(
              'lgIntensity',
              (v) => v == null
                  ? null
                  : Intensity.fromJson(v as Map<String, dynamic>)),
          comment: $checkedConvert(
              'comment',
              (v) => v == null
                  ? null
                  : CommentsOmitVar.fromJson(v as Map<String, dynamic>)),
          isVolcano: $checkedConvert('isVolcano', (v) => v as bool),
        );
        return val;
      },
    );

Map<String, dynamic> _$$EarthquakeDataImplToJson(
        _$EarthquakeDataImpl instance) =>
    <String, dynamic>{
      'earthquake': instance.earthquake,
      'intensity': instance.intensity,
      'lgIntensity': instance.lgIntensity,
      'comment': instance.comment,
      'isVolcano': instance.isVolcano,
    };

_$TsunamiDataImpl _$$TsunamiDataImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$TsunamiDataImpl',
      json,
      ($checkedConvert) {
        final val = _$TsunamiDataImpl(
          vtse41: $checkedConvert(
              'vtse41',
              (v) => _$recordConvertNullable(
                    v,
                    ($jsonValue) => (
                      body: $jsonValue['body'] == null
                          ? null
                          : TelegramVtse41Body.fromJson(
                              $jsonValue['body'] as Map<String, dynamic>),
                      cancel: $jsonValue['cancel'] == null
                          ? null
                          : TelegramCancelBody.fromJson(
                              $jsonValue['cancel'] as Map<String, dynamic>),
                      telegram: TelegramV3.fromJson(
                          $jsonValue['telegram'] as Map<String, dynamic>),
                    ),
                  )),
          vtse51: $checkedConvert(
              'vtse51',
              (v) => _$recordConvertNullable(
                    v,
                    ($jsonValue) => (
                      body: $jsonValue['body'] == null
                          ? null
                          : TelegramVtse51Body.fromJson(
                              $jsonValue['body'] as Map<String, dynamic>),
                      cancel: $jsonValue['cancel'] == null
                          ? null
                          : TelegramCancelBody.fromJson(
                              $jsonValue['cancel'] as Map<String, dynamic>),
                      telegram: TelegramV3.fromJson(
                          $jsonValue['telegram'] as Map<String, dynamic>),
                    ),
                  )),
          vtse52: $checkedConvert(
              'vtse52',
              (v) => _$recordConvertNullable(
                    v,
                    ($jsonValue) => (
                      body: $jsonValue['body'] == null
                          ? null
                          : TelegramVtse52Body.fromJson(
                              $jsonValue['body'] as Map<String, dynamic>),
                      cancel: $jsonValue['cancel'] == null
                          ? null
                          : TelegramCancelBody.fromJson(
                              $jsonValue['cancel'] as Map<String, dynamic>),
                      telegram: TelegramV3.fromJson(
                          $jsonValue['telegram'] as Map<String, dynamic>),
                    ),
                  )),
        );
        return val;
      },
    );

Map<String, dynamic> _$$TsunamiDataImplToJson(_$TsunamiDataImpl instance) =>
    <String, dynamic>{
      'vtse41': instance.vtse41 == null
          ? null
          : {
              'body': instance.vtse41!.body,
              'cancel': instance.vtse41!.cancel,
              'telegram': instance.vtse41!.telegram,
            },
      'vtse51': instance.vtse51 == null
          ? null
          : {
              'body': instance.vtse51!.body,
              'cancel': instance.vtse51!.cancel,
              'telegram': instance.vtse51!.telegram,
            },
      'vtse52': instance.vtse52 == null
          ? null
          : {
              'body': instance.vtse52!.body,
              'cancel': instance.vtse52!.cancel,
              'telegram': instance.vtse52!.telegram,
            },
    };

$Rec? _$recordConvertNullable<$Rec>(
  Object? value,
  $Rec Function(Map) convert,
) =>
    value == null ? null : convert(value as Map<String, dynamic>);

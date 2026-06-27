// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'eew_item_with_relations.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EewItemWithRelations _$EewItemWithRelationsFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_EewItemWithRelations',
  json,
  ($checkedConvert) {
    final val = _EewItemWithRelations(
      eventId: $checkedConvert('event_id', (v) => v as String),
      type: $checkedConvert(
        'type',
        (v) => $enumDecode(_$TelegramTypeEnumMap, v),
      ),
      status: $checkedConvert(
        'status',
        (v) => $enumDecode(_$TelegramStatusEnumMap, v),
      ),
      infoType: $checkedConvert(
        'info_type',
        (v) => $enumDecode(_$InfoTypeEnumMap, v),
      ),
      serialNo: $checkedConvert('serial_no', (v) => v as num),
      headline: $checkedConvert('headline', (v) => v as String?),
      isCanceled: $checkedConvert('is_canceled', (v) => v as bool),
      isWarning: $checkedConvert('is_warning', (v) => v as bool?),
      isLastInfo: $checkedConvert('is_last_info', (v) => v as bool),
      originTime: $checkedConvert(
        'origin_time',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      arrivalTime: $checkedConvert(
        'arrival_time',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      accuracy: $checkedConvert(
        'accuracy',
        (v) =>
            v == null ? null : EewAccuracy.fromJson(v as Map<String, dynamic>),
      ),
      isPlum: $checkedConvert('is_plum', (v) => v as bool),
      editorialOffice: $checkedConvert('editorial_office', (v) => v as String?),
      reportTime: $checkedConvert(
        'report_time',
        (v) => DateTime.parse(v as String),
      ),
      hypocenter: $checkedConvert(
        'hypocenter',
        (v) => v == null
            ? null
            : EewHypocenter.fromJson(v as Map<String, dynamic>),
      ),
      forecastIntensity: $checkedConvert(
        'forecast_intensity',
        (v) =>
            v == null ? null : EewIntensity.fromJson(v as Map<String, dynamic>),
      ),
      warning: $checkedConvert(
        'warning',
        (v) =>
            v == null ? null : EewWarning.fromJson(v as Map<String, dynamic>),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'eventId': 'event_id',
    'infoType': 'info_type',
    'serialNo': 'serial_no',
    'isCanceled': 'is_canceled',
    'isWarning': 'is_warning',
    'isLastInfo': 'is_last_info',
    'originTime': 'origin_time',
    'arrivalTime': 'arrival_time',
    'isPlum': 'is_plum',
    'editorialOffice': 'editorial_office',
    'reportTime': 'report_time',
    'forecastIntensity': 'forecast_intensity',
  },
);

Map<String, dynamic> _$EewItemWithRelationsToJson(
  _EewItemWithRelations instance,
) => <String, dynamic>{
  'event_id': instance.eventId,
  'type': instance.type,
  'status': instance.status,
  'info_type': instance.infoType,
  'serial_no': instance.serialNo,
  'headline': instance.headline,
  'is_canceled': instance.isCanceled,
  'is_warning': instance.isWarning,
  'is_last_info': instance.isLastInfo,
  'origin_time': instance.originTime?.toIso8601String(),
  'arrival_time': instance.arrivalTime?.toIso8601String(),
  'accuracy': instance.accuracy,
  'is_plum': instance.isPlum,
  'editorial_office': instance.editorialOffice,
  'report_time': instance.reportTime.toIso8601String(),
  'hypocenter': ?instance.hypocenter,
  'forecast_intensity': ?instance.forecastIntensity,
  'warning': ?instance.warning,
};

const _$TelegramTypeEnumMap = {
  TelegramType.undefined0: '南海トラフ地震臨時情報',
  TelegramType.undefined1: '南海トラフ地震関連解説情報',
  TelegramType.undefined2: '北海道・三陸沖後発地震注意情報',
};

const _$TelegramStatusEnumMap = {
  TelegramStatus.normal: 'NORMAL',
  TelegramStatus.training: 'TRAINING',
  TelegramStatus.test: 'TEST',
};

const _$InfoTypeEnumMap = {
  InfoType.publication: 'PUBLICATION',
  InfoType.correction: 'CORRECTION',
  InfoType.cancellation: 'CANCELLATION',
};

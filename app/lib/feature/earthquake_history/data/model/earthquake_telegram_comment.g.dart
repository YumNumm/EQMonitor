// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'earthquake_telegram_comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EarthquakeTelegramComment _$EarthquakeTelegramCommentFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_EarthquakeTelegramComment',
  json,
  ($checkedConvert) {
    final val = _EarthquakeTelegramComment(
      type: $checkedConvert(
        'type',
        (v) => $enumDecode(_$EarthquakeTelegramTypeEnumMap, v),
      ),
      reportedAt: $checkedConvert(
        'reported_at',
        (v) => DateTime.parse(v as String),
      ),
      additional: $checkedConvert('additional', (v) => v as String?),
      free: $checkedConvert('free', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {'reportedAt': 'reported_at'},
);

Map<String, dynamic> _$EarthquakeTelegramCommentToJson(
  _EarthquakeTelegramComment instance,
) => <String, dynamic>{
  'type': _$EarthquakeTelegramTypeEnumMap[instance.type]!,
  'reported_at': instance.reportedAt.toIso8601String(),
  'additional': instance.additional,
  'free': instance.free,
};

const _$EarthquakeTelegramTypeEnumMap = {
  EarthquakeTelegramType.vxse51: 'vxse51',
  EarthquakeTelegramType.vxse52: 'vxse52',
  EarthquakeTelegramType.vxse53: 'vxse53',
  EarthquakeTelegramType.vxse61: 'vxse61',
  EarthquakeTelegramType.vxse62: 'vxse62',
  EarthquakeTelegramType.vxse45Forecast: 'vxse45Forecast',
  EarthquakeTelegramType.vxse45Warning: 'vxse45Warning',
};

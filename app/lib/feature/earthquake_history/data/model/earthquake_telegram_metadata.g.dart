// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'earthquake_telegram_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EarthquakeTelegramMetadata _$EarthquakeTelegramMetadataFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_EarthquakeTelegramMetadata',
  json,
  ($checkedConvert) {
    final val = _EarthquakeTelegramMetadata(
      type: $checkedConvert(
        'type',
        (v) => $enumDecode(_$EarthquakeTelegramTypeEnumMap, v),
      ),
      reportedAt: $checkedConvert(
        'reported_at',
        (v) => DateTime.parse(v as String),
      ),
    );
    return val;
  },
  fieldKeyMap: const {'reportedAt': 'reported_at'},
);

Map<String, dynamic> _$EarthquakeTelegramMetadataToJson(
  _EarthquakeTelegramMetadata instance,
) => <String, dynamic>{
  'type': _$EarthquakeTelegramTypeEnumMap[instance.type]!,
  'reported_at': instance.reportedAt.toIso8601String(),
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

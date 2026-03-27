// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'tsunami_list_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TsunamiListItem _$TsunamiListItemFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_TsunamiListItem',
  json,
  ($checkedConvert) {
    final val = _TsunamiListItem(
      id: $checkedConvert('id', (v) => v as String),
      eventIds: $checkedConvert(
        'event_ids',
        (v) => (v as List<dynamic>).map((e) => e as String).toList(),
      ),
      isCanceled: $checkedConvert('is_canceled', (v) => v as bool),
      forecastRegionCount: $checkedConvert(
        'forecast_region_count',
        (v) => v as num,
      ),
      telegramCount: $checkedConvert('telegram_count', (v) => v as num),
      telegramTypes: $checkedConvert(
        'telegram_types',
        (v) => (v as List<dynamic>)
            .map((e) => $enumDecode(_$TsunamiListItemTelegramTypesEnumMap, e))
            .toList(),
      ),
      headline: $checkedConvert('headline', (v) => v as String?),
      latestCreatedAt: $checkedConvert(
        'latest_created_at',
        (v) => v as String?,
      ),
      latestPressAt: $checkedConvert('latest_press_at', (v) => v as String?),
      status: $checkedConvert(
        'status',
        (v) => $enumDecodeNullable(_$TsunamiListItemStatusEnumMap, v),
      ),
      maxForecastGrade: $checkedConvert(
        'max_forecast_grade',
        (v) => $enumDecodeNullable(_$TsunamiWarningKindEnumMap, v),
      ),
      earthquakeHypocenterName: $checkedConvert(
        'earthquake_hypocenter_name',
        (v) => v as String?,
      ),
      earthquakeOriginTime: $checkedConvert(
        'earthquake_origin_time',
        (v) => v as String?,
      ),
      earthquakeMagnitude: $checkedConvert(
        'earthquake_magnitude',
        (v) => v as num?,
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'eventIds': 'event_ids',
    'isCanceled': 'is_canceled',
    'forecastRegionCount': 'forecast_region_count',
    'telegramCount': 'telegram_count',
    'telegramTypes': 'telegram_types',
    'latestCreatedAt': 'latest_created_at',
    'latestPressAt': 'latest_press_at',
    'maxForecastGrade': 'max_forecast_grade',
    'earthquakeHypocenterName': 'earthquake_hypocenter_name',
    'earthquakeOriginTime': 'earthquake_origin_time',
    'earthquakeMagnitude': 'earthquake_magnitude',
  },
);

Map<String, dynamic> _$TsunamiListItemToJson(_TsunamiListItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'event_ids': instance.eventIds,
      'is_canceled': instance.isCanceled,
      'forecast_region_count': instance.forecastRegionCount,
      'telegram_count': instance.telegramCount,
      'telegram_types': instance.telegramTypes,
      'headline': ?instance.headline,
      'latest_created_at': ?instance.latestCreatedAt,
      'latest_press_at': ?instance.latestPressAt,
      'status': ?instance.status,
      'max_forecast_grade': ?instance.maxForecastGrade,
      'earthquake_hypocenter_name': ?instance.earthquakeHypocenterName,
      'earthquake_origin_time': ?instance.earthquakeOriginTime,
      'earthquake_magnitude': ?instance.earthquakeMagnitude,
    };

const _$TsunamiListItemTelegramTypesEnumMap = {
  TsunamiListItemTelegramTypes.vtse41: 'VTSE41',
  TsunamiListItemTelegramTypes.vtse51: 'VTSE51',
  TsunamiListItemTelegramTypes.vtse52: 'VTSE52',
};

const _$TsunamiListItemStatusEnumMap = {
  TsunamiListItemStatus.normal: 'NORMAL',
  TsunamiListItemStatus.training: 'TRAINING',
  TsunamiListItemStatus.test: 'TEST',
};

const _$TsunamiWarningKindEnumMap = {
  TsunamiWarningKind.majorWarning: 'MAJOR_WARNING',
  TsunamiWarningKind.warning: 'WARNING',
  TsunamiWarningKind.advisory: 'ADVISORY',
  TsunamiWarningKind.forecast: 'FORECAST',
  TsunamiWarningKind.none: 'NONE',
};

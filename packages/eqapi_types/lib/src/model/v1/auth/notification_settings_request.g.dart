// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'notification_settings_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationSettingsRequestImpl _$$NotificationSettingsRequestImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$NotificationSettingsRequestImpl',
      json,
      ($checkedConvert) {
        final val = _$NotificationSettingsRequestImpl(
          global: $checkedConvert(
              'global',
              (v) => v == null
                  ? null
                  : NotificationSettingsGlobal.fromJson(
                      v as Map<String, dynamic>)),
          regions: $checkedConvert(
              'regions',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => NotificationSettingsRegion.fromJson(
                      e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$$NotificationSettingsRequestImplToJson(
        _$NotificationSettingsRequestImpl instance) =>
    <String, dynamic>{
      'global': instance.global,
      'regions': instance.regions,
    };

_$NotificationSettingsGlobalImpl _$$NotificationSettingsGlobalImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$NotificationSettingsGlobalImpl',
      json,
      ($checkedConvert) {
        final val = _$NotificationSettingsGlobalImpl(
          minJmaIntensity: $checkedConvert('min_jma_intensity',
              (v) => $enumDecode(_$JmaForecastIntensityEnumMap, v)),
        );
        return val;
      },
      fieldKeyMap: const {'minJmaIntensity': 'min_jma_intensity'},
    );

Map<String, dynamic> _$$NotificationSettingsGlobalImplToJson(
        _$NotificationSettingsGlobalImpl instance) =>
    <String, dynamic>{
      'min_jma_intensity':
          _$JmaForecastIntensityEnumMap[instance.minJmaIntensity]!,
    };

const _$JmaForecastIntensityEnumMap = {
  JmaForecastIntensity.zero: '0',
  JmaForecastIntensity.one: '1',
  JmaForecastIntensity.two: '2',
  JmaForecastIntensity.three: '3',
  JmaForecastIntensity.four: '4',
  JmaForecastIntensity.fiveLower: '5-',
  JmaForecastIntensity.fiveUpper: '5+',
  JmaForecastIntensity.sixLower: '6-',
  JmaForecastIntensity.sixUpper: '6+',
  JmaForecastIntensity.seven: '7',
  JmaForecastIntensity.unknown: '不明',
};

_$NotificationSettingsRegionImpl _$$NotificationSettingsRegionImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$NotificationSettingsRegionImpl',
      json,
      ($checkedConvert) {
        final val = _$NotificationSettingsRegionImpl(
          code: $checkedConvert('code', (v) => (v as num).toInt()),
          minIntensity: $checkedConvert('min_intensity',
              (v) => $enumDecode(_$JmaForecastIntensityEnumMap, v)),
        );
        return val;
      },
      fieldKeyMap: const {'minIntensity': 'min_intensity'},
    );

Map<String, dynamic> _$$NotificationSettingsRegionImplToJson(
        _$NotificationSettingsRegionImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'min_intensity': _$JmaForecastIntensityEnumMap[instance.minIntensity]!,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'notification_remote_settings_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationRemoteSettingsStateImpl
    _$$NotificationRemoteSettingsStateImplFromJson(Map<String, dynamic> json) =>
        $checkedCreate(
          r'_$NotificationRemoteSettingsStateImpl',
          json,
          ($checkedConvert) {
            final val = _$NotificationRemoteSettingsStateImpl(
              eew: $checkedConvert(
                  'eew',
                  (v) => NotificationRemoteSettingsEew.fromJson(
                      v as Map<String, dynamic>)),
              earthquake: $checkedConvert(
                  'earthquake',
                  (v) => NotificationRemoteSettingsEarthquake.fromJson(
                      v as Map<String, dynamic>)),
            );
            return val;
          },
        );

Map<String, dynamic> _$$NotificationRemoteSettingsStateImplToJson(
        _$NotificationRemoteSettingsStateImpl instance) =>
    <String, dynamic>{
      'eew': instance.eew,
      'earthquake': instance.earthquake,
    };

_$NotificationRemoteSettingsEewImpl
    _$$NotificationRemoteSettingsEewImplFromJson(Map<String, dynamic> json) =>
        $checkedCreate(
          r'_$NotificationRemoteSettingsEewImpl',
          json,
          ($checkedConvert) {
            final val = _$NotificationRemoteSettingsEewImpl(
              global: $checkedConvert('global',
                  (v) => $enumDecodeNullable(_$JmaForecastIntensityEnumMap, v)),
              regions: $checkedConvert(
                  'regions',
                  (v) => (v as List<dynamic>)
                      .map((e) => NotificationRemoteSettingsEewRegion.fromJson(
                          e as Map<String, dynamic>))
                      .toList()),
            );
            return val;
          },
        );

Map<String, dynamic> _$$NotificationRemoteSettingsEewImplToJson(
        _$NotificationRemoteSettingsEewImpl instance) =>
    <String, dynamic>{
      'global': _$JmaForecastIntensityEnumMap[instance.global],
      'regions': instance.regions,
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

_$NotificationRemoteSettingsEewRegionImpl
    _$$NotificationRemoteSettingsEewRegionImplFromJson(
            Map<String, dynamic> json) =>
        $checkedCreate(
          r'_$NotificationRemoteSettingsEewRegionImpl',
          json,
          ($checkedConvert) {
            final val = _$NotificationRemoteSettingsEewRegionImpl(
              regionId: $checkedConvert('regionId', (v) => (v as num).toInt()),
              minJmaIntensity: $checkedConvert('minJmaIntensity',
                  (v) => $enumDecode(_$JmaForecastIntensityEnumMap, v)),
              name: $checkedConvert('name', (v) => v as String),
            );
            return val;
          },
        );

Map<String, dynamic> _$$NotificationRemoteSettingsEewRegionImplToJson(
        _$NotificationRemoteSettingsEewRegionImpl instance) =>
    <String, dynamic>{
      'regionId': instance.regionId,
      'minJmaIntensity':
          _$JmaForecastIntensityEnumMap[instance.minJmaIntensity]!,
      'name': instance.name,
    };

_$NotificationRemoteSettingsEarthquakeImpl
    _$$NotificationRemoteSettingsEarthquakeImplFromJson(
            Map<String, dynamic> json) =>
        $checkedCreate(
          r'_$NotificationRemoteSettingsEarthquakeImpl',
          json,
          ($checkedConvert) {
            final val = _$NotificationRemoteSettingsEarthquakeImpl(
              global: $checkedConvert('global',
                  (v) => $enumDecodeNullable(_$JmaForecastIntensityEnumMap, v)),
              regions: $checkedConvert(
                  'regions',
                  (v) => (v as List<dynamic>)
                      .map((e) =>
                          NotificationRemoteSettingsEarthquakeRegion.fromJson(
                              e as Map<String, dynamic>))
                      .toList()),
            );
            return val;
          },
        );

Map<String, dynamic> _$$NotificationRemoteSettingsEarthquakeImplToJson(
        _$NotificationRemoteSettingsEarthquakeImpl instance) =>
    <String, dynamic>{
      'global': _$JmaForecastIntensityEnumMap[instance.global],
      'regions': instance.regions,
    };

_$NotificationRemoteSettingsEarthquakeRegionImpl
    _$$NotificationRemoteSettingsEarthquakeRegionImplFromJson(
            Map<String, dynamic> json) =>
        $checkedCreate(
          r'_$NotificationRemoteSettingsEarthquakeRegionImpl',
          json,
          ($checkedConvert) {
            final val = _$NotificationRemoteSettingsEarthquakeRegionImpl(
              regionId: $checkedConvert('regionId', (v) => (v as num).toInt()),
              minJmaIntensity: $checkedConvert('minJmaIntensity',
                  (v) => $enumDecode(_$JmaForecastIntensityEnumMap, v)),
              name: $checkedConvert('name', (v) => v as String),
            );
            return val;
          },
        );

Map<String, dynamic> _$$NotificationRemoteSettingsEarthquakeRegionImplToJson(
        _$NotificationRemoteSettingsEarthquakeRegionImpl instance) =>
    <String, dynamic>{
      'regionId': instance.regionId,
      'minJmaIntensity':
          _$JmaForecastIntensityEnumMap[instance.minJmaIntensity]!,
      'name': instance.name,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'notification_remote_settings_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotificationRemoteSettingsState _$NotificationRemoteSettingsStateFromJson(
  Map<String, dynamic> json,
) =>
    $checkedCreate('_NotificationRemoteSettingsState', json, ($checkedConvert) {
      final val = _NotificationRemoteSettingsState(
        eew: $checkedConvert(
          'eew',
          (v) =>
              NotificationRemoteSettingsEew.fromJson(v as Map<String, dynamic>),
        ),
        earthquake: $checkedConvert(
          'earthquake',
          (v) => NotificationRemoteSettingsEarthquake.fromJson(
            v as Map<String, dynamic>,
          ),
        ),
      );
      return val;
    });

Map<String, dynamic> _$NotificationRemoteSettingsStateToJson(
  _NotificationRemoteSettingsState instance,
) => <String, dynamic>{'eew': instance.eew, 'earthquake': instance.earthquake};

_NotificationRemoteSettingsEew _$NotificationRemoteSettingsEewFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_NotificationRemoteSettingsEew', json, ($checkedConvert) {
  final val = _NotificationRemoteSettingsEew(
    global: $checkedConvert(
      'global',
      (v) => $enumDecodeNullable(_$JmaForecastIntensityEnumMap, v),
    ),
    regions: $checkedConvert(
      'regions',
      (v) => (v as List<dynamic>)
          .map(
            (e) => NotificationRemoteSettingsEewRegion.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$NotificationRemoteSettingsEewToJson(
  _NotificationRemoteSettingsEew instance,
) => <String, dynamic>{
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

_NotificationRemoteSettingsEewRegion
_$NotificationRemoteSettingsEewRegionFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_NotificationRemoteSettingsEewRegion',
      json,
      ($checkedConvert) {
        final val = _NotificationRemoteSettingsEewRegion(
          regionId: $checkedConvert('region_id', (v) => (v as num).toInt()),
          minJmaIntensity: $checkedConvert(
            'min_jma_intensity',
            (v) => $enumDecode(_$JmaForecastIntensityEnumMap, v),
          ),
          name: $checkedConvert('name', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'regionId': 'region_id',
        'minJmaIntensity': 'min_jma_intensity',
      },
    );

Map<String, dynamic> _$NotificationRemoteSettingsEewRegionToJson(
  _NotificationRemoteSettingsEewRegion instance,
) => <String, dynamic>{
  'region_id': instance.regionId,
  'min_jma_intensity': _$JmaForecastIntensityEnumMap[instance.minJmaIntensity]!,
  'name': instance.name,
};

_NotificationRemoteSettingsEarthquake
_$NotificationRemoteSettingsEarthquakeFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_NotificationRemoteSettingsEarthquake', json, (
      $checkedConvert,
    ) {
      final val = _NotificationRemoteSettingsEarthquake(
        global: $checkedConvert(
          'global',
          (v) => $enumDecodeNullable(_$JmaForecastIntensityEnumMap, v),
        ),
        regions: $checkedConvert(
          'regions',
          (v) => (v as List<dynamic>)
              .map(
                (e) => NotificationRemoteSettingsEarthquakeRegion.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$NotificationRemoteSettingsEarthquakeToJson(
  _NotificationRemoteSettingsEarthquake instance,
) => <String, dynamic>{
  'global': _$JmaForecastIntensityEnumMap[instance.global],
  'regions': instance.regions,
};

_NotificationRemoteSettingsEarthquakeRegion
_$NotificationRemoteSettingsEarthquakeRegionFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_NotificationRemoteSettingsEarthquakeRegion',
  json,
  ($checkedConvert) {
    final val = _NotificationRemoteSettingsEarthquakeRegion(
      regionId: $checkedConvert('region_id', (v) => (v as num).toInt()),
      minJmaIntensity: $checkedConvert(
        'min_jma_intensity',
        (v) => $enumDecode(_$JmaForecastIntensityEnumMap, v),
      ),
      name: $checkedConvert('name', (v) => v as String),
    );
    return val;
  },
  fieldKeyMap: const {
    'regionId': 'region_id',
    'minJmaIntensity': 'min_jma_intensity',
  },
);

Map<String, dynamic> _$NotificationRemoteSettingsEarthquakeRegionToJson(
  _NotificationRemoteSettingsEarthquakeRegion instance,
) => <String, dynamic>{
  'region_id': instance.regionId,
  'min_jma_intensity': _$JmaForecastIntensityEnumMap[instance.minJmaIntensity]!,
  'name': instance.name,
};

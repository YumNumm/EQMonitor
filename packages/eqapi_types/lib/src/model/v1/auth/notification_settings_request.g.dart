// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'notification_settings_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotificationSettingsRequest _$NotificationSettingsRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_NotificationSettingsRequest', json, ($checkedConvert) {
  final val = _NotificationSettingsRequest(
    global: $checkedConvert(
      'global',
      (v) => v == null
          ? null
          : NotificationSettingsGlobal.fromJson(v as Map<String, dynamic>),
    ),
    regions: $checkedConvert(
      'regions',
      (v) => (v as List<dynamic>?)
          ?.map(
            (e) =>
                NotificationSettingsRegion.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$NotificationSettingsRequestToJson(
  _NotificationSettingsRequest instance,
) => <String, dynamic>{'global': instance.global, 'regions': instance.regions};

_NotificationSettingsGlobal _$NotificationSettingsGlobalFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_NotificationSettingsGlobal',
  json,
  ($checkedConvert) {
    final val = _NotificationSettingsGlobal(
      minJmaIntensity: $checkedConvert(
        'min_jma_intensity',
        (v) => $enumDecode(_$JmaForecastIntensityEnumMap, v),
      ),
    );
    return val;
  },
  fieldKeyMap: const {'minJmaIntensity': 'min_jma_intensity'},
);

Map<String, dynamic> _$NotificationSettingsGlobalToJson(
  _NotificationSettingsGlobal instance,
) => <String, dynamic>{
  'min_jma_intensity': _$JmaForecastIntensityEnumMap[instance.minJmaIntensity]!,
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

_NotificationSettingsRegion _$NotificationSettingsRegionFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_NotificationSettingsRegion',
  json,
  ($checkedConvert) {
    final val = _NotificationSettingsRegion(
      code: $checkedConvert('code', (v) => (v as num).toInt()),
      minIntensity: $checkedConvert(
        'min_intensity',
        (v) => $enumDecode(_$JmaForecastIntensityEnumMap, v),
      ),
    );
    return val;
  },
  fieldKeyMap: const {'minIntensity': 'min_intensity'},
);

Map<String, dynamic> _$NotificationSettingsRegionToJson(
  _NotificationSettingsRegion instance,
) => <String, dynamic>{
  'code': instance.code,
  'min_intensity': _$JmaForecastIntensityEnumMap[instance.minIntensity]!,
};

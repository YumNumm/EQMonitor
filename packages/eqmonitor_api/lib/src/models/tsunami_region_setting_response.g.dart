// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'tsunami_region_setting_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TsunamiRegionSettingResponse _$TsunamiRegionSettingResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_TsunamiRegionSettingResponse',
  json,
  ($checkedConvert) {
    final val = _TsunamiRegionSettingResponse(
      id: $checkedConvert('id', (v) => v as String),
      forecastRegionCode: $checkedConvert(
        'forecast_region_code',
        (v) => v as String,
      ),
      forecastRegionName: $checkedConvert(
        'forecast_region_name',
        (v) => v as String?,
      ),
      isCurrentLocation: $checkedConvert(
        'is_current_location',
        (v) => v as bool,
      ),
      minWarningKind: $checkedConvert(
        'min_warning_kind',
        (v) => $enumDecode(_$TsunamiWarningKindEnumMap, v),
      ),
      createdAt: $checkedConvert('created_at', (v) => v as String),
      updatedAt: $checkedConvert('updated_at', (v) => v as String),
    );
    return val;
  },
  fieldKeyMap: const {
    'forecastRegionCode': 'forecast_region_code',
    'forecastRegionName': 'forecast_region_name',
    'isCurrentLocation': 'is_current_location',
    'minWarningKind': 'min_warning_kind',
    'createdAt': 'created_at',
    'updatedAt': 'updated_at',
  },
);

Map<String, dynamic> _$TsunamiRegionSettingResponseToJson(
  _TsunamiRegionSettingResponse instance,
) => <String, dynamic>{
  'id': instance.id,
  'forecast_region_code': instance.forecastRegionCode,
  'forecast_region_name': instance.forecastRegionName,
  'is_current_location': instance.isCurrentLocation,
  'min_warning_kind': instance.minWarningKind,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
};

const _$TsunamiWarningKindEnumMap = {
  TsunamiWarningKind.majorWarning: 'MAJOR_WARNING',
  TsunamiWarningKind.warning: 'WARNING',
  TsunamiWarningKind.warningCancel: 'WARNING_CANCEL',
  TsunamiWarningKind.advisory: 'ADVISORY',
  TsunamiWarningKind.advisoryCancel: 'ADVISORY_CANCEL',
  TsunamiWarningKind.forecast: 'FORECAST',
  TsunamiWarningKind.none: 'NONE',
};

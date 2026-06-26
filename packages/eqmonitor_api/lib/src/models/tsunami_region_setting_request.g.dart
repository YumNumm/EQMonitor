// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'tsunami_region_setting_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TsunamiRegionSettingRequest _$TsunamiRegionSettingRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_TsunamiRegionSettingRequest',
  json,
  ($checkedConvert) {
    final val = _TsunamiRegionSettingRequest(
      forecastRegionCode: $checkedConvert(
        'forecast_region_code',
        (v) => v as String,
      ),
      isCurrentLocation: $checkedConvert(
        'is_current_location',
        (v) => v as bool,
      ),
      minWarningKind: $checkedConvert(
        'min_warning_kind',
        (v) => $enumDecode(_$TsunamiWarningKindEnumMap, v),
      ),
      forecastRegionName: $checkedConvert(
        'forecast_region_name',
        (v) => v as String?,
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'forecastRegionCode': 'forecast_region_code',
    'isCurrentLocation': 'is_current_location',
    'minWarningKind': 'min_warning_kind',
    'forecastRegionName': 'forecast_region_name',
  },
);

Map<String, dynamic> _$TsunamiRegionSettingRequestToJson(
  _TsunamiRegionSettingRequest instance,
) => <String, dynamic>{
  'forecast_region_code': instance.forecastRegionCode,
  'is_current_location': instance.isCurrentLocation,
  'min_warning_kind': instance.minWarningKind,
  'forecast_region_name': ?instance.forecastRegionName,
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

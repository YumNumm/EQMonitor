// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'tsunami_region_setting_patch_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TsunamiRegionSettingPatchRequest _$TsunamiRegionSettingPatchRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_TsunamiRegionSettingPatchRequest',
  json,
  ($checkedConvert) {
    final val = _TsunamiRegionSettingPatchRequest(
      forecastRegionName: $checkedConvert(
        'forecast_region_name',
        (v) => v as String?,
      ),
      isCurrentLocation: $checkedConvert(
        'is_current_location',
        (v) => v as bool?,
      ),
      minWarningKind: $checkedConvert(
        'min_warning_kind',
        (v) => $enumDecodeNullable(_$TsunamiWarningKindEnumMap, v),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'forecastRegionName': 'forecast_region_name',
    'isCurrentLocation': 'is_current_location',
    'minWarningKind': 'min_warning_kind',
  },
);

Map<String, dynamic> _$TsunamiRegionSettingPatchRequestToJson(
  _TsunamiRegionSettingPatchRequest instance,
) => <String, dynamic>{
  'forecast_region_name': ?instance.forecastRegionName,
  'is_current_location': ?instance.isCurrentLocation,
  'min_warning_kind': ?instance.minWarningKind,
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

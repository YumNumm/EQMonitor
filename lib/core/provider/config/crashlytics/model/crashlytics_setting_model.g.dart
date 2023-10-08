// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'crashlytics_setting_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CrashlyticsSettingModel _$$_CrashlyticsSettingModelFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$_CrashlyticsSettingModel',
      json,
      ($checkedConvert) {
        final val = _$_CrashlyticsSettingModel(
          isEnabled: $checkedConvert('isEnabled', (v) => v as bool? ?? true),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_CrashlyticsSettingModelToJson(
        _$_CrashlyticsSettingModel instance) =>
    <String, dynamic>{
      'isEnabled': instance.isEnabled,
    };

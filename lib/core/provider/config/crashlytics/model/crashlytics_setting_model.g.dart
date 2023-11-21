// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'crashlytics_setting_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CrashlyticsSettingModelImpl _$$CrashlyticsSettingModelImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$CrashlyticsSettingModelImpl',
      json,
      ($checkedConvert) {
        final val = _$CrashlyticsSettingModelImpl(
          isEnabled: $checkedConvert('isEnabled', (v) => v as bool? ?? true),
        );
        return val;
      },
    );

Map<String, dynamic> _$$CrashlyticsSettingModelImplToJson(
        _$CrashlyticsSettingModelImpl instance) =>
    <String, dynamic>{
      'isEnabled': instance.isEnabled,
    };

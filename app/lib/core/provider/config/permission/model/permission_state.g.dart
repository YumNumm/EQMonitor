// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'permission_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PermissionStateModelImpl _$$PermissionStateModelImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$PermissionStateModelImpl',
      json,
      ($checkedConvert) {
        final val = _$PermissionStateModelImpl(
          notification:
              $checkedConvert('notification', (v) => v as bool? ?? false),
          criticalAlert:
              $checkedConvert('criticalAlert', (v) => v as bool? ?? false),
        );
        return val;
      },
    );

Map<String, dynamic> _$$PermissionStateModelImplToJson(
        _$PermissionStateModelImpl instance) =>
    <String, dynamic>{
      'notification': instance.notification,
      'criticalAlert': instance.criticalAlert,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'permission_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PermissionStateModel _$$_PermissionStateModelFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$_PermissionStateModel',
      json,
      ($checkedConvert) {
        final val = _$_PermissionStateModel(
          notification:
              $checkedConvert('notification', (v) => v as bool? ?? false),
          isNotificationDeniedByUser: $checkedConvert(
              'isNotificationDeniedByUser', (v) => v as bool? ?? false),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_PermissionStateModelToJson(
        _$_PermissionStateModel instance) =>
    <String, dynamic>{
      'notification': instance.notification,
      'isNotificationDeniedByUser': instance.isNotificationDeniedByUser,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'permission_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PermissionStateModelImpl
_$$PermissionStateModelImplFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  r'_$PermissionStateModelImpl',
  json,
  ($checkedConvert) {
    final val = _$PermissionStateModelImpl(
      notification: $checkedConvert(
        'notification',
        (v) => v as bool? ?? false,
      ),
      criticalAlert: $checkedConvert(
        'critical_alert',
        (v) => v as bool? ?? false,
      ),
      location: $checkedConvert(
        'location',
        (v) => v as bool? ?? false,
      ),
      backgroundLocation: $checkedConvert(
        'background_location',
        (v) => v as bool? ?? false,
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'criticalAlert': 'critical_alert',
    'backgroundLocation': 'background_location',
  },
);

Map<String, dynamic> _$$PermissionStateModelImplToJson(
  _$PermissionStateModelImpl instance,
) => <String, dynamic>{
  'notification': instance.notification,
  'critical_alert': instance.criticalAlert,
  'location': instance.location,
  'background_location': instance.backgroundLocation,
};

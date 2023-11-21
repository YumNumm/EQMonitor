// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'kmoni_maintenance_message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$KmoniMaintenanceMessageModelImpl _$$KmoniMaintenanceMessageModelImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$KmoniMaintenanceMessageModelImpl',
      json,
      ($checkedConvert) {
        final val = _$KmoniMaintenanceMessageModelImpl(
          message: $checkedConvert('message', (v) => v as String? ?? ''),
          type: $checkedConvert(
              'type',
              (v) => v == null
                  ? KmoniMaintenanceMessageType.non
                  : kmoniMaintenanceMessageTypeFromJson(v as String)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$KmoniMaintenanceMessageModelImplToJson(
        _$KmoniMaintenanceMessageModelImpl instance) =>
    <String, dynamic>{
      'message': instance.message,
      'type': kmoniMaintenanceMessageTypeToJson(instance.type),
    };

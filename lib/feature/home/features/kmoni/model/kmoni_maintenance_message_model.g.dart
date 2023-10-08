// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'kmoni_maintenance_message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_KmoniMaintenanceMessageModel _$$_KmoniMaintenanceMessageModelFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$_KmoniMaintenanceMessageModel',
      json,
      ($checkedConvert) {
        final val = _$_KmoniMaintenanceMessageModel(
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

Map<String, dynamic> _$$_KmoniMaintenanceMessageModelToJson(
        _$_KmoniMaintenanceMessageModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'type': kmoniMaintenanceMessageTypeToJson(instance.type),
    };

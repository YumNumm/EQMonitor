// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'migration_service_unavailable_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MigrationServiceUnavailableResponse
_$MigrationServiceUnavailableResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_MigrationServiceUnavailableResponse', json, (
      $checkedConvert,
    ) {
      final val = _MigrationServiceUnavailableResponse(
        code: $checkedConvert('code', (v) => v as String),
        message: $checkedConvert('message', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$MigrationServiceUnavailableResponseToJson(
  _MigrationServiceUnavailableResponse instance,
) => <String, dynamic>{'code': instance.code, 'message': instance.message};

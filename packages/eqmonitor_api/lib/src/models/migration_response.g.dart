// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'migration_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MigrationResponse _$MigrationResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_MigrationResponse', json, ($checkedConvert) {
      final val = _MigrationResponse(
        migrated: $checkedConvert(
          'migrated',
          (v) => MigrationResultResponse.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$MigrationResponseToJson(_MigrationResponse instance) =>
    <String, dynamic>{'migrated': instance.migrated};

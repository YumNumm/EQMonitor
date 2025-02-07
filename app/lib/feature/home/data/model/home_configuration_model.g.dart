// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'home_configuration_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HomeConfigurationModelImpl _$$HomeConfigurationModelImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$HomeConfigurationModelImpl',
      json,
      ($checkedConvert) {
        final val = _$HomeConfigurationModelImpl(
          showLocation:
              $checkedConvert('show_location', (v) => v as bool? ?? false),
        );
        return val;
      },
      fieldKeyMap: const {'showLocation': 'show_location'},
    );

Map<String, dynamic> _$$HomeConfigurationModelImplToJson(
        _$HomeConfigurationModelImpl instance) =>
    <String, dynamic>{
      'show_location': instance.showLocation,
    };

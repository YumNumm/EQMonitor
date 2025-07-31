// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'home_configuration_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HomeConfigurationModel _$HomeConfigurationModelFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_HomeConfigurationModel',
  json,
  ($checkedConvert) {
    final val = _HomeConfigurationModel(
      showLocation: $checkedConvert(
        'show_location',
        (v) => v as bool? ?? false,
      ),
    );
    return val;
  },
  fieldKeyMap: const {'showLocation': 'show_location'},
);

Map<String, dynamic> _$HomeConfigurationModelToJson(
  _HomeConfigurationModel instance,
) => <String, dynamic>{'show_location': instance.showLocation};

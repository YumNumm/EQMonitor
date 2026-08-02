// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'shindo_db_stations_parameter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ShindoDbStationsParameter _$ShindoDbStationsParameterFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_ShindoDbStationsParameter', json, ($checkedConvert) {
  final val = _ShindoDbStationsParameter(
    metadata: $checkedConvert(
      'metadata',
      (v) =>
          ShindoDbStationsParameterMetadata.fromJson(v as Map<String, dynamic>),
    ),
    stations: $checkedConvert(
      'stations',
      (v) => (v as List<dynamic>)
          .map((e) => ShindoDbStation.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$ShindoDbStationsParameterToJson(
  _ShindoDbStationsParameter instance,
) => <String, dynamic>{
  'metadata': instance.metadata,
  'stations': instance.stations,
};

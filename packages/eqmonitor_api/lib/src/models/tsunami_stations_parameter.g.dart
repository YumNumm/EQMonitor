// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'tsunami_stations_parameter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TsunamiStationsParameter _$TsunamiStationsParameterFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_TsunamiStationsParameter', json, ($checkedConvert) {
  final val = _TsunamiStationsParameter(
    metadata: $checkedConvert(
      'metadata',
      (v) =>
          TsunamiStationsParameterMetadata.fromJson(v as Map<String, dynamic>),
    ),
    prefectures: $checkedConvert(
      'prefectures',
      (v) => (v as List<dynamic>)
          .map(
            (e) => TsunamiStationPrefecture.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$TsunamiStationsParameterToJson(
  _TsunamiStationsParameter instance,
) => <String, dynamic>{
  'metadata': instance.metadata,
  'prefectures': instance.prefectures,
};

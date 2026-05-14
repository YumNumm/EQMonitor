// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'tsunami_station_prefecture.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TsunamiStationPrefecture _$TsunamiStationPrefectureFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_TsunamiStationPrefecture', json, ($checkedConvert) {
  final val = _TsunamiStationPrefecture(
    code: $checkedConvert('code', (v) => v as String),
    name: $checkedConvert(
      'name',
      (v) => LocalizedName.fromJson(v as Map<String, dynamic>),
    ),
    areas: $checkedConvert(
      'areas',
      (v) => (v as List<dynamic>)
          .map((e) => TsunamiStationArea.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$TsunamiStationPrefectureToJson(
  _TsunamiStationPrefecture instance,
) => <String, dynamic>{
  'code': instance.code,
  'name': instance.name,
  'areas': instance.areas,
};

// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'tsunami_parameter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TsunamiParameter _$TsunamiParameterFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_TsunamiParameter', json, ($checkedConvert) {
      final val = _TsunamiParameter(
        metadata: $checkedConvert(
          'metadata',
          (v) => ParameterMetadata.fromJson(v as Map<String, dynamic>),
        ),
        prefectures: $checkedConvert(
          'prefectures',
          (v) => (v as List<dynamic>)
              .map(
                (e) => TsunamiParameterPrefectureItem.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$TsunamiParameterToJson(_TsunamiParameter instance) =>
    <String, dynamic>{
      'metadata': instance.metadata,
      'prefectures': instance.prefectures,
    };

_TsunamiParameterPrefectureItem _$TsunamiParameterPrefectureItemFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_TsunamiParameterPrefectureItem', json, ($checkedConvert) {
  final val = _TsunamiParameterPrefectureItem(
    code: $checkedConvert('code', (v) => v as String),
    name: $checkedConvert(
      'name',
      (v) => LocalizedName.fromJson(v as Map<String, dynamic>),
    ),
    areas: $checkedConvert(
      'areas',
      (v) => (v as List<dynamic>)
          .map(
            (e) => TsunamiParameterAreaItem.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$TsunamiParameterPrefectureItemToJson(
  _TsunamiParameterPrefectureItem instance,
) => <String, dynamic>{
  'code': instance.code,
  'name': instance.name,
  'areas': instance.areas,
};

_TsunamiParameterAreaItem _$TsunamiParameterAreaItemFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_TsunamiParameterAreaItem', json, ($checkedConvert) {
  final val = _TsunamiParameterAreaItem(
    name: $checkedConvert(
      'name',
      (v) =>
          v == null ? null : LocalizedName.fromJson(v as Map<String, dynamic>),
    ),
    stations: $checkedConvert(
      'stations',
      (v) => (v as List<dynamic>)
          .map(
            (e) =>
                TsunamiParameterStationItem.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$TsunamiParameterAreaItemToJson(
  _TsunamiParameterAreaItem instance,
) => <String, dynamic>{'name': instance.name, 'stations': instance.stations};

_TsunamiParameterStationItem _$TsunamiParameterStationItemFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_TsunamiParameterStationItem', json, ($checkedConvert) {
  final val = _TsunamiParameterStationItem(
    code: $checkedConvert('code', (v) => v as String),
    name: $checkedConvert(
      'name',
      (v) => LocalizedName.fromJson(v as Map<String, dynamic>),
    ),
    kana: $checkedConvert('kana', (v) => v as String?),
    owner: $checkedConvert('owner', (v) => v as String),
    location: $checkedConvert(
      'location',
      (v) => LatLng.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$TsunamiParameterStationItemToJson(
  _TsunamiParameterStationItem instance,
) => <String, dynamic>{
  'code': instance.code,
  'name': instance.name,
  'kana': instance.kana,
  'owner': instance.owner,
  'location': instance.location,
};

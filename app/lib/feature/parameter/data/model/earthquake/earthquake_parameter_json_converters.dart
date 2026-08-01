import 'package:eqmonitor/feature/parameter/data/model/common/parameter_common.dart';
import 'package:eqmonitor/feature/parameter/data/model/earthquake/earthquake_parameter.dart';
import 'package:eqmonitor/feature/parameter/data/model/earthquake/earthquake_parameter_converter.dart';
import 'package:json_annotation/json_annotation.dart';

class EarthquakeParameterPrefectureItemJsonConverter
    implements
        JsonConverter<EarthquakeParameterPrefectureItem, Map<String, dynamic>> {
  const EarthquakeParameterPrefectureItemJsonConverter();

  @override
  EarthquakeParameterPrefectureItem fromJson(Map<String, dynamic> json) =>
      const EarthquakeParameterJsonDecoder().decodePrefecture(json);

  @override
  Map<String, dynamic> toJson(EarthquakeParameterPrefectureItem object) => {
    'code': object.code,
    'name': _localizedNameToJson(object.name),
    'regions': object.regions
        .map(const EarthquakeParameterRegionItemJsonConverter().toJson)
        .toList(),
  };
}

class EarthquakeParameterRegionItemJsonConverter
    implements
        JsonConverter<EarthquakeParameterRegionItem, Map<String, dynamic>> {
  const EarthquakeParameterRegionItemJsonConverter();

  @override
  EarthquakeParameterRegionItem fromJson(Map<String, dynamic> json) =>
      const EarthquakeParameterJsonDecoder().decodeRegion(json);

  @override
  Map<String, dynamic> toJson(EarthquakeParameterRegionItem object) => {
    'code': object.code,
    'name': _localizedNameToJson(object.name),
    'kana': object.kana,
    'cities': object.cities
        .map(const EarthquakeParameterCityItemJsonConverter().toJson)
        .toList(),
  };
}

class EarthquakeParameterCityItemJsonConverter
    implements
        JsonConverter<EarthquakeParameterCityItem, Map<String, dynamic>> {
  const EarthquakeParameterCityItemJsonConverter();

  @override
  EarthquakeParameterCityItem fromJson(Map<String, dynamic> json) =>
      const EarthquakeParameterJsonDecoder().decodeCity(json);

  @override
  Map<String, dynamic> toJson(EarthquakeParameterCityItem object) => {
    'code': object.code,
    'name': _localizedNameToJson(object.name),
    'kana': object.kana,
    'stations': object.stations
        .map(const EarthquakeParameterStationItemJsonConverter().toJson)
        .toList(),
  };
}

class EarthquakeParameterStationItemJsonConverter
    implements
        JsonConverter<EarthquakeParameterStationItem, Map<String, dynamic>> {
  const EarthquakeParameterStationItemJsonConverter();

  @override
  EarthquakeParameterStationItem fromJson(Map<String, dynamic> json) =>
      const EarthquakeParameterJsonDecoder().decodeStation(json);

  @override
  Map<String, dynamic> toJson(EarthquakeParameterStationItem object) => {
    'code': object.code,
    'no_code': object.noCode,
    'name': _localizedNameToJson(object.name),
    'kana': object.kana,
    'status': _earthquakeStationStatusToJson(object.status),
    'source_status': object.sourceStatus,
    'owner': object.owner,
    'location': {
      'latitude': object.location.lat,
      'longitude': object.location.lon,
    },
    if (object.arv400 != null) 'arv_400': object.arv400,
  };
}

Map<String, dynamic> _localizedNameToJson(LocalizedName name) => {
  'ja': name.ja,
  if (name.en != null) 'en': name.en,
  if (name.zhHans != null) 'zh_hans': name.zhHans,
  if (name.zhHant != null) 'zh_hant': name.zhHant,
  if (name.ko != null) 'ko': name.ko,
  if (name.es != null) 'es': name.es,
  if (name.pt != null) 'pt': name.pt,
  if (name.id != null) 'id': name.id,
  if (name.vi != null) 'vi': name.vi,
  if (name.tl != null) 'tl': name.tl,
  if (name.th != null) 'th': name.th,
  if (name.ne != null) 'ne': name.ne,
  if (name.km != null) 'km': name.km,
  if (name.my != null) 'my': name.my,
  if (name.mn != null) 'mn': name.mn,
};

String _earthquakeStationStatusToJson(EarthquakeStationStatus status) =>
    switch (status) {
      EarthquakeStationStatus.operating => 'OPERATING',
      EarthquakeStationStatus.changed => 'CHANGED',
      EarthquakeStationStatus.valueNew => 'NEW',
      EarthquakeStationStatus.abolished => 'ABOLISHED',
      EarthquakeStationStatus.unknown => 'UNKNOWN',
    };

import 'package:eqmonitor/feature/parameter/data/model/earthquake/earthquake_parameter.dart';
import 'package:json_annotation/json_annotation.dart';

class EarthquakeParameterPrefectureItemJsonConverter
    implements
        JsonConverter<EarthquakeParameterPrefectureItem, Map<String, dynamic>> {
  const EarthquakeParameterPrefectureItemJsonConverter();

  @override
  EarthquakeParameterPrefectureItem fromJson(Map<String, dynamic> json) =>
      EarthquakeParameterPrefectureItem.fromJson(json);

  @override
  Map<String, dynamic> toJson(EarthquakeParameterPrefectureItem object) =>
      object.toJson();
}

class EarthquakeParameterRegionItemJsonConverter
    implements
        JsonConverter<EarthquakeParameterRegionItem, Map<String, dynamic>> {
  const EarthquakeParameterRegionItemJsonConverter();

  @override
  EarthquakeParameterRegionItem fromJson(Map<String, dynamic> json) =>
      EarthquakeParameterRegionItem.fromJson(json);

  @override
  Map<String, dynamic> toJson(EarthquakeParameterRegionItem object) =>
      object.toJson();
}

class EarthquakeParameterCityItemJsonConverter
    implements
        JsonConverter<EarthquakeParameterCityItem, Map<String, dynamic>> {
  const EarthquakeParameterCityItemJsonConverter();

  @override
  EarthquakeParameterCityItem fromJson(Map<String, dynamic> json) =>
      EarthquakeParameterCityItem.fromJson(json);

  @override
  Map<String, dynamic> toJson(EarthquakeParameterCityItem object) =>
      object.toJson();
}

class EarthquakeParameterStationItemJsonConverter
    implements
        JsonConverter<EarthquakeParameterStationItem, Map<String, dynamic>> {
  const EarthquakeParameterStationItemJsonConverter();

  @override
  EarthquakeParameterStationItem fromJson(Map<String, dynamic> json) =>
      EarthquakeParameterStationItem.fromJson(json);

  @override
  Map<String, dynamic> toJson(EarthquakeParameterStationItem object) =>
      object.toJson();
}

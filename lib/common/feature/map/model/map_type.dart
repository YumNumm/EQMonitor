import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum(valueField: 'type')
enum MapDataType {
  areaForecastLoadlE('assets/maps/AreaForecastLocalE.json'),
  areaForecastLocalEew('assets/maps/AreaForecastLocalEew.json'),
  areaInformationCityQuake('assets/maps/AreaInformationCityQuake.json'),
  worldMap('assets/maps/world.json');

  const MapDataType(this.type);
  final String type;
}

import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum(valueField: 'path')
enum MapDataType {
  areaForecastLoadlE('assets/maps/AreaForecastLocalE.json'),
  areaForecastLocalEew('assets/maps/AreaForecastLocalEew.json'),
  areaInformationCityQuake('assets/maps/AreaInformationCityQuake.json'),
  worldMap('assets/maps/world.json');

  const MapDataType(this.path);
  final String path;
}

enum LineDataType {
  areaTsunamiForecast('assets/maps/AreaTsunamiForecast.json');

  const LineDataType(this.path);
  final String path;
}

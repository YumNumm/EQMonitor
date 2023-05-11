sealed class MapData {
  MapData(this.path);
  final String path;
}

class AreaForecastLocalEMap extends MapData {
  AreaForecastLocalEMap(super.path);
}

class AreaForecastLocalEewMap extends MapData {
  AreaForecastLocalEewMap(super.path);
}

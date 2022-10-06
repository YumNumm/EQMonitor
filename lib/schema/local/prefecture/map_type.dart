/// https://www.data.jma.go.jp/developer/gis.html

enum JmaMapType {
  /// 緊急地震速報／府県予報区
  areaForecastLocalEew,

  /// 地震情報／細分区域
  areaForecastLocalE,

  /// 市町村等(地震津波関係)
  areaInformationCityQuake,

  /// 津波予報区
  areaTsunami,
}
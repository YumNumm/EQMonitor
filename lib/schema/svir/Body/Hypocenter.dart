class SvirBodyEQHypocenter {
  SvirBodyEQHypocenter({
    required this.name,
    required this.code,
    required this.lat,
    required this.lon,
    required this.depth,
    required this.landOrSea,
  });
  SvirBodyEQHypocenter.fromJson(Map<String, dynamic> j)
      : name = j['Name'].toString(),
        code = int.parse(j['Code'].toString()),
        lat = double.parse(j['Lat'].toString()),
        lon = double.parse(j['Lon'].toString()),
        depth = int.parse(j['Depth'].toString()),
        landOrSea = (j['LandOrSea'] == null) ? null : j['LandOrSea'].toString();

  ///  震央地名
  final String name;

  /// 震央地名コード
  final int code;

  /// 緯度
  final double lat;

  /// 経度
  final double lon;

  /// 深さ
  final int depth;

  /// 陸海識別
  final String? landOrSea;
}

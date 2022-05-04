/// 緊急地震速報の警報が発表された地域を記載します。

/// VXSE43、VXSE45の場合のみ出現し、警報対象地域がない場合（取消報など）は出現しません。
class Area {
  Area.fromJson(Map<String, dynamic> j)
      : code = j['code'].toString(),
        name = j['name'].toString(),
        wasWarning = j['last']['code'].toString() == '31';
  Area({
    required this.code,
    required this.name,
    required this.wasWarning,
  });

  /// 地域コード
  /// コードは、コード表21 または コード表22 または コード表24 による
  final String code;

  /// 地域名
  final String name;

  /// 前回の警報種別が緊急地震速報(警報)だったかどうか
  final bool wasWarning;
}

class Kind {
  /// 津波警報等の種別コード
  /// コードは、気象庁防災情報XMLフォーマット コード表 地震火山関連コード表 による
  final int code;

  /// 津波警報等の種別名
  final String name;

  /// 前回発表した津波警報等の種別
  final LastKind lastKind;

  Kind({
    required this.code,
    required this.name,
    required this.lastKind,
  });
  Kind.fromJson(Map<String, dynamic> j)
      : code = int.parse(j['code'].toString()),
        name = j['name'].toString(),
        lastKind = LastKind.fromJson(j['lastKind'] as Map<String, dynamic>);
}

class LastKind {
  /// 前回発表した津波警報等の種別コード
  /// コードは、気象庁防災情報XMLフォーマット コード表 地震火山関連コード表 による
  final int code;

  /// 前回発表した津波警報等の種別名
  final String name;

  LastKind({required this.code, required this.name});
  LastKind.fromJson(Map<String, dynamic> j)
      : code = int.parse(j['code'].toString()),
        name = j['name'].toString();
}

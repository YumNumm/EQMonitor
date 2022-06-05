/// 緊急地震速報の種別を記載します。
class Kind {
  Kind({
    required this.code,
    required this.name,
  });
  Kind.fromJson(Map<String, dynamic> j)
      : code = int.parse(j['code'].toString()),
        name = j['name'].toString();

  /// 緊急地震速報の種別
  /// コードは、コード表12 による
  final int code;

  /// 緊急地震速報の種別
  final String name;
}

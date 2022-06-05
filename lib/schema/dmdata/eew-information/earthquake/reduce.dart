/// 緊急地震速報が対象とする地震の短縮用震央地名を記載します。
class Reduce {
  Reduce({
    required this.code,
    required this.name,
  });

  Reduce.fromJson(Map<String, dynamic> j)
      : code = int.parse(j['code'].toString()),
        name = j['name'].toString();

  Map<String, dynamic> toJson() => <String, dynamic>{
        'code': code,
        'name': name,
      };

  /// 短縮用震央地名コード
  /// コードは、コード表42 による
  final int code;

  /// 短縮用震央地名
  final String name;
}

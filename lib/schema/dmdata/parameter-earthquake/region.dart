/// ## 一次細分化地域
class Region {
  Region({
    required this.code,
    required this.name,
    required this.kana,
  });
  factory Region.fromJson(Map<String, dynamic> j) => Region(
        code: int.parse(j['code'].toString()),
        name: j['name'].toString(),
        kana: j['kana'].toString(),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'code': code,
        'name': name,
        'kana': kana,
  };

  /// 一次細分化地域コード
  final int code;

  /// 一次細分化地域名
  final String name;

  /// 一次細分化地域名（カナ）
  final String kana;
}

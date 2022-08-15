/// ## 市区町村
class City {
  /// 市区町村コード
  final int code;
  /// 市区町村名
  final String name;
  /// 市区町村名（カナ）
  final String kana;
  City({
    required this.code,
    required this.name,
    required this.kana,
  });

  factory City.fromJson(Map<String,dynamic> j)
  => City(
    code: int.parse(j['code'].toString()),
    name: j['name'].toString(),
    kana: j['kana'].toString(),
  );
}
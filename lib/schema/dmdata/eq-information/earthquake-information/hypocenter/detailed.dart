/// ## 震央地名を補足する詳細震央地名。
/// 遠地地震情報で出現します。
class Detailed {
  Detailed({
    required this.code,
    required this.name,
  });

  Detailed.fromJson(Map<String, dynamic> j)
      : code = int.parse(j['code'].toString()),
        name = j['name'].toString();

  Map<String, dynamic> toJson() => <String, dynamic>{
        'code': code,
        'name': name,
      };

  final int code;
  final String name;
}

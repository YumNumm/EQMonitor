class LastKind {
  LastKind({
    required this.code,
    required this.name,
  });

  factory LastKind.fromJson(Map<String, dynamic> j) => LastKind(
        code: int.parse(j['code'].toString()),
        name: j['name'].toString(),
      );

  /// 警報の種別、コード 31 又は 00
  final int code;

  /// 警報の種別、名称 緊急地震速報（警報） 又は なし
  final String name;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'code': code,
        'name': name,
      };
}

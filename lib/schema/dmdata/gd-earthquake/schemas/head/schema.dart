class Schema {
  Schema({
    required this.type,
    required this.version,
  });

  Schema.fromJson(Map<String, dynamic> j)
      : type = j['type'].toString(),
        version = j['version'].toString();

  /// スキーマ名
  final String type;

  /// スキーマのバージョン
  final String version;
}

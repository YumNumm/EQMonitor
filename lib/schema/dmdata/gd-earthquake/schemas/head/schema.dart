class Telegram {
  Telegram({
    required this.type,
    required this.version,
  });

  Telegram.fromJson(Map<String, dynamic> j)
      : type = j['type'].toString(),
        version = j['version'].toString();

  /// スキーマ名
  final String type;

  /// スキーマのバージョン
  final String version;
}

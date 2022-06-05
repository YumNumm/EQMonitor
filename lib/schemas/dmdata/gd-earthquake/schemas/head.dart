class Head {
  Head({
    required this.type,
    required this.author,
    required this.time,
    required this.designation,
  });
  Head.fromJson(Map<String, dynamic> j)
      : type = j['type'].toString(),
        author = j['author'].toString(),
        time = DateTime.parse(j['time'].toString()),
        designation =
            (j['designation'] == null) ? null : j['designation'].toString();

  /// データ種類コード
  final String type;

  /// 発表英字官署名
  final String author;

  /// 起点時刻
  final DateTime time;

  /// 指示コード
  final String? designation;
}

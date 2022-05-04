class EqHistoryContent {
  EqHistoryContent({
    required this.publishedDate,
    required this.hypoName,
    required this.magnitude,
    required this.maxint,
    required this.imageUrl,
    required this.url,
  });

  factory EqHistoryContent.fromJson(Map<String, dynamic> j) {
    return EqHistoryContent(
      publishedDate: DateTime.parse(j['publishedDate'].toString()),
      hypoName: j['hypoName'].toString(),
      magnitude: double.parse(j['magnitude'].toString()),
      maxint: j['maxint'].toString(),
      imageUrl: j['imageUrl'].toString(),
      url: j['url'].toString(),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'publishedDate': publishedDate.toIso8601String(),
        'hypoName': hypoName,
        'magnitude': magnitude.toString(),
        'maxint': maxint,
        'imageUrl': imageUrl,
        'url': url,
      };

  /// 発生日時
  final DateTime publishedDate;

  /// 震源地(名称)
  final String hypoName;

  /// マグニチュード
  final double magnitude;

  /// 最大震度
  final String maxint;

  /// 震度画像
  final String imageUrl;

  /// payload(VXSE53)へのURL
  final String url;
}

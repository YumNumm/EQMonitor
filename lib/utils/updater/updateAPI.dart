class UpdateAPI {
  /// 最新Ver
  final String latestVersion;

  /// buildNum
  final int buildNum;

  /// apkのURL
  final String assetUrl;

  /// タイトル
  final String title;

  /// 中身
  final String body;

  UpdateAPI({
    required this.latestVersion,
    required this.buildNum,
    required this.assetUrl,
    required this.title,
    required this.body,
  });

  UpdateAPI.fromJson(Map<String, dynamic> j)
      : latestVersion = j['latestVer'].toString(),
        buildNum = int.parse(j['buildNum'].toString()),
        assetUrl = j['assetUrl'].toString(),
        title = j['title'].toString(),
        body = j['body'].toString();
}

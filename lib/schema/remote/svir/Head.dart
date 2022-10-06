class SvirHead {
  SvirHead({
    required this.title,
    required this.dateTime,
    required this.editorialOffice,
    required this.eventId,
    required this.serial,
  });
  SvirHead.fromJson(Map<String, dynamic> j)
      : title = j['Title'].toString(),
        dateTime = DateTime.parse(j['DateTime'].toString()),
        editorialOffice = j['EditorialOffice'].toString(),
        eventId = int.parse(j['EventID'].toString()),
        serial = int.parse(j['Serial'].toString());

  /// API識別タイトル、「緊急地震速報（予報）」で固定
  final String title;

  /// 緊急地震速報の発表時刻
  final DateTime dateTime;

  /// 緊急地震速報を発表した管区気象台名
  final String editorialOffice;

  /// 地震識別ID、地震ごとに異なる
  final int eventId;

  /// 電文の配信数
  final int serial;
}

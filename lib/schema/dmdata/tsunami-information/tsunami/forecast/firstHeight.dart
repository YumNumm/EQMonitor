class FirstHeight {
  /// 津波到達予想時刻
  /// まだ津波が到達していない場合,到達していないと推測される場合に出現する
  final DateTime? arraivalTime;

  /// 取りうる値は `津波到達中と推測`,`第１波の到達を確認`,`ただちに津波来襲と予測`
  /// すでに津波が到達している場合や、推測される場合、直ちに津波が来襲されると予想される場合に出現する
  final String? condition;

  /// 到達予想の更新フラグ取りうる値は`追加`,`更新`
  final String? revise;
  FirstHeight({
    required this.arraivalTime,
    required this.condition,
    required this.revise,
  });
  FirstHeight.fromJson(Map<String, dynamic> j)
      : arraivalTime = (j['arrivalTime'].toString() == 'null')
            ? null
            : DateTime.parse(j['arrivalTime'].toString()),
        condition = (j['condition'].toString() == 'null')
            ? null
            : j['condition'].toString(),
        revise =
            (j['revise'].toString() == 'null') ? null : j['revise'].toString();
}

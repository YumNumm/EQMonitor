class FirstHeight {
  /// 津波到達予想時刻
  /// 識別不能時は出現しない
  final DateTime? arraivalTime;

  /// 津波の第一波の極性を記載する
  /// 取りうる値は`押し`,`引き`
  final String? initial;

  /// 取りうる値は`第１波識別不能`で固定
  /// 識別不能時に出現する
  final String? condition;

  /// 到達予想の更新フラグ取りうる値は`追加`,`更新`
  final String? revise;

  FirstHeight({
    required this.arraivalTime,
    required this.condition,
    required this.initial,
    required this.revise,
  });
  FirstHeight.fromJson(Map<String, dynamic> j)
      : arraivalTime = (j['arrivalTime'].toString() == 'null')
            ? null
            : DateTime.parse(j['arrivalTime'].toString()),
        initial = (j['initial'].toString() == 'null')
            ? null
            : j['initial'].toString(),
        condition = (j['condition'].toString() == 'null')
            ? null
            : j['condition'].toString(),
        revise =
            (j['revise'].toString() == 'null') ? null : j['revise'].toString();
}

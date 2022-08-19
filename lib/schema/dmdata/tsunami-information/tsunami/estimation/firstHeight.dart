/// 津波の到達予想時刻（推定値）を表現します。
/// 1.3.3
class FirstHeight {
  FirstHeight({
    required this.arraivalTime,
    required this.condition,
    required this.revise,
  });
  FirstHeight.fromJson(Map<String, dynamic> j)
      : arraivalTime = DateTime.parse(j['arrivalTime'].toString()),
        condition = (j['condition'] == null) ? null : j['condition'].toString(),
        revise = (j['revise'] == null) ? null : j['revise'].toString();

  /// 津波到達予想時刻
  final DateTime arraivalTime;

  /// 早いところでは既に津波到達と推定
  /// 取りうる値は`早いところでは既に津波到達と推定`
  final String? condition;

  /// 到達予想の更新フラグ取りうる値は`追加`,`更新`
  final String? revise;
}

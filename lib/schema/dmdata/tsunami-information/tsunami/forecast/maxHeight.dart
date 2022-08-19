/// 津波の予想の高さを表現します。
/// 津波注意報以上が発表されていた場合に続報において津波予報（若干の海面変動）となった場合は、出現しません。

class MaxHeight {
  MaxHeight({
    required this.height,
    required this.condition,
    required this.revise,
  });
  MaxHeight.fromJson(Map<String, dynamic> j)
      : height = Height.fromJson(j['height'] as Map<String, dynamic>),
        condition = (j['condition'] == null) ? null : j['condition'].toString(),
        revise = (j['revise'] == null) ? null : j['revise'].toString();

  /// 津波の予想される高さ
  final Height height;

  /// 取りうる値は `重要`
  /// 大津波警報で初めて発表する場合や大津波警報で上方修正を行った場合に出現する
  final String? condition;

  /// 津波の高さの更新フラグ取りうる値は`追加`,`更新`
  final String? revise;
}

/// 津波の予想される高さ
class Height {
  Height({
    required this.type,
    required this.unit,
    required this.value,
    required this.over,
    required this.condition,
  });
  Height.fromJson(Map<String, dynamic> j)
      : type = j['type'].toString(),
        unit = j['unit'].toString(),
        value =
            (j['value'] == null) ? null : double.parse(j['value'].toString()),
        over = (j['over'] == null) ? null : true,
        condition = (j['condition'] == null) ? null : j['condition'].toString();

  /// 数値情報のタイプ `津波の高さ`で固定
  final String type;

  /// 数値情報の単位 `m`で固定
  final String unit;

  /// 津波の予想される高さ。定性的表現をする場合は`Null`とする
  final double? value;

  /// 10m超となるときに出現し、数値情報を補助する
  /// 取りうる値は`true`のみ
  /// 数値情報より大きいことを示す場合に出現
  final bool? over;

  /// 津波の高さを定性的表現をする、津波注意報時は出現しない
  /// 取りうる値は `高い`,`巨大`
  final String? condition;
}

/// 津波の予想の高さ（推定値）を表現します。
class MaxHeight {
  MaxHeight.fromJson(Map<String, dynamic> j)
      : dateTime = (j['dateTime'] == null)
            ? null
            : DateTime.parse(j['dateTime'].toString()),
        height = (j['height'] == null)
            ? null
            : Height.fromJson(j['height'] as Map<String, dynamic>),
        condition = (j['condition'] == null) ? null : j['condition'].toString(),
        revise = (j['revise'] == null) ? null : j['revise'].toString();
  MaxHeight({
    required this.dateTime,
    required this.height,
    required this.condition,
    required this.revise,
  });

  /// ## 津波の最大波となる日時(推定)
  /// 日時が明確である場合に出現
  final DateTime? dateTime;

  /// ## 津波の最大波を推定した値
  /// 津波警報以上でまだ津波の観測値が小さい場合は出現しない
  final Height? height;

  /// ## 取りうる値は `微弱`,`観測中`,`重要`
  /// 津波が小さい場合や、津波警報以上で
  /// まだ津波の観測値が小さい場合、重要な場合に出現する
  final String? condition;

  /// ## 津波の高さの更新フラグ
  /// 取りうる値は `追加`,`更新`
  /// 続報により新しく追加された場合や、更新された場合に出現する
  final String? revise;
}

/// 津波の最大波を推定した値
class Height {
  Height.fromJson(Map<String, dynamic> j)
      : type = j['type'].toString(),
        unit = j['unit'].toString(),
        value =
            (j['value'] == null) ? null : double.parse(j['value'].toString()),
        over = (j['over'] == null) ? null : true,
        condition = (j['condition'] == null) ? null : j['condition'].toString();

  Height({
    required this.type,
    required this.unit,
    required this.value,
    required this.over,
    required this.condition,
  });

  /// 数値情報のタイプ `津波の高さ`で固定
  final String type;

  /// 数値情報の単位 `m`で固定
  final String unit;

  /// 津波の予想される高さ。定性的表現をする場合は Null とする
  final double? value;

  /// 10m超となるときに出現し、数値情報を補助する
  /// 取りうる値は `true`のみ
  /// 数値情報より大きいことを示す場合に出現
  final bool? over;

  /// 津波の高さを定性的表現をする、津波注意報時は出現しない
  /// 取りうる値は `高い`,`巨大`
  ///	定性的表現がある場合に出現
  final String? condition;
}

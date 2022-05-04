/// 緊急地震速報が対象とする震源の深さを記載します。
class Depth {
  Depth({
    required this.value,
    required this.condition,
  });
  Depth.fromJson(Map<String, dynamic> j)
      : value = (j['value'].toString() == 'null')
            ? null
            : int.parse(j['value'].toString()),
        condition = (j['condition'].toString() == 'null')
            ? null
            : (j['condition'].toString() == 'ごく浅い')
                ? DepthCondition.VeryShallow
                : (j['condition'].toString() == '不明')
                    ? DepthCondition.Undefined
                    : DepthCondition.MoreThan700km;

  /// 震源の深さ
  /// 不明時は`Null`とする
  final int? value;

  /// 深さの例外的表現。取りうる値は `ごく浅い`,`７００ｋｍ以上`,`不明`とする
  /// valueが`0`,`700`,`Null`の時
  final DepthCondition? condition;
}

enum DepthCondition {
  /// `ごく浅い`
  VeryShallow,

  /// `７００ｋｍ以上`
  MoreThan700km,

  /// `不明`
  Undefined,
}

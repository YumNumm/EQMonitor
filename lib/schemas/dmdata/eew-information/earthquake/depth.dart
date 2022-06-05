/// 緊急地震速報が対象とする震源の深さを記載します。
class Depth {
  Depth({
    required this.type,
    required this.unit,
    required this.value,
    required this.condition,
  });

  factory Depth.fromJson(Map<String, dynamic> j) {
    return Depth(
      type: j['type'].toString(),
      unit: j['unit'].toString(),
      value: int.tryParse(j['value'].toString()),
      condition: (j['condition'] == null)
          ? null
          : DepthCondition.values.firstWhere(
              (element) => element.name == j['condition'].toString(),
            ),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'type': type,
        'unit': unit,
        if (value != null) 'value': value,
        if (condition != null) 'condition': condition,
      };

  /// 深さ情報のタイプ。深さで固定
  final String type;

  /// 深さ情報の単位。kmで固定
  final String unit;

  /// 震源の深さ
  /// 不明時は`Null`とする
  final int? value;

  /// 深さの例外的表現。取りうる値は `ごく浅い`,`７００ｋｍ以上`,`不明`とする
  /// valueが`0`,`700`,`Null`の時
  final DepthCondition? condition;
}

enum DepthCondition {
  /// `ごく浅い`
  veryShallow('ごく浅い'),

  /// `７００ｋｍ以上`
  moreThan700km('７００ｋｍ以上'),

  /// `不明`
  unknown('不明');

  const DepthCondition(this.description);

  final String description;
}
